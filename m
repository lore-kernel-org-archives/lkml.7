Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACDC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED4C21BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfGXHHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfGXHHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:07:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A41A3179174;
        Wed, 24 Jul 2019 07:07:12 +0000 (UTC)
Received: from [10.72.12.106] (ovpn-12-106.pek2.redhat.com [10.72.12.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC5A260148;
        Wed, 24 Jul 2019 07:06:59 +0000 (UTC)
Subject: Re: KASAN: use-after-free Read in finish_task_switch (2)
To:     syzbot <syzbot+7f067c796eee2acbc57a@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, luto@amacapital.net, mhocko@suse.com,
        mingo@kernel.org, mst@redhat.com, namit@vmware.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        wad@chromium.org, yuehaibing@huawei.com
References: <00000000000027494e058e0b4b3f@google.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fc935344-4f35-3f05-dc33-398655b38330@redhat.com>
Date:   Wed, 24 Jul 2019 15:06:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <00000000000027494e058e0b4b3f@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 24 Jul 2019 07:07:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/20 上午12:34, syzbot wrote:
> syzbot has bisected this bug to:
>
> commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Fri May 24 08:12:18 2019 +0000
>
>     vhost: access vq metadata through kernel virtual address
>
> bisection log: 
> https://syzkaller.appspot.com/x/bisect.txt?x=123faf70600000
> start commit:   22051d9c Merge tag 'platform-drivers-x86-v5.3-2' of 
> git://..
> git tree:       upstream
> final crash: https://syzkaller.appspot.com/x/report.txt?x=113faf70600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=163faf70600000
> kernel config: https://syzkaller.appspot.com/x/.config?x=135cb826ac59d7fc
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=7f067c796eee2acbc57a
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=12c1898fa00000
>
> Reported-by: syzbot+7f067c796eee2acbc57a@syzkaller.appspotmail.com
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual 
> address")
>
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection


#syz dup: WARNING in __mmdrop

