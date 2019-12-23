Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0512073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="s7MOT20E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLWQm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:42:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37007 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLWQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:42:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so4594048wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 08:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ukxVfJh/BGwHOYNNZKAYUvoYhGnLhoqMqhQGTKoAgvY=;
        b=s7MOT20EmMGxZnxqyQdzHJGDnlnde7ZsvfDPM39Ld9xdIoraqf8wmJx+IaZ/9swJIU
         Kkv4qzaslRp4ICDhRik9/vdzZju0iS838I1TV9UXowRyuzmW69PA+v6rGgNromGwJzw1
         5rYXJuzj0h8ek08ZPpbaz9YwGGc7AouO72F8/Xm5zdZxesJGxzXEFTD0Rf7NA7qVtjyL
         IsIHZt3+4uXEcbKQhSeJFwprbGn1MbgRr0pu1FmSMqMNYx75hPSzLoX6occkeS9+XbrD
         ZQR08QVg9QhJ+42VnRb3n7Hxox9l1jD7tbfU5UYTLk6kGqTpy2Tjqelcyvcr/MZtp+p3
         a8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ukxVfJh/BGwHOYNNZKAYUvoYhGnLhoqMqhQGTKoAgvY=;
        b=d0veKKcvt+69K8mSBpNA6PuChPLKCbMO/mVxyyi/TxElCbcLTOhT5yNzTOMOz3Mly/
         EwePkaoKh+l2cpkVucJS1mLuFdWdymChRUb0p/s4QyfhXp7FqcqsP0YZDoA5J4McmJQb
         hINGqr9Z3KHvos/0IdtW0z7W+yRxlkoo6ZZUZjgxJ+jLocrN1jegzObgc/9vmuJ68cuj
         dkOQdYjIq8LJqykfieD8sZkeHJW+Ze6lVNXX8gtnXGkttR4Zhk96ZTMeEHZPfgaJr4pH
         5OcwP/GKUQubg+A5o7NQitzRw1nXh5uosWAqoE4MgCHf2q/5Mx3kgpNRnB/Q6e9VwVzm
         Lr0w==
X-Gm-Message-State: APjAAAVLsk+lvRj47wbhNbwSX47A+zhW0GxL5ER/aQRC7egw65OYCoRC
        vVifzrIJj2N8QZw49Cvhn9YNNA==
X-Google-Smtp-Source: APXvYqwCeAyFQR244xqoSO33ijfBZHTUX6Zzsc+6QEVmJpvqTP5oW1k9Ms2djsVhBv+Dz/rtHfP04A==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr31416903wrm.394.1577119343580;
        Mon, 23 Dec 2019 08:42:23 -0800 (PST)
Received: from localhost (97e6984e.skybroadband.com. [151.230.152.78])
        by smtp.gmail.com with ESMTPSA id t8sm20627820wrp.69.2019.12.23.08.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 08:42:23 -0800 (PST)
Date:   Mon, 23 Dec 2019 16:42:20 +0000
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Gonsolo <gonsolo@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
Message-ID: <20191223164220.GA14394@codeblueprint.co.uk>
References: <20191216103522.32215-1-gonsolo@gmail.com>
 <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
 <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
 <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
 <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec, at 02:50:49PM, Gonsolo wrote:
> > The offending commit seems to be a55c7454a8c887b2 ("sched/topology:
> > Improve load balancing on AMD EPYC systems").
> >
> > Probably the node_reclaim_distance variable should be moved from
> > an SMP-specific file to a NUMA-specific file.
> 
> There are two variables that are used elsewhere:
> 
> int                             sched_max_numa_distance;
> 
> Used in kernel/sched/fair.c and kernel/sched/topology.c. I would move
> it to fair.c.
> 
> int __read_mostly               node_reclaim_distance = RECLAIM_DISTANCE;
> 
> Used in
> arch/x86/kernel/cpu/amd.c, line 894
> kernel/sched/topology.c
> mm/khugepaged.c, line 725
> mm/page_alloc.c, line 3529
> 
> I'm not sure where to move this one.

Can someone test out this patch on one of the failing architectures?
(sh, ppc64)

---->8----

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e595b1d4..bf20e5883026 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1281,7 +1281,6 @@ static int			sched_domains_curr_level;
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
-int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 #endif
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4785a8a2040e..733890d913ea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3523,6 +3523,7 @@ bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
 }
 
 #ifdef CONFIG_NUMA
+int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 {
 	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=
