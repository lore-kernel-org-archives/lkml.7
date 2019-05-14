Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7104C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7931720818
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="quCBsaRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfENLig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:38:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZTjgx36Z1sAOaZ+WMax6rmZv5qT5zZj09GnF3pYNpJY=; b=quCBsaRMfLmD0jpUnBZ3fbNAO
        i6VIsCxwoT7eNSMBrAFRrB2xyz/sqMfzw9piEusox7i8zJzDAjA53eEgA0kkHtURvABIwTg2m65i+
        5qjo0k4x0GC476NouRGI0K6OV63bxJJmk9Bp+2fYEHI0UbIKv20nIpbNIXYCvzkP2CBqrP4CCvrXw
        Y1cSXuqs+6m4S9xEO5IrykeitFOOJXDGA41bTi2JVKIlZ9E78f38r0xPNyOt+VEaYdWejyqAku62p
        By5atMTWYXuelsox4/o8BE2i/V64Rv88FUbYAOGZR84BRiXiFZ8u6NzbJ1omxIHUgWuC8a/44YlzL
        5lNJVl0GQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQVlL-0000NI-U4; Tue, 14 May 2019 11:38:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D1DA2029F877; Tue, 14 May 2019 13:38:26 +0200 (CEST)
Date:   Tue, 14 May 2019 13:38:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        j-nomura@ce.jp.nec.com, kasong@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190514113826.GM2589@hirez.programming.kicks-ass.net>
References: <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 04:48:41PM +0800, Dave Young wrote:

> > I did some tests on the laptop,  thing is:
> > 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
> >    on latest Linus master branch, everything works fine.
> > 
> > 2. build and test the tip/next-merge-window branch, kernel hangs early
> > without output, (both 1st boot and kexec boot)
> 
> Update about 2.  It should be not early rsdp related, I got the boot log
> Since can not reproduce with Linus master branch it may have been fixed.

Nothing was changed here since PTI.

> [    0.685374][    T1] rcu: Hierarchical SRCU implementation.
> [    0.686414][    T1] general protection fault: 0000 [#1] SMP PTI
> [    0.687328][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc6+ #877
> [    0.687328][    T1] Hardware name: LENOVO 4236NUC/4236NUC, BIOS 83ET82WW (1.52 ) 06/04/2018
> [    0.687328][    T1] RIP: 0010:reserve_ds_buffers+0x34e/0x450

> [    0.687328][    T1] Call Trace:
> [    0.687328][    T1]  ? hardlockup_detector_event_create+0x50/0x50
> [    0.687328][    T1]  x86_reserve_hardware+0x173/0x180
> [    0.687328][    T1]  x86_pmu_event_init+0x39/0x220

The DS buffers are special in that they're part of cpu_entrt_area. If
this comes apart it might mean your pagetables are dodgy.
