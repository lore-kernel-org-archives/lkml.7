Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48225C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F71E2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfC1PGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:06:01 -0400
Received: from foss.arm.com ([217.140.101.70]:45862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfC1PGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:06:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE66A15AB;
        Thu, 28 Mar 2019 08:06:00 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6F063F575;
        Thu, 28 Mar 2019 08:05:58 -0700 (PDT)
Date:   Thu, 28 Mar 2019 15:05:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        cl@linux.com, willy@infradead.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190328150555.GD10283@arrakis.emea.arm.com>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <20190327172955.GB17247@arrakis.emea.arm.com>
 <49f77efc-8375-8fc8-aa89-9814bfbfe5bc@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f77efc-8375-8fc8-aa89-9814bfbfe5bc@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:02:27PM -0400, Qian Cai wrote:
> On 3/27/19 1:29 PM, Catalin Marinas wrote:
> > From dc4194539f8191bb754901cea74c86e7960886f8 Mon Sep 17 00:00:00 2001
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > Date: Wed, 27 Mar 2019 17:20:57 +0000
> > Subject: [PATCH] mm: kmemleak: Add an emergency allocation pool for kmemleak
> >  objects
> > 
> > This patch adds an emergency pool for struct kmemleak_object in case the
> > normal kmem_cache_alloc() fails under the gfp constraints passed by the
> > slab allocation caller. The patch also removes __GFP_NOFAIL which does
> > not play well with other gfp flags (introduced by commit d9570ee3bd1d,
> > "kmemleak: allow to coexist with fault injection").
> > 
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> It takes 2 runs of LTP oom01 tests to disable kmemleak.

What configuration are you using (number of CPUs, RAM)? I tried this on
an arm64 guest under kvm with 4 CPUs and 512MB of RAM, together with
fault injection on kmemleak_object cache and running oom01 several times
without any failures.

-- 
Catalin
