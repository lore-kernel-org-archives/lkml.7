Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6C9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4054F20843
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="nUbGOWn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfHSNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:21:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40842 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfHSNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:21:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id e8so1803132qtp.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upu6QqTSGqe4gvZ+l5Wj3zAWvY0pmvFRYAcyFGXCO6I=;
        b=nUbGOWn5G4f4RgZ7rY0slacUNtvDtgLunQnRfZpnKI672awITX4U4vm5WqtdoYFOcR
         2zaO9Qdk99fCRx63CLi8ChCjKXUsR8FC8FeDImFaVTtvC61cba2oDFJ0mXESnDg9hz3y
         ILwAMiqXGjAYHRZV4dzeUf75+31/Nx3HI54qMCIquLyx/w1617OyAcp2iyS4/aXtA+6+
         hVS/dXeeY2RgRrSJSizJYNnPQrqXbH6FG+AdxochqUVJmXikXZ46OlFaAkmVk7fyCw1t
         0f6Bde56DApYxMQZjTi0ZFn5Iq8TTLuzhvuayxkVhr85lm1AH6swaHnaA692JqdPmbc+
         +b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upu6QqTSGqe4gvZ+l5Wj3zAWvY0pmvFRYAcyFGXCO6I=;
        b=F843MxgIicf1ytjqBzpEWQ8VM5rMGFNsLY+iAkp0e2vkbbIpyDEbE6oX5xnhdMUapP
         i79P2qkar+n9G+ti45W8ldUgdRhIlLvf/W6X4+VowCBftg+dy5+q68+rVqulb6oqTuTk
         lydkhvpzgFebL/OCA+fRudmBSHgLylFtxbbgv7vXUnS+WF1zlRicjmpXnCJP5ri0SACM
         LdYkvt4AK6TRTNP/sR/Vd2DKcyHelYsOuq5zBKfcrspcZJNStbyfBBBTgRfFP1Kd8iSZ
         Oov2yV3j1WxWMc0V6LzsaoUpGAbDdqo9bCbVPvOgELHzD2bAGhmL472LjhuaRnoICn1x
         4mEA==
X-Gm-Message-State: APjAAAWvwNenVPB+Fbypo2fDo51q3GnsV6EE87FG5fr+wmj/qRMWSmO6
        V2zP589lieHykcIE95ussxUy+u1zn+81iXH/+Bbm6g==
X-Google-Smtp-Source: APXvYqyhkVreEIP+wRnPACbGts1R6Y0abAWu/yHAlL2g/AZXYxYgopk+hf+3ImdPxol+T7a/iX7FcjCQ9cF6JqVguyw=
X-Received: by 2002:ac8:1a6c:: with SMTP id q41mr20951425qtk.217.1566220899546;
 Mon, 19 Aug 2019 06:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190723130513.GA25290@kroah.com> <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com> <20190724153416.GA27117@kroah.com>
 <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
 <20190724155735.GC5571@kroah.com> <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de>
 <20190724161634.GB10454@kroah.com> <alpine.DEB.2.21.1907242153320.1791@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907242208590.1791@nanos.tec.linutronix.de>
 <20190725062447.GB5647@kroah.com> <CAHbf0-FenMwa6uMqpD_fJZLU3YKviOcMe_pBh8oWmUPoUYk_LA@mail.gmail.com>
 <CAHbf0-GpJY6SGz=9yXEh28vvBuHP-c_fKqP6u60Ag3et6FCPrg@mail.gmail.com> <alpine.DEB.2.21.1908191504570.2147@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908191504570.2147@nanos.tec.linutronix.de>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Mon, 19 Aug 2019 14:21:27 +0100
Message-ID: <CAHbf0-E9ye1a0uuU4p-bRJhgEpQhceo6X-qR8hoBWoiOHajh2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be reserved
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 at 14:08, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 19 Aug 2019, Mike Lothian wrote:
> > On Wed, 14 Aug 2019 at 12:09, Mike Lothian <mike@fireburn.co.uk> wrote:
> > >
> > > As it's related. I've raised
> > > https://bugzilla.kernel.org/show_bug.cgi?id=204495 about the
> > > relocatition I'm seeing since switching back to ld.bfd - is this safe
> > > to ignore? I'm guessing this is why gold isn't working as it can't do
> > > them
> >
> > Sorry am I asking in the wrong place about this?
>
> No, but I haven't come around to look at it. As your mail above is not
> giving any useful information and requires to fire up a browser it got on
> the back burner.
>
> That bugzilla entry does not tell anything about the compiler involved, the
> binutils version and the .config file. I'm really bad at guesswork and my
> crystal ball got lost years ago :)
>
> Care to give that information here by mail?
>
> Thanks,
>
>         tglx

Hi

I'm using GCC 9.2, binutils 2.32. I used to use the gold linker but
I've just switched back to using ld.bfd based on this discussion

My .config can be found at:
https://raw.githubusercontent.com/FireBurn/KernelStuff/master/dot_config_tip

Cheers

Mike
