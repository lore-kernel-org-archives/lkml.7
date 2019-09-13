Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3622C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03EF20693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R58ufm5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfIMRLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:11:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41715 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfIMRLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:11:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so18451980pfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EAgfAE9/X+plL47tISm6pcn0A81GG2Ia3PbX4b/5cuw=;
        b=R58ufm5U4j39FnWWNt2t2BDJP1afdAUnznyPuRzYGBe9rbkBEPj/WBcjoN5AWIFNTb
         Ero5JDZkHrsl928NLVWY84uA6SWqrEhz30ENeyoN97gXpQ6t7U7kklNA+HIMlOTXJwOY
         o5zZw26zCltS/BMJx1EV9YcUaNkqgMe7ocYsuqez+S6xBShpHpscfd6AzG+iuYZ2nguu
         GF6NS9nXbwOxuruDkuLc/BpHxwqq8DQ4g/0knW1Olva8eKbU0AJip/EIhpxNGChi4mUi
         Tht0Vi7yDK8OzLUR3dG8cJ03YN/6S4egCfSjUfe1vLDDAWyraKHITK+Kyv+TXXBA4kw9
         10RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EAgfAE9/X+plL47tISm6pcn0A81GG2Ia3PbX4b/5cuw=;
        b=E3VytdFt61h32+huKqQOPmDYXcGE2B0SBT8t8qkmI9s3e+MsEjA3BpFK+iRp82UVsI
         //6qiMI7wnoLYdWoGX/Qbdtx5ds+vGss8fhffa/3N4zqL2wDT2WW3LX0i8aw1ZfFtWlY
         wMTuAKM/tykG+7eMuHlhYvN01vIsHnFZHgplSjpKeydRWwhFLe/848yeHddDPdGLAN99
         eUf8QzSpbQfr4hd50gMeoP5a56hA+oclqDLgEZ0Jxfvz5CQg1WK/2gO6CsWK+oQeEIbc
         qU/J3sdL1lmMVqKLfRQR1wq3lWB+KC8lrlXwGHA/wlSFH4QmbOO7w8zTDHwqgyo4efEC
         8AwA==
X-Gm-Message-State: APjAAAXd9LbGvb0veYP5PyKMx13Rc2exlE8eKil7dNIX4IHyyiSTtkL+
        UM/0hhEytFLXhuXf5dY37s4=
X-Google-Smtp-Source: APXvYqw5IodN9ClNfpvOqzmKBkV2oBIaWriNHuufubVwgb6hsVebeq2Gf7c5HxBeW036AUt5vAgUSg==
X-Received: by 2002:a17:90a:2243:: with SMTP id c61mr6359026pje.39.1568394706675;
        Fri, 13 Sep 2019 10:11:46 -0700 (PDT)
Received: from SD ([106.222.12.17])
        by smtp.gmail.com with ESMTPSA id t9sm25684545pgj.89.2019.09.13.10.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 10:11:45 -0700 (PDT)
Date:   Fri, 13 Sep 2019 22:41:34 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     me@bobcopeland.com
Cc:     linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] omfs: make use of kmemdup
Message-ID: <20190913171134.GA10301@SD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace call to kmalloc followed by memcpy with a direct call
to kmemdup to achieve same functionality.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 fs/omfs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index b76ec6b88ded..788b41096962 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -363,12 +363,13 @@ static int omfs_get_imap(struct super_block *sb)
 		bh = sb_bread(sb, block++);
 		if (!bh)
 			goto nomem_free;
-		*ptr = kmalloc(sb->s_blocksize, GFP_KERNEL);
+
+		*ptr = kmemdup(bh->b_data, sb->s_blocksize, GFP_KERNEL);
 		if (!*ptr) {
 			brelse(bh);
 			goto nomem_free;
 		}
-		memcpy(*ptr, bh->b_data, sb->s_blocksize);
+
 		if (count < sb->s_blocksize)
 			memset((void *)*ptr + count, 0xff,
 				sb->s_blocksize - count);
-- 
2.20.1

