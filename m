Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D5FC04AA6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540BD2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f57FHpJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfEABHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 21:07:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41545 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfEABG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:06:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so7547020pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OLqlCdGifnXbJDeVsXrWrzyh1Q2u7Oi69jQbP0f+asI=;
        b=f57FHpJ5TFR88oCECdqZ5veBYfcE1BKJQLnole8kARqKQqmUBSto9h3qlLmU4gyISD
         JMwn+Olvo/q5gs3AsNwtxVjNTSiHanUefEgJGXeqM2RAXhPx7O3cnkEqGpdfQnfL7KAO
         xtNs1P4JLOROUf9HljO5LCnRKpr/svXGq3l6OJ2yynGwhQeWL+1f+gGqIAyT/yMLCEes
         xdDR/8n3c1VwJifrFIsDjpYjhv1vVCw0HsAZp0KJrHfghaBQ6eeZvnVv3X0N0gvzfQB6
         DvjPX+Tv9H6RLm3siGibNr9a4ra9lR4l4WBTV282f8xoKQXjQpTNrXhuMk/qY0oXHgP+
         h7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OLqlCdGifnXbJDeVsXrWrzyh1Q2u7Oi69jQbP0f+asI=;
        b=LI7kXfE+3T48wiWqojhDv82bOaYzSf1g6r8XqMT1UPj5pgHhtezZLJTMkG5lcIhYG1
         vpuVK8uZc+xipKBPejguAuIWCHImAlb0gk0KHtxEbn0s2ObJYfQxIUupZS3r4JMt+9Cl
         A/BiMk+VaB6CHoyIFVSPCBvZCE4R8UlXTqtHzlHuBoNCwWCSVMBb+iT4RuEy1RWLR1am
         NTYt5TbKBLJ6osOq31/iusBC1dSvHXP+BJioUClue6jWwrsMvDBWg2eWazdsZ3DwM7QB
         74/9i0asjXx44RpxZfZ099RoGAkZs5O0tqiRJQe1LZNsaKMsDmeuM+FLh15olBjtuqfW
         6dag==
X-Gm-Message-State: APjAAAWbBZ1ZzSobsXFm851WprBeUSC/2JbYB2bZJOxiCzJ3YZlwOF55
        /iGiQQpwNAPvYxg873OX4OM=
X-Google-Smtp-Source: APXvYqxNDihCBF3w9VIZv+La7NAGr9r46gV71wHBl31KYr9Uyqd8211ztTSUU/REYyg8Eurk5DDBGg==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr72879435plm.3.1556672816197;
        Tue, 30 Apr 2019 18:06:56 -0700 (PDT)
Received: from localhost ([2601:640:7:332f:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id d8sm41008582pgv.34.2019.04.30.18.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 18:06:55 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 7/7] cpumask: don't calculate length of the input string
Date:   Tue, 30 Apr 2019 18:06:36 -0700
Message-Id: <20190501010636.30595-8-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501010636.30595-1-ynorov@marvell.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New design of inner bitmap_parse() allows to avoid
calculating the size of a null-terminated string.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 include/linux/cpumask.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 21755471b1c3..d55d015edc58 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -633,9 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
  */
 static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 {
-	unsigned int len = strchrnul(buf, '\n') - buf;
-
-	return bitmap_parse(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
+	return bitmap_parse(buf, UINT_MAX, cpumask_bits(dstp), nr_cpumask_bits);
 }
 
 /**
-- 
2.17.1

