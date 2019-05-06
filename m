Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CFC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3006320830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEFTks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:40:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEFTkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:40:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60588300744C
        for <linux-kernel@vger.kernel.org>; Mon,  6 May 2019 19:40:47 +0000 (UTC)
Received: from torg.redhat.com (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0034460C43;
        Mon,  6 May 2019 19:40:46 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] hwlatdetect: disable/enable c-state transitions during detection
Date:   Mon,  6 May 2019 14:40:46 -0500
Message-Id: <20190506194046.13144-1-williams@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 06 May 2019 19:40:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent performance tuning problems led me to realize that just running
at fifo:99 and turning off interrupts isn't enough while looking for
BIOS induced latencies. Power savings logic is built into most modern
cpus and so must be disabled while looking for BIOS induced (SMI/NMI)
latencies.

Use the /dev/cpu_dma_latency mechanism to disable c-state transitions
while running the hardware latency detector. Open the file
/dev/cpu_dma_latency and write a 32-bit zero to it, which will prevent
c-state transitions while the file is open.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 2c8f9f160419..368079a158b1 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -1,6 +1,6 @@
 #!/usr/bin/python3
 
-# (C) 2018 Clark Williams <williams@redhat.com>
+# (C) 2018,2019 Clark Williams <williams@redhat.com>
 # (C) 2015,2016 Clark Williams <williams@redhat.com>
 # (C) 2009 Clark Williams <williams@redhat.com>
 #
@@ -213,6 +213,22 @@ watch = False
             counts = [ int(x.strip()) for x in p.stdout.readlines()]
         return counts
 
+    # methods for preventing/enabling c-state transitions
+    # openinging /dev/cpu_dma_latency and writeing a 32-bit zero to that file will prevent
+    # c-state transitions while the file descriptor is open.
+    # use c_states_off() to disable c-state transitions
+    # use c_states_on() to close the file descriptor and re-enable c-states
+    #
+    def c_states_off(self):
+        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
+        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
+        debug("c-states disabled")
+
+    def c_states_on(self):
+        if self.dma_latency_handle:
+            os.close(self.dma_latency_handle)
+        debug("c-states enabled")
+
     def cleanup(self):
         raise RuntimeError("must override base method 'cleanup'!")
 
@@ -235,6 +251,7 @@ watch = False
     def start(self):
         count = 0
         threshold = int(self.get("threshold"))
+        self.c_states_off()
         debug("enabling detector module (threshold: %d)" % threshold)
         self.set("enable", 1)
         while self.get("enable") == 0:
@@ -258,6 +275,7 @@ watch = False
             time.sleep(0.1)
             debug("retrying disable of detector module(%d)" % count)
             self.set("enable", 0)
+        self.c_states_on()
         debug("detector module disabled")
 
     def detect(self):
-- 
2.21.0

