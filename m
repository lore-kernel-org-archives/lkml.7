Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2023BC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B762053B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEIKbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:31:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33223 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbfEIKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:31:50 -0400
X-UUID: 49b54b4d4c1e425091c7a2b3e6c30802-20190509
X-UUID: 49b54b4d4c1e425091c7a2b3e6c30802-20190509
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1425517763; Thu, 09 May 2019 18:31:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 9 May 2019 18:31:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 9 May 2019 18:31:38 +0800
From:   <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <corbet@lwn.net>, <mhiramat@kernel.org>,
        <srv_heupstream@mediatek.com>, <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH] Documentation: {u,k}probes: add tracing_on before tracing
Date:   Thu, 9 May 2019 18:31:16 +0800
Message-ID: <1557397876-18153-1-git-send-email-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lecopzer Chen <lecopzer.chen@mediatek.com>

After following the document step by step, the `cat trace` can't be
worked without enabling tracing_on and might mislead newbies about
the functionality.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 Documentation/trace/kprobetrace.rst  | 6 ++++++
 Documentation/trace/uprobetracer.rst | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 235ce2ab131a..baa3c42ba2f4 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -189,6 +189,12 @@ events, you need to enable it.
   echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
   echo 1 > /sys/kernel/debug/tracing/events/kprobes/myretprobe/enable
 
+Use the following command to start tracing in an interval.
+::
+    # echo 1 > tracing_on
+    Open something...
+    # echo 0 > tracing_on
+
 And you can see the traced information via /sys/kernel/debug/tracing/trace.
 ::
 
diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index 4346e23e3ae7..0b21305fabdc 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -152,10 +152,15 @@ events, you need to enable it by::
 
     # echo 1 > events/uprobes/enable
 
-Lets disable the event after sleeping for some time.
+Lets start tracing, sleep for some time and stop tracing.
 ::
 
+    # echo 1 > tracing_on
     # sleep 20
+    # echo 0 > tracing_on
+
+Also, you can disable the event by::
+
     # echo 0 > events/uprobes/enable
 
 And you can see the traced information via /sys/kernel/debug/tracing/trace.
-- 
2.18.0

