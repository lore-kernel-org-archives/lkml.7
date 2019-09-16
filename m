Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E90AC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA981214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568627561;
	bh=RQ1UznfCccadcIfxFSkY9LamIw+REVSgQCY2pa/S/Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G5uo1V6qWzLd36INyJP3jL1ZnPyWA1M1hM8HBMdtHlzSdQ7VRLpX5KS9Y1wtk8Px/
	 ++dxf6dK9JPd0JnXnqAByJKeJZJSKfBWMe3xlKLeqO2Png0LVNqF3LlFtTGQ2T8hvr
	 NE9rZO+slMmh7I8xqmeVcjLgklNoEbrEUJjCSkQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfIPJwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfIPJwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:52:40 -0400
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD19206A4;
        Mon, 16 Sep 2019 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568627559;
        bh=RQ1UznfCccadcIfxFSkY9LamIw+REVSgQCY2pa/S/Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3qd+Bqq/q6bnDFerTgY0xQ4kcy2RDw6LXqOhsVwSAbwFdfco/FN1gQ4+c2arI5HP
         sGAiCDys7PY/Fa3T5vJy5JO+XqIrSNiib17bzNrSNZWBrs7t/IJt8zXYCrCpMqy5mN
         0p9FY9Vl8GcZXx/y7eiKei9GHWqpCKT+Yj5kh+OI=
Date:   Mon, 16 Sep 2019 12:52:35 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mips: sgi-ip27: switch from DISCONTIGMEM to SPARSEMEM
Message-ID: <20190916095233.GB5196@rapoport-lnx>
References: <20190905233800.0f6b3fb3722cde2f5a88663a@suse.de>
 <20190906130223.GA17704@rapoport-lnx>
 <20190909182242.c1ef9717d14b20212ef75954@suse.de>
 <20190910113243.GA19207@rapoport-lnx>
 <20190911160939.19f776535770d12ff51a2af7@suse.de>
 <20190912105831.GA10677@rapoport-lnx>
 <20190912155539.6151b0811e858455be4c8d86@suse.de>
 <20190912140912.GA13137@alpha.franken.de>
 <20190914104112.GA12045@rapoport-lnx>
 <20190916090705.GA5119@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916090705.GA5119@alpha.franken.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 11:07:05AM +0200, Thomas Bogendoerfer wrote:
> On Sat, Sep 14, 2019 at 11:41:13AM +0100, Mike Rapoport wrote:
> > On Thu, Sep 12, 2019 at 04:09:12PM +0200, Thomas Bogendoerfer wrote:
> > > On Thu, Sep 12, 2019 at 03:55:39PM +0200, Thomas Bogendoerfer wrote:
> > > > - reserved[0xd]	[0x000000035bff8000-0x000000035bffffff], 0x0000000000008000 bytes flags: 0x0
> > > > 
> > > > I have no idea which reservation this is, but it's not from one of the
> > > > node data.
> > > 
> > > that's sparsemem's mem_section. And 
> > > 
> > >  free_bootmem_with_active_regions(node, end_pfn);
> > 
> > It seems that the call to free_bootmem_with_active_regions() should have
> > been removed along with bootmem and it's not needed now.
> > 
> > Can you please test the below version of the patch?
> 
> Patch is good. I've compared bootlogs and output is the same
> regarding memblock/memory debug messages.

Can I add your co-developed+signed-off then?
 
> When this is merged, I'll have a look into using memblock_alloc
> for the node memory.
> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]

-- 
Sincerely yours,
Mike.
