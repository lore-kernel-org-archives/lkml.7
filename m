Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF0CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFCF20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dRvlgiVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfKDTXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:23:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43544 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfKDTXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:23:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id a194so18729922qkg.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=THuFq2IBXjmPNYhpv9M/ZPB2jpu/SvDJBuqEClLTgyw=;
        b=dRvlgiVnfY+0y5W5oZQGjAzRqKYHjf2QnKwmmLZwGlC7UZcF7946mkJ31cXCi+TiAU
         Wmmc49xWcpfh9Zvb7USWDmt2sttlewGaY6tCnff9DndqXU/3ddyTGZuXfxXXY6qbGq8u
         6EVk3Kdo+/3zeVYPdXnqoxEcO6vTi/NPrXUdVjpmUXJV1a61oUgb5bCaeYYWDJfdCRae
         kxxXAuf2DpmwIZsU2iBtHhjhILkaG4plyqJUgZCx9rboWI4KqMy1DkBu13aFARnmPrzf
         FY1o5ZFgyxPP+lz/oAeApSM00iPtrqM1LK0IH9ecp/qbslB9QHw+uR1H8sGd+ZsXYWrb
         xVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=THuFq2IBXjmPNYhpv9M/ZPB2jpu/SvDJBuqEClLTgyw=;
        b=S4HQEi2BTmnFc/gCZ83Y+ds7DztiXsMVmHt8ysY8u/Fx+irL5lXj3qhpRg7Nyh5JuQ
         FiWbub27nUzehiiiBzeUFgpnyNRvBAmZlN5iQ7z6ImrWnAxxPcjo4C5B67+Yxw7oRm3g
         3dmpZXhKpRpkLGcLZzEhkcZlX/rUkjQ2hn3n+AJJGp67tGyMn4VCFMwU71m1+ZgvAFf6
         jnKqK8J7A/mPcx/HejkQPkPv9amIWOXMdVSyVlmlM1cKzu9ThMiYTD4c9Xkfvfoo9lvX
         16r94+Ov/j9o5Ov29gXqkSF2TbjkOZCWOUOFHkEXoM8/XtvKSeitDbmmA8dIvvsyyQEo
         8LQw==
X-Gm-Message-State: APjAAAX4QDf6drBnaNCtg3cNcTAdGKCN33vOzuhnpN6cPPjxApZLp8yE
        krF6lpipYAvGo5Hw2WBayRX4TA==
X-Google-Smtp-Source: APXvYqyq06OqM6mRPH11h1O8n6TfjfcqIKm5RFZmh4Ii3187F/plXd/7FRACWMCiecvf47veeuWvMg==
X-Received: by 2002:a05:620a:149a:: with SMTP id w26mr3248212qkj.361.1572895397082;
        Mon, 04 Nov 2019 11:23:17 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i189sm1334181qkc.65.2019.11.04.11.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:23:16 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     steven.price@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/ptdump: fix a -Wold-style-declaration warning
Date:   Mon,  4 Nov 2019 14:23:05 -0500
Message-Id: <1572895385-29194-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -next commit "mm: add generic ptdump" [1] introduced a GCC
compilation warning,

mm/ptdump.c:123:1: warning: 'static' is not at beginning of declaration
[-Wold-style-declaration]
 const static struct mm_walk_ops ptdump_ops = {
 ^~~~~

[1] http://lkml.kernel.org/r/20191028135910.33253-20-steven.price@arm.com

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/ptdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index 5d349311e77e..a30ea0cf6c5f 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -120,7 +120,7 @@ static int ptdump_hole(unsigned long addr, unsigned long next,
 	return 0;
 }
 
-const static struct mm_walk_ops ptdump_ops = {
+static const struct mm_walk_ops ptdump_ops = {
 	.pgd_entry	= ptdump_pgd_entry,
 	.p4d_entry	= ptdump_p4d_entry,
 	.pud_entry	= ptdump_pud_entry,
-- 
1.8.3.1

