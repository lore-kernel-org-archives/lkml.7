Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A18C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB63217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5lZgDhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfEUICn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:02:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35347 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfEUICl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:02:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so1819773wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOhhDvGFx5TQBrV3vUuuJNqU81qFULp2qAUcY70tdpo=;
        b=U5lZgDhD03GpNQCNQxmESbv9lWfJZcDrizZYolBCQqWW/xEYt9UwLILokyg8eZw2fv
         OoHDixUXEs4MfaUj9VCaYKeLQ6CgxSEf+3dN3WetIPP+SUCRY7n1qJjhUO9i7So752mT
         eOVjY3sdJA+kTXkPvE52Mc0lf6Qz9kuRXbijZTvxFeFXk/rtACX7jccmZp1RgxGZpYNb
         R8icSFl8ioKe7x+3GqeaG1+kGo2RQ5tP0EH7tAtsrz9RlLQT0gbcEiXM0C89oq41RMxJ
         131Ipwk/vsUv5tD+3ALHha2SVRHMkreikP5BaMJXOjM6YlJ28mWz/Gj0x3kuklYPyrNb
         hU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOhhDvGFx5TQBrV3vUuuJNqU81qFULp2qAUcY70tdpo=;
        b=uWi0SfaGdtcIwvpx2EIDGiay5Q0O6SIhoDJiXpJo2n6KIbPdma+ZxbPzv/DD+FPppj
         ngiNUWx6RL49T5a7Vm1i5aGs87ik5cVDMTstLDF/+rYxVdz0E2X0TG9GAWnbgRkjFeyc
         cQAibQLqGaNWY1MkA6dVpt8ON5h/ysh1vPPmwFmWFk6rlZEXUn7JEfz4T2q4+Nmi8Vqe
         2sUo6995yJiK2flNS0pMBpFvQ6ccdIfznuNu6FY7uJIYXq8ElZy3YJdAcCyg1vWVYWLe
         XxbCc5aTe6ftQuOGZjcO7pbJL2D22haquYIa+HtgWwiOWjlTzm4sJz5X1MDWSUHCqPpP
         HCsg==
X-Gm-Message-State: APjAAAVrVlaokdjzURsuR4IrR/Qbfm4TYXaxmjkqgKgCHJ4QPPCFeCP0
        22obsxJaTs4/uWiZpIAZ8e8Yiw==
X-Google-Smtp-Source: APXvYqyspoPg9SEqm8OAK4EKMduyZ0wkoaz46tnzvrFz0D5YKN4kzgcvCqAOYUkBdjzY7BugddgXkw==
X-Received: by 2002:a1c:3287:: with SMTP id y129mr2330502wmy.153.1558425759355;
        Tue, 21 May 2019 01:02:39 -0700 (PDT)
Received: from localhost.localdomain ([88.147.35.136])
        by smtp.gmail.com with ESMTPSA id p8sm11322301wro.0.2019.05.21.01.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:02:38 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Angelo Ruocco <angeloruocco90@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/2] block, bfq: add weight symlink to the bfq.weight cgroup parameter
Date:   Tue, 21 May 2019 10:01:55 +0200
Message-Id: <20190521080155.36178-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521080155.36178-1-paolo.valente@linaro.org>
References: <20190521080155.36178-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

Many userspace tools and services use the proportional-share policy of
the blkio/io cgroups controller. The CFQ I/O scheduler implemented
this policy for the legacy block layer. To modify the weight of a
group in case CFQ was in charge, the 'weight' parameter of the group
must be modified. On the other hand, the BFQ I/O scheduler implements
the same policy in blk-mq, but, with BFQ, the parameter to modify has
a different name: bfq.weight (forced choice until legacy block was
present, because two different policies cannot share a common parameter
in cgroups).

Due to CFQ legacy, most if not all userspace configurations still use
the parameter 'weight', and for the moment do not seem likely to be
changed. But, when CFQ went away with legacy block, such a parameter
ceased to exist.

So, a simple workaround has been proposed [1] to make all
configurations work: add a symlink, named weight, to bfq.weight. This
commit adds such a symlink.

[1] https://lkml.org/lkml/2019/4/8/555

Suggested-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b3796a40a61a..59f46904cb11 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1046,7 +1046,8 @@ struct blkcg_policy blkcg_policy_bfq = {
 struct cftype bfq_blkcg_legacy_files[] = {
 	{
 		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.link_name = "weight",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_SYMLINKED,
 		.seq_show = bfq_io_show_weight,
 		.write_u64 = bfq_io_set_weight_legacy,
 	},
@@ -1166,7 +1167,8 @@ struct cftype bfq_blkcg_legacy_files[] = {
 struct cftype bfq_blkg_files[] = {
 	{
 		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.link_name = "weight",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_SYMLINKED,
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
 	},
-- 
2.20.1

