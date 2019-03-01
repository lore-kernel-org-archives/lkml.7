Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6249FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D7F20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmhla2Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfCAULd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:11:33 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:36556 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCAULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:11:33 -0500
Received: by mail-oi1-f202.google.com with SMTP id x133so11123202oia.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3hpFHv++6lINrXCZce6bR2Tiv/iZaZvnV7r9EzurSfU=;
        b=fmhla2PwlRngkyFtebovmQTRPmpLEKgikP6Eo+rs+8f/wF1v/VoRjYGUZIT7cXFH9L
         Axx4Klw2f8Qn7TvrjXAbkKj8vcx9HByFqMqroVCb9vOueEZBGjpeMiv1m8ndi54PZGPz
         oE3MlJOcBFLaSHZjLGZvt44Ma8PcAirS3vJaF5QM/SDlWlZTx5vmf5ppkUoCMTV1ERp6
         JEK/PN895LedwBGRGDwYTwmCgLxQOUqaEEXEssZisEFY0bfmrNAvLnT8rYs9GE9qrPh4
         z5rPJAi4b5wMjCbkbqJPgaEEs+lQz2llqtVWSILtG4LiRLACNAOuBTUiqYLG/SYv7NVw
         Qnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3hpFHv++6lINrXCZce6bR2Tiv/iZaZvnV7r9EzurSfU=;
        b=kJd+UU1DiVAm/IUAi0v/XYsFmfCybYc+T7H55slBOAHL+jPdsJ3Sx4qx2i9daiy1bh
         Qk4yjSmF6jKGtdwHRv3Ma0piOa03HDJKGAnJLJ56T//h4sYqupO4B6X8T5hB/TlX5jlp
         HfQv6KKactpz6GZulBGB/pjEG/GUtFbnG6GsLnm1VlFcFqUep70LMa6eKdYIgPJHQypy
         HzfF5cIUKAKo9R3R4yIR1m5XcMqK+CCokBFWDQfSrBcpMyOzAAtJjDGxjGRA6Zvyk1O5
         isTjd7fssL6rYlNBJNrWTPyLjpSSgpGGXynzebydeRskMfWr00fPIbcsSWEpgvKuOdLS
         Nr5A==
X-Gm-Message-State: AHQUAubhnlU+W8yIXxd0uRlCnz4oD2UOozp0Y0mNdaqZjYd8vdPgapB5
        akdcVXPSq26NxnZjjdr4VRU6FXz6Qg==
X-Google-Smtp-Source: AHgI3IYlexV92H/vTL4nL7PMUDgEktQWZKSaB4ByX1Qz5WJU1EL+aUVQd2heZLXYUTMdUFBKE1Vl28dPhg==
X-Received: by 2002:aca:4812:: with SMTP id v18mr3939257oia.30.1551471092559;
 Fri, 01 Mar 2019 12:11:32 -0800 (PST)
Date:   Fri,  1 Mar 2019 21:11:24 +0100
Message-Id: <20190301201124.19858-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH] staging: rtl8723bs: use kernel_read() instead of open-coded version
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jannh@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the manual call to f_op->read() under KERNEL_DS with kernel_read().
This also reduces the number of users of the legacy alias get_ds() for
KERNEL_DS.

Signed-off-by: Jann Horn <jannh@google.com>
---
 .../staging/rtl8723bs/os_dep/osdep_service.c  | 23 ++++++-------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index e14d7cc411c9..4378827243f0 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -107,7 +107,7 @@ static int readFile(struct file *fp, char *buf, int len)
 		return -EPERM;
 
 	while (sum<len) {
-		rlen =fp->f_op->read(fp, (char __force __user *)buf+sum, len-sum, &fp->f_pos);
+		rlen = kernel_read(fp, buf + sum, len - sum, &fp->f_pos);
 		if (rlen>0)
 			sum+=rlen;
 		else if (0 != rlen)
@@ -116,7 +116,7 @@ static int readFile(struct file *fp, char *buf, int len)
 			break;
 	}
 
-	return  sum;
+	return sum;
 
 }
 
@@ -129,22 +129,16 @@ static int isFileReadable(char *path)
 {
 	struct file *fp;
 	int ret = 0;
-	mm_segment_t oldfs;
 	char buf;
 
 	fp =filp_open(path, O_RDONLY, 0);
-	if (IS_ERR(fp)) {
-		ret = PTR_ERR(fp);
-	}
-	else {
-		oldfs = get_fs(); set_fs(get_ds());
+	if (IS_ERR(fp))
+		return PTR_ERR(fp);
 
-		if (1!=readFile(fp, &buf, 1))
-			ret = -EINVAL;
+	if (readFile(fp, &buf, 1) != 1)
+		ret = -EINVAL;
 
-		set_fs(oldfs);
-		filp_close(fp, NULL);
-	}
+	filp_close(fp, NULL);
 	return ret;
 }
 
@@ -158,16 +152,13 @@ static int isFileReadable(char *path)
 static int retriveFromFile(char *path, u8 *buf, u32 sz)
 {
 	int ret =-1;
-	mm_segment_t oldfs;
 	struct file *fp;
 
 	if (path && buf) {
 		if (0 == (ret =openFile(&fp, path, O_RDONLY, 0))) {
 			DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);
 
-			oldfs = get_fs(); set_fs(get_ds());
 			ret =readFile(fp, buf, sz);
-			set_fs(oldfs);
 			closeFile(fp);
 
 			DBG_871X("%s readFile, ret:%d\n", __func__, ret);
-- 
2.21.0.352.gf09ad66450-goog

