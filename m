Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72028C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2CB214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552409066;
	bh=z0KMNbw0qKXUa8yJfspk5oKOih4joxqpNz7O21hXz+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oARmQ6PNlK6jKF48gR7FJkJwUiNhVlbpp6Lu+GO61TuyMt31XwPZi/Ap7+gQbzQHw
	 aW5M51FSirWQtzESaUGEjXbUV+5eKrfGk6aHFFz1yO82dzxDrteL0wmq9INH1H0pCG
	 MyvriJbywoyuRZ4fBe4eZ/y16XMOidv5PPm7A8ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCLQoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:44:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfCLQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:44:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E0F8AF0C;
        Tue, 12 Mar 2019 16:44:23 +0000 (UTC)
Date:   Tue, 12 Mar 2019 17:44:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Subject: Re: [PATCH] mm: compaction: some tracepoints should be defined only
 when CONFIG_COMPACTION is set
Message-ID: <20190312164422.GD5721@dhcp22.suse.cz>
References: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
 <1551501538-4092-2-git-send-email-laoar.shao@gmail.com>
 <20190312161803.GC5721@dhcp22.suse.cz>
 <CALOAHbBR119mzbkkQ5fmGQ5Bqxu2O4EFgq89gVRXqXN+USzDEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBR119mzbkkQ5fmGQ5Bqxu2O4EFgq89gVRXqXN+USzDEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-03-19 00:29:57, Yafang Shao wrote:
> On Wed, Mar 13, 2019 at 12:18 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Sat 02-03-19 12:38:58, Yafang Shao wrote:
> > > Only mm_compaction_isolate_{free, migrate}pages may be used when
> > > CONFIG_COMPACTION is not set.
> > > All others are used only when CONFIG_COMPACTION is set.
> >
> > Why is this an improvement?
> >
> 
> After this change, if CONFIG_COMPACTION is not set, the tracepoints
> that only work when CONFIG_COMPACTION is set will not be exposed to
> the usespace.
> Without this change, they will always be expose in debugfs no matter
> CONFIG_COMPACTION is set or not.

And this is exactly something that the changelog should mention. I
wasn't aware that we do export tracepoints even when they are not used
by any code path. This whole macro based programming is just a black
magic.
-- 
Michal Hocko
SUSE Labs
