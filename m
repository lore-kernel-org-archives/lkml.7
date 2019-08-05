Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7C92182B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="wIkzzujg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfHEGiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:38:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46238 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEGiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:38:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so15964507pfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 23:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CBE2RxQAGoG3LaBnrWD40VvQ1s3Zc1p2YNjhDaVQZYE=;
        b=wIkzzujgXkOVi7Ki0cOf1lHqXj2TsWK0iWppP0cX5E3NgPSgD8LmlqqnGfCdKrmOiW
         YC/5558MPEGyzGrLSZ/odKYU7SfqvwQFsv0QK1xirJeTtwA3ZmCKproGKzoWSM7MgYoL
         K0npL84yKbwslvnXFud6giJKc+gi9NEoBx2fNCqY4fj2B7BUGQzEQSU/hIUcR/xVX/uP
         w0ezOuEvrOWAUqFBppcVxdk1fgWYqqXd6Z80d6FzzQ7Spsk5x8FZuRUW4cSlYw2ZVyi7
         FT9nGH7wXkDm+naORN+RByCHNchfJqSW62DZyHPvHzUR7FFNS+zpMBdGpmE5rm6xB8Pk
         74DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CBE2RxQAGoG3LaBnrWD40VvQ1s3Zc1p2YNjhDaVQZYE=;
        b=h2I/Gce3cWcdpBeEzOcP5lfwpqz0Hu/Ev5yvgQCuJIyY4KUbkgasr46uDamwRKR0Qd
         kmq1XRNCsZ2E9TZwoqE5qUrGKkDTuMYQDqYG0MKZYKfmAi0t3F8CU1dqLd9wy8Q8jGii
         hhXZa/IK7/GtC12F8PFcykIXlt5ZFcJlvxjL0rlhYK29pUuJ8FXEeIvXopgARqFQTcN+
         wBpdd6A13GgR7npc/tFyqEjF/Z87UXO8Kgz15MEW4LSb1DZmOIKQYMgyE85o+ZpZpYUi
         nXIRfH7x+F5X93FCBIjT3Ld/gi7x5TnqzcQzAvanudtdU2ne2iBk0YWC2goodEVEYjvI
         8uXw==
X-Gm-Message-State: APjAAAXFqvOFdObtp8ADibo2jHvKo980Mm0gpLJVnWK4Ha0m4BI87ofy
        aNyRg8MaG4pqw6BHQ8EEB4Ip1frczri7Sw==
X-Google-Smtp-Source: APXvYqxrDgdZFYrMxcKjIromxiq2TaMO++88ERtAXgo2iUcKdNBh/yFnVEf+6gcNSAoVDfjhziuWEw==
X-Received: by 2002:a62:f250:: with SMTP id y16mr71199579pfl.50.1564987098995;
        Sun, 04 Aug 2019 23:38:18 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id i124sm150930671pfe.61.2019.08.04.23.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Aug 2019 23:38:18 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, fam@euphon.net, paolo.valente@linaro.org,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        tj@kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
Subject: [PATCH v2 2/3] bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
Date:   Mon,  5 Aug 2019 14:38:06 +0800
Message-Id: <20190805063807.9494-3-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190805063807.9494-1-zhengfeiran@bytedance.com>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function will be useful when we update weight from the soon-coming
per-device interface.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
---
 block/bfq-cgroup.c | 60 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 0f6cd688924f..28e5a9241237 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -918,6 +918,36 @@ static int bfq_io_show_weight(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight)
+{
+	/*
+	 * Setting the prio_changed flag of the entity
+	 * to 1 with new_weight == weight would re-set
+	 * the value of the weight to its ioprio mapping.
+	 * Set the flag only if necessary.
+	 */
+	if ((unsigned short)weight != bfqg->entity.new_weight) {
+		bfqg->entity.new_weight = (unsigned short)weight;
+		/*
+		 * Make sure that the above new value has been
+		 * stored in bfqg->entity.new_weight before
+		 * setting the prio_changed flag. In fact,
+		 * this flag may be read asynchronously (in
+		 * critical sections protected by a different
+		 * lock than that held here), and finding this
+		 * flag set may cause the execution of the code
+		 * for updating parameters whose value may
+		 * depend also on bfqg->entity.new_weight (in
+		 * __bfq_entity_update_weight_prio).
+		 * This barrier makes sure that the new value
+		 * of bfqg->entity.new_weight is correctly
+		 * seen in that code.
+		 */
+		smp_wmb();
+		bfqg->entity.prio_changed = 1;
+	}
+}
+
 static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 				    struct cftype *cftype,
 				    u64 val)
@@ -936,34 +966,8 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
-		if (!bfqg)
-			continue;
-		/*
-		 * Setting the prio_changed flag of the entity
-		 * to 1 with new_weight == weight would re-set
-		 * the value of the weight to its ioprio mapping.
-		 * Set the flag only if necessary.
-		 */
-		if ((unsigned short)val != bfqg->entity.new_weight) {
-			bfqg->entity.new_weight = (unsigned short)val;
-			/*
-			 * Make sure that the above new value has been
-			 * stored in bfqg->entity.new_weight before
-			 * setting the prio_changed flag. In fact,
-			 * this flag may be read asynchronously (in
-			 * critical sections protected by a different
-			 * lock than that held here), and finding this
-			 * flag set may cause the execution of the code
-			 * for updating parameters whose value may
-			 * depend also on bfqg->entity.new_weight (in
-			 * __bfq_entity_update_weight_prio).
-			 * This barrier makes sure that the new value
-			 * of bfqg->entity.new_weight is correctly
-			 * seen in that code.
-			 */
-			smp_wmb();
-			bfqg->entity.prio_changed = 1;
-		}
+		if (bfqg)
+			bfq_group_set_weight(bfqg, val);
 	}
 	spin_unlock_irq(&blkcg->lock);
 
-- 
2.11.0

