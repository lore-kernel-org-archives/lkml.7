Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC318C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8859020B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SmKMpQLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfJIRF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:05:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41538 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:05:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id w65so2382015oiw.8;
        Wed, 09 Oct 2019 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2mWDjNiFA8ZmwOSzNfxAaNscOF3X+a/Kjb9sBM4nYM=;
        b=SmKMpQLMdu9zF+nZETtyRyzRFHvqJQM931spdY+ZgtQexKRYWMGEJ/SEMSjPLRwgyX
         sGCfwlBzFBSSOoOzZLbNiPuenj186i0Q7O7o4hyzoB/N1b6hXnlm4oQPBxy0cSQ98bGH
         +x4VPv8LVWtflqbB9+1yalCGMt+xywez2ywORN8R2ErdI0GVP9PpkcGn8eZZ8O2JUM0a
         eD/ZrXd47/tKoNo4ITdNZBi9cgx0HQu6Az30CNCGEEg6kXWwqoRIrbg0h5iH+fCF1bLF
         M1G353WsH6zE4VwfLPFeaGBAVKlGrbU1LWazFwx1S2wB5DtSH+hZg90j0MwtKUYG5/lu
         g2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2mWDjNiFA8ZmwOSzNfxAaNscOF3X+a/Kjb9sBM4nYM=;
        b=R4NMN9HGVxQvfLvgm0Oip4YBwfSAjoAW1qDb1vebtvlZ+2Yojcel5FGdrqjAzhoGWQ
         g8401l2l0vIreZgy1LRsAT7pVU4joodhZUWgFi6809gND6XPhz+x0/aPP6QCwsGCE2h3
         trxLns+Jxt1tqLKgMGdpJGW+zySjW8Zmd6Fsoeh9snymilynFrnPuSRdYnIZGiH0JRa8
         p/ViB7hSViN1mgWkminODlAnG9Y8PZ4e/RB9opEYanFm8PaEF1xPJOKRKXQWVc9PBQfX
         N3826/L3IrvFtjfKEujIUs1xpWueEB09xb1chgGM7DT2xUFEbka/iGlvqsmQOnE/cvKA
         WkwQ==
X-Gm-Message-State: APjAAAWGtAvUFNgVug8wLi+PL6rl1sQiUwGN8iqqD6yBJ95o517vuN7W
        Qggi65bglMLUI6SpZV4gC6YVrKobxTe4FI+uJDE=
X-Google-Smtp-Source: APXvYqzRkSN7OkK/hbG3KqKLVZ1gB3egs7zTwNvk2ZAefW8rYVwzudrNvLiAtRk9tvfW75gia/FxyzlIvLMQYI7QLR0=
X-Received: by 2002:aca:d90a:: with SMTP id q10mr3536020oig.129.1570640757567;
 Wed, 09 Oct 2019 10:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
 <7hsgo4cgeg.fsf@baylibre.com> <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
 <CAFBinCA6ZoeR4m4bhj08HF1DqxY1qB5mygpaQCGbo3d8M+Wr9Q@mail.gmail.com> <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com>
In-Reply-To: <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 9 Oct 2019 19:05:46 +0200
Message-ID: <CAFBinCCHrvjNTruVk7qr+7Y_m7mP2BJ-0HxftJpiPXpvoD=-QQ@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Wed, Oct 9, 2019 at 10:49 AM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > can you please share a boot log with the command line parameter
> > "initcall_debug" [0]?
> > from Documentation/admin-guide/kernel-parameters.txt:
> >  initcall_debug [KNL] Trace initcalls as they are executed.  Useful
> >  for working out where the kernel is dying during
> >  startup.
> >
>
> Well I have tied to add this command  *initcall_debug* to kernel command prompt.
> Here is the console log,  but I did not see any init kernel timer logs
I don't remember from the top of my head if any additional Kconfig
setting is needed

> Kernel command line: console=ttyAML0,115200n8
> root=PARTUUID=45d7d61e-01 rw rootwait
> earlyprintk=serial,ttyAML0,115200 initcall_debug printk.time=y
>
> [0] https://pastebin.com/eBgJrSKe
>
> > you can also try the command line parameter "clk_ignore_unused" (it's
> > just a gut feeling: maybe a "critical" clock is being disabled because
> > it's not wired up correctly).
> >
>
> It look like some clk issue after I added the *clk_ignore_unused* to
> kernel command line
> it booted further to login prompt and cpufreq DVFS seem to be loaded.
> So I could conclude this is clk issue.below is the boot log
interesting - as Jerome suggested: the next step is to find out which
clock is causing problems
last time I checked there was no debug print in the code which
disables unused clocks so I had to add that myself

> Kernel command line: console=ttyAML0,115200n8
> root=PARTUUID=45d7d61e-01 rw rootwait
> earlyprintk=serial,ttyAML0,115200 initcall_debug printk.time=y
> clk_ignore_unused
>
> [1] https://pastebin.com/Nsk0wZQJ
>
> > back when I was working out the CPU clock tree for the 32-bit SoCs I
> > had a bad parent clock in one of the muxes which resulted in sporadic
> > lockups if CPU DVFS was enabled.
> > you can try to disable CPU DVFS by dropping the OPP table and it's
> > references from the .dtsi
> >
>
> Yep yesterday my focus was to disable PWM feature and get boot up-to
> login prompt
> But not I have to look into clk feature.
>
> *Many thanks for your valuable inputs, I learned a lot of things.*
you're welcome :-)


Martin
