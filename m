Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9990C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF500206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLaCk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 21:40:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55612 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfLaCk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 21:40:58 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1im7So-0001le-HG; Tue, 31 Dec 2019 02:40:54 +0000
Date:   Tue, 31 Dec 2019 02:40:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rob Landley <rob@landley.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is CONFIG_VT forced on?
Message-ID: <20191231024054.GC4203@ZenIV.linux.org.uk>
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
 <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
 <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 08:04:35PM -0600, Rob Landley wrote:
> 
> 
> On 12/30/19 7:45 PM, Rob Landley wrote:
> > On 12/30/19 6:59 PM, Randy Dunlap wrote:
> >> #
> >> # Character devices
> >> #
> >> CONFIG_TTY=y
> >> # CONFIG_VT is not set
> >>
> >> But first you must set/enable EXPERT.  See the bool prompt.
> > 
> > Wait, the if doesn't _disable_ the symbol? It disables _editability_ of the
> > symbol, but the symbol can still be on (and displayed) when the if is false?
> > (Why would...)
> > 
> > Ok. Thanks for pointing that out. Any idea why the menuconfig help text has no
> > mention of this?
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

No.  What you need is
	* actually attempt to flip CONFIG_EXPERT (go to "General setup" submenu and
set "Configure standard kernel features (expert users)" there)
	* check the resulting .config (or look at the items in question via
menuconfig)
	* get enlightened

Rob, if you are in a mood for a long wank, it's your business.  But try to avoid
spraying the results over public lists.
