Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D0AC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E01218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="upzMdkBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCPRCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:02:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42070 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfCPRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:02:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so8580392wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5sBiQxs7mw52OinugVuABSDctfMF/antra9v6/jEZWU=;
        b=upzMdkBngZcSKdu0T9u3vHgRJEjrCde762PELuScejpV77aaF8FubYThBix/2ejR2d
         KartoA+ezftB8zoz0deXdyXBNjJUeusgO0MkUxkNF/xVzkmxK3EG9fqfIF5XJjz0SQbq
         1uAKQuIOhGai7yFnGw3RqxTICOW8HQct/t7zmjv3t/xYmXQ/1PdNQjt1Nlnr4uIEqZHq
         YQR+UcQcOKbYdoxnL16Db0xh4PSIgDIStZPcCxE7IzFHfSHEfKMPoKvpHZ7Wz2nXmns8
         S8eZv/HBMltGfcUgSBikpk3dc74kPjOehJvKeSNwAVlKp63gTENhjRW/nSeXC1PgUpaQ
         Ysog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5sBiQxs7mw52OinugVuABSDctfMF/antra9v6/jEZWU=;
        b=kPemcVU6DtUutP0OvCOwnPOlTNKqBV5OmS4nbZuXL3ZsSxmC9zho0DG4PT4ljEqZrd
         11aG/F7LlZdxCdOS6PSfW4SrAsc0G5C8ACLeaYC1CxGYe7Sw1Ji32sNPDsnEJISctWBK
         RBRp9LGEkoaqe6pKW4pcbL2Eozb+97DhDdRryKlJqk4KbUtZpZX6DmXg9eP4nT0aorzq
         FLZbjvXVK77FwPLr3MnDZ7qGHNeFTKxoUWjZfH2P+GX5xuI9K/K9ZxjVVlbQ7QDEyokz
         UL4aSROLCC2UUM7Jv+UQ1cZmLiieso0VSsXdLE2Gg7HUnTgBwE9QipxEqmBZSKJVmm5r
         KmTQ==
X-Gm-Message-State: APjAAAVUWFMXbJvxuXglbPRwmSV7549PszTI1R1bw5GlPl6LZi+ZO5Lt
        2lYDpae6KRTqYjIKORqyX1TGqQ==
X-Google-Smtp-Source: APXvYqzbA7SPteuQxvyGj163oQuyEF7+9MIsEAkEDX03l3XEOiUpGGjjowZZgLGZpdUe+hoEo4I/xQ==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr6100928wrt.210.1552755769978;
        Sat, 16 Mar 2019 10:02:49 -0700 (PDT)
Received: from boomer.baylibre.com (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id d10sm14038501wrh.83.2019.03.16.10.02.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 10:02:49 -0700 (PDT)
Message-ID: <13432d537f671c8065693b7e53348f812e8bbc04.camel@baylibre.com>
Subject: Re: [PATCH net-next 2/3] net: phy: add amlogic g12a mdio mux support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Sat, 16 Mar 2019 18:02:45 +0100
In-Reply-To: <20190316025448.GD29548@lunn.ch>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
         <20190314140135.19184-3-jbrunet@baylibre.com>
         <20190316025448.GD29548@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-16 at 03:54 +0100, Andrew Lunn wrote:
> On Thu, Mar 14, 2019 at 03:01:34PM +0100, Jerome Brunet wrote:
> > > +static int _g12a_enable_internal_mdio(struct g12a_mdio_mux *priv)
> 
> You would generally use the _ prefix when you have a locked and an
> unlocked version. I don't see anything like this here. So please drop
> the _ .
> 

will do

> Nice to see the generic clock framework being used. I just wonder if
> this is the correct place to have this clock code. Can it be made part
> of the SoC clock code?

the PLL is local to this particular device.

In 'Soc clock code' (driver/clk/meson in this case) we usually put clock
controllers. Those controllers feeds the different devices of the SoC but we
tends some more clock elements in the consumer device

Usually, it is just a few mux, dividers and gates (like in
drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c) but in this case, we have
a PLL. IMO, it belongs here. Do you see a problem with this ?

Jerome

> 
>     Andrew


