Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A92CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BCA205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571869878;
	bh=DWYa+x0xITM9x5wWaEuEOfOVystvbEdQhFiEO2C4nug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gTs4jzPuSDwHarqiECA6SNqm2KTR1VRCI/0drWuplXz6zWJ/NQyiRzExk5G2KD4tX
	 24CbaJ1XAI1bRvb7wjqBSUCVKgrGuVSW0pLXumrHAhkhwzVEfaXEsshUPOLWlREbpu
	 OihU/z0YgTgsuHhim531tpyVjMcvzxvOrbSfCJgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407867AbfJWWan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405952AbfJWWan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:30:43 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E159E205F4;
        Wed, 23 Oct 2019 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571869841;
        bh=DWYa+x0xITM9x5wWaEuEOfOVystvbEdQhFiEO2C4nug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ro1EeVpxrO5SIABm2XMFzd+1A3Hs7vUtQSbjUTQneiaoSYyxXKyDcXhVU9MLn/cun
         +Txt75/UI6hdcK8IC0nlOtxvpX5xXqCTUatAcX/AF7o1JSn+1sXMigEF8fDQ1p0tYO
         Rb1a3EToiaRUk9iIugb2w7CdCN90dZW4Gikl4dzM=
Date:   Wed, 23 Oct 2019 15:30:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-Id: <20191023153040.c7fff4bc7c86ed605fc4667f@linux-foundation.org>
In-Reply-To: <a4398f60-c07e-8fa9-c26d-3b8f688e65a1@redhat.com>
References: <20191022162156.17316-1-longman@redhat.com>
        <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
        <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
        <1571842093.5937.84.camel@lca.pw>
        <a4398f60-c07e-8fa9-c26d-3b8f688e65a1@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 11:01:04 -0400 Waiman Long <longman@redhat.com> wrote:

> On 10/23/19 10:48 AM, Qian Cai wrote:
> >>> this still isn't a bulletproof fix.  Maybe just terminate the list
> >>> walk if freecount reaches 1024.  Would anyone really care?
> >>>
> >>> Sigh.  I wonder if anyone really uses this thing for anything
> >>> important.  Can we just remove it all?
> >>>
> >> Removing it will be a breakage of kernel API.
> > Who cares about breaking this part of the API that essentially nobody will use
> > this file?
> >
> There are certainly tools that use /proc/pagetypeinfo and this is how
> the problem is found. I am not against removing it, but we have to be
> careful and deprecate it in way that minimize user impact.

Yes, removing things is hard.  One approach is to add printk_once(this
is going away, please email us if you use it) then wait a few years. 
Backport that one-liner into -stable kernels to hopefully speed up the
process.

Meanwhile, we need to fix the DoS opportunity.  How about my suggestion
that we limit the count to 1024, see if anyone notices?  I bet they
don't!
