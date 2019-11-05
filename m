Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07ECC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5384214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1AWEpG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbfKER2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:28:04 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44972 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbfKER2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:28:03 -0500
Received: by mail-il1-f195.google.com with SMTP id i6so326967ilr.11;
        Tue, 05 Nov 2019 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTFoXOfWJrTJukAAsyozGS2jxqQNjGUoCCDkiyXZrks=;
        b=K1AWEpG14GpazrrnyADY6KKZpTspIcP9uY98rGEXah5YJNdRQxZtJUlKG3gbnWbDdj
         hzlV1HXEm+ujPHU/4IV734ebSheBGFxv2rnS9zp1nmmyIwLDbJLFmuX96Mde74v6v5PK
         xq6RQPhqI/TK7KmHB8UVozfDcZKuObclsGNGIX7B2OxN4b+DRPlYF20x/LW+nqU+R25z
         hWPI9MXL/Lm5xaVOpGWDdeRteIQfmMur18Gjve0AvgToDTYd9f1xmigBIitsvGKMB05y
         5aKbUnB9c+9nEhvGf/vXGeXDN0jetxr4cecdZRwNaSILS4//mTzDJuefH2b6zOt4+z47
         tXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTFoXOfWJrTJukAAsyozGS2jxqQNjGUoCCDkiyXZrks=;
        b=DVSaQ3JQRvXDKOutFD46g1oSASeWMGVWhX6791V5G8AakCpmxZiN4PY9DgjTERJjil
         QAZvAdy7SGPbk3X1Iwru2FlZ/kYxg6Eq0bqzLBZToCdY8Rblxaf68OHinbsmEJCObbMI
         pZVuKNrzQkpP++S1FDpkQhKm/OfbQzhvpqu37t0xZOt/WF02lTsWe6U/UXblIkkdPl6T
         vvy5+yT6A7NOmFubKF+gOiUC0O/6c3WdyBrhUU3lfdBaY66/Xgjn6FjKeyMZfwvsfoAZ
         BENdps1P73hbKZGO8/kizr8Zur2/X49zNlt/shckDvKwrsHnVPjiWgoFc2IsCKIu00q/
         0Myw==
X-Gm-Message-State: APjAAAUdZ6WKkpX2hLlu3X4Y0060ga4tZVQPMegsPIOnrOWDdB80S7kU
        Sk2ZkhOYWbNs1OoJpaRs5w087hRNwCAngYXHaTA=
X-Google-Smtp-Source: APXvYqzGIwf2uAcj+jbv7ogsYQ8oo8RHYjm0AfGfROTgS6+aOn75ZQCD4Hy2jm36RyD9vSLEkaJhAICptCEdpEYMo88=
X-Received: by 2002:a05:6e02:803:: with SMTP id u3mr36060158ilm.43.1572974882467;
 Tue, 05 Nov 2019 09:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20191014174022.94605-1-dmitry.torokhov@gmail.com>
 <20191105004016.GT57214@dtor-ws> <20191105005541.GP25745@shell.armlinux.org.uk>
In-Reply-To: <20191105005541.GP25745@shell.armlinux.org.uk>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 5 Nov 2019 09:27:51 -0800
Message-ID: <CAKdAkRQNWXjMdJ9F1Lu=8+rHWFJwoyWu6Lcc+LFesaSTz3wspg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] net: phy: switch to using fwnode_gpiod_get_index
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 4:55 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Nov 04, 2019 at 04:40:16PM -0800, Dmitry Torokhov wrote:
> > Hi Linus,
> >
> > On Mon, Oct 14, 2019 at 10:40:19AM -0700, Dmitry Torokhov wrote:
> > > This series switches phy drivers form using fwnode_get_named_gpiod() and
> > > gpiod_get_from_of_node() that are scheduled to be removed in favor
> > > of fwnode_gpiod_get_index() that behaves more like standard
> > > gpiod_get_index() and will potentially handle secondary software
> > > nodes in cases we need to augment platform firmware.
> > >
> > > Linus, as David would prefer not to pull in the immutable branch but
> > > rather route the patches through the tree that has the new API, could
> > > you please take them with his ACKs?
> >
> > Gentle ping on the series...
>
> Given that kbuild found a build issue with patch 1, aren't we waiting
> for you to produce an updated patch 1?

No: kbuild is unable to parse instructions such as "please pull an
immutable branch" before applying the series. Linus' tree already has
needed changes.

Thanks.

-- 
Dmitry
