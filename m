Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68890C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F322081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5WoVIom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfCISb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:31:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42394 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfCISbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:31:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id u7so854438qtg.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5pcmfqLxKhNNFdMwZ7KXfx6L/RP0Zv0nhwMF1T1BdAc=;
        b=U5WoVIomOUMQl0tza85xdGfvXZPXh9uW0sTDc6MOO9N5Z8WJxS0bR4yvLEFb6rLKeL
         npOtu23T2lLZ89a/EtaKMbsO5YNdw8N4Kivr8zgrGHGX+RUJ3wOaCHGYHpV7LwE8VcoK
         a4ERD5sAr45e3yvDWku8dprTFv8y25ZaKpMnj8sk0zTXjoxQQbBStRo2+3O2mnilhzVT
         dRKeLq4BcvXpt5g99XtjwuzNc/BnAznwsL5qbFmoKgL3dOu8aMoFjW3q7rw1jGcQCeYR
         izn28ADJD6GGBEmYU5W5fxnkRc6lmI94zcMGtGDgcT6qvVUkRxAz1c9N9EJInDAEx6qP
         ecYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5pcmfqLxKhNNFdMwZ7KXfx6L/RP0Zv0nhwMF1T1BdAc=;
        b=hFSiK3DH+efJD/2mJznm3vnav0Yjj6KxIBi42bdK3x9h6ecTfapdPNEvXEx05CguRv
         yHufblF2j+MtnYlx0oOs09CYzJ4TSwZ1UmbcVvExoyPoZavSSE9dfmqboqmjO1lAxJ39
         GgpEcvLYErfRrUwatv4tUDRFyciSVm88uHBMbp91iXt+BxTkMcQL3xDsz4XsfVQ0hm/3
         Mu8u6iSeJdsrsvJVNj76mh8wYKsCum2FYvzU3pu4V6b0CKfD86O4JY35s4uDGvZI992O
         UuRTcauOwMQ1zllphHDg/kpaGJRAbSJrhSojRb2q0q89l5lbilcNq53zedFwo2MO0e19
         EPSQ==
X-Gm-Message-State: APjAAAXOR/sZ/tVCBBF0iJ7f+a6uXaLseGehZ5nuBLk50aiuFOBUNe+/
        UEAr3ejo3RDTJJsqkoheq40=
X-Google-Smtp-Source: APXvYqyFVPb6jTv3+uUVx0LyWB6m/vXGwX7SG7aFCHLdLFMPma2bIvNKwy+cNDEMVgELil6jxQDTRg==
X-Received: by 2002:ac8:38ba:: with SMTP id f55mr19437605qtc.192.1552156281049;
        Sat, 09 Mar 2019 10:31:21 -0800 (PST)
Received: from localhost.localdomain ([191.8.88.159])
        by smtp.gmail.com with ESMTPSA id f8sm558824qkl.11.2019.03.09.10.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:31:20 -0800 (PST)
From:   Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
Subject: [PATCH 5/5] Staging: rtl8723bs: os_dep: Set constant on right side
Date:   Sat,  9 Mar 2019 15:30:47 -0300
Message-Id: <20190309183047.10781-6-gui.maeoka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309183047.10781-1-gui.maeoka@gmail.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place a constant on the right side of the test.

Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 262b70e88e67..2ad28d903ef8 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -109,7 +109,7 @@ static int readFile(struct file *fp, char *buf, int len)
 		rlen = fp->f_op->read(fp, (char __force __user *)buf+sum, len-sum, &fp->f_pos);
 		if (rlen > 0)
 			sum += rlen;
-		else if (0 != rlen)
+		else if (rlen != 0)
 			return rlen;
 		else
 			break;
@@ -137,7 +137,7 @@ static int isFileReadable(char *path)
 	} else {
 		oldfs = get_fs(); set_fs(KERNEL_DS);
 
-		if (1 != readFile(fp, &buf, 1))
+		if (readFile(fp, &buf, 1) != 1)
 			ret = -EINVAL;
 
 		set_fs(oldfs);
-- 
2.17.1

