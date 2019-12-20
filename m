Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA90C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAF121655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfLTMau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:30:50 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:56712 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfLTMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:30:50 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47fSlD381Gz1rdjG;
        Fri, 20 Dec 2019 13:30:48 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47fSlD2XJHz1rYZN;
        Fri, 20 Dec 2019 13:30:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BNEWlVKDnHqf; Fri, 20 Dec 2019 13:30:47 +0100 (CET)
X-Auth-Info: /8d85fX2ezcvOGNU+aU4qC5uYFUpU5VTeYosAXHRaIM=
Received: from maia.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 20 Dec 2019 13:30:47 +0100 (CET)
From:   Harald Seiler <hws@denx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Harald Seiler <hws@denx.de>
Subject: [PATCH] perf python: Convert tracepoint example to python 3
Date:   Fri, 20 Dec 2019 13:29:57 +0100
Message-Id: <20191220122957.8091-1-hws@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the tracepoint example compatible with python 3 and fix string
handling of the prev_comm and next_comm fields so they are properly
truncated.

Signed-off-by: Harald Seiler <hws@denx.de>
---
 tools/perf/python/tracepoint.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index eb76f6516247..a5420cfb3a31 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -3,6 +3,8 @@
 # -*- python -*-
 # -*- coding: utf-8 -*-
 
+from __future__ import print_function
+
 import perf
 
 class tracepoint(perf.evsel):
@@ -34,15 +36,23 @@ def main():
             if not isinstance(event, perf.sample_event):
                 continue
 
-            print "time %u prev_comm=%s prev_pid=%d prev_prio=%d prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
+            # The prev_comm and next_comm fields are `bytes` objects but they
+            # are not truncated to the first \x00.  This is due to the
+            # underlying code treating the strings as just an array of
+            # arbitrary bytes.  Convert them to properly truncated python
+            # strings.
+            prev_comm_str = event.prev_comm.split(b'\x00', 1)[0].decode(errors="ignore")
+            next_comm_str = event.next_comm.split(b'\x00', 1)[0].decode(errors="ignore")
+
+            print("time {} prev_comm={} prev_pid={} prev_prio={} prev_state=0x{:x} ==> next_comm={} next_pid={} next_prio={}".format(
                    event.sample_time,
-                   event.prev_comm,
+                   prev_comm_str,
                    event.prev_pid,
                    event.prev_prio,
                    event.prev_state,
-                   event.next_comm,
+                   next_comm_str,
                    event.next_pid,
-                   event.next_prio)
+                   event.next_prio))
 
 if __name__ == '__main__':
     main()
-- 
2.20.1

