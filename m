Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1DC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDED2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nouW5bnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfKQRof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 12:44:35 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:38400 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfKQRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 12:44:35 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 7DE70988
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 17:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w-v5soyHgjiC for <linux-kernel@vger.kernel.org>;
        Sun, 17 Nov 2019 11:44:33 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 56A0596C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 11:44:33 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id x206so10961435ywa.22
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mw/Vlkzgb0El0NgG+DOgWe9VKjNKfsd7T66YcI7lk7A=;
        b=nouW5bnh81fiK2GHy9gbyrglpuSBnRnypaqCYXUs73el/DrH1SM7Lqio9sMJ0rffZq
         q4PB21vYm8aMgrD/Hv7++x780RkHvayKQQjmJGMCUF2Gj6YRPcFDUue2n2MeJ7zDDUQg
         kXXMjj5Q4mvganZCikxTcMdxBRGwG9PqJvpP6hmL7TsrQA5b/uC50RYL61as66DCx5KZ
         etPqQ3Mt9GM3fSvo3bDBixJzFDqQf/YXqs81+YPiGti7A2gbAJx8JjIGsIAfG5nwaqme
         +sDB6VV4IB3JYhdVZdCbDpdoN9/4xX3vLmVvq0Och6ryCH6qZheFXevyqRYAWLIJi2Ug
         p0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mw/Vlkzgb0El0NgG+DOgWe9VKjNKfsd7T66YcI7lk7A=;
        b=je/fQosyDqJqMSCG9XmlXUAuGAqerqZpROADCou77kFLJcq3UeukR8KhLGHriW4OX1
         tP685UhKmlht0GneCXUWuUzl04il6MAIcsfre2g1BbIlg1p4mPTs4B1isHOIhjI0pmzz
         e6VjbkqmcSzmsKCGQPaImbQO/7YvTnGDqGUW8oCGo5lTf6Z5d1Rc7L/HQYY9qnq82CuE
         /7E8nOjTUz4w7ts0BRvGEyCCzkr7ebewWU1KN2bvE9Ba/Ke1JFTfDp+v6xq52suoGzK5
         WR/ZxWeyo8E4r5BTX0lQU6leXTl4czSl+naKxdEHA0haQpxGi7gfoMN3fLl4P9V8eu3A
         qjYg==
X-Gm-Message-State: APjAAAXFUDSKM1bxIY38R9ARRDsFb53yGB+xLSvGdYs2BTfe+tsWc6Kp
        5NIpgq2FQQ0f5VSMsT04OLby0j7+2GeKKXDyhBoxBmogbFbBflcv4ADi9+8kLhkR1S1BX5hWYZZ
        K6Tg6+CF6YOw9yiNruD+jcngElM91
X-Received: by 2002:a25:2443:: with SMTP id k64mr21290817ybk.69.1574012672777;
        Sun, 17 Nov 2019 09:44:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpBTogweemKa79wfzPNbsHtrixwjsjnmo4IwYBoUO8ucS52TaPZMbffuxkMrolaHWZppACPg==
X-Received: by 2002:a25:2443:: with SMTP id k64mr21290797ybk.69.1574012672478;
        Sun, 17 Nov 2019 09:44:32 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id f10sm1914590ywh.86.2019.11.17.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 09:44:32 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: Reduce the severity level of logging errors
Date:   Sun, 17 Nov 2019 11:44:12 -0600
Message-Id: <20191117174413.2876-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other instances of critical errors that call BUG(), kmalloc
failure in jffs2_wbuf_recover does not require pr_crit. Replace this
error logging with pr_warn().

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/jffs2/wbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index c6821a509481..59e145220b51 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -339,7 +339,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 
 		buf = kmalloc(end - start, GFP_KERNEL);
 		if (!buf) {
-			pr_crit("Malloc failure in wbuf recovery. Data loss ensues.\n");
+			pr_warn("Malloc failure in wbuf recovery. Data loss ensues.\n");
 
 			goto read_failed;
 		}
@@ -354,7 +354,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 			ret = 0;
 
 		if (ret || retlen != c->wbuf_ofs - start) {
-			pr_crit("Old data are already lost in wbuf recovery. Data loss ensues.\n");
+			pr_warn("Old data are already lost in wbuf recovery. Data loss ensues.\n");
 
 			kfree(buf);
 			buf = NULL;
-- 
2.17.1

