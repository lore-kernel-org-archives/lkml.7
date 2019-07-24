Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EFDC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59F4229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563983860;
	bh=WmChL+Yyy9MFTNkMH2DU83voQKBjFaMJYXMpkoWGQZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uxxTFDTaXLcXIXaKPVg2pPDV1s1w7ST/TmDcN4+Rs5qKQMz9CR293ALdUkFXSH5cg
	 SEosbY4YBhvyJDqWGn9K8MjDMxCyyKpQoyrcK6hSUhIhZBU++H9mEHwnMiWhzX0iu+
	 8ND/TTmZik6gAfC2ouarT4/4EzHFBRj3kf7I7cgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfGXP5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfGXP5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:57:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5C62083B;
        Wed, 24 Jul 2019 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563983858;
        bh=WmChL+Yyy9MFTNkMH2DU83voQKBjFaMJYXMpkoWGQZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYAOOvPlDrCRaetUlG5ur3qrKVKQ3OB91rXLMuAMkAZh/HBEECZKXOTUSMqkRM4fz
         71Kh3BFX7/C0fHjoGkxWGncYHPtLn2mkpey16PmoMeLMtTuUmqtsAGWtyEXEe1aEnD
         n0LnJbcRlTyppcxLVdwWgrOoYN+bb8WDthBISXgk=
Date:   Wed, 24 Jul 2019 17:57:35 +0200
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
Message-ID: <20190724155735.GC5571@kroah.com>
References: <alpine.DEB.2.21.1907151011590.1669@nanos.tec.linutronix.de>
 <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com>
 <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
 <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com>
 <20190723130513.GA25290@kroah.com>
 <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com>
 <20190724153416.GA27117@kroah.com>
 <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 05:49:45PM +0200, Thomas Gleixner wrote:
> On Wed, 24 Jul 2019, Greg KH wrote:
> > On Tue, Jul 23, 2019 at 03:44:54PM +0200, Greg KH wrote:
> > > Sorry, I saw that after writing that.  You are right, if the others
> > > don't object, that's fine with me.  I'll go poke the various build
> > > systems that are failing right now on 5.3-rc1 and try to get them fixed
> > > for this reason.
> > 
> > Ok, I dug around and the gold linker is not being used here, only clang
> > to build the source and GNU ld to link, and I am still seeing this
> > error.
> 
> Odd combo.

I'm not disagreeing :)

Wait, does clang link things itself and not need ld?

> > Hm, clang 8 does not cause this error, but clang 9 does.  Let me go poke
> > the people who are providing this version of clang to see if there's
> > something they can figure out.
> 
> Let me try that with my clang variant. Which version of GNU ld are you
> using?

I think it is 2.27:
$ ./ld --version
GNU ld (binutils-2.27-44492f8) 2.27.0.20170315

Which does feel old to me.

I know 2.32 works fine.

Gotta love old tool-chains :(

greg k-h
