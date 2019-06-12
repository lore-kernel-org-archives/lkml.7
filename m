Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0551EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C7521743
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560354086;
	bh=h2OJWaA1zJZ3xhFkbg+nebkUURxadPut5gZ6ubpsrzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tVHqBDAeUK2A4ElEFrm6/HqjrZQlbgtrzlBo92cjePxZ3jspihT7d+9wY/tcvXMCc
	 IRHb9WqmdjcpvBB9ZMYzJ1OCzVex74QtarVxvSJk7zgpGWOd4/Yg6WJcxCGJeQLt69
	 cQPboLc4ghKzQRNYbRzwxyA0nmnF72dGxACMzd/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440111AbfFLPl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfFLPlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:41:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC2C215EA;
        Wed, 12 Jun 2019 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560354085;
        bh=h2OJWaA1zJZ3xhFkbg+nebkUURxadPut5gZ6ubpsrzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ux2w4Sq2rQnliDWIbYwJ8C4CqnokTaTMPwJKnhHrzumTyU6O10li3kXp39EUOmFOC
         Pz6XHmpUPh66P3xaB//ZWjkYimxpJ0Rk2Gzo9WBVbA27r724mIIQcMJI7aEFqroaLI
         MkXuE+/LfOWDCVYCtegau8SS8UEVnxwxj4giX0H0=
Date:   Wed, 12 Jun 2019 17:41:22 +0200
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
Message-ID: <20190612154122.GB21828@kroah.com>
References: <20190612151531.GA16278@kroah.com>
 <20190612151856.GK32652@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612151856.GK32652@zn.tnic>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 05:18:56PM +0200, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 05:15:31PM +0200, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: <x86@kernel.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Pu Wen <puwen@hygon.cn>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/x86/kernel/cpu/mce/core.c     | 16 +++++---------
> >  arch/x86/kernel/cpu/mce/inject.c   | 34 +++++-------------------------
> >  arch/x86/kernel/cpu/mce/severity.c | 14 +++---------
> >  3 files changed, 13 insertions(+), 51 deletions(-)
> 
> I think I'm having a deja-vu:
> 
> https://lkml.kernel.org/r/20190122215326.GM26587@zn.tnic

Ah, I thought I had sent this out before...

Anyway, I'll fix this up, but really, you will not have a debugfs file
fail creation unless the system is totally out of memory...

thanks,

greg k-h
