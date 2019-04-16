Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFAC20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfDPUWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:22:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbfDPUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:21:41 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MelWf-1ggbw644En-00akCZ; Tue, 16 Apr 2019 22:21:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 08/26] compat_ioctl: add compat_ptr_ioctl()
Date:   Tue, 16 Apr 2019 22:19:46 +0200
Message-Id: <20190416202013.4034148-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3cLQXVaj78IIldWV0E5molvs+Vy9QLxh58Bd4yL3smwUBpHfezm
 8XTJdRwsNVuUUiQNSjazq3JzYH9z9pTAqB2RN/oyGHMBBNs7ac8xe32Cgh9913wXNip4Uzr
 cmJWzgW0Es6glE+ICLxZSZbnmClTzY/2jI5LoGktjktovKm+DXd2t9O5OsNPJNVYqiqr4DF
 xFwYQvm7y2ABrFbdSPLwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M2anEmf9acI=:TvKqnxJ6XRR94QN9cSCD40
 J+VR387v9tanlAxZrH0w6Db8780kw37ZVZpFd/bfhS9vlExIReXxSQ042IqQARJhTXPbyPrdG
 0nUHe5dpYAZ0NV15AHLPMzxMWN+zmJpC5iTaHO7MW38GXY1GRLShZmvnKKYB20APzczL09snG
 y/CWhZcfJ4oKjrcpLuM8jTzzdpXR1EQSI9CdTcEXt0cz4TaixSyP/P0xEvxHGq/VU1TCikpHF
 Nzk3p145UyYz36klkKMhYY4VsHVD1D8RSuPvOuNF/dmCr8ju/Z5c44UmXnkmUReP/B6htFfph
 qlrxXmPEbiR8PO+GgAK4U28UJ5nSWhCai+rWcwKbf9pYrZ/DX6zGGc5j3xLwhdUtse+69vktI
 zuuuYql8aOCPfA3q4GKjDXZkScLytGoauzUQYCbBp3cJ3ZDl3+843OOtnI1Vm/GsrDRs0xvKi
 Fhs6Xg2MKcZmn09KiyEpS34kiDFMWiYtI392zcfPKkLcpvrIVsdQ33UGnxzEUHwduc/TqHgcx
 +1jMAca2T1xJdQh30nSQVPGidieJM/VODF9/kuIxwTElKHLeDPk4Yxwqh/QAsMexNo4rBjXYd
 VKo72Uf2PBnlefu4Q7qiBvBGiJnHQcLvQQ3Z8omdyY+I4P+Z0XCD+6G5n+ZZkZK/FAf+6bSys
 ZeSl4IZCVlcDIwZ3lyOHstkGWg8Y2+HtsOjqhLtI0y8DcDtRVAPwOF4uNVdTRm+zWA4Du9XtE
 KXVHrJZ2KDNESdKf2gs5PJOdTOjtTBQZu/vTaw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers have ioctl() handlers that are completely compatible between
32-bit and 64-bit architectures, except for the argument that is passed
down from user space and may have to be passed through compat_ptr()
in order to become a valid 64-bit pointer.

Using ".compat_ptr = compat_ptr_ioctl" in file operations should let
us simplify a lot of those drivers to avoid #ifdef checks, and convert
additional drivers that don't have proper compat handling yet.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use compat_ptr_ioctl instead of generic_compat_ioctl_ptrarg,
as suggested by Al Viro
---
 fs/compat_ioctl.c  | 10 ++++++++++
 include/linux/fs.h |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index fee116e822d8..ab2ff530313b 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -78,6 +78,16 @@
 	get_user(val, srcptr) || put_user(val, dstptr);	\
 })
 
+/* helper function to avoid trivial compat_ioctl() implementations */
+long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	if (!file->f_op->unlocked_ioctl)
+		return -ENOIOCTLCMD;
+
+	return file->f_op->unlocked_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+EXPORT_SYMBOL(compat_ptr_ioctl);
+
 static inline int do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e7679089..dc4138314635 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1698,6 +1698,13 @@ int vfs_mkobj(struct dentry *, umode_t,
 
 extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
+#ifdef CONFIG_COMPAT
+extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
+					unsigned long arg);
+#else
+#define compat_ptr_ioctl NULL
+#endif
+
 /*
  * VFS file helper functions.
  */
-- 
2.20.0

