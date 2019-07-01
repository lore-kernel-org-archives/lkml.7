Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41026C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1413D2146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbSa/XL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfGAPrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:47:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34760 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGAPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:47:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id u18so6246287wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OYbnfUR9dCYFLINXoIyX0GbGtAYWpqvIvnH71iWYfBU=;
        b=bbSa/XL2D0XSiOrgG+7e7u10xLBjPFGH5IozlqzrBvyBI056vpYcrC92X37b1DgR9k
         Ve2dh3k0Nw9Li5iqNW86i/48IN5qelgvuHjjy+/3h5zZL27kV6yfVPPSb7ZcLxWK/EiW
         x7jhjXpF6/1PMa/tX7EFJ2BH3ymhO9bgr7t8/1z+Svw5mOeNx6sI39Xe4a5ps4EZPh8y
         YYQUHLpJwx2iV06SC0gCPjMKhqsdZ/6JQPKuStigw840BMBBHHt//m+G2bXkvkvpZhWa
         Ya1chKqoOBgirMJ5hKSr7R+gg5+9DkhC6f+qvMBqB37ssg62kO0ARe66hp00uTS+Suds
         N4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OYbnfUR9dCYFLINXoIyX0GbGtAYWpqvIvnH71iWYfBU=;
        b=oHwKTziaAcCzdoX6NAtt0xVNG0XpXJH7ga9k2ZOnsCUtqsPNd7AP2aBPrlnfhF2MuP
         6FIPO3fyXC+vkI3X4DrWj8CaE7EN9nwn4IHkPrX5iTk2/KQb1qRe3L0vNFaBWQsNkwbG
         ynLdDaxfiLp2O3hdqVTub/VJD1BAynIcXGhORTsKmc4+BmMu4vThLEAORs/rGTCJxkeo
         c2xmQZWvqyeqxdYYjKPcOqwmJdWMbdPXEs6IpHkBwlYha7W28lMpS/+osK5vYTdcPHIe
         q24Oi0x+fHbaxXDDqePdSnpboxbA+4y8EmnUIGFkGWDw7fYIEieaCn7I1ur30Wi1NZJZ
         XWwA==
X-Gm-Message-State: APjAAAU4E+ydIh8+hZ0RQ5C6K4zicqlU1B0ZoW5TPa4rhrrn2d4U6Woe
        upA0N4gkmZJCChT+Ckcw2GytbuzV1PI=
X-Google-Smtp-Source: APXvYqx6w4di47uj+z9WMEszW5ASZwR2go01YFjwGWHKLlni6y6Di+fKXj/vS6wPZquD4rELnmkgTA==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr19063405wrv.347.1561996026093;
        Mon, 01 Jul 2019 08:47:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5dbd:30b:8a71:a020])
        by smtp.gmail.com with ESMTPSA id y16sm8300300wru.28.2019.07.01.08.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 08:47:05 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: fix imbalance due to CPU affinity
Date:   Mon,  1 Jul 2019 17:47:02 +0200
Message-Id: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The load_balance() has a dedicated mecanism to detect when an imbalance
is due to CPU affinity and must be handled at parent level. In this case,
the imbalance field of the parent's sched_group is set.

The description of sg_imbalanced() gives a typical example of two groups
of 4 CPUs each and 4 tasks each with a cpumask covering 1 CPU of the first
group and 3 CPUs of the second group. Something like:

	{ 0 1 2 3 } { 4 5 6 7 }
	        *     * * *

But the load_balance fails to fix this UC on my octo cores system
made of 2 clusters of quad cores.

Whereas the load_balance is able to detect that the imbalanced is due to
CPU affinity, it fails to fix it because the imbalance field is cleared
before letting parent level a chance to run. In fact, when the imbalance is
detected, the load_balance reruns without the CPU with pinned tasks. But
there is no other running tasks in the situation described above and
everything looks balanced this time so the imbalance field is immediately
cleared.

The imbalance field should not be cleared if there is no other task to move
when the imbalance is detected.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Sorry, I sent the patch before rebasing it on top of sched-tip and it might
conlfict when applying because it was on top of my ongoing rework of load_balance

This version is rebased on top of latest shced-tip/sched/core

 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b798fe7..fff5632 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8992,9 +8992,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 out_balanced:
 	/*
 	 * We reach balance although we may have faced some affinity
-	 * constraints. Clear the imbalance flag if it was set.
+	 * constraints. Clear the imbalance flag only if other tasks got
+	 * a chance to move and fix the imbalance.
 	 */
-	if (sd_parent) {
+	if (sd_parent && !(env.flags & LBF_ALL_PINNED)) {
 		int *group_imbalance = &sd_parent->groups->sgc->imbalance;
 
 		if (*group_imbalance)
-- 
2.7.4

