Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42487C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F432233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbfHVO6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:58:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729922AbfHVO6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:58:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7D38731106B5519A65DA;
        Thu, 22 Aug 2019 22:58:32 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:58:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <gregkh@linuxfoundation.org>,
        <pavel@denx.de>, <allison@lohutok.net>, <tglx@linutronix.de>,
        <yuehaibing@huawei.com>, <pakki001@umn.edu>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ALSA: line6: Fix -Wunused-const-variable warnings
Date:   Thu, 22 Aug 2019 22:57:41 +0800
Message-ID: <20190822145741.9592-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/usb/line6/driver.h:69:18: warning:
 SYSEX_DATA_OFS defined but not used [-Wunused-const-variable=]
sound/usb/line6/driver.h:70:18: warning:
 SYSEX_EXTRA_SIZE defined but not used [-Wunused-const-variable=]

SYSEX_EXTRA_SIZE is only used in driver.c and
SYSEX_DATA_OFS in pod.c, so move them to .c fix
this warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/usb/line6/driver.c | 2 ++
 sound/usb/line6/driver.h | 3 ---
 sound/usb/line6/pod.c    | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b5a3f75..8027da8 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -31,6 +31,8 @@ const unsigned char line6_midi_id[3] = {
 };
 EXPORT_SYMBOL_GPL(line6_midi_id);
 
+static const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
+
 /*
 	Code to request version of POD, Variax interface
 	(and maybe other devices).
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index e5e572e..c57633a 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -66,9 +66,6 @@
 
 extern const unsigned char line6_midi_id[3];
 
-static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
-static const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
-
 /*
 	 Common properties of Line 6 devices.
 */
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index ee4c9d2..24ad337 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -110,6 +110,8 @@ enum {
 	POD_BUSY_MIDISEND
 };
 
+static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
+
 static struct snd_ratden pod_ratden = {
 	.num_min = 78125,
 	.num_max = 78125,
-- 
2.7.4


