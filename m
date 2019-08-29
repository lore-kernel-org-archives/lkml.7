Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8064FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482BB2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567081753;
	bh=DcYrTwuhvE3ZTyaWeowmkN5S3XcPaOJeLDBSFTuhcEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iCz66XAS5eY6EgEE2wgYxRPKAuwUJI7Lqy1TW8lCPnJCstcOWDkK5zE3ZRVrRxFyd
	 w3I3seQ8eSvvV0fSBtTqm8h4jeCO22H5ihMBeBpb86KA2BT11GQCBpXbdRnuUDgsmA
	 AZmCiEii9qWERZV9y46CSz3C8EhAEYxv4RE5hirk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfH2M3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:29:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfH2M3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:29:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8B80AC97;
        Thu, 29 Aug 2019 12:29:10 +0000 (UTC)
Date:   Thu, 29 Aug 2019 14:29:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     James Courtier-Dutton <james.dutton@gmail.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessm.com, hadess@hadess.net,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190829122909.GG28313@dhcp22.suse.cz>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <20190820064620.5119-1-drake@endlessm.com>
 <CAAMvbhH=ftMoh9eFVR3YgN9DVSLaN5tXa-vTsBocY8YuL0Rc1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhH=ftMoh9eFVR3YgN9DVSLaN5tXa-vTsBocY8YuL0Rc1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-08-19 22:42:29, James Courtier-Dutton wrote:
> On Tue, 20 Aug 2019 at 07:47, Daniel Drake <drake@endlessm.com> wrote:
> >
> > Hi,
> >
> > And if there is a meaningful way to make the kernel behave better, that would
> > obviously be of huge value too.
> >
> > Thanks
> > Daniel
> 
> Hi,
> 
> Is there a way for an application to be told that there is a memory
> pressure situation?

PSI (CONFIG_PSI) measures global as well as per memcg pressure characteristics.

[...]

> I have also found, for the desktop, one of the biggest pressures on
> the system is disk pressure. Accessing the disk causes the UI to be
> less responsive.
> For example, if I am in vim, and trying to type letters on the
> keyboard, whether some other application is using the disk or not
> should have no impact on my letter writing. Has anyone got any ideas
> with regards to what we can do about that?

This is what we have the page cache for.
-- 
Michal Hocko
SUSE Labs
