Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC628CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F3620874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572444785;
	bh=jTQLus0ZbOmpvgP1GJucOjeccecRcm4lwx8yYDdGYMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vH4/cqZw6u0f6P9vvxswCXwo/lkYt3KrKZVZT0ne0pnSbrLdt+ZeD3y3GugFpmzoo
	 qACrclDOVlkIPABScb1cOTebFw5R4mLNeZ9L8DXbvaSv+4I/bwqcEc06XMIpEA/KOF
	 hcWeUABx16zeXgsa3NKGdMF1VVPnjZwj/1/bXKyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfJ3ONE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:13:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:56930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfJ3ONC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:13:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7DC0B6B5;
        Wed, 30 Oct 2019 14:13:00 +0000 (UTC)
Date:   Wed, 30 Oct 2019 15:12:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191030141259.GE31513@dhcp22.suse.cz>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz>
 <20191030140216.i26n22asgafckfxy@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030140216.i26n22asgafckfxy@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Add Pavel - the email thread starts http://lkml.kernel.org/r/20191030131122.8256-1-vincent.whitchurch@axis.com
 but it used your old email address]

On Wed 30-10-19 15:02:16, Vincent Whitchurch wrote:
> On Wed, Oct 30, 2019 at 02:29:58PM +0100, Michal Hocko wrote:
> > On Wed 30-10-19 14:11:22, Vincent Whitchurch wrote:
> > > (I noticed this because on my ARM64 platform, with 1 GiB of memory the
> > >  first [and only] section is allocated from the zeroing path while with
> > >  2 GiB of memory the first 1 GiB section is allocated from the
> > >  non-zeroing path.)
> > 
> > Do I get it right that sparse_buffer_init couldn't allocate memmap for
> > the full node for some reason and so sparse_init_nid would have to
> > allocate one for each memory section?
> 
> Not quite.  The sparsemap_buf is successfully allocated with the correct
> size in sparse_buffer_init(), but sparse_buffer_alloc() fails to
> allocate the same size from it.
> 
> The reason it fails is that sparse_buffer_alloc() for some reason wants
> to return a pointer which is aligned to the allocation size.  But the
> sparsemap_buf was only allocated with PAGE_SIZE alignment so there's not
> enough space to align it.
> 
> I don't understand the reason for this alignment requirement since the
> fallback path also allocates with PAGE_SIZE alignment.  I'm guessing the
> alignment is for the VMEMAP code which also uses sparse_buffer_alloc()?

I am not 100% sure TBH. Aligning makes some sense when mapping the
memmaps to page tables but that would suggest that sparse_buffer_init
is using a wrong alignment then. It is quite wasteful to allocate
alarge misaligned block like that.

Your patch still makes sense but this is something to look into.

Pavel?

-- 
Michal Hocko
SUSE Labs
