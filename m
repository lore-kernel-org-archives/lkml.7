Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0653C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7055520656
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556808156;
	bh=EkdJKz+g6QMmg2qk7qFnp9jFndU1X+NWw2khzkoIlPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sTOjaaYjiKsAEHyfrG+FR2BviLwRcCW67wMZjdGdyduvtyvNICIuPeca2hqodEEK9
	 u9RLpL0/ID0XG2NSe5l+MQZENboSuXgUIiwjMdyF9ymwCW165JSAL97vL0WY58FbWQ
	 h0zepKC9/31MKM3brC5iVOQaUfr8doEC3cp3ESRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfEBOmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBOme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:42:34 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A71420656
        for <linux-kernel@vger.kernel.org>; Thu,  2 May 2019 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556808154;
        bh=EkdJKz+g6QMmg2qk7qFnp9jFndU1X+NWw2khzkoIlPc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mWrTgAIyC4DlVy49pGcN4kIzYhbnmxQ/AzBqduK1gG98kxrsHyPdE/L3Jta0D+J4q
         AN72w0uauuD8IUnagm0parp+B+8aMSzb+SNNKTjk30euQ4+DArpNOAxolDD/x7pUFM
         1VeLqOBC7h03vKK3VEbkKhHMtHnjOpGY2Vu6xtQg=
Received: by mail-wr1-f48.google.com with SMTP id s15so3699103wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:42:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUkXZvkyyRDaiY3pZRZ+Cnz217HVBP6UAf7Ivt+PcO9KcugxK6f
        DM4drSPMgxHf1I3XPY0qMPRk5wAVrh/TZIjQn7P4Yg==
X-Google-Smtp-Source: APXvYqxDFECASb07Cr9Mq/i0ETnDrerY85Mj8ZdygnotfKNl/ols3G6hroQacFAk5x+z1qCxXIEnUdHXch7BCLoRY5A=
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr3219255wrq.330.1556808152685;
 Thu, 02 May 2019 07:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <1556544977149154@kroah.com> <CALCETrVjhVXYA4B6zFzbH14wBXZcNMAeM8YxdRh3RLHxVVde_g@mail.gmail.com>
 <20190502080204.GA2832@kroah.com>
In-Reply-To: <20190502080204.GA2832@kroah.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 2 May 2019 07:42:21 -0700
X-Gmail-Original-Message-ID: <CALCETrXx_24vOLosXvOMZ81LKcAnud1A7axZ057wK0KFeBCT3A@mail.gmail.com>
Message-ID: <CALCETrXx_24vOLosXvOMZ81LKcAnud1A7axZ057wK0KFeBCT3A@mail.gmail.com>
Subject: Re: Patch "x86/fpu: Don't export __kernel_fpu_{begin,end}()" has been
 added to the 4.19-stable tree
To:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        20181129150210.2k4mawt37ow6c2vq@linutronix.de,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        stable-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 1:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 01, 2019 at 10:47:07AM -0700, Andy Lutomirski wrote:
> > On Mon, Apr 29, 2019 at 6:36 AM <gregkh@linuxfoundation.org> wrote:
> > >
> > >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     x86/fpu: Don't export __kernel_fpu_{begin,end}()
> > >
> > > to the 4.19-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > Why?  ISTM the only possible effect is to break out-of-tree modules.
> > I have no objection to breaking such modules if we need to, but, in
> > this case, I don't see the benefit.
>
> The "benefit" is that people keep complaining that newer kernels do not
> have this api for some reason and that it is a "regression", which
> completely does not understand how the kernel handles internal apis.

I suppose that's a reasonable point.  But maybe we should actually
give these modules a credible alternative first?  I just send a patch.
