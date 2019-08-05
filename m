Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C5C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1F9206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565006729;
	bh=0KthwZ/qASUYVgIm9Vr44fdumvR86Xj9n+x93+7mobo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XUu9xV2qXC5FGPWr1Y+mp7dPIzHUKjndSnyG7nDFbG7oQX+c+2uK79OBJF5JUQQDp
	 2JePs6/wr+x++43ylBTZPOW8tVPP3iBTY1y5/Fuqw+6AsuzcJ0Tf33HvC0IzcYexcX
	 01NWwaVva3wUge6LFMAhTBmitdVz7+b+RWxAM/5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfHEMF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:05:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728028AbfHEMF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:05:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A26EBADAA;
        Mon,  5 Aug 2019 12:05:26 +0000 (UTC)
Date:   Mon, 5 Aug 2019 14:05:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pankaj.suryawanshi@einfochips.com
Subject: Re: oom-killer
Message-ID: <20190805120525.GL7597@dhcp22.suse.cz>
References: <CACDBo54Jbueeq1XbtbrFOeOEyF-Q4ipZJab8mB7+0cyK1Foqyw@mail.gmail.com>
 <20190805112437.GF7597@dhcp22.suse.cz>
 <0821a17d-1703-1b82-d850-30455e19e0c1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0821a17d-1703-1b82-d850-30455e19e0c1@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-08-19 13:56:20, Vlastimil Babka wrote:
> On 8/5/19 1:24 PM, Michal Hocko wrote:
> >> [  727.954355] CPU: 0 PID: 56 Comm: kworker/u8:2 Tainted: P           O  4.14.65 #606
> > [...]
> >> [  728.029390] [<c034a094>] (oom_kill_process) from [<c034af24>] (out_of_memory+0x140/0x368)
> >> [  728.037569]  r10:00000001 r9:c12169bc r8:00000041 r7:c121e680 r6:c1216588 r5:dd347d7c > [  728.045392]  r4:d5737080
> >> [  728.047929] [<c034ade4>] (out_of_memory) from [<c03519ac>]  (__alloc_pages_nodemask+0x1178/0x124c)
> >> [  728.056798]  r7:c141e7d0 r6:c12166a4 r5:00000000 r4:00001155
> >> [  728.062460] [<c0350834>] (__alloc_pages_nodemask) from [<c021e9d4>] (copy_process.part.5+0x114/0x1a28)
> >> [  728.071764]  r10:00000000 r9:dd358000 r8:00000000 r7:c1447e08 r6:c1216588 r5:00808111
> >> [  728.079587]  r4:d1063c00
> >> [  728.082119] [<c021e8c0>] (copy_process.part.5) from [<c0220470>] (_do_fork+0xd0/0x464)
> >> [  728.090034]  r10:00000000 r9:00000000 r8:dd008400 r7:00000000 r6:c1216588 r5:d2d58ac0
> >> [  728.097857]  r4:00808111
> > 
> > The call trace tells that this is a fork (of a usermodhlper but that is
> > not all that important.
> > [...]
> >> [  728.260031] DMA free:17960kB min:16384kB low:25664kB high:29760kB active_anon:3556kB inactive_anon:0kB active_file:280kB inactive_file:28kB unevictable:0kB writepending:0kB present:458752kB managed:422896kB mlocked:0kB kernel_stack:6496kB pagetables:9904kB bounce:0kB free_pcp:348kB local_pcp:0kB free_cma:0kB
> >> [  728.287402] lowmem_reserve[]: 0 0 579 579
> > 
> > So this is the only usable zone and you are close to the min watermark
> > which means that your system is under a serious memory pressure but not
> > yet under OOM for order-0 request. The situation is not great though
> 
> Looking at lowmem_reserve above, wonder if 579 applies here? What does
> /proc/zoneinfo say?

This is GFP_KERNEL request essentially so there shouldn't be any lowmem
reserve here, no?
-- 
Michal Hocko
SUSE Labs
