Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D37C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F0821849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563468048;
	bh=TXpNHF+XvvdoHPQp+vySXRoZM+QOCbEQHokynlM/C5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mr/sMoi75FaIBCQw/EqNYqVEod/BhWKNlu7aYWdJ4pR7p+K8B3MepcJrYQgcr/BhB
	 l7mp4kn6TFWSU/oCPCrJ4TFB8IzHkQsbx3li/URKUClsSwinCzln0GZOhyn6GM+8eM
	 mYFMOTiKtguNoiZtzPCbigI0r4aUYNPVOFfZraAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbfGRQkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:40:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:42146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727762AbfGRQkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:40:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0A6CAD07;
        Thu, 18 Jul 2019 16:40:44 +0000 (UTC)
Date:   Thu, 18 Jul 2019 18:40:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/1] mm/memory_hotplug: Adds option to hot-add memory in
 ZONE_MOVABLE
Message-ID: <20190718164043.GE30461@dhcp22.suse.cz>
References: <20190718024133.3873-1-leonardo@linux.ibm.com>
 <1563430353.3077.1.camel@suse.de>
 <0e67afe465cbbdf6ec9b122f596910cae77bc734.camel@linux.ibm.com>
 <20190718155704.GD30461@dhcp22.suse.cz>
 <CA+CK2bBU72owYSXH10LTU8NttvCASPNTNOqFfzA3XweXR3gOTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBU72owYSXH10LTU8NttvCASPNTNOqFfzA3XweXR3gOTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-07-19 12:11:25, Pavel Tatashin wrote:
> On Thu, Jul 18, 2019 at 11:57 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 18-07-19 12:50:29, Leonardo Bras wrote:
> > > On Thu, 2019-07-18 at 08:12 +0200, Oscar Salvador wrote:
> > > > We do already have "movable_node" boot option, which exactly has that
> > > > effect.
> > > > Any hotplugged range will be placed in ZONE_MOVABLE.
> > > Oh, I was not aware of it.
> > >
> > > > Why do we need yet another option to achieve the same? Was not that
> > > > enough for your case?
> > > Well, another use of this config could be doing this boot option a
> > > default on any given kernel.
> > > But in the above case I agree it would be wiser to add the code on
> > > movable_node_is_enabled() directly, and not where I did put.
> > >
> > > What do you think about it?
> >
> > No further config options please. We do have means a more flexible way
> > to achieve movable node onlining so let's use it. Or could you be more
> > specific about cases which cannot use the command line option and really
> > need a config option to workaround that?
> 
> Hi Michal,
> 
> Just trying to understand, if kernel parameters is the preferable
> method, why do we even have
> 
> MEMORY_HOTPLUG_DEFAULT_ONLINE

I have some opinion on this one TBH. I have even tried to remove it. The
config option has been added to workaround hotplug issues for some
memory balloning usecases where it was believed that the memory consumed
for the memory hotadd (struct pages) could get machine to OOM before
userspace manages to online it. So I would be more than happy to remove
it but there were some objections in the past. Maybe the work by Oscar
to allocate memmaps from the hotplugged memory can finally put an end to
this gross hack.

In any case, I do not think we want to repeat that pattern again.
-- 
Michal Hocko
SUSE Labs
