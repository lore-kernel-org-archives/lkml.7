Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7151E2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCVPql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:46:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45691 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfCVPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:46:40 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MnpwC-1gfVXC0zBS-00pKgq; Fri, 22 Mar 2019 16:45:08 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Ravindra Lokhande <rlokhande@nvidia.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 02/25] ALSA: compress: add support for 32bit calls in a 64bit kernel
Date:   Fri, 22 Mar 2019 16:43:53 +0100
Message-Id: <20190322154425.3852517-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qdmoVgn5qRBXiX0rd6Jjr6hDFLSAzZ7K8GEgzOoBTJ7z24e4UWD
 RjKLEBCA6OW0mDWPPMZuNQ0nofk8g9w/lw97NF0CYfqxbdatuEs1E/WFUeMImyuAmTRweg8
 VS7I91GhVWgKkiLqm740IaYAOQU3cFPKM+JkraWNkzIt5H0WbCXp6os0vwagWMGQNljHAdb
 p/Z2CFCmOWedlw7LF25tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ctb8eMkV2xI=:Q7CpqNFjF8sfLZetR/lwPI
 dIAMil0TxiU1g3D27dOwhRGZ6fHDZRML4J32+m4sRNxFGQWtIQMf96SsXVxx0VuqrGdV3RVBu
 3FXGN2+HmJDkSOx/YaAP5tjLVSj1ZWO0YSgFDg/McX61rwyn9XA7YBMv7NVNvLh+ev26NKoff
 DdLXd6WiT7F2pcs4JPkg/sQNfYM9ej71b7TH26P7CpiR7RSpm6wXDVXmmgYOeb8otUosJOcAF
 9TJlnQLIvmBQETigdnHcOePeKKtccrkDWE4qXryEezqE51gFnTZ0WGqPF3xVqK+RtD6FXMOPD
 QIABs0JOPdNubjvuzSwl46x/VumGHJa8NN35aAHS/lnNAOgTi4fAQ+e0JHRqxnPKQ6p/wqh1V
 tkAVJOaiMKq0GMr8ZnCfQXqY3vyjqTO8bn/6JhL2qZw47NmgNxf0OMUyigubdBZLQKSTKf4zT
 UK4wulxOvRCttye8f8O5fNUR8h1Tbb1gVwA+xnwL2PgnYtnRjHY845QAJVYEjn/nleEG7zAHw
 EKiURZvOJj4GwFYKj3cyCJTW3nFg35TNwelxaT+yueAgbKScTBcIoZEsCeyUahqhat5hhWIge
 HLcQo7dkK/gZ38Z1uMD04o2z5OHO9++iBEkvWWeutqCoS3CcxGyrHHLRTCDTXw/a/OHTUZvN4
 kleH6Yae12LIR7P0/9S7h4df+Fu30EioWPAYnN86hglLv5wXh/d8ZeFZRd5+IOYoQeYcKIqam
 SuC83ORPZKj5YF7OBWsWcMmR2EHnq+EBpwlZPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravindra Lokhande <rlokhande@nvidia.com>

Compress offload does not support ioctl calls from a 32bit userspace
in a 64 bit kernel. This patch adds support for ioctls from a 32bit
userspace in a 64bit kernel

Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit c10368897e104c008c610915a218f0fe5fa4ec96)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/compress_offload.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 6163bf3e8177..33d40d6fa3f1 100644
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
@@ -858,6 +859,15 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
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
@@ -865,6 +875,9 @@ static const struct file_operations snd_compr_file_ops = {
 		.write =	snd_compr_write,
 		.read =		snd_compr_read,
 		.unlocked_ioctl = snd_compr_ioctl,
+#ifdef CONFIG_COMPAT
+		.compat_ioctl = snd_compr_ioctl_compat,
+#endif
 		.mmap =		snd_compr_mmap,
 		.poll =		snd_compr_poll,
 };
-- 
2.20.0

