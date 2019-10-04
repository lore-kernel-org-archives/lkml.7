Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C808C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C34D222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570194773;
	bh=SSmPcvLZmSMyjaaVpSqokklrhqv+4ipEMepV2hCCcu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G7jg6HZ9yE5SNhcBmmjBBR6B+bxNTeiC+Q5TDQIHfX933E+/pJjm7ASwZd9KsFRhd
	 yHZMmO8ctMHVxc4efDmV6dO5t3STLV0JXZJfqrzCINfImEviODHe/Bw04ZLDxBSmqp
	 jo57gIT7M1EhcIQV4sfw706sTgN9OQKdJBILSpZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbfJDNMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387545AbfJDNMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:12:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC365215EA;
        Fri,  4 Oct 2019 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570194771;
        bh=SSmPcvLZmSMyjaaVpSqokklrhqv+4ipEMepV2hCCcu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8P+Cgkqc1I7N7eQ5K66gNOHRmyaAolFQnRY0sxQxc+m8RwIelPJhFJKiUh0Ncn/R
         axdNMg2qsmGIJr3tR9OmyzpyG7rXsDeE1BfZ3noCLmrALhr5WbkDGc2jPZhF4iYEju
         pIPdr41eBy0Wev9SpS9OljuAsvpDY4Fu1cuZVKsA=
Date:   Fri, 4 Oct 2019 15:12:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     jslaby@suse.com, nico@fluxnic.net, textshell@uchuujin.de,
        daniel.vetter@ffwll.ch, sam@ravnborg.org, mpatocka@redhat.com,
        ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/vt: Touch NMI watchdog in vt_console_print
Message-ID: <20191004131248.GA644694@kroah.com>
References: <1568969846-1800-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568969846-1800-1-git-send-email-hqjagain@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:57:26PM +0800, Qiujun Huang wrote:
> vt_console_print could trigger NMI watchdog in case writing slow:
> 
> [2858736.789664] NMI watchdog: Watchdog detected hard LOCKUP on cpu 23
> ...
> [2858736.790194] CPU: 23 PID: 32504 Comm: tensorflow_mode Not tainted 4.4.131-1.el7.elrepo.x86_64 #1
> [2858736.790206] Hardware name: Huawei RH2288 V3/BC11HGSB0, BIOS 3.57 02/26/2017
> [2858736.790222] task: ffff881e0a191640 ti: ffff881fd73a8000 task.ti: ffff881fd73a8000
> [2858736.790358] RIP: 0010:[<ffffffff810cc06e>]  [<ffffffff810cc06e>] native_queued_spin_lock_slowpath+0x15e/0x170
> [2858736.790363] RSP: 0018:ffff88203f043db0  EFLAGS: 00000002
> [2858736.790365] RAX: 00000000005c0101 RBX: 0000000000000246 RCX: 0000000000000001
> ...
> [2858736.790452] Call Trace:
> [2858736.790521]  <IRQ>
> [2858736.790521]  [<ffffffff8118ab28>] queued_spin_lock_slowpath+0xb/0xf
> [2858736.790552]  [<ffffffff8170eca7>] _raw_spin_lock_irqsave+0x37/0x40
> [2858736.790653]  [<ffffffff814c80a4>] scsi_end_request+0x104/0x1d0
> [2858736.790656]  [<ffffffff814c9e13>] scsi_io_completion+0x153/0x650
> [2858736.790671]  [<ffffffff814c1092>] scsi_finish_command+0xd2/0x120
> [2858736.790673]  [<ffffffff814c9607>] scsi_softirq_done+0x127/0x150
> [2858736.790749]  [<ffffffff8131973e>] blk_done_softirq+0x8e/0xc0
> [2858736.790811]  [<ffffffff810857db>] __do_softirq+0xeb/0x2f0
> [2858736.790813]  [<ffffffff81085c85>] irq_exit+0xf5/0x100
> [2858736.790867]  [<ffffffff81051819>] smp_call_function_single_interrupt+0x39/0x40
> [2858736.790890]  [<ffffffff8171055b>] call_function_single_interrupt+0x9b/0xa0
> [2858736.790973]  <EOI>
> ...
> 
> PID: 1793   TASK: ffff88103445c2c0  CPU: 32  COMMAND: "java"
>  #0 [ffff88103fe88e38] crash_nmi_callback at ffffffff810504d7
>  #1 [ffff88103fe88e48] nmi_handle at ffffffff8101c1f7
>  #2 [ffff88103fe88ea0] default_do_nmi at ffffffff8101c7d0
>  #3 [ffff88103fe88ec0] do_nmi at ffffffff8101c901
>  #4 [ffff88103fe88ee8] end_repeat_nmi at ffffffff8171176a
>     [exception RIP: cfb_imageblit+1167]
>     RIP: ffffffff813bdf8f  RSP: ffff880006823380  RFLAGS: 00000046
>     RAX: 0000000000000001  RBX: 0000000000000000  RCX: 0000000000000005
>     RDX: 000000000000024d  RSI: 00000000ff000000  RDI: 0000000000000001
>     RBP: ffff8800068233f0   R8: ffffffff81785e80   R9: ffffc9000c843168
>     R10: 0000000000000001  R11: 0000000000000000  R12: ffff882037a831ba
>     R13: ffff882037a831af  R14: ffffc9000c84316c  R15: ffffc9000c843000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #5 [ffff880006823380] cfb_imageblit at ffffffff813bdf8f
>  #6 [ffff880006823398] bit_putcs at ffffffff813b2307
>  #7 [ffff8800068234d0] bit_cursor at ffffffff813b1fc8
>  #8 [ffff8800068235f0] fbcon_scroll at ffffffff813aebda
>  #9 [ffff880006823650] scrup at ffffffff81442600
> ...
> 
> the cpu23 wait for the same blk queue_lock

Why is this acting "slow"?

Do we want to sprinkle this type of call everywhere in the console layer
(hint, I doubt it.)

This feels like something odd is wrong with your system, not with the
tty layer...

thanks,

greg k-h
