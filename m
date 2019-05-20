Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E2CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4A21743
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="10gtItmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfETVvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:51:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35288 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETVvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:51:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so803198wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=suG0F0UoWiaM1rg1kA32ZVwY8eEO38Fk254vRSf8mBg=;
        b=10gtItmO4VM4P1eUEBvLxn2dalHadbbCVYyxG+5wqFl6o7xBJEF1GodNxN7/DKFY+e
         EgSUO11pCntSYZVWb3SQeoXYQfyJYrQ1ApRPWeHpSHnshIL663Dwz4id0LJHhH4fLb7k
         FFivLYNEc/QQOHW6HlMix2bSCey96AxYoTFsNUC/ZFzc+Mw0fJfx7ZJmQzxuXdL7MMwK
         0czeVM9YR/LbUd7STCqRasjeuvSDkZvWN36/rr0vrwuZnCmqhRUASStu9xJkdj+T4BMX
         2ciigQmSWhiWZBB9OxTMZwmH/+bAnEpuG7ws2502Y4aXxO9pv/AbbHyr35zAIgfS9OWd
         Il9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=suG0F0UoWiaM1rg1kA32ZVwY8eEO38Fk254vRSf8mBg=;
        b=Hry9BINVEuOh4mW6UwSNLnT/50dc2rT5smZwlODcXO+6/s26rd5FDPhxdjmHrSepiO
         uqTRxzEwKfcNFiJut3T771B+lhc5H9qry+Oe+uE0zUTS10XrAekZETN6ZQ7MEm5J7Qui
         /28HUZfmgrQkn6l0xz/IbfO+GBw565wMB3ec/jehhD91tgU1i5KHPw8aiwONdggH0ffy
         gAamveUwAEakEYs+Pe+2RPBqC0JExjJDr30L6MJ96jU0pRa3v46xmM13q84yNrWcnBQV
         VIXtT+8D/8hOikV3ojnbAPqksS5vAEAgslnUIpKQrE6pDQUUWp0IoXuhnPwpNodqCAjC
         orLA==
X-Gm-Message-State: APjAAAU8CjB3mf995jodxJgAXtt1G+gbK1mbF1DQrq8J0qenA4wpwF/l
        LvOZvvf0lHwSio/yVTMu7D3lvw==
X-Google-Smtp-Source: APXvYqzyO1M/CnCLWf6cAnnORJuCPlXz906OZjZZljzCcjQtkTxx24tsTI99NINeG4zlq2iYc88zJQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr832063wmb.110.1558389071947;
        Mon, 20 May 2019 14:51:11 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id m13sm18131299wrs.87.2019.05.20.14.51.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:51:11 -0700 (PDT)
Message-ID: <97cde329c44eade402deb517211a15fd70103f01.camel@baylibre.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: meson: g12a: add mdio multiplexer
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Date:   Mon, 20 May 2019 23:51:09 +0200
In-Reply-To: <20190520190533.GF22024@lunn.ch>
References: <20190520131401.11804-1-jbrunet@baylibre.com>
         <20190520131401.11804-4-jbrunet@baylibre.com>
         <CAFBinCA_XE86eqCMpEFc3xMZDH8J7wVQPRj7bFZyqDxQx-w-qw@mail.gmail.com>
         <20190520190533.GF22024@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-20 at 21:05 +0200, Andrew Lunn wrote:
> > > +                               int_mdio: mdio@1 {
> > > +                                       reg = <1>;
> > > +                                       #address-cells = <1>;
> > > +                                       #size-cells = <0>;
> > > +
> > > +                                       internal_ephy: ethernet_phy@8 {
> > > +                                               compatible = "ethernet-phy-id0180.3301",
> > > +                                                            "ethernet-phy-ieee802.3-c22";
> > Based on your comment on v1 of this patch [0] the Ethernet PHY ID is
> > defined by this "mdio-multiplexer" (write arbitrary value to a
> > register then that's the PHY ID which will show up on the bus)
> > I'm fine with explicitly listing the ID which the PHY driver binds to
> > because I don't know a better way.

... 

> 
> Does reading the ID registers give the correct ID, once you have poked
> registers in the mdio-multiplexer? If so, you don't need this
> compatible string.

Hi Andrew,

In 5.1 the mdio-mux set a wrong simply because I got it wrong. I pushed a
fix for that, and maybe it has already hit mainline.

As I pointed to Martin on v1, this situation just shows that this setting is
weaker than the usual phy setup.

I do understand why we don't want to put the PHY id in DT. If the PHY fitted on
the board changes, we want to pick it up. This particular phy is embedded in
SoC, we know it won't change for this SoC, whatever the mdio-mux sets.

So yes it should (soon) work as usual, setting this id is not strictly
necessary but it nicely reflect that this particular phy is integrated in
the SoC and we know which driver to use. 

So, if this is ok with you, I'd prefer to keep this particular id around.

> 
> If the read is giving the wrong ID, then yes, you do want this. But
> then please add a comment in the DT blob. This is very unusual, so
> should have some explanation why it is needed.

Sure, can add a comment. I suggest to do it in follow-up. At least it keeps
things aligned between the gxl, which has been like this for quite a while now,
and g12a.


> 
> Thanks
> 	Andrew


