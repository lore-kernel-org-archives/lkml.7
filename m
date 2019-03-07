Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D09CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072B32064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCGRnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:43:20 -0500
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:59589 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbfCGRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:43:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 01D92180A8437;
        Thu,  7 Mar 2019 17:43:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feet26_564532aeeac24
X-Filterd-Recvd-Size: 2626
Received: from XPS-9350 (unknown [172.56.44.251])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Mar 2019 17:43:12 +0000 (UTC)
Message-ID: <1ad70fe88b2d22b2064c4ada53d3fb0bdacf6b66.camel@perches.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
From:   Joe Perches <joe@perches.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Mar 2019 09:42:40 -0800
In-Reply-To: <20190307172541.2262ccaxjk43twi4@shell.armlinux.org.uk>
References: <20190307091514.2489338-1-arnd@arndb.de>
         <b83ed0ab05b12484a70d5f3db742a7a141718a00.camel@perches.com>
         <20190307172541.2262ccaxjk43twi4@shell.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 17:25 +0000, Russell King - ARM Linux admin wrote:
> On Thu, Mar 07, 2019 at 09:19:04AM -0800, Joe Perches wrote:
> > On Thu, 2019-03-07 at 10:14 +0100, Arnd Bergmann wrote:
> > > On 32-bit ARM, I got a link failure in futex_init() when building
> > > with clang in some random configurations:
> > > 
> > > kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> > > 
> > > As far as I can tell, the problem is that a branch is over 16MB
> > > apart in those configurations, but only if it branches back to
> > > the init text.
> > > 
> > > Marking the futex_detect_cmpxchg() function as noinline and
> > > not __init avoids the problem for me.
> > 
> > Perhaps the __init and __exit #defines should be noinline
> > to allow discarding of the code.
> 
> How does that help this case?

It doesn't particularly.
It does help any other case that might arise.

> It seems to me to be completely sane to have:
> 
> static void __init foo(...)
> {
> }
> 
> static int __init foo_init(...)
> {
> 	foo();
> }
> 
> and have the expectation that the compiler _can_, if it desires, inline
> foo() into foo_init().

True, but init function performance requirements are
generally trivial and isolating the possibility of
defects like this seems a reasonable trade-off to me.


