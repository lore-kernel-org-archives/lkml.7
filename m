Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAABC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB092173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sOceQQQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfEKR0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:26:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40874 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfEKR0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:26:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so10951651wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zGbXafpSb2HshgO2XMP6h8Y6gtWk2K/zGjC4Q7Aa/fg=;
        b=sOceQQQ7FUjZUb9cq6RMY4OY0UtuWxXjBusFoTudXNPxeE/PaMGSOANxujMyfFCSLM
         1MmHNbnE3b5nkHrr84AJOBPTlThBl6Mbdlr7MgbOf+YmyiLHSH+WVq3tuMap/Q3GWYo5
         e+r5CvUmT38WroNUBTzKMimertVVCGaw4KkpvYITGmKEgM1CfOew3qI0+UrYDjHV7gWA
         R6NNnosMK492+4YUMQwf5NVEeKk7diYUx2R2n92WtXJ1ZZzSBJsSg2tv4qLSfNpbVzH/
         UyRHd0M9QM2mXz3eLJSRT1yZ5fHYcZTsupdmyr/f53gzHlHDhvojVzJSaMMsK6CZpRNK
         viJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zGbXafpSb2HshgO2XMP6h8Y6gtWk2K/zGjC4Q7Aa/fg=;
        b=ElBaoXRGCFNDg2cjMahgP6RE9vFxuIlJQQxB/aGz4fDyIbwB1R9TMyaFsnJisVhcXu
         eA5GkNowkoBq5I5ZvvpvfjH0JKQPGDM7x5h1cmabv4tnirtYl/DN/mzP+Dkifv6VqU0L
         sqCWE9TXy9mljoWdBHBcPTlqe0/Equ/b7aTKaPaXAGpKQGGybBcJu/ZavqpGXyxo9Rn5
         cNW03eBhZd8Xiekf+UNXvw6cFkzXNPSPbH4pvZZxgTKZjpGcIBLWwLRuQCoHGTqxTC8q
         5txH/H1jNpasS7TkflNSTZIoy+29ai+w8g5e4ALE7DKpg5JAa2d3HA3QEnWN45Lu8rsV
         4vew==
X-Gm-Message-State: APjAAAXdVIqIJRiINCOhTIgR14zVt5/JdeQkdFn01WL7LzD3gUPKaKRp
        Qhsabu/jYU1nkmfkZrt4E7yZuA==
X-Google-Smtp-Source: APXvYqxiNrIZ71M/NEU6SrK8ObcYzxQx6F/XwLVianmSstjOsoGpmQ5a6gJNvCIZA+XBpy8zwlMaPw==
X-Received: by 2002:adf:a202:: with SMTP id p2mr11897591wra.166.1557595560934;
        Sat, 11 May 2019 10:26:00 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id o8sm17856891wra.4.2019.05.11.10.25.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 11 May 2019 10:26:00 -0700 (PDT)
Message-ID: <c474c55386dede7f541aaf8afd6c87b78ccd6577.camel@baylibre.com>
Subject: Re: [PATCH 5/5] arm64: dts: meson: sei510: add network support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 May 2019 19:25:58 +0200
In-Reply-To: <CAFBinCDA3kqCK9riSkNAv9069ASN8E2ECdsffi+U7mYRqHrfJg@mail.gmail.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
         <20190510164940.13496-6-jbrunet@baylibre.com> <7ho94ac4jn.fsf@baylibre.com>
         <CAFBinCDA3kqCK9riSkNAv9069ASN8E2ECdsffi+U7mYRqHrfJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-11 at 19:16 +0200, Martin Blumenstingl wrote:
> Hi Kevin,
> 
> On Sat, May 11, 2019 at 12:45 AM Kevin Hilman <khilman@baylibre.com> wrote:
> > Jerome Brunet <jbrunet@baylibre.com> writes:
> > 
> > > Enable the network interface of the SEI510 which use the internal PHY.
> > > 
> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > 
> > I tried testing this series on SEI510, but I must still be missing some
> > defconfig options, as the default defconfig doesn't lead to a working
> > interface.
> > 
> > 
> > I tried adding this kconfig fragment[1], and the dwmac probes/inits but
> > I must still be missing something, as the dwmac is still failing to find
> > a PHY.  Boot log: https://termbin.com/ivf3
> > 
> > I have the same result testing on the u200.
> I wonder if we're simply missing the pinctrl definitions in the ethmac node:
>   pinctrl-0 = <&eth_rmii_pins>;
>   pinctrl-names = "default";
> 
> I don't know how the SoC works internally but I am assuming that the
> MDIO pins are routed to the "internal PHY" (within the chip).
> also we need the eth_rmii_pins anyways for the RXD/TXD pins which are
> connected to the physical Ethernet port on the board.
> bonus question: while writing this email I'm surprised to see that on
> GXL we don't use the rmii pins anywhere, why is Ethernet working fine
> there?

AFAIK, the pinmux is for the external pad Martin
The internal phy does not use those pads.

> 
> 
> Martin


