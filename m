Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8635EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C8B217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560357865;
	bh=+3cWtpgBJG5SbFUJBAK87w4SkBcN0QERolbEi4yfwfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FaYGAaUy/7ld5GTnIoR6f6F4Qo0mozItEikA5FZD2wwhyYFQLAQoCPBoDaoEtLrxF
	 uNb4pAn39hBHSuOUNKwRbu1GZYmOkTcHs9Civ7TaPaGOz55ljfmvrWp8VnEqgSiWqe
	 hODSWOz/7y5JXgohyHWOsPjYfJbKoa2S3m5lLOi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438188AbfFLQoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404956AbfFLQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:44:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E33E208C2;
        Wed, 12 Jun 2019 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560357862;
        bh=+3cWtpgBJG5SbFUJBAK87w4SkBcN0QERolbEi4yfwfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Boa2bcWBDYBLXQw9JPJSY/IucF2zCSPshGzx5nCOfVGaWwqvwGj1TalY6OPh8Ib5j
         lmv5bXjVrHC9DeALrOp9n9tBtkjecbmcG+nldi5GRNWFaH3WrY6yJrixwkBxxl9aWl
         US2JxmJ/FkwxtllBeDhxE8Ex9+xcMCVe6ot9UC9w=
Date:   Wed, 12 Jun 2019 18:44:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pu Wen <puwen@hygon.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: mce: no need to check return value of
 debugfs_create functions
Message-ID: <20190612164420.GB27064@kroah.com>
References: <20190612151531.GA16278@kroah.com>
 <20190612151856.GK32652@zn.tnic>
 <20190612154122.GB21828@kroah.com>
 <20190612154730.GM32652@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612154730.GM32652@zn.tnic>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 05:47:30PM +0200, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 05:41:22PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 12, 2019 at 05:18:56PM +0200, Borislav Petkov wrote:
> > > On Wed, Jun 12, 2019 at 05:15:31PM +0200, Greg Kroah-Hartman wrote:
> > > > When calling debugfs functions, there is no need to ever check the
> > > > return value.  The function can work or not, but the code logic should
> > > > never do something different based on this.
> > > > 
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Cc: <x86@kernel.org>
> > > > Cc: Tony Luck <tony.luck@intel.com>
> > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > Cc: Pu Wen <puwen@hygon.cn>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  arch/x86/kernel/cpu/mce/core.c     | 16 +++++---------
> > > >  arch/x86/kernel/cpu/mce/inject.c   | 34 +++++-------------------------
> > > >  arch/x86/kernel/cpu/mce/severity.c | 14 +++---------
> > > >  3 files changed, 13 insertions(+), 51 deletions(-)
> > > 
> > > I think I'm having a deja-vu:
> > > 
> > > https://lkml.kernel.org/r/20190122215326.GM26587@zn.tnic
> > 
> > Ah, I thought I had sent this out before...
> > 
> > Anyway, I'll fix this up, but really, you will not have a debugfs file
> > fail creation unless the system is totally out of memory...
> 
> Promise? :-P

Yes, the only way this can fail is if:
	debugfs superblock can not be pinned - something really went wrong with the vfs layer
	file is created with same name - the caller's fault
	new_inode() fails - happens if memory is exhausted

So yes, I do promise :)

> I mean, I don't mind getting rid of all that error handling getting in
> the way of the code but we'll leave the injector in a half-init state if
> the allocation fails.

That's fine, your system is hosed then.

> I guess I can take this and see what breaks. If it does, we can always
> revert it...

Yup!

> Btw, is your aim to make debugfs_create_file() return void or you're
> just doing some cleanups?

Yes, that is my long-term goal here.  I don't think it will be possible
as there are some valid users that only want a single file and then
remove the file later, but I'll deal with that when I'm done sweeping
the tree.  I'm already able to start removing the return value for many
of the other debugfs "helper file" creation functions.

thanks,

greg k-h
