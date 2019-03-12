Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04442C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22632171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552397900;
	bh=p4LcNkekg4TnXFFUzhct4tzaw9RrdasPKA47ITk6h38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iv4/trtRQpmtgEP03UL2kONI8BtHxkOtyH3e2uC57nHnjnWy3qb7B12W3s+IWIKtp
	 XKtZZSTYMPf3NV/o6cUwNr7oSC3SzHoE+aIeaafQKGoLJU1GyRjBGU4wAcNdBcgDdf
	 1inTiNKZlToj/anMTYsjKXYQ7OETfQ8uy/WNVqIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCLNiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:38:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:50554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfCLNiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:38:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A54D5ABCF;
        Tue, 12 Mar 2019 13:38:17 +0000 (UTC)
Date:   Tue, 12 Mar 2019 14:38:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Subject: Re: [PATCH] mm: vmscan: show zone type in kswapd tracepoints
Message-ID: <20190312133816.GR5721@dhcp22.suse.cz>
References: <1551425934-28068-1-git-send-email-laoar.shao@gmail.com>
 <20190311084743.GX5232@dhcp22.suse.cz>
 <CALOAHbDHM1mJ3X9x3vFpDagd81T+hrb7_xdqM12x6JQXuHqwxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDHM1mJ3X9x3vFpDagd81T+hrb7_xdqM12x6JQXuHqwxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-03-19 19:04:43, Yafang Shao wrote:
> On Mon, Mar 11, 2019 at 4:47 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 01-03-19 15:38:54, Yafang Shao wrote:
> > > If we want to know the zone type, we have to check whether
> > > CONFIG_ZONE_DMA, CONFIG_ZONE_DMA32 and CONFIG_HIGHMEM are set or not,
> > > that's not so convenient.
> > >
> > > We'd better show the zone type directly.
> >
> > I do agree that zone number is quite PITA to process in general but do
> > we really need this information in the first place? Why do we even care?
> >
> 
> Sometimes we want to know this event occurs in which zone, then we can
> get the information of this zone,
> for example via /proc/zoneinfo.
> It could give us more information for debugging.

Could you be more specific please?

> > Zones are an MM internal implementation details and the more we export
> > to the userspace the more we are going to argue about breaking userspace
> > when touching them. So I would rather not export that information unless
> > it is terribly useful.
> >
> 
> I 'm not sure whether zone type is  terribly useful or not, but the
> 'zid' is useless at all.
> 
> I don't agree that Zones are MM internal.
> We can get the zone type in many ways, for example /proc/zoneinfo.
> 
> If we show this event occurs in which zone, we'd better show the zone type,
> or we should drop this 'zid'.

Yes, I am suggesting the later. If somebody really needs it then I would
like to see a _specific_ usecase. Then we can add the proper name.
-- 
Michal Hocko
SUSE Labs
