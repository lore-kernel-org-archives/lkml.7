Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF9EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B03D2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfJAOeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:34:07 -0400
Received: from foss.arm.com ([217.140.110.172]:51036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbfJAOeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:34:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD9A1000;
        Tue,  1 Oct 2019 07:34:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63D533F71A;
        Tue,  1 Oct 2019 07:34:04 -0700 (PDT)
Date:   Tue, 1 Oct 2019 15:33:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Denis Efremov <efremov@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [Xen-devel] [PATCH] ARM: xen: unexport HYPERVISOR_platform_op
 function
Message-ID: <20191001143334.GA46651@lakrids.cambridge.arm.com>
References: <20190906153948.2160342-1-arnd@arndb.de>
 <7abad95e-ea47-c068-d91c-ba503f2530b9@citrix.com>
 <CAK8P3a1qkMLW_Wnn-N0seUw4N5bPwTU7Dy7CwOWxzS6NTnTmiQ@mail.gmail.com>
 <bda2a05b-e2d0-feee-761b-88deeeac2449@citrix.com>
 <95dbd972-fe78-d0ca-f7b4-1a6bdd418eab@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95dbd972-fe78-d0ca-f7b4-1a6bdd418eab@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On Sat, Sep 07, 2019 at 11:05:45AM +0100, Julien Grall wrote:
> On 9/6/19 6:20 PM, Andrew Cooper wrote:
> > On 06/09/2019 17:00, Arnd Bergmann wrote:
> > > On Fri, Sep 6, 2019 at 5:55 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > > > On 06/09/2019 16:39, Arnd Bergmann wrote:
> > > > > HYPERVISOR_platform_op() is an inline function and should not
> > > > > be exported. Since commit 15bfc2348d54 ("modpost: check for
> > > > > static EXPORT_SYMBOL* functions"), this causes a warning:
> > > > > 
> > > > > WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL
> > > > > 
> > > > > Remove the extraneous export.
> > > > > 
> > > > > Fixes: 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions")
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > Something is wonky.  That symbol is (/ really ought to be) in the
> > > > hypercall page and most definitely not inline.
> > > > 
> > > > Which tree is that changeset from?  I can't find the SHA.
> > > This is from linux-next, I think from the kbuild tree.
> > 
> > Thanks.
> > 
> > Julien/Stefano: Why are any of these hypercalls out-of-line?  ARM
> > doesn't use the hypercall page, and there is no argument translation
> > (not even in arm32 as there are no 5-argument hypercalls declared).
> 
> I am not sure how the hypercall page makes things different. You still have
> to store the arguments in the correct register so...
> 
> > 
> > They'd surely be easier to implement with a few static inlines and some
> > common code, than to try and replicate the x86 side hypercall_page
> > interface ?
> 
> ... I don't think they will be easier to implement with a few static
> inlines. The implementation will likely end up to be similar to
> arch/x86/asm/xen/hypercall.h.
> 
> Furthermore, one of the downside of per-arch static inline is it is more
> difficult to ensure the prototype match for all the architectures. Although,
> it might be possible to make them common by only requesting per-arch to
> implement HYPERCALL_N(...).
> 
> So I think the code is better as it is.
> 
> While looking at the code, I also realized that the implementation of
> HYPERCALL_dm_op might be incorrect for Arm32. Similarly do privcmd call, I
> think dm_op call should enable user access as they will be used by
> userspace.
> 
> We don't use dm_op on Arm so far, hence why I think this was unnoticed. I
> will see if I can reproduce it and send a patch.

I'm seeing this when building arm64 defconfig v5.4-rc1:

| [mark@lakrids:~/src/linux]% usekorg 8.1.0  make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j56 -s
| arch/arm64/Makefile:62: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
| WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL
| WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL

I couldn't see a follow-up; do you have a patch for this?

Thanks,
Mark.
