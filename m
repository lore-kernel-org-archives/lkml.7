Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E36DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4720720830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaiiRwOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfCZK2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:28:34 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52026 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCZK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:28:31 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so18693345itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Pa2hHx1krLUUKLo4HVfoSo1n6QmzxGuIvnvOfPoj1A=;
        b=qaiiRwOwTa19JjyeE3h36Yl3zW8YxQZc+OaRxetF5FWJppv1Whxpj2q3fYu2+wx+Sw
         4NMwFrPEzJkZ9qSXxSny0tgI1EvzEFTFoT4yr/0FjQ5/t6Ox5kN+OFH2acPJlorzSB4b
         Zj/X1c0YPAXDVmKvFbqziFSWphvhUTo2gLRlP1tXJW76zeeiirZxQT5s3xuTBnC4rVg5
         7cQ2KfrhZNWkbyxl2YwgH3sv4GEVfFlUWGxJNHq70YYQFapuEB7kR3nTmEM5SfUHYgL6
         MTpX7iI+S7TqSNImFeHiD16k3vyercp8Avb0wx/oZ4DVAAP6vk8L9qoupH67ir0ewwhp
         0Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Pa2hHx1krLUUKLo4HVfoSo1n6QmzxGuIvnvOfPoj1A=;
        b=Yp6DpU8SShXEiMcN3YR2kyLKQ9map5cte3U9A7hWMTGpnQvvqGldWTXZCOwao0n6JB
         EGnU5T/ecjb3nW7TSz5ctTV+dcg2eYmXVB8sxGxh+LT+9Buyqr5KZpvRqKpkj6hyB6T8
         IXeSUB+gOslxWrBuzcxTydvxTc+kZzu0sY4oqG19jT0psUZVg3T6V1NNyO8Op11iwE7w
         YDLIs1P/UKko7k7cnfmPn8XoddU6oFhedt4WmXLGZWzYXfWPG3Fhs0XWa53oI4cZUkgk
         +eknt00c1AC7bCMxLQJx8el6ruDDUet6naB8ZD1yR17tDTakoa1k4uUxqdO0O2YOAuKo
         7n/A==
X-Gm-Message-State: APjAAAVwFLzue3AT5h4Fjn6qKo5Tw2YRHjcFgOHXhJ9Lk+LUQZSVtnCR
        k7Z3wGht6hz57xNJOsW0MlroKUgfUP/VeNxJGmIZvQ==
X-Google-Smtp-Source: APXvYqxSmng3heofTCli47CaH/ZWlY+Z+Gi548aO6izCOxG5kiWeDpJjVWYO66BU1Pmf+yFgPnyuixVND1l5T1dr/Sc=
X-Received: by 2002:a24:3281:: with SMTP id j123mr13899319ita.166.1553596109701;
 Tue, 26 Mar 2019 03:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f8499057be95e1d@google.com> <0000000000008ee87005847fc985@google.com>
 <20190325100223-mutt-send-email-mst@kernel.org> <df4f2cf6-8469-f894-8f45-7c48a6a1801f@redhat.com>
In-Reply-To: <df4f2cf6-8469-f894-8f45-7c48a6a1801f@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Mar 2019 11:28:18 +0100
Message-ID: <CACT4Y+Z1s-Lx1UXHKj88kQoOcbiD8gwyuRU3F_+cceP3pzbbrw@mail.gmail.com>
Subject: Re: INFO: task hung in vhost_net_stop_vq
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot <syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        virtualization@lists.linux-foundation.org, weiyj.lk@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:17 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/3/25 =E4=B8=8B=E5=8D=8810:02, Michael S. Tsirkin wrote:
> > Looks like more iotlb locking mess?
>
>
> Looking at the calltrace:
>
> [  221.743675] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> [  221.744297] [ INFO: possible recursive locking detected ]
> [  221.744944] 4.7.0+ #1 Not tainted
> [  221.745326] ---------------------------------------------
> [  221.746128] syz-executor1/6823 is trying to acquire lock:
> [  221.746737]  (&vq->mutex){+.+...}, at: [<ffffffff84484b70>] vhost_proc=
ess_iotlb_msg+0xe0/0x9e0
> [  221.747789]
> [  221.747789] but task is already holding lock:
> [  221.748470]  (&vq->mutex){+.+...}, at: [<ffffffff84484b70>] vhost_proc=
ess_iotlb_msg+0xe0/0x9e0
> [  221.749535]
> [  221.749535] other info that might help us debug this:
> [  221.750280]  Possible unsafe locking scenario:
> [  221.750280]
> [  221.750946]        CPU0
> [  221.751232]        ----
> [  221.751523]   lock(&vq->mutex);
> [  221.751922]   lock(&vq->mutex);
> [  221.752339]
> [  221.752339]  *** DEADLOCK ***
> [  221.752339]
>
> I could not think of a path that can hit this. And I could not reproduce =
with the reproducer in the link in net-next.


Looking at the bisection log, syzbot is able to reproduce this
super-reliably on multiple kernel revisions. Are you sure you are
using the right config/revision? What else can be in play? syzbot uses
VMs. The image is available.


> Thanks
>
>
> >
> > On Tue, Mar 19, 2019 at 10:21:00PM -0700, syzbot wrote:
> >> syzbot has bisected this bug to:
> >>
> >> commit 6b1e6cc7855b09a0a9bfa1d9f30172ba366f161c
> >> Author: Jason Wang <jasowang@redhat.com>
> >> Date:   Thu Jun 23 06:04:32 2016 +0000
> >>
> >>      vhost: new device IOTLB API
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1486ad2=
7200000
> >> start commit:   6b1e6cc7 vhost: new device IOTLB API
> >> git tree:       upstream
> >> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D1686ad2=
7200000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1286ad2720=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc94f9f0c03=
63db4b
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd21e6e297322=
a900c128
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D141db34d=
400000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D108ef29340=
0000
> >>
> >> Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
> >> Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/df4f2cf6-8469-f894-8f45-7c48a6a1801f%40redhat.com.
> For more options, visit https://groups.google.com/d/optout.
