Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABD7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D44E206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfCFSXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:23:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51539 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfCFSXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:23:06 -0500
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1bC3-0002Ay-Gj; Wed, 06 Mar 2019 19:23:03 +0100
Date:   Wed, 6 Mar 2019 19:23:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        tipbuild@zytor.com, kbuild test robot <lkp@intel.com>
Subject: Re: [tip:x86/asm 2/4] arch/x86/include/asm/special_insns.h:31:9:
 error: 'X86_CR0_WP' undeclared
In-Reply-To: <CAGXu5jKiW9-pnKbRh05_SmYm8TwjoRpsrA8472+Gct_YjVr+Jw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903061922320.1646@nanos.tec.linutronix.de>
References: <201903061919.b2BJj7iX%fengguang.wu@intel.com> <CAGXu5jKiW9-pnKbRh05_SmYm8TwjoRpsrA8472+Gct_YjVr+Jw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019, Kees Cook wrote:

> On Wed, Mar 6, 2019 at 3:43 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
> > head:   a0bf7fc24303a538396aa8d32450d05c1929b9f0
> > commit: d309ba034fac1a149d00cac79318973e9ba81848 [2/4] x86/asm: Pin sensitive CR0 bits
> > config: um-x86_64_defconfig (attached as .config)
> > compiler: gcc-8 (Debian 8.3.0-2) 8.3.0
> > reproduce:
> >         git checkout d309ba034fac1a149d00cac79318973e9ba81848
> >         # save the attached .config to linux build tree
> >         make ARCH=um SUBARCH=x86_64
> 
> Gah, I did not build-test um. :(
> 
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from arch/x86/include/asm/cacheflush.h:7,
> >                     from include/linux/highmem.h:12,
> >                     from net//core/sock.c:117:
> >    arch/x86/include/asm/special_insns.h: In function 'native_write_cr0':
> > >> arch/x86/include/asm/special_insns.h:31:9: error: 'X86_CR0_WP' undeclared (first use in this function)
> >      val |= X86_CR0_WP;
> >             ^~~~~~~~~~
> 
> Should I just add something like:
> 
> #ifdef __arch_um__
> # define X86_CR0_WP 0
> #endif

Fixed it up by including the proper header file.

Thanks,

	tglx
