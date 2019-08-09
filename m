Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B8C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429C82171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="NblyOw93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407173AbfHIRbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:31:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41207 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIRbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:31:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so35837902pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o4KyUArqXmkClyMndBwARjbgAguNJaXFLfZH+78C3Fk=;
        b=NblyOw93JRPVTmFr5sfAXmZSjW11mR/3bmjjggtv8t6I2F/6NpZYR70YToAJzZdftd
         cgbG4waoTnjLtthk6byMT+yut72nDrtMyvnwR5IW+w2wdO4PUpTS2dysfV15KfjtWZuY
         oj46fy0OqniYuAet1QfkFHfjXziev78OEQBTgVfg2MKCBwyV81neNmVrZXlAtyLkimcs
         S1k5R3v97gJVKAR6xbyxwCIiI4rhYTKeELLzorRMW+umEB69RnbMcux4CZYvDqsP73Pv
         o706rZCWSzeChY54iZjz8L7SNKpNmAHsAyhtQ75PoEZEX1haIhLCDpk6dITnX4edQ3gg
         Cb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o4KyUArqXmkClyMndBwARjbgAguNJaXFLfZH+78C3Fk=;
        b=O1oc9ps8xL89gWf1+uwm00l8XF5FBFxdsZafDmSHI+e3SDoVFNP+QmnOJmolMDVrPM
         ovFFKp+bxvC9HafvrqfTwFhbjUohUKtgv4rZhhI+CZhx74xq1gjWPeDqc2fQ75PLCzd5
         L99A7M6W6cWwDl3xPzmV6D2SmsIfuy1KP7VetE2A4CEpb/w7PF8PulyGfjGKx6q0Tf00
         GQ7mEC8c5GGHOg7stzf4srYawzjbkj4JFkS594iSwx9oxaQg8Oh6/90JCMN11HN3YDoH
         Jd/1k7J7XdrTACaydx/9AlvAbCE9Bwq4G8HiFr9fatFepga0Q8Au607vzaFy8gtuLRf/
         mn/w==
X-Gm-Message-State: APjAAAUN43V75+MFRF3MyGtwSl7BdkouwS35yIGUHDexMLpjAgq6nWWV
        PNa8VUDtsWzic3zLGgv2RnOgKkE4Goc=
X-Google-Smtp-Source: APXvYqzMr7pLWX9oUN+nN/IL/jhIcg+L8Yr6aSg8RTDdYi5us3s5rTWlZZfhmbsFg3tPpjihJVTQlw==
X-Received: by 2002:a63:3d4f:: with SMTP id k76mr18907892pga.345.1565371870824;
        Fri, 09 Aug 2019 10:31:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::ad32])
        by smtp.gmail.com with ESMTPSA id o95sm5483952pjb.4.2019.08.09.10.31.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:31:10 -0700 (PDT)
Date:   Fri, 9 Aug 2019 13:31:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190809173108.GA21089@cmpxchg.org>
References: <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
 <20190806142728.GA12107@cmpxchg.org>
 <20190806143608.GE11812@dhcp22.suse.cz>
 <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org>
 <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org>
 <e535fb6a-8af4-3844-34ac-3294eef26ca6@suse.cz>
 <20190808172725.GA16900@cmpxchg.org>
 <6e7f0cd2-8b13-7534-1c0e-f3569f8b4c05@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7f0cd2-8b13-7534-1c0e-f3569f8b4c05@suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:56:28PM +0200, Vlastimil Babka wrote:
> On 8/8/19 7:27 PM, Johannes Weiner wrote:
> > On Thu, Aug 08, 2019 at 04:47:18PM +0200, Vlastimil Babka wrote:
> >> On 8/7/19 10:51 PM, Johannes Weiner wrote:
> >>> From 9efda85451062dea4ea287a886e515efefeb1545 Mon Sep 17 00:00:00 2001
> >>> From: Johannes Weiner <hannes@cmpxchg.org>
> >>> Date: Mon, 5 Aug 2019 13:15:16 -0400
> >>> Subject: [PATCH] psi: trigger the OOM killer on severe thrashing
> >>
> >> Thanks a lot, perhaps finally we are going to eat the elephant ;)
> >>
> >> I've tested this by booting with mem=8G and activating browser tabs as
> >> long as I could. Then initially the system started thrashing and didn't
> >> recover for minutes. Then I realized sysrq+f is disabled... Fixed that
> >> up after next reboot, tried lower thresholds, also started monitoring
> >> /proc/pressure/memory, and found out that after minutes of not being
> >> able to move the cursor, both avg10 and avg60 shows only around 15 for
> >> both some and full. Lowered thrashing_oom_level to 10 and (with
> >> thrashing_oom_period of 5) the thrashing OOM finally started kicking,
> >> and the system recovered by itself in reasonable time.
> > 
> > It sounds like there is a missing annotation. The time has to be going
> > somewhere, after all. One *known* missing vector I fixed recently is
> > stalls in submit_bio() itself when refaulting, but it's not merged
> > yet. Attaching the patch below, can you please test it?
> 
> It made a difference, but not enough, it seems. Before the patch I could
> observe "io:full avg10" around 75% and "memory:full avg10" around 20%,
> after the patch, "memory:full avg10" went to around 45%, while io stayed
> the same (BTW should the refaults be discounted from the io counters, so
> that the sum is still <=100%?)
>
> As a result I could change the knobs to recover successfully with
> thrashing detected for 10s of 40% memory pressure.
> 
> Perhaps being low on memory we can't detect refaults so well due to
> limited number of shadow entries, or there was genuine non-refault I/O
> in the mix. The detection would then probably have to look at both I/O
> and memory?

Thanks for testing it. It's possible that there is legitimate
non-refault IO, and there can be interaction of course between that
and the refault IO. But to be sure that all genuine refaults are
captured, can you record the workingset_* values from /proc/vmstat
before/after the thrash storm? In particular, workingset_nodereclaim
would indicate whether we are losing refault information.

[ The different resource pressures are not meant to be summed
  up. Refaults truly are both IO events and memory events: they
  indicate memory contention, but they also contribute to the IO
  load. So both metrics need to include them, or it would skew the
  picture when you only look at one of them. ]
