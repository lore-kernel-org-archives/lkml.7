Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6ABC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4E020656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfF1Kke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:40:34 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43775 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1Kke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:40:34 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mqrjz-1iJykT2h0L-00mrot; Fri, 28 Jun 2019 12:40:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix 32-bit linking
Date:   Fri, 28 Jun 2019 12:39:52 +0200
Message-Id: <20190628104007.2721479-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i9pne7gOZCrulnXnNLDG96catfF75e570yRKxFiuSSGz1wserXj
 V+2v6vNon66+ukSkKeYP5KgkYiApttcBaBPeaidxkb24oPlO/LH7M7D126r1GBTEdd3AUPT
 XVYSmsJyz5A2TCi4arN4hYixkHJpsVxqxfNhgPx8TlBTZfg/yCy23rrqI9LR6mBaIymqMc5
 Jm+Rl+eFnIXH0yVU148rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FR3HnG46Egc=:FDEAcdE/ll0BOROb5cxi1M
 2FF8mxEX6+baPUmlZWdyJJpJKqbmA+3tQ1w0h0leqhhoQ1ShzEK8Xg7EIzW59cXLTdEeMRjyO
 F3BXMV6Uw4i1jlubPWxCMnKIXmXPDWFkEDOTRr6KkNaRJLz7GcJcFPm0cP/VBGRgVbmIPbM9o
 VVzx6vgrWdknzPhbQbcUs8MgDgmORUd3uXP9/HRwbNoZFXMlgpsURQSBnV9DE06w3Og2jtLPx
 tyv4GD2nwmjH9PHWDqKp5zaLjbIgxjYX9FQcIDHLxmuQBcz584TpU2m6GfyhyhoTFvyiIrLNq
 vas2qDxdSSatWX9kb9NTDPOw2ACY5XBmeA6kLu6HIw+ke4k1FEAbMyN5QnJkx3UMr49WQ2nnF
 PDDd2RGdVu/DWE7WcxMnNO03Xc5PUH6Ng62S1PwM459/E3/uaJRGPBVXA+Bbcs8HhVWtt3sQX
 CS7kSAy3BbQAgCWY1H8yRqkuAeGegCERgf5T8Wa+Y4bZVCNpRS/qyLcNBV2D/YLX8yVU20D2k
 XJZ9BWn3LpPLkR5+liH14GSKQioBe9bzcbyN2vOBygcGMyCyZeaewEMsMAtAGIKSmsROqlfC4
 3NG9W+OLmLG7unFxXcGzAGqBwXQ+ahaE0fOddfCO4gbiLsZ5rWXzYnWXf3li2/JDHvjCu985l
 II8BRHvm+HVJRqHL6oHR36eQM1d/WVhzRKqoYlu5WnP1pfWyttVi8DHJTnTYnLYaTpCsBAAmX
 Fn9UVF3LVasLObondlhoddMRvzhJMYQoUN63NA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all architectures support get_user() with a 64-bit argument:

ERROR: "__get_user_bad" [fs/f2fs/f2fs.ko] undefined!

Use copy_from_user() here, this will always work.

Fixes: d2ae7494d043 ("f2fs: ioctl for removing a range from F2FS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 998affe31419..465853029b8e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3066,7 +3066,8 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
-	if (get_user(block_count, (__u64 __user *)arg))
+	if (copy_from_user(&block_count, (void __user *)arg,
+			   sizeof(block_count)))
 		return -EFAULT;
 
 	ret = f2fs_resize_fs(sbi, block_count);
-- 
2.20.0

