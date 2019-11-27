Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149632068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK0QDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:03:49 -0500
Received: from foss.arm.com ([217.140.110.172]:49506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0QDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:03:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1388630E;
        Wed, 27 Nov 2019 08:03:48 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50F533F68E;
        Wed, 27 Nov 2019 08:03:45 -0800 (PST)
Date:   Wed, 27 Nov 2019 16:03:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 3/3] arm64: remove the rest of asm-uaccess.h
Message-ID: <20191127160342.GF51937@lakrids.cambridge.arm.com>
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
 <20191122022406.590141-4-pasha.tatashin@soleen.com>
 <20191127151154.GC51937@lakrids.cambridge.arm.com>
 <CA+CK2bDDom_pwLC-ABwDw66ynyELH3f3NdjUEdhr1LYLkgWJvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDDom_pwLC-ABwDw66ynyELH3f3NdjUEdhr1LYLkgWJvg@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:31:54AM -0500, Pavel Tatashin wrote:
> On Wed, Nov 27, 2019 at 10:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 09:24:06PM -0500, Pavel Tatashin wrote:
> > > The __uaccess_ttbr0_disable and __uaccess_ttbr0_enable,
> > > are the last two macros defined in asm-uaccess.h.
> > >
> > > Replace them with C wrappers and call C functions from
> > > kernel_entry and kernel_exit.
> >
> > For now, please leave those as-is.
> >
> > I don't think we want to have out-of-line C wrappers in the middle of
> > the entry assembly where we don't have a complete kernel environment.
> > The use in entry code can also assume non-preemptibility, while the C
> > functions have to explcitily disable that.
> 
> I do not understand, if C function is called form non-preemptible
> context it stays non-preemptible. kernel_exit already may call C
> functions around the time __uaccess_ttbr0_enable is called (it may
> call post_ttbr_update_workaround), and that C functions does not do
> explicit preempt disable:

Sorry, I meant that IRQs are disabled here.

The C wrapper calls __uaccess_ttbr0_enable(), which calls
local_irq_save() and local_irq_restore(). Those are pointless in the
bowels of the entry code, and potentially expensive if IRQ prio masking
is in use.

I'd rather not add more out-of-line C code calls here right now as I'd
prefer to factor out the logic to C in a better way.

> > We can certainly remove the includes of <asm/asm-uaccess.h> elsewhere,
> > and maybe fold the macros into entry.S if it's not too crowded.
> 
> I can do this as a separate patch.

That sounds fine to me,

Thanks,
Mark.
