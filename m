Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CFDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B707B21743
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BjIrGdvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440133AbfFLPrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:47:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42260 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437713AbfFLPrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:47:39 -0400
Received: from zn.tnic (p200300EC2F0A6800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFAB91EC09C0;
        Wed, 12 Jun 2019 17:47:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560354457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AmCfLyR4W8uwN4jCphyC/roQx44k2jx2XkPRIsRNW7A=;
        b=BjIrGdvxNgr+CgSRlZNaf2lFfNhgWb3xvyJEpysjY6QRB/puv0oWUxLJz/C+dNsSoYThQV
        S7FGJWGce8cM/PACHzg3YTauN3mkxONFjIHcqxBCXSwwwbD2KlUhVojmDmmqNg4e9cpMif
        GmcI2LDtLCxL+iHqUhRHh8rbXXMfBdw=
Date:   Wed, 12 Jun 2019 17:47:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pu Wen <puwen@hygon.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: mce: no need to check return value of
 debugfs_create functions
Message-ID: <20190612154730.GM32652@zn.tnic>
References: <20190612151531.GA16278@kroah.com>
 <20190612151856.GK32652@zn.tnic>
 <20190612154122.GB21828@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612154122.GB21828@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 05:41:22PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 12, 2019 at 05:18:56PM +0200, Borislav Petkov wrote:
> > On Wed, Jun 12, 2019 at 05:15:31PM +0200, Greg Kroah-Hartman wrote:
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > > 
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: <x86@kernel.org>
> > > Cc: Tony Luck <tony.luck@intel.com>
> > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > Cc: Pu Wen <puwen@hygon.cn>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  arch/x86/kernel/cpu/mce/core.c     | 16 +++++---------
> > >  arch/x86/kernel/cpu/mce/inject.c   | 34 +++++-------------------------
> > >  arch/x86/kernel/cpu/mce/severity.c | 14 +++---------
> > >  3 files changed, 13 insertions(+), 51 deletions(-)
> > 
> > I think I'm having a deja-vu:
> > 
> > https://lkml.kernel.org/r/20190122215326.GM26587@zn.tnic
> 
> Ah, I thought I had sent this out before...
> 
> Anyway, I'll fix this up, but really, you will not have a debugfs file
> fail creation unless the system is totally out of memory...

Promise? :-P

I mean, I don't mind getting rid of all that error handling getting in
the way of the code but we'll leave the injector in a half-init state if
the allocation fails.

I guess I can take this and see what breaks. If it does, we can always
revert it...

Btw, is your aim to make debugfs_create_file() return void or you're
just doing some cleanups?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
