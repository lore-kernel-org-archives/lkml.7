Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D855ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52D9206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfJKQ0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:26:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:42200 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfJKQ0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:26:52 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9BGPsfd001460;
        Fri, 11 Oct 2019 11:25:54 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x9BGPqOV001459;
        Fri, 11 Oct 2019 11:25:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 11 Oct 2019 11:25:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-parisc@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org
Subject: Re: [PATCH v2 01/29] powerpc: Rename "notes" PT_NOTE to "note"
Message-ID: <20191011162552.GK9749@gate.crashing.org>
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-2-keescook@chromium.org> <20191011082519.GI9749@gate.crashing.org> <201910110910.48270FC97@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910110910.48270FC97@keescook>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:11:43AM -0700, Kees Cook wrote:
> On Fri, Oct 11, 2019 at 03:25:19AM -0500, Segher Boessenkool wrote:
> > On Thu, Oct 10, 2019 at 05:05:41PM -0700, Kees Cook wrote:
> > > The Program Header identifiers are internal to the linker scripts. In
> > > preparation for moving the NOTES segment declaration into RO_DATA,
> > > standardize the identifier for the PT_NOTE entry to "note" as used by
> > > all other architectures that emit PT_NOTE.
> > 
> > All other archs are wrong, and "notes" is a much better name.  This
> > segment does not contain a single "note", but multiple "notes".
> 
> True, but the naming appears to be based off the Program Header name of
> "PT_NOTE".

Ah, so that's why the kernel segment (which isn't text btw, it's rwx) is
called "load" :-P

(Not convinced.  Some arch just got it wrong, and many others blindly
copied it?  That sounds a lot more likely imo.)

> Regardless, it is an entirely internal-to-the-linker-script
> identifier, so I am just consolidating on a common name with the least
> number of collateral changes.

Yes, that's what I'm complaining about.

Names *matter*, internal names doubly so.  So why replace a good name with
a worse name?  Because it is slightly less work for you?


Segher

p.s. Thanks for doing this, removing the powerpc workaround etc. :-)
