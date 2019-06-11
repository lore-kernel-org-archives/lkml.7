Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B24C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734A220657
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ndrS8CSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404851AbfFKJBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:01:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52150 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404175AbfFKJBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sV1vOAf/isE295kyIEtrRhzRyh3WToidRktoUAnwYT8=; b=ndrS8CSXGdFdSvmUTQUnRaROr
        vKgEXO1nX50zm216uYrs/ra8yY0PTeCyjdEnRMCGoMqSiMWHvbg/QHx87/LV1oipCOgwaEVVL7Yeq
        uGLK+uBiQ/4AN8oXjJxichvTtbSLm8s+bQ8qYfWvdGsUChXcfq4egkjAywQ6CCbl8jAIm9Bqwp2TI
        arIpucc2RXvt8L8zil7l7mJ3wFGvNX1WetOFYElsrOHTRTqvOvUH77IMPzpV1VLFxK7/mSZIT1qEy
        KZdof9PIc+cX6ymv0NnvmV6AsHHy3RicmOIVjo0Nxnw3sgS1q8gLlseThyGiUj1NyAdcz66/W+im2
        5Y/atgLLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hacf4-0003cY-PP; Tue, 11 Jun 2019 09:01:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8950B202173E3; Tue, 11 Jun 2019 11:01:45 +0200 (CEST)
Date:   Tue, 11 Jun 2019 11:01:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 0/5] x86/umwait: Enable user wait instructions
Message-ID: <20190611090145.GU3436@hirez.programming.kicks-ass.net>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 03:00:32PM -0700, Fenghua Yu wrote:
> Today, if an application needs to wait for a very short duration
> they have to have spinloops. Spinloops consume more power and continue
> to use execution resources that could hurt its thread siblings in a core
> with hyperthreads. New instructions umonitor, umwait and tpause allow
> a low power alternative waiting at the same time could improve the HT
> sibling perform while giving it any power headroom. These instructions
> can be used in both user space and kernel space.
> 
> A new MSR IA32_UMWAIT_CONTROL allows kernel to set a time limit in
> TSC-quanta that prevents user applications from waiting for a long time.
> This allows applications to yield the CPU and the user application
> should consider using other alternatives to wait.

I'm confused on the purpose of this control; what do we win by limiting
this time?

>  .../ABI/testing/sysfs-devices-system-cpu      |  21 ++
>  arch/x86/include/asm/cpufeatures.h            |   1 +
>  arch/x86/include/asm/msr-index.h              |   4 +
>  arch/x86/power/Makefile                       |   1 +
>  arch/x86/power/umwait.c                       | 182 ++++++++++++++++++

You seem to miss the arch/x86/lib/delay.c change to use this fancy new
stuff for udelay(). I'm thinking that's exactly what TPAUSE is good for.
