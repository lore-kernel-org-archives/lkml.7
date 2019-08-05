Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D82C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF3B217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="HkqdS5Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfHEGiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:38:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39487 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfHEGiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:38:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so39181851pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 23:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H0yUp64wfUQz7/P14zeAkDAdPbazrBmBRzsKkTj102k=;
        b=HkqdS5JfAzU5BEi1rePzJYVVta7pmYY9kcs8THIOz9I9OoWyVYFoS8yIydBOR4khk5
         NeMe6c/hV8JE8DIvkkaEz8yze8KZ1gP7tzk+8ey9ETPzgPATG5RgLbFTQ2SSaIEtF9ww
         6ZFeXT8qCQpIRrKSxqf1DLd7BnjBrA5abZ3VxSqjTOBPBP18qoUm5LLlvjyrM+cfIHfV
         e0l9CmNfliF9bLK/71XhHxS26xy1KnswmuImQ04lHQJerW1dB/mMVqRBjda0RZ116I6g
         pTFy2Wo6QOPDj2YsB8/flAFkdF3Hi2A7F/xY5Wzj9oBxQdd5g1vbsMV2JkgpPKSUMnfn
         iV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H0yUp64wfUQz7/P14zeAkDAdPbazrBmBRzsKkTj102k=;
        b=atiN9Iyzu/tpi2/UL7NbdAhUeNmsZGpxEXgBoYv11AJUrrQsInuryiQd8ZEqsdpRrN
         kxV8WJ8lSoptYP4OOkm0TPxjY/2jc4Ak/LJ9NR5pA015mwP/P4o21VzIquRYtlw66KxF
         SigKoPrGGiFr3U+c9QePSUBZvvWQG/22Nos4on9iAVgVQM/Ib5pzoMuBEnr23v0Cena1
         lhT1EvHXIELkWozPsN6xR+KriMCKF2rdgKHEVfTII5+07LEFa3hVF5vuYs0xh4eYaYUb
         iqDfsmWe55wj584y4EMW7ER5aQhv1jUnaYHavFQb0PoPYwZphK60IOusqh0Q2SaRrfxg
         soPA==
X-Gm-Message-State: APjAAAV8EZyv1lnLb+IBSSzSxEF73SaJ+IA/5RyH6fYld3ROy1KMO2h2
        m+sfcY/TQWX4HacnCaUAyR9Q+5RkFnnP1Q==
X-Google-Smtp-Source: APXvYqyWLOSI2+DYTh0Ld4S5k28wKqb34K9CG5dKxzGU+mc2z+KxEEsAAqZNhQ/hEc/DAJFUjB1lFw==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr62133295pgv.168.1564987094988;
        Sun, 04 Aug 2019 23:38:14 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id f197sm81442794pfa.161.2019.08.04.23.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Aug 2019 23:38:14 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, fam@euphon.net, paolo.valente@linaro.org,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        tj@kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
Subject: [PATCH v2 1/3] bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
Date:   Mon,  5 Aug 2019 14:38:05 +0800
Message-Id: <20190805063807.9494-2-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190805063807.9494-1-zhengfeiran@bytedance.com>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment of bfq_group_set_weight says the reading of prio_changed
should happen before the reading of weight, but a memory barrier is
missing here. Add it now, to match the smp_wmb() there.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
---
 block/bfq-wf2q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index c9ba225081ce..05f0bf4a1144 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -744,6 +744,8 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		}
 #endif
 
+		/* Matches the smp_wmb() in bfq_group_set_weight. */
+		smp_rmb();
 		old_st->wsum -= entity->weight;
 
 		if (entity->new_weight != entity->orig_weight) {
-- 
2.11.0

