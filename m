Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48923C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAA12190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmGy/pSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfGXWzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:55:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38182 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfGXWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:54:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so22546767plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=He3hFXi90MosbqiSamTnu9D3+6VDTB+JURQA9mOByDI=;
        b=HmGy/pSRUREcRq2rJeHZpbhUfiPOCw154BfVI80ZghfpVkWaLO5FfT6/AeV76NXwGJ
         WVotN94y4ef3AG9KvDN2WavaHWjq9p3+ctqBh5Xk0GrTdWJlUE9j2Ez+1FSG3xgh6f2S
         maM7A2tmkHlzExSM0m3hkKlNnVk/t73NTRps1Ufl5Zf2hLd3tbuLvq0HY+Kto3rH26+a
         5y/d6ndr8PJRAthuWPEyFDSKuK7gYuiC4EtcQxdIkcNO0bu1rkwS06T6kwN3Zj8HGUaw
         T3EWtKs3LnkxvFzKJ7z6dgFmv0xEh8Fdl0J3oPuZm7epX3QIN//Q29BQ1825O1/TYxu/
         wSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=He3hFXi90MosbqiSamTnu9D3+6VDTB+JURQA9mOByDI=;
        b=ZKjER6NYBqRTZjGiuSvWCMAaqPzBNk1s4lmQtt/+uwbTLW1v7xmZObxIycY9Pl7Eb9
         sbiCG/op9AGK5fnlBbhNemtTvC5UFqFRcfEK5ATcDmL/vx1nm6dCl+UprhpSNBcMIVx9
         aaC0h0Q3YgISamnNkJEKIBUEujE+nbB60wCC+tHuISI59FvhJYVhY4qJQh34Iz4mD28d
         6S70GkQz2X62D+jZCK0GrIWd8RaAz2u4D1XVhnOJ3i9E8IlfBWNnU72yLDYawsC4AH0v
         its8ErdqXKOFiooH7kcRK8ozNiUwAlY5rJR8DYC2I9L0vDV2qtvZKfE6P80VmMNX0OG2
         9CPA==
X-Gm-Message-State: APjAAAWB8QKLYxSBZo5ERtfKg43GdMq4ebtqcSV/fPxuPQ9HUATe+Xq2
        cdf2Y6s8vU/AFYqAgM9yhBY=
X-Google-Smtp-Source: APXvYqzh0kpmiquu3e/h3eXcpuBzfU3bMywHvdY+v+JeSk5SbryJBgK1Hm1uJ7z3Aq0ZXrYVmPoIVA==
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr89379804pla.325.1564008897721;
        Wed, 24 Jul 2019 15:54:57 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d14sm59526525pfo.154.2019.07.24.15.54.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 15:54:57 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] lockdep: fix an unused variable warning
Date:   Wed, 24 Jul 2019 15:54:52 -0700
Message-Id: <20190724225452.24503-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724225452.24503-1-jhubbard@nvidia.com>
References: <20190724225452.24503-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For the !CONFIG_PROVE_LOCKING case, the "class" variable is left unused.
Rather than tease apart the functionality in lockdep_stats_show(), where
class is used to increment up to 15 local variables, this patch merely
adds yet another ifdef to fix the build warning.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 kernel/locking/lockdep_proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 65b6a1600c8f..86f0868a1bfc 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -200,7 +200,9 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 
 static int lockdep_stats_show(struct seq_file *m, void *v)
 {
+#ifdef CONFIG_PROVE_LOCKING
 	struct lock_class *class;
+#endif
 	unsigned long nr_unused = 0, nr_uncategorized = 0,
 		      nr_irq_safe = 0, nr_irq_unsafe = 0,
 		      nr_softirq_safe = 0, nr_softirq_unsafe = 0,
-- 
2.22.0

