Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B6FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A1F20748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfKYONI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:13:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49822 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:13:07 -0500
Received: from 79.184.255.91.ipv4.supernova.orange.pl (79.184.255.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id f0c09f2032884491; Mon, 25 Nov 2019 15:13:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: kernel 5.2+: suspend freeze in VMware Player.
Date:   Mon, 25 Nov 2019 15:13:05 +0100
Message-ID: <1725395.bLeSF54TfN@kreacher>
In-Reply-To: <bc51bc4e-21e5-d6a9-22ee-7c1194deefc8@gmail.com>
References: <bc51bc4e-21e5-d6a9-22ee-7c1194deefc8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, November 23, 2019 11:51:19 PM CET Woody Suwalski wrote:
> Rafael, Thomas, this is the same VMware Player 15.2 freeze on suspend issue
> I have been discussing with you in August.
> 
> It has surfaced after Thomas Gleixner's change in kernel 5.2
> dfe0cf8b  x86/ioapic: Implement irq_get irqchip_state() callback
> 
> It is still with us in 5.4, 100% repeatable on a second suspend after a 
> reboot.
> 
> I have traced it down to the ioapic_irq_get_chip_state() function, where
> rentry.rr is stuck hi.
> 
> On the first suspend I can see that for IRQ9 the test exits with irr=0,
> trigger=1, but on second and consecutive suspends it is returning
> irr=1 trigger=1, so *state=1, and this results in a never-ending loop
> in __synchronize_hardirq(), because inprogress is always 1.
> 
> I have been usig a "fix" to timeout in __synchronize_hardirq() after
> 64 iterations, and that seems to work OK (no side-effects noticed),
> but of course is not addressing the underlying problem.
> 
> And the problem may be somewhere in VMware emulation code, returning bad 
> data?
> 
> Would you have ideas as to what should be the right setting for
> IRQ9 in VM environment?  Edge or level?
> And which part of code is reading the "hardware" state from VMware?
> 
> OTOH, current implementation is not really safe, as the wait loop should 

It is not clear to me the current implementation of what exactly you mean here.

> have a timeout, or else it may get stuck. Should I provide my safety-exit patch?

Thanks!



