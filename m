Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF0C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A9D2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfFXJeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:34:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35443 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:34:22 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfLML-0003qz-Q7; Mon, 24 Jun 2019 11:33:57 +0200
Date:   Mon, 24 Jun 2019 11:33:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+c4521ac872a4ccc3afec@syzkaller.appspotmail.com>
cc:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        dmitry.torokhov@gmail.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        wanghai26@huawei.com, yuehaibing@huawei.com
Subject: Re: WARNING: ODEBUG bug in netdev_freemem (2)
In-Reply-To: <000000000000d6a8ba058c0df076@google.com>
Message-ID: <alpine.DEB.2.21.1906241130100.32342@nanos.tec.linutronix.de>
References: <000000000000d6a8ba058c0df076@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    fd6b99fa Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=144de256a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
> dashboard link: https://syzkaller.appspot.com/bug?extid=c4521ac872a4ccc3afec
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c4521ac872a4ccc3afec@syzkaller.appspotmail.com
> 
> device hsr_slave_0 left promiscuous mode
> team0 (unregistering): Port device team_slave_1 removed
> team0 (unregistering): Port device team_slave_0 removed
> bond0 (unregistering): Releasing backup interface bond_slave_1
> bond0 (unregistering): Releasing backup interface bond_slave_0
> bond0 (unregistering): Released all slaves
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object type: timer_list hint:
> delayed_work_timer_fn+0x0/0x90 arch/x86/include/asm/paravirt.h:767

One of the cleaned up devices has left an active timer which belongs to a
delayed work. That's all I can decode out of that splat. :(

Thanks,

	tglx


