Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55969C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0A42073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfDQIqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:46:46 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:58414 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:46:46 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 781773C00DD;
        Wed, 17 Apr 2019 10:46:44 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w-yeZ4OTLi6V; Wed, 17 Apr 2019 10:46:36 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id AC4493C00C0;
        Wed, 17 Apr 2019 10:46:36 +0200 (CEST)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 17 Apr
 2019 10:46:36 +0200
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH] ALSA: pcm: Enable MMAP status and control for ARMv7 and ARMv8
Date:   Wed, 17 Apr 2019 10:46:11 +0200
Message-ID: <1555490771-13242-1-git-send-email-twischer@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

Since ARMv7 hardware cache coherence is supported.
"The SCU maintains coherency between the individual data caches in the
Cortex-A5 MPCore processor using a variation of the MOESI protocol" [1].

Therefore this patch enables the MMAP access to the status and control
structures. This avoids HWSYYNC ioctl calls and therefore lowers the CPU
usage.

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0434c/
BABJECBF.html

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/core/pcm_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1d84529..b8019ef 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3225,7 +3225,8 @@ static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
  * Only on coherent architectures, we can mmap the status and the control records
  * for effcient data transfer.  On others, we have to use HWSYNC ioctl...
  */
-#if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_ALPHA)
+#if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_ALPHA) || \
+	(defined(CONFIG_ARM) && defined(CONFIG_CPU_V7)) || defined(CONFIG_ARM64)
 /*
  * mmap status record
  */
-- 
2.7.4

