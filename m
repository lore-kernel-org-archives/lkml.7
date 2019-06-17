Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A186C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDC32089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q7kHBLmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfFQMvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:51:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41809 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFQMvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:51:41 -0400
Received: by mail-vs1-f65.google.com with SMTP id 2so2864413vso.8;
        Mon, 17 Jun 2019 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klPdjqqlVoeDREb75kQqStjinhVsI/mU0etQ6QnCaVA=;
        b=Q7kHBLmkk8yeIcrJfSdKv0eDe8c6TIcykYfxeE+gtyxDGM7jTmWBX8X8LqO0Vz8wmh
         l2H7Gj3rNds4mi0waYFOmJF58IVTdd8njCA3nt2QMsVA/in322QCir6CzFI8M8Jq+RI6
         YLDvBk2D9gE6D8rmyfWqroIaIJxgFycHSyS4NRF7Zo2BY2Qag9JEILtsxLXUpFsVF9op
         U3TVunfWmIcq5z0r1zZ3UousfHv+Y5FC10uYHhcLW+z/qmYV+1TCAl9OkJKcvx/K/+O1
         zIAQ70uPMhRJ/QLvnR1n8XirV8I5X8DuBiVQLw5/I5wrY9+jsNdRYprh+F8aPtaKk29P
         LX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klPdjqqlVoeDREb75kQqStjinhVsI/mU0etQ6QnCaVA=;
        b=SWKhRB0NKz7Nz4os0WwEMufS3VRQ9nsvGuvM9dFiBCl7fhEtSff/DmWEBTgDCTB4+d
         411tYMqXTLAXDKkyHgYFgpzlCxmFOxPxrhOpRDgNM6czejboJAwjcXOWH9fCX3DPr1EU
         F4IAz1YN6guhNNxhB3OsiK5kbZ3hJNG48Du19k/eHjZUwlWfgRZlQ06luhw5D8ltKUJy
         DSc6fFl99g54hhuQZTRvmDGQ+knYP79siKibnMO5Qrnk7eeaAE7KK5n3+ie3RV9mvXFy
         Jd4PRJ/Ln6ZvW2kK6nXpXUCMndAndrWKIMVS72uo+e1QZ3t7uU5tml+Gm40FeLpRsykj
         xm+g==
X-Gm-Message-State: APjAAAUmIyGv6ILaDhOEArTk2Sc6cpANJbTZhb2AuYjGFGz1t3conkzg
        DrhBfoKdEkyM8/NdxFIL+Ihfvd87B3Rjk1/vv/I=
X-Google-Smtp-Source: APXvYqwFeWgFnNJblZqkjL2ae02IOcVqxIIBQrv40Ft1GMFRwdqN43eWUISS8RdMVxsuA8gLkKAFkvwqWO2Ghp/c13c=
X-Received: by 2002:a67:de0b:: with SMTP id q11mr4656005vsk.134.1560775900716;
 Mon, 17 Jun 2019 05:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190613154542.32438-1-sr@denx.de> <20190613154542.32438-3-sr@denx.de>
 <CAGm1_kuyt5ue_3CuvryXw8L0=z0Bti5BeQMA50yRYhFmffcJuQ@mail.gmail.com>
 <CAGm1_ksdQ5CNLGGNzHKBNKeLE3ByHvPyOkjYNoWWM+rw0q214Q@mail.gmail.com> <d62c1a2b-3e24-c109-a7fb-57190388d75f@denx.de>
In-Reply-To: <d62c1a2b-3e24-c109-a7fb-57190388d75f@denx.de>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon, 17 Jun 2019 14:51:15 +0200
Message-ID: <CAGm1_ks0TWAkKGQ+k060hmwZi-i1jD2-KMqxex1QqrbujS00WQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] tty/serial/8250: use mctrl_gpio helpers
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 2:42 PM Stefan Roese <sr@denx.de> wrote:
>
> On 17.06.19 11:51, Yegor Yefremov wrote:
>
> <snip>
>
> >>> @@ -1944,11 +1948,15 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
> >>>   {
> >>>          struct uart_8250_port *up = up_to_u8250p(port);
> >>>          unsigned int status;
> >>> +       unsigned int val = 0;
> >>>
> >>>          serial8250_rpm_get(up);
> >>>          status = serial8250_modem_status(up);
> >>>          serial8250_rpm_put(up);
> >>>
> >>> +       if (up->gpios)
> >>> +               return mctrl_gpio_get(up->gpios, &val);
> >>> +
> >>
> >> What happens when you have a mixed setup i.e. CTS controlled by UART
> >> but other status pins controlled by GPIO? In this case CTS status
> >> won't be returned. Do I see it right?
>
> Yes, your analysis does seem to be correct. Please note that I did
> not intentionally did change it this way. I was not thinking about
> such a "mixed design".
>
> > What about something like this:
> >
> > unsigned int serial8250_do_get_mctrl(struct uart_port *port)
> >    {
> >            struct uart_8250_port *up = up_to_u8250p(port);
> >            unsigned int status;
> >            unsigned int val;
> >
> >            serial8250_rpm_get(up);
> >            status = serial8250_modem_status(up);
> >            serial8250_rpm_put(up);
> >
> >            val = serial8250_MSR_to_TIOCM(status);
> >            if (up->gpios)
> >                    mctrl_gpio_get(up->gpios, &val);
> >
> >            return val;
> >    }
>
> Looks good to me, thanks. Do you have such a setup with some modem
> control signal handled via GPIO and some via the UART? Could you
> test such a change?

I already have :-)

This my DTS file:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/am335x-baltos-ir5221.dts#n38

Yegor
