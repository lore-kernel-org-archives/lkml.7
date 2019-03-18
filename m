Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF61E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552916567;
	bh=yPy/EHnR+eRSRxO6OE5vwLK8mfQEKBt7xNCvAMl49RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LA/tsHKAAG2nepuopr57AAcZDtYexhtVuqUrfuojWzk/KKeS4FSFli0KyYMD2zoKY
	 K7wOt51a1tzm3majDJZ0wVStcZVf53x+fBQm+Cs0vqw1BNCCcEbJLbi3rlXRq3zpkY
	 OOxDS3F11rp5ZW9jBDPqm0zRUIH7Ltt37WUGcjXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCRNmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:42:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:45066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbfCRNmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:42:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83D40AD70;
        Mon, 18 Mar 2019 13:42:43 +0000 (UTC)
Date:   Mon, 18 Mar 2019 14:42:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [External] Re: mm/cma.c: High latency for cma allocation
Message-ID: <20190318134242.GI8924@dhcp22.suse.cz>
References: <SG2PR02MB3098E44824F5AA69BC04F935E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190318130757.GG8924@dhcp22.suse.cz>
 <SG2PR02MB309886996889791555D5B53EE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR02MB309886996889791555D5B53EE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please do not use html emails to the mailing list and try to fix your
email client to not break quoating. Fixed for this email]

On Mon 18-03-19 13:28:50, Pankaj Suryawanshi wrote:
> On Mon 18-03-19 12:58:28, Pankaj Suryawanshi wrote:
> > > Hello,
> > >
> > > I am facing issue of high latency in CMA allocation of large size buffer.
> > >
> > > I am frequently allocating/deallocation CMA memory, latency of allocation is very high.
> > >
> > > Below are the stat for allocation/deallocation latency issue.
> > >
> > > (390100 kB),  latency 29997 us
> > > (390100 kB),  latency 22957 us
> > > (390100 kB),  latency 25735 us
> > > (390100 kB),  latency 12736 us
> > > (390100 kB),  latency 26009 us
> > > (390100 kB),  latency 18058 us
> > > (390100 kB),  latency 27997 us
> > > (16 kB), latency 560 us
> > > (256 kB), latency 280 us
> > > (4 kB), latency 311 us
> > >
> > > I am using kernel 4.14.65 with android pie(9.0).
> > >
> > > Is there any workaround or solution for this(cma_alloc latency) issue ?
> > 
> > Do you have any more detailed information on where the time is spent?
> > E.g. migration tracepoints?
> > 
> > Hello Michal,
> 
> I have the system(vanilla kernel) with 2GB of RAM, reserved 1GB for CMA. No swap or zram.
> Sorry, I don't have information where the time is spent.
> time is calculated in between cma_alloc call.
> I have just cma_alloc trace information/function graph.

Then please collect that data because it is really hard to judge
anything from the numbers you have provided.
-- 
Michal Hocko
SUSE Labs
