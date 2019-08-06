Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A1AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DCB216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbfHFKEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:04:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732583AbfHFKEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:04:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3D61B008;
        Tue,  6 Aug 2019 10:04:10 +0000 (UTC)
Subject: Re: oom-killer
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pankaj.suryawanshi@einfochips.com
References: <CACDBo54Jbueeq1XbtbrFOeOEyF-Q4ipZJab8mB7+0cyK1Foqyw@mail.gmail.com>
 <20190805112437.GF7597@dhcp22.suse.cz>
 <0821a17d-1703-1b82-d850-30455e19e0c1@suse.cz>
 <20190805120525.GL7597@dhcp22.suse.cz>
 <CACDBo562xHy6McF5KRq3yngKqAm4a15FFKgbWkCTGQZ0pnJWgw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <df820f66-cf82-b43f-97b6-c92a116fa1a6@suse.cz>
Date:   Tue, 6 Aug 2019 12:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACDBo562xHy6McF5KRq3yngKqAm4a15FFKgbWkCTGQZ0pnJWgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 5:34 PM, Pankaj Suryawanshi wrote:
> On Mon, Aug 5, 2019 at 5:35 PM Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Mon 05-08-19 13:56:20, Vlastimil Babka wrote:
>> > On 8/5/19 1:24 PM, Michal Hocko wrote:
>> > >> [  727.954355] CPU: 0 PID: 56 Comm: kworker/u8:2 Tainted: P           O  4.14.65 #606
>> > > [...]
>> > >> [  728.029390] [<c034a094>] (oom_kill_process) from [<c034af24>] (out_of_memory+0x140/0x368)
>> > >> [  728.037569]  r10:00000001 r9:c12169bc r8:00000041 r7:c121e680 r6:c1216588 r5:dd347d7c > [  728.045392]  r4:d5737080
>> > >> [  728.047929] [<c034ade4>] (out_of_memory) from [<c03519ac>]  (__alloc_pages_nodemask+0x1178/0x124c)
>> > >> [  728.056798]  r7:c141e7d0 r6:c12166a4 r5:00000000 r4:00001155
>> > >> [  728.062460] [<c0350834>] (__alloc_pages_nodemask) from [<c021e9d4>] (copy_process.part.5+0x114/0x1a28)
>> > >> [  728.071764]  r10:00000000 r9:dd358000 r8:00000000 r7:c1447e08 r6:c1216588 r5:00808111
>> > >> [  728.079587]  r4:d1063c00
>> > >> [  728.082119] [<c021e8c0>] (copy_process.part.5) from [<c0220470>] (_do_fork+0xd0/0x464)
>> > >> [  728.090034]  r10:00000000 r9:00000000 r8:dd008400 r7:00000000 r6:c1216588 r5:d2d58ac0
>> > >> [  728.097857]  r4:00808111
>> > >
>> > > The call trace tells that this is a fork (of a usermodhlper but that is
>> > > not all that important.
>> > > [...]
>> > >> [  728.260031] DMA free:17960kB min:16384kB low:25664kB high:29760kB active_anon:3556kB inactive_anon:0kB active_file:280kB inactive_file:28kB unevictable:0kB writepending:0kB present:458752kB managed:422896kB mlocked:0kB kernel_stack:6496kB pagetables:9904kB bounce:0kB free_pcp:348kB local_pcp:0kB free_cma:0kB
>> > >> [  728.287402] lowmem_reserve[]: 0 0 579 579
>> > >
>> > > So this is the only usable zone and you are close to the min watermark
>> > > which means that your system is under a serious memory pressure but not
>> > > yet under OOM for order-0 request. The situation is not great though
>> >
>> > Looking at lowmem_reserve above, wonder if 579 applies here? What does
>> > /proc/zoneinfo say?
> 
> 
> What is  lowmem_reserve[]: 0 0 579 579 ?
> 
> $cat /proc/sys/vm/lowmem_reserve_ratio
> 256     32      32
> 
> $cat /proc/sys/vm/min_free_kbytes
> 16384
> 
> here is cat /proc/zoneinfo (in normal situation not when oom)

Thanks, that shows the lowmem reserve was indeed 0 for the GFP_KERNEL allocation
checking watermarks in the DMA zone. The zone was probably genuinely below min
watermark when the check happened, and things changed while the allocation
failure was printing memory info.
