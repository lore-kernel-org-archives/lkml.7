Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C3EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A1C20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KpwMHLSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfHLVAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:00:08 -0400
Received: from first.geanix.com ([116.203.34.67]:57890 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfHLVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:00:07 -0400
Received: from [192.168.8.21] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id D641556039;
        Mon, 12 Aug 2019 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1565643542; bh=rHjYfc08ShpDPeyiIqfYjLEdvUv9CGrkWeC0Jnjou5M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KpwMHLSnTo1bcxaeQceZAuHj9rNyLOh/Dpn7unBeJeT6n46ukfdsOHqoRRX0Y4PP4
         OSdh/W0aTGw5hIIHXoVV1hy0TuchwkK6QVeihZTwNpUXEBXeBHnPkHAmgBOZLwFzgg
         fMVR6bcbkw+BeEF0pWGgq22gVZ3mlHuWzueuDtxQbCNh4krhHkhd54tObGoAKqrSAN
         i4LEi1F3XFEn5jW7YAOgYhA8liFSX8Fj1Bk/xPFsEcQ6Q+nyd69PHKot3/FZERfalp
         0wKJWIkpAuBWtBEzXBx0jQx8JVyX/TlA31J4RJhi5+qXU7pBOK8EPgthWNbv1LYQ0z
         vzhCKizxRJW+A==
Subject: Re: [BUG] n_gsm: possible recursive locking detected
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dirkjan Bussink <dirkjan.bussink@nedap.com>
References: <e2e9cc8f-6bb4-f66f-2d2b-3875c2e66cd3@geanix.com>
 <20190725112651.GA12309@kroah.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Message-ID: <79b38084-8867-0972-ca6c-155e5dbb0d90@geanix.com>
Date:   Mon, 12 Aug 2019 22:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725112651.GA12309@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2019 13.26, Greg Kroah-Hartman wrote:
> On Wed, Jul 17, 2019 at 11:40:02AM +0200, Martin Hundebøll wrote:
>> Hi,
>>
>> The GSM0710 line discipline driver triggers a lockdep warning when disabling
>> the ldisc while holding a multiplexed virtual tty open:
>>
>> ============================================
>> WARNING: possible recursive locking detected
>> 5.2.0-00114-gdab52e30156b #6 Not tainted
>> --------------------------------------------
>> cmux/263 is trying to acquire lock:
>> e1e23b18 (&tty->legacy_mutex){+.+.}, at: __tty_hangup.part.0+0x58/0x27c
>>
>> but task is already holding lock:
>> d6eddf48 (&tty->legacy_mutex){+.+.}, at: tty_set_ldisc+0x3c/0x1bc
>>
>> other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(&tty->legacy_mutex);
>>    lock(&tty->legacy_mutex);
>>
>>   *** DEADLOCK ***
>>
>>   May be due to missing lock nesting notation
>>
>> 3 locks held by cmux/263:
>>   #0: d6eddf48 (&tty->legacy_mutex){+.+.}, at: tty_set_ldisc+0x3c/0x1bc
>>   #1: f28bead9 (&tty->ldisc_sem){++++}, at: tty_ldisc_lock+0x50/0x74
>>   #2: e5d20e4f (&gsm->mutex){+.+.}, at: gsm_cleanup_mux+0x9c/0x15c
>>
>> stack backtrace:
>> CPU: 0 PID: 263 Comm: cmux Not tainted 5.2.0-00114-gdab52e30156b #6
>> Hardware name: Freescale i.MX6 Ultralite (Device Tree)
>> [<c011184c>] (unwind_backtrace) from [<c010cc74>] (show_stack+0x10/0x14)
>> [<c010cc74>] (show_stack) from [<c0852488>] (dump_stack+0xd4/0x108)
>> [<c0852488>] (dump_stack) from [<c017be90>] (__lock_acquire+0x6ec/0x1e84)
>> [<c017be90>] (__lock_acquire) from [<c017ddc4>] (lock_acquire+0xcc/0x204)
>> [<c017ddc4>] (lock_acquire) from [<c086e9d0>] (__mutex_lock+0x64/0x90c)
>> [<c086e9d0>] (__mutex_lock) from [<c086f294>] (mutex_lock_nested+0x1c/0x24)
>> [<c086f294>] (mutex_lock_nested) from [<c04c02fc>]
>> (__tty_hangup.part.0+0x58/0x27c)
>> [<c04c02fc>] (__tty_hangup.part.0) from [<c04ce718>]
>> (gsm_cleanup_mux+0xe8/0x15c)
>> [<c04ce718>] (gsm_cleanup_mux) from [<c04ce7d4>] (gsmld_close+0x48/0x90)
>> [<c04ce7d4>] (gsmld_close) from [<c04c7e24>] (tty_set_ldisc+0xb8/0x1bc)
>> [<c04c7e24>] (tty_set_ldisc) from [<c04c0b70>] (tty_ioctl+0x640/0xcb0)
>> [<c04c0b70>] (tty_ioctl) from [<c0297e68>] (do_vfs_ioctl+0x41c/0xa5c)
>> [<c0297e68>] (do_vfs_ioctl) from [<c02984dc>] (ksys_ioctl+0x34/0x60)
>> [<c02984dc>] (ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
>> Exception stack(0xc8ce1fa8 to 0xc8ce1ff0)
>> 1fa0:                   00438000 00000000 00000003 00005423 beb6cc04
>> beb6cc04
>> 1fc0: 00438000 00000000 00000000 00000036 00000000 00000000 00438000
>> beb6ccd4
>> 1fe0: 00438048 beb6cbfc 00427684 b6f58b88
>>
>>
>> Steps to reproduce using the attached cmux util:
>>
>> root@iwg26:~# ./cmux &
>> [1] 254
>> SERIAL_PORT = /dev/ttymxc0
>> AT+IFC=2: Ie5   +CFUN: 1    +CPIN: READY    Call Ready  AT+IFC=2,2   OK
>> AT+GMM  : AT+GMM   Quectel_M95    OK
>> AT      : AT   OK
>> AT+IPR=1: AT+IPR=115200&w   OK
>> AT+CMUX=: AT+CMUX=0,0,5,512,10,3,30,10,2   OK
>> Line dicipline set
>>
>> root@iwg26:~# cat /dev/gsmtty1 &
>> [2] 262
>> root@iwg26:~# kill %1
>> [   74.517449] ============================================
>> [   74.522769] WARNING: possible recursive locking detected
>> [   74.528094] 5.2.0-00114-gdab52e30156b #6 Not tainted
>> [   74.533065] --------------------------------------------
>> <...>
>>
>>
>> This has supposedly been fixed before in 4d9b109060f6 ("tty: Prevent
>> deadlock in n_gsm driver"), but the fix was undone in be7065725590
>> ("TTY/n_gsm: Removing the wrong tty_unlock/lock() in gsm_dlci_release()")
> 
> Do you have a patch that can resolve this given you have a test case?

No, sorry.

I can try to cook a patch, but chances are I will break locking for 
someone else. Hints are welcome.

// Martin
