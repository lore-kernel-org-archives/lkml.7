Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC8EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A239D22CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfHTDY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:24:57 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45584 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfHTDY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:24:57 -0400
Received: by mail-yb1-f195.google.com with SMTP id u32so1444787ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 20:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4PBL1bXvyffgnqpG9faUgGd+kgjbdB5K1WLVO2WjDew=;
        b=GUBytnQtvYblaKV2zZRWWVQcBxrJpYIkERwgzfTea6kYifhPNx73DwpNoml1u74an0
         m/QSp3plmdxjmuokRqSyeJ9mGFqlEfGHM8Tru9cwcN+1aCR2cK8dFTplhmJlNbHaBPnX
         8GgBZ4JoGVoKfJTEcxbFyaU031PTtKcELRDvEs+6R4Rw5ApgMOkmGHMOWCvpwu1d3NT9
         8V9eIhMuN4STTuUkDcJ2I28U4ifCYanAKkVZMvSV6d3zobZ7UslBc8p1ysNAJIWQsGiY
         cNpW3JFRX+E1rVRo056697qSYCPfWVVZoDYGNxFqM6yXbddUpr4c/lE33H2N2IE9xnQo
         N8eA==
X-Gm-Message-State: APjAAAW+rynsN9fnat1ozMIFkWFzysBeXn09xkufvUCIaPTLnTIOIdCH
        tUX+gXMAYKXFRZ2yiST+LtsGhi+JpG3zfw==
X-Google-Smtp-Source: APXvYqwjd36M+vpwT56jVjRWh+3YbgE5fUREcpEx9vjB6p47mzp7sGfFmYw2dqsktm+c0GUqDzehjA==
X-Received: by 2002:a25:324b:: with SMTP id y72mr6698233yby.361.1566271496511;
        Mon, 19 Aug 2019 20:24:56 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id t63sm3433010ywe.103.2019.08.19.20.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 20:24:55 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org (open list:UBI FILE SYSTEM (UBIFS)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ubifs: fix a memory leak bug
Date:   Mon, 19 Aug 2019 22:24:50 -0500
Message-Id: <1566271490-8533-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __ubifs_node_verify_hmac(), 'hmac' is allocated through kmalloc().
However, it is not deallocated in the following execution if
ubifs_node_calc_hmac() fails, leading to a memory leak bug. To fix this
issue, free 'hmac' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/ubifs/auth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index d9af2de..8cdbd53 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -479,8 +479,10 @@ int __ubifs_node_verify_hmac(const struct ubifs_info *c, const void *node,
 		return -ENOMEM;
 
 	err = ubifs_node_calc_hmac(c, node, len, ofs_hmac, hmac);
-	if (err)
+	if (err) {
+		kfree(hmac);
 		return err;
+	}
 
 	err = crypto_memneq(hmac, node + ofs_hmac, hmac_len);
 
-- 
2.7.4

