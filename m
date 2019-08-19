Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8361FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0C7214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfHSVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:55:14 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41052 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHSVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:55:14 -0400
Received: by mail-yw1-f68.google.com with SMTP id i138so1450740ywg.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j8ArHqoH8hRKY32uSG2n9B6xxahAFt/eVeW0eXi2ctw=;
        b=OTBwoCirHelODOBjjYOT7yneJNZw5CzlMnZuFXAqQkis6e/8UdUGhzDxJOMqlbaCR9
         r8gqq0xrzkT7nBS+CO4lvk+m/cNA4tDaFIfbITigoZkc3gQET0O5pJXf6kM4361EkS8R
         ftU29Fvre7SHYH6I5Ioj5C0H5rkXPYj9ez4CDwwS9Z2tix//NO+ddJhsihSGd2clmMsJ
         MgJK5X+rCwCUcdVOM2xdw6jI4LOAY8gB1OSiBv2LnHFu+sKr7WWDg1wre/exzLZej1Za
         J2FLP//bHIFcUhO1a6RQ/YpP5DsbvEJXYAVKZdkeHZfoEoSjwOtsKqZoVQPtyprv538b
         mnVA==
X-Gm-Message-State: APjAAAVeGYFU+czGsryg/pAlSa/kY/nn+xkpu/3V0g88WCeba20oAMtt
        WiX5u6ajPsmkJmD+vKMPb5g=
X-Google-Smtp-Source: APXvYqySihgswsPdsn5yT2rV1y9hK5Ju/ANr2ecCzBrhFmjclQf/vl/w/di3HiumNmRyWIEBt434dA==
X-Received: by 2002:a81:f81:: with SMTP id 123mr14292554ywp.469.1566251713421;
        Mon, 19 Aug 2019 14:55:13 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id x10sm3491960ywl.16.2019.08.19.14.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 14:55:12 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org (open list:JOURNALLING FLASH FILE SYSTEM
        V2 (JFFS2)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] jffs2: fix a memory leak bug
Date:   Mon, 19 Aug 2019 16:55:04 -0500
Message-Id: <1566251705-7133-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In jffs2_scan_eraseblock(), 'sumptr' is allocated through kmalloc() if
'sumlen' is larger than 'buf_size'. However, it is not deallocated in the
following execution if jffs2_fill_scan_buf() fails, leading to a memory
leak bug. To fix this issue, free 'sumptr' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/jffs2/scan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 90431dd..5f7e284 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -527,8 +527,11 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 					err = jffs2_fill_scan_buf(c, sumptr, 
 								  jeb->offset + c->sector_size - sumlen,
 								  sumlen - buf_len);				
-					if (err)
+					if (err) {
+						if (sumlen > buf_size)
+							kfree(sumptr);
 						return err;
+					}
 				}
 			}
 
-- 
2.7.4

