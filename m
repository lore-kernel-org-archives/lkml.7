Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B2C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676EB208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565599529;
	bh=Zc4541VTNIDmpRdqCOvnRlsl41hKTV+0rRGJ3+TrDZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GJ0Rt/LefdtqTKj6Sc5/V62H3H81xftDcGxtqeqwLXE4/x5sThrQxdnlN84afdXKW
	 c756GiW1N+knDn/5eoZgALHllya9s2CE/FYL0BTRnrS9LravcFX44x65RDdPQemANr
	 6NhYT1s8hEmYaud5IPf1ttxJOsockqqb3gEC6pPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHLIp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:45:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727092AbfHLIp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:45:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4681AD46;
        Mon, 12 Aug 2019 08:45:25 +0000 (UTC)
Date:   Mon, 12 Aug 2019 10:45:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race causing
 SIGBUS
Message-ID: <20190812084524.GC5117@dhcp22.suse.cz>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
 <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
 <20190808185313.GG18351@dhcp22.suse.cz>
 <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
 <20190809064633.GK18351@dhcp22.suse.cz>
 <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
 <20190811234614.GZ17747@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811234614.GZ17747@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 11-08-19 19:46:14, Sasha Levin wrote:
> On Fri, Aug 09, 2019 at 03:17:18PM -0700, Andrew Morton wrote:
> > On Fri, 9 Aug 2019 08:46:33 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > > Maybe we should introduce the Fixes-no-stable: tag.  That should get
> > > > their attention.
> > > 
> > > No please, Fixes shouldn't be really tight to any stable tree rules. It
> > > is a very useful indication of which commit has introduced bug/problem
> > > or whatever that the patch follows up to. We in Suse are using this tag
> > > to evaluate potential fixes as the stable is not reliable. We could live
> > > with Fixes-no-stable or whatever other name but does it really makes
> > > sense to complicate the existing state when stable maintainers are doing
> > > whatever they want anyway? Does a tag like that force AI from selecting
> > > a patch? I am not really convinced.
> > 
> > It should work if we ask stable trees maintainers not to backport
> > such patches.
> > 
> > Sasha, please don't backport patches which are marked Fixes-no-stable:
> > and which lack a cc:stable tag.
> 
> I'll add it to my filter, thank you!

I would really prefer to stick with Fixes: tag and stable only picking
up cc: stable patches. I really hate to see workarounds for sensible
workflows (marking the Fixes) just because we are trying to hide
something from stable maintainers. Seriously, if stable maintainers have
a different idea about what should be backported, it is their call. They
are the ones to deal with regressions and the backporting effort in
those cases of disagreement.

-- 
Michal Hocko
SUSE Labs
