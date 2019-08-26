Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAABC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBCA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWI+S+Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfHZPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:45:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36690 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:45:33 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so38387236iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQHPYDSQypQ9ChdaeenBRr1dnYZdF3dhaiY40oARyws=;
        b=oWI+S+Undd77FeJA4VZ5M5AN+kBODItR77545AG+SnXjILnM0T2D7LYqUZBa4AAM3r
         YxDS1Vu8gvb+8rYx9BS3aFNJPMlKc4cNvOiccadQmg25Lrq/Gwjw7Ijkhote9pIIYdii
         GyVtC3DR5zXr8W86AyyPBpxAhiVSpZL1mjKWCakUuEP4cmNDHeFlvriLgGexVQuwwOaH
         Vqn5nHRJJodFgPpp4Na+TxISZKmxm6bm97wBFhl/s97+QKaqjQPV6uJjxY/acT847Lo+
         PcgMqUPLjjl2JemqjLKkeAs06QEif7XnoYwKc+NBJ9MAxqk8R0LQ7pFSsT1yloAb3FKA
         9AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQHPYDSQypQ9ChdaeenBRr1dnYZdF3dhaiY40oARyws=;
        b=qwewRqgn4nDZjwVJ7drqeKEtt+5CewRRv5Mwz+X2HygCU5aDLL45zww42kHtDYXF0m
         BZcgUAM8x/5M671P9dDONPEbqiSt4BDx2TnKzovkBYnBD2nRQ0LnZVogEE/1xmO/zBdX
         XBUpVFFALLBAUnsOzkOkmWpfoYT7n7iEFzyRTBRcwgAj4kAI5TpWyBXacurPUW594RED
         74JYXl2wv8Fycqb0ySXqDZGtN0JaI24Rm/4Yw8ATy9Rh0nUGOMHFYCn2vTa/r2NbqBRW
         kyJAIRDmC4lLMY5xdb8fY3Xgm1JKzKouiNZgOzxBxAWhkacjCqg4F0E+YlfuPEG2zuZX
         1GPQ==
X-Gm-Message-State: APjAAAVNsPiqiN4KqilE2Dthn2pnAx4MDDlLMt0253NeTSt8qwYEKX0j
        pJ4W3WcsrvY4uKI545bfdP6A/pOlne94e7VEtWg=
X-Google-Smtp-Source: APXvYqyh/Fs6PpfTF8PLCcKVqzPhQwtSK2hTjMhAJkR+FdKaNR48OjFgAitd3+G51RiUpz3J1HJ9/gK45JT8WDUQ4QI=
X-Received: by 2002:a6b:e90c:: with SMTP id u12mr3026752iof.221.1566834332518;
 Mon, 26 Aug 2019 08:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190825173053.5649-1-lukas.bulwahn@gmail.com> <alpine.DEB.2.21.1908261706460.1939@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908261706460.1939@nanos.tec.linutronix.de>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 26 Aug 2019 17:45:21 +0200
Message-ID: <CAKXUXMzZxAY-C3Eqh9OHTrLnkv5Jy3wdYsKVuqA=OpHtkWaZtQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2-resend] MAINTAINERS: mark simple firmware
 interface (SFI) obsolete
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Len Brown <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 5:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Lukas,
>
> On Sun, 25 Aug 2019, Lukas Bulwahn wrote:
>
> > Len Brown has not been active in this part since around 2010. The recent
> > activity suggests that Thomas Gleixner and Jiang Lui were maintaining
> > this part of the kernel sources. Jiang Lui has not been active in the
> > kernel sources since beginning 2016. So, the maintainer's role seems to
> > be now with Thomas.
>
> Nice try. All I did there was converting the existing code to new
> interfaces and to use SPDX identifiers. You touched it last, you own it, is
> not really working.
>
> TBH. I have no clue what that is except that it's bitrotting.
>
> >  SIMPLE FIRMWARE INTERFACE (SFI)
> > -M:   Len Brown <lenb@kernel.org>
> > -L:   sfi-devel@simplefirmware.org
> > +M:   Thomas Gleixner <tglx@linutronix.de>
> >  W:   http://simplefirmware.org/
> > -T:   git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
> > -S:   Supported
> > +S:   Obsolete
> >  F:   arch/x86/platform/sfi/
> >  F:   drivers/sfi/
> >  F:   include/linux/sfi*.h
>
> So why not removing this whole entry. arch/x86/platform/sfi is already
> covered by x86 and the driver cruft falls back to the people who are used
> to deal with dead drivers anyway.
>

Patch v3 will follow, where I will simply drop the maintainer. That
makes clear that nobody is maintaining this obsolete driver and with
the next clean-up action, somebody looking for obsolete drivers will
simply move this code into staging or simply delete it for good.

Let us indicate that that is the plan by changing it to obsolete and
remove all maintainers.

Lukas
