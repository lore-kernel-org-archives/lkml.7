Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1617C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBC6206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="eDsDWskl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbfDQQDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:03:50 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44768 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:03:50 -0400
Received: by mail-yb1-f193.google.com with SMTP id u187so9290350ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRTGHEZ2P8IOenNpGB+9Wp9aVSXnSjOQvSDcZRVNsO8=;
        b=eDsDWsklfWOL2hK7nDALTNMMlTlJIAJEonP3lzTed+JBPFsy1zrHu5SfdLbRcQudn3
         vvGH2YGnaYPplAORrscyf+5TkmpiilGWvS6Xzld53D1WN94AVV5fvBJ6FvzmtW7K1V2u
         eF2EgewWaoAURpfkJiITXWwUHrro3eMOkD1XVDiIryzdAAsDFpq6JyqqhNHCrSzEXNXm
         fKx6TXJ1tE8HLk9w8ij1TqxuHD7QqxHT6ySUFCsKnTzXOat6L48ifdDVtD2KWNwqkzye
         4jUMSvyYPhGDH4gX5dSJDL1H4PZdCtqaoYYVamJqrOZL4vNQbUp/mj3z1qlY3U3vzZEU
         /Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRTGHEZ2P8IOenNpGB+9Wp9aVSXnSjOQvSDcZRVNsO8=;
        b=fB7BgTF7jYXJWvuB0alS3yAdaxQkN+8fWNGC3Y3UNIWk5S5mlWCm4aT7N4wb6t4Wsm
         JlBK7mL+JSrV2wwL8FsuLFM621t4rroPIBFKpZi//1UTmtiQhCo7IVfeMks+spgKoUNQ
         CUwyM/eYqRp52oKO5IYMkViA+EOS2dyEG4AWLlYU677EendumbXKL+rKo8BpfXibWnO9
         Z/LSZW/IRJ+94G8pPE3Iw3zVCvEvh9Rcx42x+fy3/B7lbjA+iIi6yRYDcO2Wo55bFWiX
         x6uinVcOtUaj34ClYhTzIsuLjoz3D9SsaZXUcYaLauyNe5VXKkxQnVhzaNRS0iG2frPo
         a8Ew==
X-Gm-Message-State: APjAAAVnXdz837VKTbTK3UBPI6k0eTYDwSuOjdxnAbnq/vF4RH7i3Vyh
        KAWQzknLdq0TpTj2mWMrmhUouA==
X-Google-Smtp-Source: APXvYqyB4+2uikIAtAhDit0gTTnf/Zwxa7aFIrGyV05hh5hG7sgu2yY9yunwx34n0IGmVamXTC5MwA==
X-Received: by 2002:a25:9784:: with SMTP id i4mr59451217ybo.394.1555517029056;
        Wed, 17 Apr 2019 09:03:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:fc54])
        by smtp.gmail.com with ESMTPSA id l82sm19329426ywl.6.2019.04.17.09.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 09:03:48 -0700 (PDT)
Date:   Wed, 17 Apr 2019 12:03:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     akpm@linux-foundation.org
Cc:     guro@fb.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: +
 mm-memcontrol-make-cgroup-stats-and-events-query-api-explicitly-local.patch
 added to -mm tree
Message-ID: <20190417160347.GC23013@cmpxchg.org>
References: <20190416015132.yxxUAu8Rx%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416015132.yxxUAu8Rx%akpm@linux-foundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 06:51:32PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      Subject: mm: memcontrol: make cgroup stats and events query API explicitly local
> has been added to the -mm tree.  Its filename is
>      mm-memcontrol-make-cgroup-stats-and-events-query-api-explicitly-local.patch

From 65f026fe5481f8dc32b3dc3b97994f8cdc82dd17 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 17 Apr 2019 11:08:47 -0400
Subject: [PATCH] mm: memcontrol: make cgroup stats and events query API
 explicitly local fix

The lruvec_page_state() -> lruvec_page_state_local() rename should
have been part of this patch, not the previous one.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 871c661ca8be..6e99a8b9b2ad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2979,7 +2979,7 @@ static void snapshot_refaults(struct mem_cgroup *root_memcg, pg_data_t *pgdat)
 		struct lruvec *lruvec;
 
 		lruvec = mem_cgroup_lruvec(pgdat, memcg);
-		refaults = lruvec_page_state(lruvec, WORKINGSET_ACTIVATE);
+		refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
 		lruvec->refaults = refaults;
 	} while ((memcg = mem_cgroup_iter(root_memcg, memcg, NULL)));
 }
-- 
2.21.0

