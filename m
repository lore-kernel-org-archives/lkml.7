Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB50C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB8A22387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563985000;
	bh=a24TsQt9JYma1IzUe2EluXMiNaz5l9qhJR7tK9JqkyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U3Vg+olrXVvglq0NvlFAM1Uysp06Lf5h3QkLMfHjwh2GbKTODs0Lrvk6PQrh28D7R
	 Nz3Kvppoj1wDRiew0U7OLcOfe68q5eQGDJlC3d0/XJ20x18q6GQj8DkQ8ds12w/X7V
	 1Ud34RvvqEv9v697KHj6kL4Dx7Jc5+szOUZjNED0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfGXQQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbfGXQQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:16:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C016921841;
        Wed, 24 Jul 2019 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563984996;
        bh=a24TsQt9JYma1IzUe2EluXMiNaz5l9qhJR7tK9JqkyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajdUxVrlg8zUkV1c0GL7ldAD9peSRe8hChjlirVOBa7Elqm0xgGGfZbUPM/P9x6hF
         X/JZuzdJyeylxOF0stS2H2BfDWcboECtPBnLmxJE0KCmMU5ZYCWPP+FIIH1gIZH64N
         OTf7LkHOvGkbUYP/y9dLa1TIrF/IgQ7ZTpIIms3A=
Date:   Wed, 24 Jul 2019 18:16:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Message-ID: <20190724161634.GB10454@kroah.com>
References: <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
 <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com>
 <20190723130513.GA25290@kroah.com>
 <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com>
 <20190724153416.GA27117@kroah.com>
 <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
 <20190724155735.GC5571@kroah.com>
 <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 06:03:41PM +0200, Thomas Gleixner wrote:
> On Wed, 24 Jul 2019, Greg KH wrote:
> > On Wed, Jul 24, 2019 at 05:49:45PM +0200, Thomas Gleixner wrote:
> > > > Ok, I dug around and the gold linker is not being used here, only clang
> > > > to build the source and GNU ld to link, and I am still seeing this
> > > > error.
> > > 
> > > Odd combo.
> > 
> > I'm not disagreeing :)
> > 
> > Wait, does clang link things itself and not need ld?
> 
> Nah.
> 
> > > > Hm, clang 8 does not cause this error, but clang 9 does.  Let me go poke
> > > > the people who are providing this version of clang to see if there's
> > > > something they can figure out.
> > > 
> > > Let me try that with my clang variant. Which version of GNU ld are you
> > > using?
> > 
> > I think it is 2.27:
> > $ ./ld --version
> > GNU ld (binutils-2.27-44492f8) 2.27.0.20170315
> > 
> > Which does feel old to me.
> > 
> > I know 2.32 works fine.
> 
> 2.31 works fine as well.
> 
> > Gotta love old tool-chains :(
> 
> Oh yes. /me does archaeology to find a VM with old stuff

I can provide a binary if you can't find anything.

thanks,

greg k-h
