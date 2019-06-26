Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6A6C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2032204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvDQGUVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFZDay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:30:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42666 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfFZDay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:30:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so516191pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XEppC4gbVPEQZR2Kaz9anVmct3U9E6CQXzdvNSwq1Ug=;
        b=BvDQGUVtDtNQ7wVRM4ZcJUkLAAGKMIKZ0UDtl2Oh+1gZu1ofLLAx+tszz7+XgiyBi0
         0TYiU7s8/ypL/n+Ujtg8347fmHKFXF4CMa5LUdBN3DZq8XBOs34RJWe0H7p7nrB5/qaK
         9Xnq1WiqUHrRCZe8TNKBvYAGok5miHwxEoFvT4KZxkYRzbgSHTef7an/9WqazjeExLz3
         9uYc7E4INcSqiwzXCEfysccdK3IT+RGtD1wC/P2Qf65k4YRZzOEeSDToSpQ8lE0YJPED
         gw5sjcUAyMq0BXzlgiDtbRNkk0wFV+Y5NaWZlKfjIHSBiGWhgDEP3BQiL+BjI8VXa1pI
         TatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XEppC4gbVPEQZR2Kaz9anVmct3U9E6CQXzdvNSwq1Ug=;
        b=UkZt8Xxq3hjuB22KNLlQxyVLXTt5GDvqYTgy5Y+XxPXhVGtLSW/I0gn5wpVQop+NSd
         Hchut7oxwN3TtDAWjHvoJNnWw7qExWzOyAOxpxLhXDcsEGqhN/xjsSKH48rWPV6Og53Q
         Nmm3yCG8T5HHhZgn1K91SQDgYQ+q6YVDzEAPE1BxG+41LYIVmA5NGXZGkNAoI4KcL5QC
         0t3BgnJFSKbGJKANjCkDVsoKL1pf89Z/CXVjo/Iqw08/YJ+26Si/5kfQx/HrsI+Ljyo2
         KI7vqzFIIYaT7/tkvmyNMOpWHpw1TxKZEsLQTQ6ZhYmdbbUsZVUhSodP/KDsOFJjyyi3
         9YYw==
X-Gm-Message-State: APjAAAVFMPpDkK3QlXcrd/SJL2IJoif7S9czVPMTKR0LGzPXB/MMbP8E
        KJON5V2JEmx+fViRJZRyiTU=
X-Google-Smtp-Source: APXvYqzgXOaBd0m6wSY+5AEmeAN7rUcjZ0f2dRq9xOhDTJHdBtUUM+yHvKK/xbj+X4pwJYOReCeAKQ==
X-Received: by 2002:a63:4e5f:: with SMTP id o31mr536783pgl.49.1561519853560;
        Tue, 25 Jun 2019 20:30:53 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id t2sm16053325pgo.61.2019.06.25.20.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 20:30:52 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH RESEND] staging: erofs: return the error value if fill_inline_data() fails
Date:   Wed, 26 Jun 2019 11:30:38 +0800
Message-Id: <20190626033038.9456-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We should consider the error returned by fill_inline_data() when filling
last page in fill_inode(). If not getting inode will be successful even
though last page is bad. That is illogical. Also change -EAGAIN to 0 in
fill_inline_data() to stand for successful filling.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index d6e1e16..1433f25 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -156,7 +156,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 		inode->i_link = lnk;
 		set_inode_fast_symlink(inode);
 	}
-	return -EAGAIN;
+	return 0;
 }
 
 static int fill_inode(struct inode *inode, int isdir)
@@ -223,7 +223,7 @@ static int fill_inode(struct inode *inode, int isdir)
 		inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 		/* fill last page if inline data is available */
-		fill_inline_data(inode, data, ofs);
+		err = fill_inline_data(inode, data, ofs);
 	}
 
 out_unlock:
-- 
1.9.1

