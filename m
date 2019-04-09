Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D7BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD61B213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfDIDbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:31:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfDIDbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:31:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D269B308620E;
        Tue,  9 Apr 2019 03:31:50 +0000 (UTC)
Received: from [10.72.12.117] (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E0901001E8E;
        Tue,  9 Apr 2019 03:31:45 +0000 (UTC)
Subject: Re: INFO: task hung in vhost_net_stop_vq
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot <syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        virtualization@lists.linux-foundation.org, weiyj.lk@gmail.com
References: <0000000000004f8499057be95e1d@google.com>
 <0000000000008ee87005847fc985@google.com>
 <20190325100223-mutt-send-email-mst@kernel.org>
 <df4f2cf6-8469-f894-8f45-7c48a6a1801f@redhat.com>
 <CACT4Y+Z1s-Lx1UXHKj88kQoOcbiD8gwyuRU3F_+cceP3pzbbrw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <858fcd87-071f-e484-7d2d-a7d9f8144f91@redhat.com>
Date:   Tue, 9 Apr 2019 11:31:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z1s-Lx1UXHKj88kQoOcbiD8gwyuRU3F_+cceP3pzbbrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 09 Apr 2019 03:31:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/26 下午6:28, Dmitry Vyukov wrote:
> On Tue, Mar 26, 2019 at 11:17 AM Jason Wang<jasowang@redhat.com>  wrote:
>> On 2019/3/25 下午10:02, Michael S. Tsirkin wrote:
>>> Looks like more iotlb locking mess?
>> Looking at the calltrace:
>>
>> [  221.743675] =============================================
>> [  221.744297] [ INFO: possible recursive locking detected ]
>> [  221.744944] 4.7.0+ #1 Not tainted
>> [  221.745326] ---------------------------------------------
>> [  221.746128] syz-executor1/6823 is trying to acquire lock:
>> [  221.746737]  (&vq->mutex){+.+...}, at: [<ffffffff84484b70>] vhost_process_iotlb_msg+0xe0/0x9e0
>> [  221.747789]
>> [  221.747789] but task is already holding lock:
>> [  221.748470]  (&vq->mutex){+.+...}, at: [<ffffffff84484b70>] vhost_process_iotlb_msg+0xe0/0x9e0
>> [  221.749535]
>> [  221.749535] other info that might help us debug this:
>> [  221.750280]  Possible unsafe locking scenario:
>> [  221.750280]
>> [  221.750946]        CPU0
>> [  221.751232]        ----
>> [  221.751523]   lock(&vq->mutex);
>> [  221.751922]   lock(&vq->mutex);
>> [  221.752339]
>> [  221.752339]  *** DEADLOCK ***
>> [  221.752339]
>>
>> I could not think of a path that can hit this. And I could not reproduce with the reproducer in the link in net-next.
> Looking at the bisection log, syzbot is able to reproduce this
> super-reliably on multiple kernel revisions. Are you sure you are
> using the right config/revision? What else can be in play? syzbot uses
> VMs. The image is available.
>
>

Yes, looks like the reason is vhost accept zero size iova range which 
lead a infinite loop when trying to translate iova. Will post a patch to 
fix this.

Thanks

