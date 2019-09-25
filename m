Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C913C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E9C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHadCcaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502032AbfIYRKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:10:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42583 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437796AbfIYRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:10:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id q12so3906834pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+jBc2CSetMNlK7QdXb0YLft4/BLzR5dJnratyqnpwHE=;
        b=eHadCcaYhW2D4fgyLXwrkM3CMk0j1zb4CDkXBk4LduohBqguf2KqmRBoZ8Z+fDb+8+
         MtTR+5YWcvFi35fzOzZcYm3NyY5zm1BnNm7G3g2meI318uwSrJxmdpV0TLiuwXnY2LGm
         5GpdzeVYkQjbz79wOWkdm4uGsv3eb2OB6mX+Q9pX35COFajISsSWFajgZ76dpXYj70zU
         JNPkBtiwPs4nCM4xFq4wrPAF8aryp3elKVtvBHc2lZ4t0lQ2jcmxkdOJrg5mVrPDfktA
         SHRx+G8+99o7mxFh736xOQaZ8w6h5ToX2HmKHTfNP5k1WnpvTyWqFVB92bhY8L7TPqpf
         OK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+jBc2CSetMNlK7QdXb0YLft4/BLzR5dJnratyqnpwHE=;
        b=HDGd+uoYpVTrjl2mX7AL0/ZU0QxmfnDNVLNZpjWmq5YGQmZWE3qrK/AXPDedRgXCY5
         TX+Rn1RhGrQf4eX7gU9M4Hr+Wog2IfgyCyd73O9dIE6RPPGG26IAPrIxJrv4tfeQbWwq
         5FCSGLzVgllf5+JKf5dKzZ8j/RyRCHtmmPsECplR57trzm6G2MNPHOzOdS9cSlOMhDeZ
         U/pPQIBlC5y2LR7A0PMwvPJvwdSEY2MWngFW5TynXL6HOfq0VcX+mwpWxUjLel2x8cGy
         DSw1LHSkftQtDaGB4bajMUvc91QuPUjZZOYoXdn6JRQ9RwdLWVsoylDt2do2gv3Qqrn0
         AOiQ==
X-Gm-Message-State: APjAAAVk0D228BDi35U6yDcAtgX5MPloJ8V1uMNZ7fkvM+oLxo7vtTNa
        8Qb1PMBU+kpdXaswRIZZQNhdq/geO0U=
X-Google-Smtp-Source: APXvYqzAuparAEMQO7ZF8eR08c9ftl3IiJj4TdNXnK9QgRrTUJly0P3EO6M20o/DqpQRZZ7wCN63KQ==
X-Received: by 2002:a62:8683:: with SMTP id x125mr10652531pfd.108.1569431421694;
        Wed, 25 Sep 2019 10:10:21 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([42.109.146.156])
        by smtp.gmail.com with ESMTPSA id e192sm8613264pfh.83.2019.09.25.10.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 10:10:21 -0700 (PDT)
Date:   Wed, 25 Sep 2019 22:39:42 +0530
From:   Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kernel: sched: fair: Changes data type from int to u64
Message-ID: <20190925170931.GA23927@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the data type of variable overrun in the function
sched_cfs_period_timer() from int to u64 as the return type of the
function hrtimer_forward_now() is u64.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bbf68c3161..7c97e9704ca2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4929,7 +4929,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
 	unsigned long flags;
-	int overrun;
+	u64 overrun;
 	int idle = 0;
 	int count = 0;
 
-- 
2.17.1

