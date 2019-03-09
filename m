Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721E8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3221B20815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwaCZvbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCIRKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:10:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45254 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCIRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:10:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id h71so428392qke.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 09:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NH8QXcMMjhBsFyMRAq65Avqi1Qcz+azp11fj9GvyLqk=;
        b=pwaCZvbJWsjRTL6pdc2IpV51cHj7L+Zwh+C454Ez+Bn66e2JWB29yj78zJKFP5RHby
         lL3Z6oDcqffsrp7+sjLVFdlvhaAz3L27ZC2gfECKYHP7J55J5LtcQiZmY1VfDM9RFTyU
         OW9tBJf2AUsOMaZUg7k0CGk8ab1z89cW0/cdBeAH8VfVDM7AYqW+kgi6hnDOCrFZru8f
         66Rh/O4ldsP3KWFSYRAB/ypI/2ZH+e2Q5BJEHzjzrkzV7J+iqpsJ07eNb3riOuyPw3Jd
         mGsfuavuoiVfMIxa2ID+UVNKvQ2zhxWq/fxWYT8uY7HvTNK1+cQts4bM+0RgC4JLUmyT
         MTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NH8QXcMMjhBsFyMRAq65Avqi1Qcz+azp11fj9GvyLqk=;
        b=TQhWkskIpjJiHnO8CHPxGWq4DhfnLiKb2OWt5E33gBXqLEZqE7afJvLbCukZjdiBD3
         KjcQV9ewyKqqJtC8nPJmzylIID0E3P+QRSetrAxZbAFwb6mhwIA3WtjKTn6pXLeJ63gP
         L+mgzK1zNqCwReqvFcSEN+41492SzeGjQgIQ+tXMAOqXDXWTlJHQCf/+FpWcA2Y0Hshi
         w8FmqEXYSJpG1LYkUdSsoANjpJpEEzYop4vcsIWfRBFxKs6obe49ijl+VyG08pffZ/Mp
         DL/SnWHygn8m7S2+QHmCtvjcr0ghfrHGyr9yyQkuR5g64IgkShgx28nVoxMzgPti/Fzw
         hP4A==
X-Gm-Message-State: APjAAAWlIPvvaCImS2CzhNSpb8TKvJkgmio916jt0Q/1bhQ0CZ1TkTP8
        fgwd3Zb7iWYsU8ZAVNp+/gc=
X-Google-Smtp-Source: APXvYqzyMkrz4kmW6ZuOGMT0xSQxlxa0xs08wG6uigZSmyHsUtcvih/hgxjeNL6tf/mvyltr13g4zQ==
X-Received: by 2002:a37:e209:: with SMTP id g9mr17601479qki.310.1552151405342;
        Sat, 09 Mar 2019 09:10:05 -0800 (PST)
Received: from jdev.famaf.unc.edu.ar (proxy-4.psi.unc.edu.ar. [200.16.16.13])
        by smtp.gmail.com with ESMTPSA id f189sm500642qkb.79.2019.03.09.09.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 09:10:04 -0800 (PST)
From:   Julio Bianco <juliobianco@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Julio Bianco <juliobianco@gmail.com>
Subject: [PATCH] staging: erofs: add a new line after variable declaration
Date:   Sat,  9 Mar 2019 14:08:53 -0300
Message-Id: <20190309170853.8297-1-juliobianco@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new line after variable declaration

Signed-off-by: Julio Bianco <juliobianco@gmail.com>
---
 drivers/staging/erofs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 924b8dfc7a8f..1cf1afe2d73a 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -270,6 +270,7 @@ struct inode *erofs_iget(struct super_block *sb,
 	if (inode->i_state & I_NEW) {
 		int err;
 		struct erofs_vnode *vi = EROFS_V(inode);
+
 		vi->nid = nid;
 
 		err = fill_inode(inode, isdir);
-- 
2.11.0

