Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C74C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76B72081C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562749974;
	bh=rS1FXWun4tnZthZjP5gvCnsRMWjJHRs43/TtJSmyduM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h/eeh4f2z/lS3Hc+Npizgg/sD/JkZkOorQ6QtaQgYOvNFjripMv3ZL0/0uLhIQeCY
	 j+VRKbrlpRU+8Nz9M+gDWMY/7VLd98b+PUpuJmAy9BskP0fECACU+GQbLf0NjAYA1D
	 NP8zD+s0DUkaedudtzbtlZ+JkvswSCfhmvdGszCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfGJJMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfGJJMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:12:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830AE20665;
        Wed, 10 Jul 2019 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562749972;
        bh=rS1FXWun4tnZthZjP5gvCnsRMWjJHRs43/TtJSmyduM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1z2JsBfvr21gQUt5iPDz7NT2dAXcWemQ9w/74bx4HfLPPC6I7yVg06g5XX0Wfju1i
         A7YbWtlN91d+sVk5jnXkMYO7rltvml6cCoFWpUmywj+Czo+7nwKBl+DzPN77JGNAsg
         PKclIs28Fbusl8l9KEjTRFoEXRXj2I6/SdInl9L4=
Date:   Wed, 10 Jul 2019 10:12:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
Message-ID: <20190710091245.zztm6cpbix4objlq@willie-the-truck>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
 <20190710082750.mvm3e6myzpqsurga@willie-the-truck>
 <alpine.DEB.2.21.1907101057190.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907101057190.1758@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 10:58:25AM +0200, Thomas Gleixner wrote:
> On Wed, 10 Jul 2019, Will Deacon wrote:
> > On Tue, Jul 09, 2019 at 09:02:54PM -0700, John Stultz wrote:
> > > I tried to bisect things down a bit, but as some later fixes are
> > > required (at one point, date was returning the start epoch and never
> > > increasing), this hasn't worked too well. But I'm guessing since I
> > > see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
> > > not be built", and the system is half working, I'm guessing this is an
> > > issue with just the 32bit code failing.  While I can try to sort out
> > > the proper CROSS_COMPILE_COMPAT in my build environment, I assume
> > > userland shouldn't be crashing if that value isn't set.
> > > 
> > > Any chance this issue has already been raised?
> > 
> > First I've seen of it, although Vincenzo is likely to know better than me.
> > In the meantime, please can you share your .config?
> 
> I think the key is: CROSS_COMPILE_COMPAT not defined or empty. And then run
> 32bit userspace.

The part I was wondering about is whether the vectors page has been disabled
at the same time, since I'm fairly sure I've already been running with the
above (but I can easily double-check).

Will
