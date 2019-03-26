Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB57620856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfCZKRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfCZKRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:17:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A449C057F3D;
        Tue, 26 Mar 2019 10:17:33 +0000 (UTC)
Received: from [10.72.12.211] (ovpn-12-211.pek2.redhat.com [10.72.12.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D134F48D24;
        Tue, 26 Mar 2019 10:17:27 +0000 (UTC)
Subject: Re: INFO: task hung in vhost_net_stop_vq
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot <syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org, weiyj.lk@gmail.com
References: <0000000000004f8499057be95e1d@google.com>
 <0000000000008ee87005847fc985@google.com>
 <20190325100223-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <df4f2cf6-8469-f894-8f45-7c48a6a1801f@redhat.com>
Date:   Tue, 26 Mar 2019 18:17:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325100223-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 26 Mar 2019 10:17:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/25 下午10:02, Michael S. Tsirkin wrote:
> Looks like more iotlb locking mess?


Looking at the calltrace:

[  221.743675] =============================================
[  221.744297] [ INFO: possible recursive locking detected ]
[  221.744944] 4.7.0+ #1 Not tainted
[  221.745326] ---------------------------------------------
[  221.746128] syz-executor1/6823 is trying to acquire lock:
[  221.746737]  (&vq->mutex){+.+...}, at: [<ffffffff84484b70>] vhost_process_iotlb_msg+0xe0/0x9e0
[  221.747789]
[  221.747789] but task is already holding lock:
[  221.748470]  (&vq->mutex){+.+...}, at: [<ffffffff84484b70>] vhost_process_iotlb_msg+0xe0/0x9e0
[  221.749535]
[  221.749535] other info that might help us debug this:
[  221.750280]  Possible unsafe locking scenario:
[  221.750280]
[  221.750946]        CPU0
[  221.751232]        ----
[  221.751523]   lock(&vq->mutex);
[  221.751922]   lock(&vq->mutex);
[  221.752339]
[  221.752339]  *** DEADLOCK ***
[  221.752339]

I could not think of a path that can hit this. And I could not reproduce with the reproducer in the link in net-next.

Thanks


>
> On Tue, Mar 19, 2019 at 10:21:00PM -0700, syzbot wrote:
>> syzbot has bisected this bug to:
>>
>> commit 6b1e6cc7855b09a0a9bfa1d9f30172ba366f161c
>> Author: Jason Wang <jasowang@redhat.com>
>> Date:   Thu Jun 23 06:04:32 2016 +0000
>>
>>      vhost: new device IOTLB API
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1486ad27200000
>> start commit:   6b1e6cc7 vhost: new device IOTLB API
>> git tree:       upstream
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1686ad27200000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1286ad27200000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d21e6e297322a900c128
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141db34d400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ef293400000
>>
>> Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
>> Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
