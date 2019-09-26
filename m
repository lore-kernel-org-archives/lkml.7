Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC42AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBD6222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfIZPvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:51:53 -0400
Received: from foss.arm.com ([217.140.110.172]:53482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbfIZPvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:51:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCE1028;
        Thu, 26 Sep 2019 08:51:50 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA1793F534;
        Thu, 26 Sep 2019 08:51:49 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:51:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: Allow disabling of the compat vDSO
Message-ID: <20190926155147.GL9689@arrakis.emea.arm.com>
References: <20190925130926.50674-1-catalin.marinas@arm.com>
 <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com>
 <20190925170838.GK7042@arrakis.emea.arm.com>
 <a7e06b86-facd-21de-c47c-246d0da8d80d@arm.com>
 <20190926074717.GA26802@iMac.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926074717.GA26802@iMac.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 08:47:18AM +0100, Catalin Marinas wrote:
> On Thu, Sep 26, 2019 at 01:06:50AM +0100, Vincenzo Frascino wrote:
> > On 9/25/19 6:08 PM, Catalin Marinas wrote:
> > > On Wed, Sep 25, 2019 at 09:53:16AM -0700, Nick Desaulniers wrote:
> > >> On Wed, Sep 25, 2019 at 6:09 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >>> - clean up the headers includes; vDSO should not include kernel-only
> > >>>   headers that may even contain code patched at run-time
> > >>
> > >> This is a big one; Clang validates the inline asm constraints for
> > >> extended inline assembly, GCC does not for dead code.  So Clang chokes
> > >> on the inclusion of arm64 headers using extended inline assembly when
> > >> being compiled for arm-linux-gnueabi.
> > > 
> > > Whether clang or gcc, I'd like this fixed anyway. At some point we may
> > > inadvertently rely on some code which is patched at boot time for the
> > > kernel code but not for the vDSO.
> > 
> > Do we have any code of this kind in header files?
> > 
> > The vDSO library uses only a subset of the headers (mainly Macros) hence all the
> > unused symbols should be compiled out. Is your concern only theoretical or do
> > you have an example on where this could be happening?
> 
> At the moment it's rather theoretical.

Actually, it's not. The moment the compat vdso Makefile needs the line
below, we are doing it wrong:

VDSO_CFLAGS += -D__uint128_t='void*'

-- 
Catalin
