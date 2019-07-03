Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E6AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17139218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+Wf2C2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfGCNSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:18:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38993 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:18:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so1250030pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hxbdbXfpKlWeZDFBNP3Rw24BZGkHIWmPL64L5H0l0/c=;
        b=S+Wf2C2Jk6z8AJKWBStHmtebpIIso91LHvvYA691oncofDQ035K6CNvwFp4FPWdc/o
         th6KmmOLsCbq0IP3ZraP6F0GaSnXRerXuV1a3mThha5wyjnhX+lFxvrZmg0Zs0vJT6CN
         PbQ2wH5PULpi8SDUiQG/x+HbwwDZZPNKTx7qSfYzZ1fsgvR5ejlACwb5Vyq647M05Z+9
         UFAAH+Ij+WNIojAkr2dtFepqI2QJBta2wOR3ie3l7UlYzX/JCUf44tEUrN4uv2gdMg2w
         5ix7u6m23OA0zmW/6KD6X1DZiDOItPzBIKeUZmlK7ymxumz7gil73ejTH54ZwWegwsbG
         bUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hxbdbXfpKlWeZDFBNP3Rw24BZGkHIWmPL64L5H0l0/c=;
        b=p22d3FK48WhfDagVW7bXkzyT4FVl8mxMOZWtDKk74xfb8jLJ6FxhbOYXQ0ezcPwkg8
         skWHbEG8sWFb7BmOBo9kENf6XtaiivCvp7Csl28Uoa6OwNYwAUJ0R5mFK+UG+b3HsAQd
         c/EIGpIswhg5Q/GA/zKvyoRRQvq9BCYnHvpohClbAu+n8h6Soa6brofIFIyVduBLpzBt
         RWoaQzX1I4geDLTYQ3I9sjpwYqXiXUw+3PubrQwYfbiar6xzF9Q/gIGY9lbgoz9A0z4M
         C9UkxYPOcrdJo3SMm+oLhdQHzVl7KL3SNgKKyk7gQBZ8PRYj5Zupfq6yuQKjvwRrfBfr
         5dIQ==
X-Gm-Message-State: APjAAAXvsuwtGTjuz69fDq1ojYfMA67RHhEZKEFMBCe8g1z47kTnF5PK
        UJeSmMx0PRtojyG8DevcCXBNonzh4/I=
X-Google-Smtp-Source: APXvYqwWXeTDUBXw2Z77WGyEDCYzisrNSswkhi+/e8nPWLosJdPMJRj2iFNQLcdvLTRTe0RTEl47DQ==
X-Received: by 2002:a17:902:2889:: with SMTP id f9mr40292230plb.230.1562159909865;
        Wed, 03 Jul 2019 06:18:29 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r198sm3713361pfc.149.2019.07.03.06.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:18:29 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 28/30] omfs: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:18:20 +0800
Message-Id: <20190703131820.25967-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 fs/omfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 08226a835ec3..1aa0c0a224b1 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -363,12 +363,11 @@ static int omfs_get_imap(struct super_block *sb)
 		bh = sb_bread(sb, block++);
 		if (!bh)
 			goto nomem_free;
-		*ptr = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		*ptr = kmemdup(bh->b_data, sb->s_blocksize, GFP_KERNEL);
 		if (!*ptr) {
 			brelse(bh);
 			goto nomem_free;
 		}
-		memcpy(*ptr, bh->b_data, sb->s_blocksize);
 		if (count < sb->s_blocksize)
 			memset((void *)*ptr + count, 0xff,
 				sb->s_blocksize - count);
-- 
2.11.0

