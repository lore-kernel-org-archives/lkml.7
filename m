Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33ABC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E3020840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="dY3N7FwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfHMVKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:10:49 -0400
Received: from first.geanix.com ([116.203.34.67]:53280 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHMVKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:10:49 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 85D234B441;
        Tue, 13 Aug 2019 21:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1565730578; bh=HnRrkMnK2x5biGgdnBcO7bDH82LVKWeShQafsKrCa4g=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=dY3N7FwQTee1xMDY+q1fZ2CG38Sn4Agm+s9vQmv/0bGtxEsgAA7AM67QUxURna11R
         NFLVnt1lCyaweKFLTmnVtpIL27j+hL7Y6/2mzx3+fdQ7EBQGFnpKThYZt7Hv8l1V0a
         eTx1Z3aHEMsIBkbYMpVSNSnZ61hmQO5piKoJuYNTBqGSLYuS2Ct7rr0X+w/cxb9wlk
         dwEeOrKYLehlUplyByLxB/QJjRSLo1jGQ3K2ISmPTjLbX032/aRisIQDY4/eDws98K
         dU3ED80VktW+/RY+/3Gqp7QYtu6BrkTf4u92+Jf3lw0mgUpKzv3h7rmQuGw0C4Z+FF
         8eINEf/JkVGSQ==
Subject: Re: [BUG] n_gsm: possible recursive locking detected
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dirkjan Bussink <dirkjan.bussink@nedap.com>
References: <e2e9cc8f-6bb4-f66f-2d2b-3875c2e66cd3@geanix.com>
 <20190725112651.GA12309@kroah.com>
 <79b38084-8867-0972-ca6c-155e5dbb0d90@geanix.com>
Message-ID: <cbae9e00-d3cf-848a-636d-8d4b3d0973f5@geanix.com>
Date:   Tue, 13 Aug 2019 23:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <79b38084-8867-0972-ca6c-155e5dbb0d90@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/08/2019 22.59, Martin Hundebøll wrote:
> 
> 
> On 25/07/2019 13.26, Greg Kroah-Hartman wrote:
>> On Wed, Jul 17, 2019 at 11:40:02AM +0200, Martin Hundebøll wrote:
>>> Hi,
>>>
>>> The GSM0710 line discipline driver triggers a lockdep warning when 
>>> disabling
>>> the ldisc while holding a multiplexed virtual tty open:
>>>
>>> ============================================
>>> WARNING: possible recursive locking detected
>>> 5.2.0-00114-gdab52e30156b #6 Not tainted
>>> --------------------------------------------
>>> cmux/263 is trying to acquire lock:
>>> e1e23b18 (&tty->legacy_mutex){+.+.}, at: __tty_hangup.part.0+0x58/0x27c
>>>
>>> but task is already holding lock:
>>> d6eddf48 (&tty->legacy_mutex){+.+.}, at: tty_set_ldisc+0x3c/0x1bc
>>>
>>> other info that might help us debug this:
>>>   Possible unsafe locking scenario:
>>>
>>>         CPU0
>>>         ----
>>>    lock(&tty->legacy_mutex);
>>>    lock(&tty->legacy_mutex);
>>>
>>>   *** DEADLOCK ***
>>>
>>>   May be due to missing lock nesting notation
>>>
>>> 3 locks held by cmux/263:
>>>   #0: d6eddf48 (&tty->legacy_mutex){+.+.}, at: tty_set_ldisc+0x3c/0x1bc
>>>   #1: f28bead9 (&tty->ldisc_sem){++++}, at: tty_ldisc_lock+0x50/0x74
>>>   #2: e5d20e4f (&gsm->mutex){+.+.}, at: gsm_cleanup_mux+0x9c/0x15c
>>>
>>> stack backtrace:
>>> CPU: 0 PID: 263 Comm: cmux Not tainted 5.2.0-00114-gdab52e30156b #6
>>> Hardware name: Freescale i.MX6 Ultralite (Device Tree)
>>> [<c011184c>] (unwind_backtrace) from [<c010cc74>] (show_stack+0x10/0x14)
>>> [<c010cc74>] (show_stack) from [<c0852488>] (dump_stack+0xd4/0x108)
>>> [<c0852488>] (dump_stack) from [<c017be90>] 
>>> (__lock_acquire+0x6ec/0x1e84)
>>> [<c017be90>] (__lock_acquire) from [<c017ddc4>] 
>>> (lock_acquire+0xcc/0x204)
>>> [<c017ddc4>] (lock_acquire) from [<c086e9d0>] (__mutex_lock+0x64/0x90c)
>>> [<c086e9d0>] (__mutex_lock) from [<c086f294>] 
>>> (mutex_lock_nested+0x1c/0x24)
>>> [<c086f294>] (mutex_lock_nested) from [<c04c02fc>]
>>> (__tty_hangup.part.0+0x58/0x27c)
>>> [<c04c02fc>] (__tty_hangup.part.0) from [<c04ce718>]
>>> (gsm_cleanup_mux+0xe8/0x15c)
>>> [<c04ce718>] (gsm_cleanup_mux) from [<c04ce7d4>] (gsmld_close+0x48/0x90)
>>> [<c04ce7d4>] (gsmld_close) from [<c04c7e24>] (tty_set_ldisc+0xb8/0x1bc)
>>> [<c04c7e24>] (tty_set_ldisc) from [<c04c0b70>] (tty_ioctl+0x640/0xcb0)
>>> [<c04c0b70>] (tty_ioctl) from [<c0297e68>] (do_vfs_ioctl+0x41c/0xa5c)
>>> [<c0297e68>] (do_vfs_ioctl) from [<c02984dc>] (ksys_ioctl+0x34/0x60)
>>> [<c02984dc>] (ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
>>> Exception stack(0xc8ce1fa8 to 0xc8ce1ff0)
>>> 1fa0:                   00438000 00000000 00000003 00005423 beb6cc04
>>> beb6cc04
>>> 1fc0: 00438000 00000000 00000000 00000036 00000000 00000000 00438000
>>> beb6ccd4
>>> 1fe0: 00438048 beb6cbfc 00427684 b6f58b88
>>>
>>>
>>> Steps to reproduce using the attached cmux util:
>>>
>>> root@iwg26:~# ./cmux &
>>> [1] 254
>>> SERIAL_PORT = /dev/ttymxc0
>>> AT+IFC=2: Ie5   +CFUN: 1    +CPIN: READY    Call Ready  AT+IFC=2,2   OK
>>> AT+GMM  : AT+GMM   Quectel_M95    OK
>>> AT      : AT   OK
>>> AT+IPR=1: AT+IPR=115200&w   OK
>>> AT+CMUX=: AT+CMUX=0,0,5,512,10,3,30,10,2   OK
>>> Line dicipline set
>>>
>>> root@iwg26:~# cat /dev/gsmtty1 &
>>> [2] 262
>>> root@iwg26:~# kill %1
>>> [   74.517449] ============================================
>>> [   74.522769] WARNING: possible recursive locking detected
>>> [   74.528094] 5.2.0-00114-gdab52e30156b #6 Not tainted
>>> [   74.533065] --------------------------------------------
>>> <...>
>>>
>>>
>>> This has supposedly been fixed before in 4d9b109060f6 ("tty: Prevent
>>> deadlock in n_gsm driver"), but the fix was undone in be7065725590
>>> ("TTY/n_gsm: Removing the wrong tty_unlock/lock() in 
>>> gsm_dlci_release()")
>>
>> Do you have a patch that can resolve this given you have a test case?
> 
> No, sorry.
> 
> I can try to cook a patch, but chances are I will break locking for 
> someone else. Hints are welcome.

The recursive locking happens when restoring the initial line discipline:

	ioctl(serial_fd, TIOCSETD, &ldisc_save);

If I remove the restore, and let close() do the ldisc tear down I get a 
circular lockdep warning:

[   56.254258] ======================================================
[   56.260447] WARNING: possible circular locking dependency detected
[   56.266641] 5.2.0-00118-g1fd58e20e5b0 #30 Not tainted
[   56.271701] ------------------------------------------------------
[   56.277890] cmux/271 is trying to acquire lock:
[   56.282436] 8215283a (&tty->legacy_mutex){+.+.}, at: 
__tty_hangup.part.0+0x58/0x27c
[   56.290128]
[   56.290128] but task is already holding lock:
[   56.295970] e9e2b842 (&gsm->mutex){+.+.}, at: gsm_cleanup_mux+0x9c/0x15c
[   56.302699]
[   56.302699] which lock already depends on the new lock.
[   56.302699]
[   56.310884]
[   56.310884] the existing dependency chain (in reverse order) is:
[   56.318372]
[   56.318372] -> #2 (&gsm->mutex){+.+.}:
[   56.323624]        mutex_lock_nested+0x1c/0x24
[   56.328079]        gsm_cleanup_mux+0x9c/0x15c
[   56.332448]        gsmld_ioctl+0x418/0x4e8
[   56.336554]        tty_ioctl+0x96c/0xcb0
[   56.340492]        do_vfs_ioctl+0x41c/0xa5c
[   56.344685]        ksys_ioctl+0x34/0x60
[   56.348535]        ret_fast_syscall+0x0/0x28
[   56.352815]        0xbe97cc04
[   56.355791]
[   56.355791] -> #1 (&tty->ldisc_sem){++++}:
[   56.361388]        tty_ldisc_lock+0x50/0x74
[   56.365581]        tty_init_dev+0x88/0x1c4
[   56.369687]        tty_open+0x1c8/0x430
[   56.373536]        chrdev_open+0xa8/0x19c
[   56.377560]        do_dentry_open+0x118/0x3c4
[   56.381928]        path_openat+0x2fc/0x1190
[   56.386123]        do_filp_open+0x68/0xd4
[   56.390146]        do_sys_open+0x164/0x220
[   56.394257]        kernel_init_freeable+0x328/0x3e4
[   56.399146]        kernel_init+0x8/0x110
[   56.403078]        ret_from_fork+0x14/0x20
[   56.407183]        0x0
[   56.409548]
[   56.409548] -> #0 (&tty->legacy_mutex){+.+.}:
[   56.415402]        __mutex_lock+0x64/0x90c
[   56.419508]        mutex_lock_nested+0x1c/0x24
[   56.423961]        __tty_hangup.part.0+0x58/0x27c
[   56.428676]        gsm_cleanup_mux+0xe8/0x15c
[   56.433043]        gsmld_close+0x48/0x90
[   56.436979]        tty_ldisc_kill+0x2c/0x6c
[   56.441173]        tty_ldisc_release+0x88/0x194
[   56.445715]        tty_release_struct+0x14/0x44
[   56.450254]        tty_release+0x36c/0x43c
[   56.454365]        __fput+0x94/0x1e8


Doing the hangup asynchronously fixes both cases for me (tested on 5.2):

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d30525946892..36a3eb4ad4c5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1716,7 +1716,7 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
                 gsm_destroy_network(dlci);
                 mutex_unlock(&dlci->mutex);

-               tty_vhangup(tty);
+               tty_hangup(tty);

                 tty_port_tty_set(&dlci->port, NULL);
                 tty_kref_put(tty);

What am I missing ?

// Martin
