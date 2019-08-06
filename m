Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAEBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAB1214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565104378;
	bh=5bnsFMIWFOI6iCESZfiLVc9Rosm0DrIKb+aQb+lYbGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gAGx2oDRj8vc3u4L24/pQLBGsKZb9OQRXGxnVcVo/Hl0Cgk6qorr5R5EiT1XIk/Ei
	 /pC3XvNcv+Nv0Eu+i3uJu1079GfR32J8yXm08Kpf7ynhT8DuTct/6VrT5dAPqTEqFU
	 udL9MUXxcZOxliMp3dZL/ZCLGczH/Ob36heynfnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfHFPM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:12:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:48546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbfHFPMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:12:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B566AF4C;
        Tue,  6 Aug 2019 15:12:52 +0000 (UTC)
Date:   Tue, 6 Aug 2019 17:12:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pankaj.suryawanshi@einfochips.com
Subject: Re: oom-killer
Message-ID: <20190806151251.GJ11812@dhcp22.suse.cz>
References: <CACDBo54Jbueeq1XbtbrFOeOEyF-Q4ipZJab8mB7+0cyK1Foqyw@mail.gmail.com>
 <20190805112437.GF7597@dhcp22.suse.cz>
 <0821a17d-1703-1b82-d850-30455e19e0c1@suse.cz>
 <20190805120525.GL7597@dhcp22.suse.cz>
 <CACDBo562xHy6McF5KRq3yngKqAm4a15FFKgbWkCTGQZ0pnJWgw@mail.gmail.com>
 <20190805201650.GT7597@dhcp22.suse.cz>
 <CACDBo54kBy_YBcXBzs1dOxQRg+TKFQox_aqqtB2dvL+mmusDVg@mail.gmail.com>
 <20190806150733.GH11812@dhcp22.suse.cz>
 <CACDBo54KihsV=8NLGZkTghTzb2p70WURF2L5op=fW7DGj_vJ1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo54KihsV=8NLGZkTghTzb2p70WURF2L5op=fW7DGj_vJ1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 20:39:22, Pankaj Suryawanshi wrote:
> On Tue, Aug 6, 2019 at 8:37 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 06-08-19 20:24:03, Pankaj Suryawanshi wrote:
> > > On Tue, 6 Aug, 2019, 1:46 AM Michal Hocko, <mhocko@kernel.org> wrote:
> > > >
> > > > On Mon 05-08-19 21:04:53, Pankaj Suryawanshi wrote:
> > > > > On Mon, Aug 5, 2019 at 5:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > >
> > > > > > On Mon 05-08-19 13:56:20, Vlastimil Babka wrote:
> > > > > > > On 8/5/19 1:24 PM, Michal Hocko wrote:
> > > > > > > >> [  727.954355] CPU: 0 PID: 56 Comm: kworker/u8:2 Tainted: P           O  4.14.65 #606
> > > > > > > > [...]
> > > > > > > >> [  728.029390] [<c034a094>] (oom_kill_process) from [<c034af24>] (out_of_memory+0x140/0x368)
> > > > > > > >> [  728.037569]  r10:00000001 r9:c12169bc r8:00000041 r7:c121e680 r6:c1216588 r5:dd347d7c > [  728.045392]  r4:d5737080
> > > > > > > >> [  728.047929] [<c034ade4>] (out_of_memory) from [<c03519ac>]  (__alloc_pages_nodemask+0x1178/0x124c)
> > > > > > > >> [  728.056798]  r7:c141e7d0 r6:c12166a4 r5:00000000 r4:00001155
> > > > > > > >> [  728.062460] [<c0350834>] (__alloc_pages_nodemask) from [<c021e9d4>] (copy_process.part.5+0x114/0x1a28)
> > > > > > > >> [  728.071764]  r10:00000000 r9:dd358000 r8:00000000 r7:c1447e08 r6:c1216588 r5:00808111
> > > > > > > >> [  728.079587]  r4:d1063c00
> > > > > > > >> [  728.082119] [<c021e8c0>] (copy_process.part.5) from [<c0220470>] (_do_fork+0xd0/0x464)
> > > > > > > >> [  728.090034]  r10:00000000 r9:00000000 r8:dd008400 r7:00000000 r6:c1216588 r5:d2d58ac0
> > > > > > > >> [  728.097857]  r4:00808111
> > > > > > > >
> > > > > > > > The call trace tells that this is a fork (of a usermodhlper but that is
> > > > > > > > not all that important.
> > > > > > > > [...]
> > > > > > > >> [  728.260031] DMA free:17960kB min:16384kB low:25664kB high:29760kB active_anon:3556kB inactive_anon:0kB active_file:280kB inactive_file:28kB unevictable:0kB writepending:0kB present:458752kB managed:422896kB mlocked:0kB kernel_stack:6496kB pagetables:9904kB bounce:0kB free_pcp:348kB local_pcp:0kB free_cma:0kB
> > > > > > > >> [  728.287402] lowmem_reserve[]: 0 0 579 579
> > > > > > > >
> > > > > > > > So this is the only usable zone and you are close to the min watermark
> > > > > > > > which means that your system is under a serious memory pressure but not
> > > > > > > > yet under OOM for order-0 request. The situation is not great though
> > > > > > >
> > > > > > > Looking at lowmem_reserve above, wonder if 579 applies here? What does
> > > > > > > /proc/zoneinfo say?
> > > > >
> > > > >
> > > > > What is  lowmem_reserve[]: 0 0 579 579 ?
> > > >
> > > > This controls how much of memory from a lower zone you might an
> > > > allocation request for a higher zone consume. E.g. __GFP_HIGHMEM is
> > > > allowed to use both lowmem and highmem zones. It is preferable to use
> > > > highmem zone because other requests are not allowed to use it.
> > > >
> > > > Please see __zone_watermark_ok for more details.
> > > >
> > > >
> > > > > > This is GFP_KERNEL request essentially so there shouldn't be any lowmem
> > > > > > reserve here, no?
> > > > >
> > > > >
> > > > > Why only low 1G is accessible by kernel in 32-bit system ?
> > >
> > >
> > > 1G ivirtual or physical memory (I have 2GB of RAM) ?
> >
> > virtual
> >
>  I have set 2G/2G still it works ?

It would reduce the amount of memory that userspace might use. It may
work for your particular case but the fundamental restriction is still
there.
-- 
Michal Hocko
SUSE Labs
