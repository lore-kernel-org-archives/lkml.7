Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7BDCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0217C21744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ts5QbPW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390868AbfJ1QSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:18:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40427 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732278AbfJ1QSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572279519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsdkRdIWUcvVqHqhfGpK3uHN2hfGr9QSmqHuEm4E9/s=;
        b=Ts5QbPW9wwdS1laYQ1uMm0DEWhArPKSLWXnARuDZudAVc1AdLqra3DNgZ91H8Xjx5h1Q5H
        /67T7jVyUYddNUAWANCJsuwdOahpso7u433SUnqI1zFY+FLfQdBI2ZUxWkCQDlnBajuuil
        rkJ8nwW/dWTt7m3frchhjDqccDjuClQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-dSLwM00ZOTSQqIdsIQsxYw-1; Mon, 28 Oct 2019 12:18:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7CD8476;
        Mon, 28 Oct 2019 16:18:29 +0000 (UTC)
Received: from [10.36.117.63] (ovpn-117-63.ams2.redhat.com [10.36.117.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 037663DA6;
        Mon, 28 Oct 2019 16:18:20 +0000 (UTC)
Subject: Re: kernel BUG at mm/vmscan.c:LINE! (2)
To:     Minchan Kim <minchan@kernel.org>,
        syzbot <syzbot+8e6326965378936537c3@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, chris@chrisdown.name, chris@zankel.net,
        dancol@google.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        hdanton@sina.com, james.bottomley@hansenpartnership.com,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        laoar.shao@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, mhocko@kernel.org,
        mhocko@suse.com, oleksandr@redhat.com, ralf@linux-mips.org,
        rth@twiddle.net, sfr@canb.auug.org.au, shakeelb@google.com,
        sonnyrao@google.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, timmurray@google.com,
        yang.shi@linux.alibaba.com
References: <000000000000a9694d058f261963@google.com>
 <20190802200643.GA181880@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <658defc9-8727-dfbd-7e27-94f7cc36cf4a@redhat.com>
Date:   Mon, 28 Oct 2019 17:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190802200643.GA181880@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dSLwM00ZOTSQqIdsIQsxYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.19 22:06, Minchan Kim wrote:
> On Fri, Aug 02, 2019 at 10:58:05AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    0d8b3265 Add linux-next specific files for 20190729
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1663c7d06000=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dae96f3b8a7e8=
85f7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8e632696537893=
6537c3
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D133c437c60=
0000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D156458546000=
00
>>
>> The bug was bisected to:
>>
>> commit 06a833a1167e9cbb43a9a4317ec24585c6ec85cb
>> Author: Minchan Kim <minchan@kernel.org>
>> Date:   Sat Jul 27 05:12:38 2019 +0000
>>
>>      mm: introduce MADV_PAGEOUT
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1545f7646=
00000
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D1745f7646=
00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1345f7646000=
00
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commi=
t:
>> Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
>> Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")
>>
>> raw: 01fffc0000090025 dead000000000100 dead000000000122 ffff88809c49f741
>> raw: 0000000000020000 0000000000000000 00000002ffffffff ffff88821b6eaac0
>> page dumped because: VM_BUG_ON_PAGE(PageActive(page))
>> page->mem_cgroup:ffff88821b6eaac0
>> ------------[ cut here ]------------
>> kernel BUG at mm/vmscan.c:1156!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 1 PID: 9846 Comm: syz-executor110 Not tainted 5.3.0-rc2-next-201907=
29
>> #54
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> RIP: 0010:shrink_page_list+0x2872/0x5430 mm/vmscan.c:1156
>=20
> My old version had PG_active flag clear but it seems to lose it with revi=
sing
> patchsets. Thanks, Sizbot!
>=20
>  From 66d64988619ef7e86b0002b2fc20fdf5b84ad49c Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Sat, 3 Aug 2019 04:54:02 +0900
> Subject: [PATCH] mm: Clear PG_active on MADV_PAGEOUT
>=20
> shrink_page_list expects every pages as argument should be no active
> LRU pages so we need to clear PG_active.
>=20
> Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
> Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")

I think this should be

Fixed: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")


$ git show 1a4e58cce84e
commit 1a4e58cce84ee88129d5d49c064bd2852b481357
Author: Minchan Kim <minchan@kernel.org>
Date:   Wed Sep 25 16:49:15 2019 -0700

     mm: introduce MADV_PAGEOUT
[...]

$ git tag --contains 1a4e58cce84ee88129d5d49c064bd2852b481357
[...]
v5.4-rc5


--=20

Thanks,

David / dhildenb

