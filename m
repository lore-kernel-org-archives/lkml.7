Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41624C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C52320866
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574696817;
	bh=Ny6lop3d8OCuPBF/M6hCSIX9bwpLPqscXgrmdHRemVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DEpTKvvp+2tScw2ZCW5xDWNSh6wA1yaBXL2ZHrmu89sjMSNMMtHk6vausCyeoy00Y
	 LjmLRgscSISVZYjtUrCnhbIFoM2T4DwopFTWyN4v9MoNwu7t7FcOG+wH4l1Utjwolf
	 d6AKfz7kiVaDXBO2aU+PPDhM+GMfQn36qrMtUSdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfKYPq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:46:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51728 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfKYPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:46:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so15697130wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuIgeyITz3hMqeZdtOyVywD/hNAEdNGAJ5DgsDKYZg8=;
        b=T/JmJDPZ4z2hhzHeWCm6DStHv3tUzayhVAlyOVsg+k70A6J/SZ39HlaLZZ1KacQWjp
         leQimfGw01Go88pn4ySzHMnp7plYcGBB06cFtNlBguJ4ZphnPC4Ui5F/B/dhUQCvFdri
         1Pwt7Q6mtaBtTBZVg/3UEVOJn68xOBrRBZGd6u8ssDqNpLKFrcdyM1svlrpUNMuf/jra
         o13YktGoCbbYipfE1T8mY5bgQlb8e5p367yLdia+UUtfqI+WoFpFAdLFgQB9Xldiz0Ka
         dXHkbKvRu16Taf6IErK4lpO/Qht/v7s7GRpuaOMSawqAP1fxXA8VBLphmzX0Sq2W51fM
         lHSA==
X-Gm-Message-State: APjAAAXa+SDoiq4jH/T9+v+nnCQZFBC804tuDomIztMN9Bu88Zpuh4j6
        VR48MwfGz33/6HVrEYtw7FYrQbGq
X-Google-Smtp-Source: APXvYqykJqodyyfq8OLxx0nqs51Z8v7G5EX8tYJjoHrygdNlt0J5kGY9cBZxHsD+/it0jF7dfO/jEg==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr22657988wmc.131.1574696813540;
        Mon, 25 Nov 2019 07:46:53 -0800 (PST)
Received: from localhost (ip-37-188-171-132.eurotel.cz. [37.188.171.132])
        by smtp.gmail.com with ESMTPSA id u14sm11051978wrm.51.2019.11.25.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:46:52 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:46:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pengfei Li <fly@kernel.page>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191125154651.GA31703@dhcp22.suse.cz>
References: <20191121151811.49742-1-fly@kernel.page>
 <20191121180401.GL23213@dhcp22.suse.cz>
 <20191122230543.2f106c80.fly@kernel.page>
 <20191125084058.GD31714@dhcp22.suse.cz>
 <20191125224603.688cb69c.fly@kernel.page>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125224603.688cb69c.fly@kernel.page>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-11-19 22:46:03, Pengfei Li wrote:
> On Mon, 25 Nov 2019 09:40:58 +0100
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Fri 22-11-19 23:05:43, Pengfei Li wrote:
> > > On Thu, 21 Nov 2019 19:04:01 +0100
> > > Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > > On Thu 21-11-19 23:17:52, Pengfei Li wrote:
> > > > [...]
> > > > > Since I don't currently have multiple node NUMA systems, I
> > > > > would be grateful if anyone would like to test this series of
> > > > > patches.
> > > > 
> > > > I didn't really get to think about the actual patchset. From a
> > > > very quick glance I am wondering whether we need to optimize as
> > > > there are usually only small amount of numa nodes. But I am quite
> > > > busy so I cannot really do any claims.
> > > 
> > > Thanks for your comments.
> > > 
> > > I think it's time to modify the zonelist to nodelist because the
> > > zonelist is always in node order and the page reclamation is based
> > > on node.
> > > 
> > > I will do more performance testing to show that multi-node systems
> > > will benefit from this series of patches.
> > 
> > Sensible performance numbers on multiple workloads (ideally some real
> > world ones rather than artificial microbenchmarks) is essential for a
> > performance optimization that is this large.
> 
> 
> Thank you for your suggestion.
> 
> But this is probably a bit difficult because I don't have a NUMA server
> to do real-world workload testing.

For this particular feature you really do not need any real NUMA server.
Your patch shouldn't introduce NUMA locality. All you are aiming for is
to optimize the zone list iteration.

> I will do as many performance benchmarks as possible, just like Mel
> Gorman's "Move LRU page reclaim from zones to nodes v9"
> (https://lwn.net/Articles/694121/).

Be aware that this will be quite time consuming and non-trivial to
process/evaluate. Not that I want to discourage you from this endeavor
but it is always good to think whether your final goal really has a
potential to a visible optimization. I might be wrong but only the page
allocator should really be the hot path which iterates over zonelist
so a microbenchmark targeting this path would be something I would start
with. Unless there are some really nice results from there I would lose
more time with other benchmarks.
-- 
Michal Hocko
SUSE Labs
