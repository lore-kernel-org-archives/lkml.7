Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D6C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB48218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfGYHpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388193AbfGYHpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 356623084246;
        Thu, 25 Jul 2019 07:45:44 +0000 (UTC)
Received: from [10.72.12.18] (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2591B5C6D2;
        Thu, 25 Jul 2019 07:45:16 +0000 (UTC)
Subject: Re: WARNING in __mmdrop
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190722141152.GA13711@ziepe.ca>
 <20190725015402-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6389178e-35f2-28a1-4d36-3696bcde6af0@redhat.com>
Date:   Thu, 25 Jul 2019 15:44:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725015402-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 25 Jul 2019 07:45:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/25 下午2:02, Michael S. Tsirkin wrote:
> On Mon, Jul 22, 2019 at 11:11:52AM -0300, Jason Gunthorpe wrote:
>> On Sun, Jul 21, 2019 at 06:02:52AM -0400, Michael S. Tsirkin wrote:
>>> On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
>>>> syzbot has bisected this bug to:
>>>>
>>>> commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
>>>> Author: Jason Wang <jasowang@redhat.com>
>>>> Date:   Fri May 24 08:12:18 2019 +0000
>>>>
>>>>      vhost: access vq metadata through kernel virtual address
>>>>
>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
>>>> start commit:   6d21a41b Add linux-next specific files for 20190718
>>>> git tree:       linux-next
>>>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
>>>>
>>>> Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
>>>> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
>>>> address")
>>>>
>>>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>>
>>> OK I poked at this for a bit, I see several things that
>>> we need to fix, though I'm not yet sure it's the reason for
>>> the failures:
>> This stuff looks quite similar to the hmm_mirror use model and other
>> places in the kernel. I'm still hoping we can share this code a bit more.
> Right. I think hmm is something we should look at.


Exactly. I plan to do that.

Thanks

