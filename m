Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444E2206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="onavkD8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKLPls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:41:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35400 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:41:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id n4so15584066qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sffWfpS2QMNTM1duykbFQpzXK+3tOCKOX41PX9BWYJY=;
        b=onavkD8gXnY+DU1QMK2HKA+4DpFvljAtoowojpZNSn+s0cLs/O18OrDv8iBAq4FvUi
         KP1rQK3YeTpiD8U2k8ka7l4WIYaGpIXtkl1YuHLG0X7+/HdQwQQX9eMq4d4seNrJkVC4
         v7BknGxXQXa0cmzcJ8t08SpTlNcAxqENnpVyozDraXVtjL6x3Tn3uUkMMPOgNCaufeSP
         u1emdrAlE7gmBHpBDkZ9V8QtfG8cEx5wXeAkijgrB260ccDdVStO+rVW02zXe/5lAiVm
         C+PkYYbm+M4nvk7s2NSQeMuIzl8efyk4T/tTf0RHvXIACA1c7U7Qb242q/sFqhmzUsHr
         uEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sffWfpS2QMNTM1duykbFQpzXK+3tOCKOX41PX9BWYJY=;
        b=lO/YrmpuAqGc39qRzis//wOY0qgM+FAyv//dPUVcOnJozGpwx1z7YWe26NNl7v1t8K
         3xwEqv0zxmAqvB3qfRoTNnowRM3xBizRan0U7LBpBdkz1dD0i8A/S+qOCSFOD6K0ooGA
         EvOjW8OnAypb9JhDbbwqNlxEovBFKAHSej3s2QpvU5x6I3usW1YS7mYHdXB3Xusp1bhK
         7KCfCDK8rfCQ6EA6BSRS2Cuj8BKX0BgnIeH8OJYNFZxOOWse6c1Xdkspszv/Flr7RqgU
         //KTbxybKDxjvdbXpNn6sJawRJAkNqHkW7OzvltFEVw452QmgQHVRBWK+TezYCnE1Tu8
         GTww==
X-Gm-Message-State: APjAAAU7Nt92JUD6MEjYN4S6YbzAuHhAzgX7cDplCWR74IsxSBBbr/67
        qXApjLkprYHGCjud9HQpOFUZN6U195a/8Q==
X-Google-Smtp-Source: APXvYqxOd4pPWa64qwH77p1Z7pN3tfY2KsLmQ10aVuK7/GUr2f1dg31kFQIynxDKY1d2JLm22kN6OA==
X-Received: by 2002:ac8:4a93:: with SMTP id l19mr1888152qtq.121.1573573306337;
        Tue, 12 Nov 2019 07:41:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::aa8c])
        by smtp.gmail.com with ESMTPSA id n185sm8973944qkd.32.2019.11.12.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 07:41:45 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:41:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     tim <xiejingfeng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
Message-ID: <20191112154144.GC168812@cmpxchg.org>
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
> In psi_update_stats, it is possible that period has value like
> 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which
> truncates u64 period to u32, results in zero divisor.
> Use div64_u64() instead of div_u64()  if the divisor is u64 to avoid
> truncation to 32-bit on 64-bit platforms.
> 
> Signed-off-by: xiejingfeng <xiejingfeng@linux.alibaba.com>

This is legit. When we stop the periodic averaging worker due to an
idle CPU, the period after restart can be much longer than the ~4 sec
in the lower 32 bits. See the missed_periods logic in update_averages.

What is surprising is that you can hit this repeatedly, as the odds
are 1 in 4,294,967,296. An extremely coarse clock source?

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

There are several more instances of div_u64 in psi.c. They all look
fine to me except for one in the psi poll() windowing code, where we
divide by the window size, which can be up to 10s. CCing Suren.

---
From 009cece5f37a38f4baeb1bebdcb432ac9ae66ef8 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Tue, 12 Nov 2019 10:35:26 -0500
Subject: [PATCH] psi: fix a division error in psi poll()

The psi window size is a u64 an can be up to 10 seconds right now,
which exceeds the lower 32 bits of the variable. But div_u64 is meant
only for 32-bit divisors. Use div64_u64 for the 64-bit divisor.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 517e3719027e..84af7aa158bf 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -481,7 +481,7 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 		u32 remaining;
 
 		remaining = win->size - elapsed;
-		growth += div_u64(win->prev_growth * remaining, win->size);
+		growth += div64_u64(win->prev_growth * remaining, win->size);
 	}
 
 	return growth;
-- 
2.24.0

