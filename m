Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B28C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41BA2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562047995;
	bh=WNJFRVtXGiIsJmQmGSXzJipNnwfRDuFAi3IeLCeLlX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jcmzz0m8a5zKxToICwmv/koUzfdOjPL6Zz/Vi5rB9efnT1bASGrQ/Vw4DPjOU8+Qm
	 TiUm2UtOptKMgWOshba330JSEemZSBoUH5ItVuc5BGo8mPpR1V2jdyo3//NWCHeaPo
	 ESW/L+C+zVa/YZ1+UxE3mXbOgKt0m356/lz1/3Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfGBGNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:13:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:37360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfGBGNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:13:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A75CB008;
        Tue,  2 Jul 2019 06:13:12 +0000 (UTC)
Date:   Tue, 2 Jul 2019 08:13:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
Message-ID: <20190702061310.GA978@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-2-alastair@au1.ibm.com>
 <20190626062113.GF17798@dhcp22.suse.cz>
 <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
 <20190626065751.GK17798@dhcp22.suse.cz>
 <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
 <20190627080724.GK17798@dhcp22.suse.cz>
 <833b9675bc363342827cb8f7c76ebb911f7f960d.camel@d-silva.org>
 <20190701104658.GA6549@dhcp22.suse.cz>
 <7f0ac9250e6fe6318aaf0685be56b121a978ce1b.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f0ac9250e6fe6318aaf0685be56b121a978ce1b.camel@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-07-19 14:13:25, Alastair D'Silva wrote:
> On Mon, 2019-07-01 at 12:46 +0200, Michal Hocko wrote:
> > On Fri 28-06-19 10:46:28, Alastair D'Silva wrote:
> > [...]
> > > Given that there is already a VM_BUG_ON in the code, how do you
> > > feel
> > > about broadening the scope from 'VM_BUG_ON(!root)' to
> > > 'VM_BUG_ON(!root
> > > > > (root_nr == NR_SECTION_ROOTS))'?
> > 
> > As far as I understand the existing VM_BUG_ON will hit when the
> > mem_section tree gets corrupted. This is a different situation to an
> > incorrect section given so I wouldn't really mix those two. And I
> > still
> > do not see much point to protect from unexpected input parameter as
> > this
> > is internal function as already pointed out.
> > 
> 
> Hi Michael,
> 
> I was able to hit this problem as the system firmware had assigned the
> prototype pmem device an address range above the 128TB limit that we
> originally supported. This has since been lifted to 2PB with patch
> 4ffe713b7587b14695c9bec26a000fc88ef54895.
> 
> As it stands, we cannot move this range lower as the high bits are
> dictated by the location the card is connected.
> 
> Since the physical address of the memory is not controlled by the
> kernel, I believe we should catch (or at least make it easy to debug)
> the sitution where external firmware allocates physical addresses
> beyond that which the kernel supports.

Just make it clear, I am not against a sanitization. I am objecting to
put it into __section_nr because this is way too late. As already
explained, you already must have a bogus mem_section object in hand.
Why cannot you add a sanity check right there when the memory is added?
Either when the section is registered or even sooner in arch_add_memory.

-- 
Michal Hocko
SUSE Labs
