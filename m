Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61825218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qfSupxWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCPWPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:15:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34113 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPWPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:15:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id r19so11445823otn.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1HQC+1IFkebVQL6B4ux1aetRkmn37CSNxrXUwZ6hs4=;
        b=qfSupxWOpePXZgmDGqlMKQpnQ6BCNYs5EaFL12fkrEF8xgrNdBIPlpG8EMsnQ0fjyL
         tk2jU+mcggy3DsJcxRiB3+GTEnsr2SnjYtS7WYF3oC49Dcma1V+Uta1fLbBEh9GzFkzq
         gcQoO8v3kAde3b5sNRZUyaQJ1tx84xhYzU5lLZICg+fi1O4owFxPu1JwoYmZee/Ufp29
         EgNKRbwCyhjiEYmSuj4BuIMZdrbd0GzMhw69LFe4Dh5nkppKO31JBl8SrxIgiqfJzmzh
         hgNnn3WFoMKlDQkIJCP5hsoASUuOUdcr6H22teVb0PLUL0juJxaS0eEV6XfA3fZP2d5C
         yLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1HQC+1IFkebVQL6B4ux1aetRkmn37CSNxrXUwZ6hs4=;
        b=HlnK4dY/ZAQy1Yy4jrBFX3jOHZRBWJG56+gHVW+vkYZRwzMUHDd1nVEV9MP74pwOly
         O7SQgvyN0ZGboUMH8QFzgsFJFKUS20lzqZgcU4FWPJEXzZCq7gefehjPFww6QTL2sU9s
         4O1gtE9ozBrWJUazu6mtOm56F7xBcYd8A572RWC6MZfWr9AXCbexpPXEvE7W0iyglglN
         8X1Eh28S2Zi5YJmu6KNk9raGe4RbTN48UpMbXDs5DEuewzoLn5Nqm2GA4Lr0F0j8GZbl
         PUKNz8bwvzf7KLOccYLkwd9YsrZxZ+Ju+B5t8WhntWHlhCfkSvWOgDp0UVP+HW8YQJTI
         9MkA==
X-Gm-Message-State: APjAAAU+lM5jaG0q8g6nlrpKDhq52rpZaXbtN3P9Zr7L+SpKOHrTWbuR
        MS0GsoV+W1s1FFa4iE0SxC1tg0v4p58I1lr6ZUk=
X-Google-Smtp-Source: APXvYqwSI9SAC06hhXk5T+2abmVcsC94KUvyeKel9KPB30erL3BOiYVQncrvjS/00NnJkOpPK9c8ufRKphaMo7squik=
X-Received: by 2002:a9d:7d09:: with SMTP id v9mr6498564otn.131.1552774502289;
 Sat, 16 Mar 2019 15:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190307151342.7381-1-narmstrong@baylibre.com>
 <20190307151342.7381-7-narmstrong@baylibre.com> <CAFBinCAa+ZjxJi491_dG+kvLFPLFoLXHFZToGP8W1ECeeqOYVQ@mail.gmail.com>
 <5C8D099D.5020206@baylibre.com>
In-Reply-To: <5C8D099D.5020206@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Mar 2019 23:14:51 +0100
Message-ID: <CAFBinCBHiLjrwXA4jXSg3qnGa925r--Nj_RH7xUFqyTkYzhKGA@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Sat, Mar 16, 2019 at 3:35 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> >> +                                       uart_ao_a_c_pins: uart_ao_a_c {
> >> +                                               mux {
> >> +                                                       groups = "uart_ao_a_rx_c",
> >> +                                                                "uart_ao_a_tx_c";
> >> +                                                       function = "uart_ao_a_c";
> >> +                                                       bias-disable;
> >> +                                               };
> >> +                                       };
> > I'm fine with this part if you mention it in the subject and/or the description
> > uart_ao_a_c routes two pins from bank C (from the EE domain) to the
> > uart_AO controller (from the AO domain)
>
> Not sure DT is the right place for that, I think I'll remove this until
> we have it actually used somewhere.
I'm fine with that as well

[...]
> >> +
> >> +                       uart_C: serial@22000 {
> >> +                               compatible = "amlogic,meson-gx-uart";
> >> +                               reg = <0x0 0x22000 0x0 0x18>;
> >> +                               interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
> >> +                               clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
> > does uart_C really use CLKID_UART1? on GX uart_C uses CLKID_UART2
>
> It seems so :
> https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/arch/arm64/boot/dts/amlogic/mesong12a.dtsi#L1020
it's weird but we can always fix it up later if needed. so let's keep
it for now to stay consistent with the vendor kernel until we know
better

Jianxin, can you please check with the hardware team whether the
uart_C gate clock (pclk) is CLKID_UART1 or CLKID_UART2 on G12A?


Regards
Martin
