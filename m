Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A798DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DE020883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140666;
	bh=Es9sY6x3GHYPEBMm9sEFlkxstnamJjzO5PQWVknp3oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rBy95klt/vepyKfJouoGxNZTKcQCBNJv8cOikCRfhS2HyDejafp0f9qHgK9mOgVWu
	 kMx3Fk14qh4vwmsAdFLbR2ESzo4NRBS5xah/3WV+rHWKl2ak3FcZOQr1n6VqiwSoRI
	 Oxd+DMk4sf11m1Y1XtDRV/r5JQnokK5bise7MgN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbfDARoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733290AbfDARev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A4F2070B;
        Mon,  1 Apr 2019 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140090;
        bh=Es9sY6x3GHYPEBMm9sEFlkxstnamJjzO5PQWVknp3oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCt7xQtnQwn7hClzENko37MFjM2Btfum3bByeykoOmTGgc2nXIMEhbBZ3v7XPm6/f
         sm7xG1FZAqQsDmYmBVYcwZ/Vy6sciVcIDiSHRU02BDX0BD/KR1TjiWeG3Ne1p8VCzY
         wL/foUv8LcRhIZw8EenlX8iL5Pmj0RGJ4vIRN2Fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ravindra Lokhande <rlokhande@nvidia.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 103/131] ALSA: compress: add support for 32bit calls in a 64bit kernel
Date:   Mon,  1 Apr 2019 19:02:53 +0200
Message-Id: <20190401170100.467684472@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravindra Lokhande <rlokhande@nvidia.com>

commit c10368897e104c008c610915a218f0fe5fa4ec96 upstream.

Compress offload does not support ioctl calls from a 32bit userspace
in a 64 bit kernel. This patch adds support for ioctls from a 32bit
userspace in a 64bit kernel

Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/compress_offload.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -38,6 +38,7 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
+#include <linux/compat.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/compress_params.h>
@@ -859,6 +860,15 @@ static long snd_compr_ioctl(struct file
 	return retval;
 }
 
+/* support of 32bit userspace on 64bit platforms */
+#ifdef CONFIG_COMPAT
+static long snd_compr_ioctl_compat(struct file *file, unsigned int cmd,
+						unsigned long arg)
+{
+	return snd_compr_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static const struct file_operations snd_compr_file_ops = {
 		.owner =	THIS_MODULE,
 		.open =		snd_compr_open,
@@ -866,6 +876,9 @@ static const struct file_operations snd_
 		.write =	snd_compr_write,
 		.read =		snd_compr_read,
 		.unlocked_ioctl = snd_compr_ioctl,
+#ifdef CONFIG_COMPAT
+		.compat_ioctl = snd_compr_ioctl_compat,
+#endif
 		.mmap =		snd_compr_mmap,
 		.poll =		snd_compr_poll,
 };


