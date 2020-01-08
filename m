Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D2C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6092070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgAHTte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:49:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43458 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730406AbgAHTqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:46:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ipHHB-0006np-O0; Wed, 08 Jan 2020 19:45:57 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1ipHHB-007dl4-6r; Wed, 08 Jan 2020 19:45:57 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Ravindra Lokhande" <rlokhande@nvidia.com>,
        "Vinod Koul" <vinod.koul@intel.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Date:   Wed, 08 Jan 2020 19:43:06 +0000
Message-ID: <lsq.1578512578.869982560@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 08/63] ALSA: compress: add support for 32bit calls in
 a 64bit kernel
In-Reply-To: <lsq.1578512578.117275639@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.81-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ravindra Lokhande <rlokhande@nvidia.com>

commit c10368897e104c008c610915a218f0fe5fa4ec96 upstream.

Compress offload does not support ioctl calls from a 32bit userspace
in a 64 bit kernel. This patch adds support for ioctls from a 32bit
userspace in a 64bit kernel

Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/compress_offload.c | 13 +++++++++++++
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
@@ -864,6 +865,15 @@ static long snd_compr_ioctl(struct file
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
@@ -871,6 +881,9 @@ static const struct file_operations snd_
 		.write =	snd_compr_write,
 		.read =		snd_compr_read,
 		.unlocked_ioctl = snd_compr_ioctl,
+#ifdef CONFIG_COMPAT
+		.compat_ioctl = snd_compr_ioctl_compat,
+#endif
 		.mmap =		snd_compr_mmap,
 		.poll =		snd_compr_poll,
 };

