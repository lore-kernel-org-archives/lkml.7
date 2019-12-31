Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177CFC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D776E2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qRWm/zNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLaCD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 21:03:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfLaCD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 21:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NcR1DITLyZDwVfijh4Itb/klrZ9aX2S8Z/+EATPgWnc=; b=qRWm/zNlS/s/vrfX7y9C9CuuT
        K/ydTptVeAfZxDkqRACaA5fQ5RJ/xz4rmbgG/tiP52U96Br2DeN1iYAjgNkkFSYoufWKTkda/Nw9D
        pPrDAMaqDGKbg2REiHXs7OSLpLrX1+wQWrtfcLHhkGWBEwFr3g1Hj7nHnmVCTszLDvBjDZTOw2V3e
        764RkvBU7ZX5+H/tN0jqdb0MMuDal/sxoWaK0ElWYxDG8UXaKHb4PJYJbHwIDqgAf5WwU1QL1VcON
        CBvpWn6rZqSYbjOpzOhLTqe/WdxsAHFZu5BDsjXdgpJe7olGlPm1JCG4qPGpzm4wJDqH7/6l0Cl9P
        Y9ZWjmE+w==;
Received: from [2601:1c0:6280:3f0::34d9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1im6sa-000714-DF; Tue, 31 Dec 2019 02:03:28 +0000
Subject: Re: Why is CONFIG_VT forced on?
To:     Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
 <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
 <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8059d1c4-759d-9911-73c7-211f8576e7f2@infradead.org>
Date:   Mon, 30 Dec 2019 18:03:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/19 6:04 PM, Rob Landley wrote:
> 
> 
> On 12/30/19 7:45 PM, Rob Landley wrote:
>> On 12/30/19 6:59 PM, Randy Dunlap wrote:
>>> #
>>> # Character devices
>>> #
>>> CONFIG_TTY=y
>>> # CONFIG_VT is not set
>>>
>>> But first you must set/enable EXPERT.  See the bool prompt.
>>
>> Wait, the if doesn't _disable_ the symbol? It disables _editability_ of the
>> symbol, but the symbol can still be on (and displayed) when the if is false?
>> (Why would...)
>>
>> Ok. Thanks for pointing that out. Any idea why the menuconfig help text has no
>> mention of this?
> 
> So if I disable CONFIG_EXPERT, using miniconfig I then need to manually switch on:
> 
> ./init/Kconfig:	bool "Namespaces support" if EXPERT
> ./init/Kconfig:	bool "Multiple users, groups and capabilities support" if EXPERT
> ./init/Kconfig:	bool "Sysfs syscall support" if EXPERT
> ./init/Kconfig:	bool "open by fhandle syscalls" if EXPERT
> ./init/Kconfig:	bool "Posix Clocks & timers" if EXPERT
> ./init/Kconfig:	bool "Enable support for printk" if EXPERT
> ./init/Kconfig:	bool "BUG() support" if EXPERT
> ./init/Kconfig:	bool "Enable ELF core dumps" if EXPERT
> ./init/Kconfig:	bool "Enable full-sized data structures for core" if EXPERT
> ./init/Kconfig:	bool "Enable futex support" if EXPERT
> ./init/Kconfig:	bool "Enable eventpoll support" if EXPERT
> ./init/Kconfig:	bool "Enable signalfd() system call" if EXPERT
> ./init/Kconfig:	bool "Enable timerfd() system call" if EXPERT
> ./init/Kconfig:	bool "Enable eventfd() system call" if EXPERT
> ./init/Kconfig:	bool "Use full shmem filesystem" if EXPERT
> ./init/Kconfig:	bool "Enable AIO support" if EXPERT
> ./init/Kconfig:	bool "Enable IO uring support" if EXPERT
> ./init/Kconfig:	bool "Enable madvise/fadvise syscalls" if EXPERT
> ./init/Kconfig:	bool "Enable membarrier() system call" if EXPERT
> ./init/Kconfig:	bool "Load all symbols for debugging/ksymoops" if EXPERT
> ./init/Kconfig:	bool "Enable rseq() system call" if EXPERT
> ./init/Kconfig:	bool "Enabled debugging of rseq() system call" if EXPERT
> ./init/Kconfig:	bool "PC/104 support" if EXPERT
> ./init/Kconfig:	bool "Enable VM event counters for /proc/vmstat" if EXPERT
> 
> plus of course
> 
> ./arch/x86/Kconfig.cpu:	bool "Supported processor vendors" if EXPERT
> ./arch/x86/Kconfig:	bool "DMA memory allocation support" if EXPERT
> ./arch/x86/Kconfig:	bool "Enable DMI scanning" if EXPERT
> ./arch/x86/Kconfig:	bool "Enable support for 16-bit segments" if EXPERT
> ./arch/x86/Kconfig:       bool "Enable vsyscall emulation" if EXPERT
> ./arch/x86/Kconfig:	bool "Enable the LDT (local descriptor table)" if EXPERT
> ./arch/x86/Kconfig:	bool "Read CNB20LE Host Bridge Windows" if EXPERT
> ./arch/x86/Kconfig:	bool "ISA bus support on modern systems" if EXPERT
> ./arch/x86/Kconfig:	bool "ISA-style DMA support" if (X86_64 && EXPERT)
> 
> So nobody noticed you have a structural "this config option actually switches
> this thing _off_" implemented via magic symbol then?

I guess nobody had a problem with it for the last 10 or 15 or 20 years.

> I think the right fix here involves running sed after kconfig does its thing...

I doubt that would work, but if it does, go for it.

-- 
~Randy

