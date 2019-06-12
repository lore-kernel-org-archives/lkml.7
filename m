Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07EEC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7168206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lE2zkkfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfFLSkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:40:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33191 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfFLSkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:40:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so10142834ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BCHDCMqhJT/6FshXZBORq3geSmDeK2ImfsvkULZ7ako=;
        b=lE2zkkflj0+rg65PZkQJswReFAFB73OuSI0tN6PxnBkJP/VFGNj1K6LE3WlWR1dg5V
         P5Aq0dfZFClkS9LxQBbxtFDEJ1Scp1OfJPvRy686oMTHdRjyWofbzn5Hr5asuisoAS+T
         NpIsWoQvpLvQvEyJrrk2fHLDKAr2jq+vUqkMot2y6a9eVObTSo5oRHrUGQnGWppBbpFf
         +37jFd1wvaUHxFs1OpWZOEv/uyLWxvqde73l6D208E3fAqL3dCIFouietBA2/2pJUBz7
         ci0YmRCAdnfog+siXDGqltWsATRNrAfiwun3LivBIy3vUD0Kg7++F//HIPKR5g8lPPz8
         7G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCHDCMqhJT/6FshXZBORq3geSmDeK2ImfsvkULZ7ako=;
        b=uNhIe4G2O/jykTZEV+LKXZW+R9vQKVDM9XfQ3OO4uV/ZluZiRtI+RAaGZHVW1jX0ud
         5bFvS1MmefUaaN/eNhG4hIh0Tnm9H8ZL3AQw+ZxE0eqixgMI6Ym+lNozqd0uZgDn3C7I
         +zBUiPyS6VXgek0ecXS5sCHhrIaG/ffZl4lPhaiEr0E7UlrhWWbAsved28VgKwnIxuBf
         CVyV26cseoTJAEmsI0ddkTbxip+H5IhRh421QPtUX6O0x9rMaD8CUxvaDar/zBM4nUQS
         L7raGvw/KXyHVtxzzzf59P5gYbdrDfemskj6RvFxx1yjqxIAM5dTAfL0cROfZgIeWZ0W
         Z8mg==
X-Gm-Message-State: APjAAAXxqV0N27d56gSb0cmuW4Ukvy4ND+yV5hgAe/o3ZTpAUXpTRDx7
        QA/l1jIrXHD9szizOBbBXknltHuKHsJp/W8MwIs1ug==
X-Google-Smtp-Source: APXvYqx1aU3ktFN2gcF7RCr6w2X4mZJs1SwOwOdH5Y2XxcJU445SgyS7OuaIeO5AfJMw0REuUlJKVxTW5q6NEmLlwTM=
X-Received: by 2002:a2e:5d54:: with SMTP id r81mr7178030ljb.104.1560364812092;
 Wed, 12 Jun 2019 11:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190612081147.1372-1-anders.roxell@linaro.org>
 <CACRpkdbhRAdybqKdMgyM9Jy=eSJaRHjTpuOZO=KBgeaCbcP88Q@mail.gmail.com> <20190612131647.GD23615@lunn.ch>
In-Reply-To: <20190612131647.GD23615@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 20:39:59 +0200
Message-ID: <CACRpkdZof4S9xySBLMnf6Uu4LuRSjoEyxJYv4EXTgKDOf5R8Ag@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: net: dsa: fix warning same module names
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 3:16 PM Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Jun 12, 2019 at 02:36:44PM +0200, Linus Walleij wrote:

> > Sorry for giving bad advice here on IRC... my wrong.
> >
> > > -obj-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek.o
> > > -realtek-objs                   := realtek-smi.o rtl8366.o rtl8366rb.o
> > > +obj-$(CONFIG_NET_DSA_REALTEK_SMI) += rtl8366.o
> > > +rtl8366-objs                   := realtek-smi.o rtl8366-common.o rtl8366rb.o
> >
> > What is common for this family is not the name rtl8366
> > (there is for example rtl8369 in this family, we just haven't
> > added it yet) but the common technical item is SMI.
>
> Hi Linus
>
> I was not sure about this. I thought SMI was the bus used to
> communicate with the switch. It just seemed odd to call a switch
> family after the bus.

It is true, but as can be seen from:
Documentation/devicetree/bindings/net/dsa/realtek-smi.txt
it is a family of 8 switches. I think we should just have
one module handling all of them for simplicity, once we
get around to implementing anything else than RTL8366RB
that is.

It's these 8 switches that talk SMI and they have a lot
in common like talking RRCP internally AFAICT.
I think these switches are pretty complex on the inside,
we just don't have very good documentation :/

> Anyway, if you are happy with the name realtek-smi:
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks!

Yours,
Linus Walleij
