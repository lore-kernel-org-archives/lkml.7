Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B0CC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F49217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfGXHHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15105 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfGXHHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:07:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E16030832EA;
        Wed, 24 Jul 2019 07:07:44 +0000 (UTC)
Received: from [10.72.12.106] (ovpn-12-106.pek2.redhat.com [10.72.12.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59983608A5;
        Wed, 24 Jul 2019 07:07:38 +0000 (UTC)
Subject: Re: KASAN: use-after-free Write in tlb_finish_mmu
To:     syzbot <syzbot+8267e9af795434ffadad@syzkaller.appspotmail.com>,
        aarcange@redhat.com, davem@davemloft.net, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <0000000000002c183d058e0e3abd@google.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e003d427-36ef-a6bc-e433-36d90080e3cb@redhat.com>
Date:   Wed, 24 Jul 2019 15:07:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0000000000002c183d058e0e3abd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 24 Jul 2019 07:07:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/20 上午4:04, syzbot wrote:
> syzbot has bisected this bug to:
>
> commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Fri May 24 08:12:18 2019 +0000
>
>     vhost: access vq metadata through kernel virtual address
>
> bisection log: 
> https://syzkaller.appspot.com/x/bisect.txt?x=11642a58600000
> start commit:   22051d9c Merge tag 'platform-drivers-x86-v5.3-2' of 
> git://..
> git tree:       upstream
> final crash: https://syzkaller.appspot.com/x/report.txt?x=13642a58600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15642a58600000
> kernel config: https://syzkaller.appspot.com/x/.config?x=d831b9cbe82e79e4
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=8267e9af795434ffadad
> userspace arch: i386
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=10d58784600000
>
> Reported-by: syzbot+8267e9af795434ffadad@syzkaller.appspotmail.com
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual 
> address")
>
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection


#syz dup: WARNING in __mmdrop

