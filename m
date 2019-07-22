Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6878C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B792084D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563809071;
	bh=nRZoH4xwtPYcCRpqCTX6tj1SFiPFkQ6nWJP4CJHJpAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HN89+ikVBQA7k1ft1XD4skgxr0qNj1HjXZVpXETLuZsDHbrIjrZAIp4/vRKOROzct
	 Ht0j7txA8ziqM2gH5v4/ZIcm457uSoUz4pJxYLByR9V3FKOdaBy/4oGBY95n4FBnL2
	 qWs4UkOiOnuXvysve829j5gQCcQqX8YP6a/IHfGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfGVPYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbfGVPYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:24:30 -0400
Received: from localhost (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A74F2084D;
        Mon, 22 Jul 2019 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563809069;
        bh=nRZoH4xwtPYcCRpqCTX6tj1SFiPFkQ6nWJP4CJHJpAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdiQlr7NQEHX5Y8VohEbyIP/GE59TUXoXpuEB/4ncjPGpDv6Fxw8ycYnAFN3ERFGV
         llygx3szbdHDSbFFo4uuiGJsMsVbQ1tyx1SlyzcmruLxDAIKl2b56FbPuuW+hq6xU8
         vWIOxm0UKWkzXa+IbDVma6OH6IvkpSlx65A0AH7o=
Date:   Mon, 22 Jul 2019 20:53:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] [RESEND] dmaengine: omap-dma: make
 omap_dma_filter_fn private
Message-ID: <20190722152315.GY12733@vkoul-mobl.Dlink>
References: <20190722081705.2084961-1-arnd@arndb.de>
 <20190722141240.GT12733@vkoul-mobl.Dlink>
 <CAK8P3a0tHRyjwwHk3tGFA=3dByH4g7R4FobrGC874bW5DJCnNw@mail.gmail.com>
 <20190722143533.GX12733@vkoul-mobl.Dlink>
 <CAK8P3a1P4LyOieH1ii0vn_5rdj-NC4ft6JKCKs6YX88Qdk5SSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1P4LyOieH1ii0vn_5rdj-NC4ft6JKCKs6YX88Qdk5SSg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-19, 16:44, Arnd Bergmann wrote:
> On Mon, Jul 22, 2019 at 4:36 PM Vinod Koul <vkoul@kernel.org> wrote:
> > On 22-07-19, 16:22, Arnd Bergmann wrote:
> > > On Mon, Jul 22, 2019 at 4:13 PM Vinod Koul <vkoul@kernel.org> wrote:
> > > >
> > > > On 22-07-19, 10:16, Arnd Bergmann wrote:
> > > > > With the audio driver no longer referring to this function, it
> > > > > can be made private to the dmaengine driver itself, and the
> > > > > header file removed.
> > > > >
> > > > > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > > Link: https://lore.kernel.org/lkml/20190307151646.1016966-1-arnd@arndb.de/
> > > >
> > > > This seems to point to older rev, my script updated it to latest one.
> > >
> > > That was intentional, to see the replies to the last time it got
> > > posted. I'm not sure if that's the best way to do it, would you
> > > rather not have that included?
> >
> > That's a valid point, but should we add both the links or just relevant
> > one, common sense says former, scripting tends to add so keep both...?
> >
> > I am thinking of not changing the one submitted and let my
> > script append. Is that fine?
> 
> I think adding both is best then.

Ok, updated!

-- 
~Vinod
