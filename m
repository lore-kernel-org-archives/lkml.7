Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F23C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECA720840
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="DSK7CFgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfG0IFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:05:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52914 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfG0IFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:05:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so49717711wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUuh5ETZIUfuMg+mI65VPB6v8GyKBFkoAPNDHAvE7TY=;
        b=DSK7CFgzqlGC9xuu5pNy0qetVetRijrSTSdqyMwkEpr4ELdVjD31wyMLuH3u6Pt/3O
         Zg0v/ZxrPbvESPn4/hhxy+RS40BgQ/zL3v3smv9CrHdHWgdY1WjjMiWy5ajW0sQBHlBt
         9Z833G8aSMPU5q+rx8YrgBOJocy/QVhM/4kimK06gO1bnJkTVTYN+Wy9BZO0YMa88PYs
         KsRZ7L6oCmP/tW8VLnbIT5b2IP5FVhouHrU+VX7bWlK1AJ/rMuIpwq3FmIPeyPFQgYp6
         bGooNcsD8QfOgokBFpMSpTB+S415pJsdhxG+tjzOf5yeeNYseex604fnB2KPMgR+Xd9w
         TBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUuh5ETZIUfuMg+mI65VPB6v8GyKBFkoAPNDHAvE7TY=;
        b=oOR5XdmhKXCf+wjdXeVdDcGiqCwlP6vUx9LFzr8sEHOFfXvQ9yUykhSeKcPUrAzaz3
         3DoMNqHsUBonpl1/GNW/fS26rCgkPF+lHAGoK0QoVSBsyZdMITIEauA1QpD/rtMXyxSU
         p6skzz6GeHJ3KmJhplA2LBxKU0D0hyaBnExU7Dh4VG07Z+XdZPARgx0WRjzbRyG6No2v
         CWJW0ZIigbvEGc9G3c4ErID1Sms5FTbSCxosCP6nlskjiIYwX5LrinN2bMyYZiExctNW
         8wnPIZFnqrLUahopR1kcGl8TcqvmsBGxOCTdeRHTuNq7a/AwkqM8FZbn03R8+JwDG3B+
         S27A==
X-Gm-Message-State: APjAAAWmz5fpw4Ee0gYaNQglfaT7JbTR8KSKOw/PGXp1Ip2rcOIaQcjT
        eAF+H0hf778ZLNcKaHoNo0YemYi0mcdCyUv57q8=
X-Google-Smtp-Source: APXvYqwFGmFBAMUBtp+cB38MuVPO658FcLjausGtYUU+oVPF1Cz3+bTQ6+Bni7xO7RehJMYRYh4azEMgE93IzowsBh4=
X-Received: by 2002:a1c:cfc5:: with SMTP id f188mr81569607wmg.24.1564214748146;
 Sat, 27 Jul 2019 01:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190726194638.8068-1-atish.patra@wdc.com> <20190726194638.8068-3-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com>
 <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com> <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
 <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com>
 <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 27 Jul 2019 13:35:36 +0530
Message-ID: <CAAhSdy0Eycc0ORSnh6LJeC_D_x9yLOkoc7OkPNuN6qOcZEGVWg@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 1:23 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Sat, 27 Jul 2019, Anup Patel wrote:
>
> > > -----Original Message-----
> > > From: Paul Walmsley <paul.walmsley@sifive.com>
> > > Sent: Saturday, July 27, 2019 5:00 AM
> > >
> > > On Fri, 26 Jul 2019, Atish Patra wrote:
> > >
> > > > On 7/26/19 1:47 PM, Paul Walmsley wrote:
> > > > > On Fri, 26 Jul 2019, Atish Patra wrote:
> > > > >
> > > > > > As per riscv specification, ISA naming strings are case
> > > > > > insensitive. However, currently only lower case strings are parsed
> > > > > > during cpu procfs.
> > > > > >
> > > > > > Support parsing of upper case letters as well.
> > > > > >
> > > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > >
> > > > > Is there a use case that's driving this, or
> > > >
> > > > Currently, we use all lower case isa string in kvmtool. But somebody
> > > > can have uppercase letters in future as spec allows it.
> > > >
> > > >
> > > > can we just say, "use
> > > > > lowercase letters" and leave it at that?
> > > > >
> > > >
> > > > In that case, it will not comply with RISC-V spec. Is that okay ?
> > >
> > > I think that section of the specification is mostly concerned with someone
> > > trying to define "f" as a different extension than "F", or something like that.
> > > I'm not sure that it imposes any constraint that software must accept both
> > > upper and lower case ISA strings.
> > >
> > > What gives me pause here is that this winds up impacting DT schema
> > > validation:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docu
> > > mentation/devicetree/bindings/riscv/cpus.yaml#n41
> >
> > If 'f' and 'F' mean same extension as-per RISC-V spec then software should also
> > interpret it that way hence this patch.
>
> The list of valid RISC-V ISA strings is already constrained by the DT
> schema to be all lowercase.  Anything else would violate the schema.
>
> I'd take a patch that would pr_warn() or a BUG() if any uppercase letters
> were found in the riscv,isa DT property, though, in case the developer
> skipped the DT schema validator.

If your only objection is uppercase letter not agreeing with YMAL schema
then why not fix the YMAL schema to have regex for RISC-V ISA string?

The YMAL schema should not enforce any artificial restriction which is
theoretically allowed in the RISC-V spec.

Regards,
Anup
