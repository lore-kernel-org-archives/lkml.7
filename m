Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A356A206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574355207;
	bh=5YQuUwvEV2IjtXDfviE9LBz+gl36AhsvVGC/cp0ZkzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R5RpRlnfmmVeMrQFdO8uqnaQDKaQKkuSsixgifhT0Az1JstI6CYkuC0tEybpbbUpQ
	 wgOKq7mtpuHbYb4CQGLhMxoktrQhp4ci9Y8us/+776v2Wle5eZNS/35x/qdw7wNAmD
	 MBHWhr+qXllawavyKVLUMPr4Pwi6FHYyPfoNqUzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKUQx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfKUQx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:53:26 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C23D20658;
        Thu, 21 Nov 2019 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574355205;
        bh=5YQuUwvEV2IjtXDfviE9LBz+gl36AhsvVGC/cp0ZkzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3nL1rnjcXHeGPctFIRc3nSHhABiswV6ac9RGZVn/UNm1AOpY6LIZnDg2U1J1prJu
         I+cde0oOfokij3KMhkufEFAuERnPszuDK7u/VwWD7h7vldmmfXxzMjv0tJR0VTmlEh
         BpORUA+nvZGkwr4Zr3Wemq438BPg9xPD6+r12+uM=
Date:   Thu, 21 Nov 2019 16:53:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] export.h: reduce __ksymtab_strings string duplication by
 using "MS" section flags
Message-ID: <20191121165320.GA4905@willie-the-truck>
References: <20191120145110.8397-1-jeyu@kernel.org>
 <93d3936d-0bc4-9639-7544-42a324f01ac1@rasmusvillemoes.dk>
 <20191121160919.GB22213@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121160919.GB22213@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On Thu, Nov 21, 2019 at 05:09:20PM +0100, Jessica Yu wrote:
> +++ Rasmus Villemoes [21/11/19 11:51 +0100]:
> > On 20/11/2019 15.51, Jessica Yu wrote:
> > >  /*
> > > - * note on .section use: @progbits vs %progbits nastiness doesn't matter,
> > > - * since we immediately emit into those sections anyway.
> > > + * note on .section use: we specify @progbits vs %progbits since usage of
> > > + * "M" (SHF_MERGE) section flag requires it.
> > >   */
> > > +
> > > +#ifdef CONFIG_ARM
> > > +#define ARCH_PROGBITS %progbits
> > > +#else
> > > +#define ARCH_PROGBITS @progbits
> > > +#endif
> > 
> > Did you figure out a way to determine if ARM is the only odd one? I was
> > just going by gas' documentation which mentions ARM as an example, but
> > doesn't really provide a way to know what each arch uses. I suppose 0day
> > will tell us shortly.
> 
> I *think* so. At least, I was going off of
> drivers/base/firmware_loader/builtin/Makefile and
> scripts/recordmcount.pl, which were the only other places that I found
> that reference the %progbits vs @progbits oddity. They only use
> %progbits in the case of CONFIG_ARM and @progbits for other
> arches. I wasn't sure about arm64, but I looked at the assembly files
> gcc produced and it looked like @progbits was used there. Added some
> arm64 people to CC since they would know :-)

The '@' character is a comment delimiter for 32-bit ARM assembly, so that's
why you end up having to use a different character there. This isn't the
case for arm64, where you need to use standard C/C++ comment delimiters
instead and so '@progbits' should work correctly.

Hope that helps,

Will
