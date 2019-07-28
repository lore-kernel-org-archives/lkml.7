Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86269C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8AC2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tAZwniCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfG1Wx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:53:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39782 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfG1Wx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:53:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so40665720lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=293HgNYyed41RovpEOe3GRTdf8e582HYxtgx4LeaxX8=;
        b=tAZwniCR0CPqi/ult8quwOe+LiEPOnK1pWoH/p5x/mp3iQzLmMmSrUg7fMjQ7j3abc
         PeCYmgFFjQhbJMuMRIF6KWG3Y5GWnVCaGcercOYI//Rkt4MMZ9VP4wUURUMSWFoHyJCW
         IEKUirZ1GtcscdHq8zp422EJAcMe87w4vkWfQ+iuFLk6UZOGinDfdBSQAoh7WUSQUmNI
         Sl9dm4D/tOBaEA2nSHG2wOllxE7ohK2FMv/LTTseUeesqYxiNAZafvWIZWQPpO0zRRJ9
         isxZ/0baSUzg1L4ny3bXBnp1AsnU1eOHnMvU/MTgGsUhO5t/DwyLtcMBqVE6td/QHqT7
         yyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=293HgNYyed41RovpEOe3GRTdf8e582HYxtgx4LeaxX8=;
        b=DSJ191n8PbgLS3axu8ex/Fegaynvv4nnHCnrYeWfrJ7ftdg2stfXwVxl3MqZancL5/
         qt6LgpRU+vK9l8geQkPjxHa6NOojdkykOP+IEHqsKvh4orNqOm3JXQY7t6rj/CVHR7WJ
         ON9+vrwodxmF6b6nwbPMkMrnnNnYc3dTsaH8FsjJOOfO1KKEYG5ts5BLk+LTqAAq8VRU
         lc+JNW9QMB418+uE99Y8Y+ZLdAxLgT8uRTvechrh3WpCyB+NhKKCzHQA76jGYu9x0JkI
         85489HK0eEBh1aOKxmSlbMDN4M9wg2efK9cg2wI8eF+K/i/S2yJRZVCNwEHsXXsCt8ne
         IPeg==
X-Gm-Message-State: APjAAAUQC/1RWGf39yU+ZieiCpGkEQBFNc2D//+aJ3UHmDPWcV8HvEiL
        9W7ML8py5cntZ9hpHLAs4xyBrqYxtC3yxPNzHu4gEw==
X-Google-Smtp-Source: APXvYqyRtXjryP5sP5m8Z9yg9JFeb+N25+DCvbf/LanaCCkR4NFm7RX6WHaYn71J41in1OzN5ZtYeqLAwNo3WAGVnD0=
X-Received: by 2002:a19:7616:: with SMTP id c22mr51039500lff.115.1564354436188;
 Sun, 28 Jul 2019 15:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190724080155.12209-1-andrew@aj.id.au>
In-Reply-To: <20190724080155.12209-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:53:45 +0200
Message-ID: <CACRpkdaJTB-=DODtj-u6bOkmy7bQ8eXoYyTqv4xK9L+cV4T11Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed-g5: Delay acquisition of regmaps
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:02 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> While sorting out some devicetree issues I found that the pinctrl driver
> was failing to acquire its GFX regmap even though the phandle was
> present in the devicetree:
>
>     [    0.124190] aspeed-g5-pinctrl 1e6e2000.syscon:pinctrl: No GFX phandle found, some mux configurations may fail
>
> Without access to the GFX regmap we fail to configure the mux for the
> VPO function:
>
>     [    1.548866] pinctrl core: add 1 pinctrl maps
>     [    1.549826] aspeed-g5-pinctrl 1e6e2000.syscon:pinctrl: found group selector 164 for VPO
>     [    1.550638] aspeed-g5-pinctrl 1e6e2000.syscon:pinctrl: request pin 144 (V20) for 1e6e6000.display
>     [    1.551346] aspeed-g5-pinctrl 1e6e2000.syscon:pinctrl: request pin 145 (U19) for 1e6e6000.display
>     ...
>     [    1.562057] aspeed-g5-pinctrl 1e6e2000.syscon:pinctrl: request pin 218 (T22) for 1e6e6000.display
>     [    1.562541] aspeed-g5-pinctrl 1e6e2000.syscon:pinctrl: request pin 219 (R20) for 1e6e6000.display
>     [    1.563113] Muxing pin 144 for VPO
>     [    1.563456] Want SCU8C[0x00000001]=0x1, got 0x0 from 0x00000000
>     [    1.564624] aspeed_gfx 1e6e6000.display: Error applying setting, reverse things back
>
> This turned out to be a simple problem of timing: The ASPEED pinctrl
> driver is probed during arch_initcall(), while GFX is processed much
> later. As such the GFX syscon is not yet registered during the pinctrl
> probe() and we get an -EPROBE_DEFER when we try to look it up, however
> we must not defer probing the pinctrl driver for the inability to mux
> some GFX-related functions.
>
> Switch to lazily grabbing the regmaps when they're first required by the
> mux configuration. This generates a bit of noise in the patch as we have
> to drop the `const` qualifier on arguments for several function
> prototypes, but has the benefit of working.
>
> I've smoke tested this for the ast2500-evb under qemu with a dummy
> graphics device. We now succeed in our attempts to configure the SoC's
> VPO pinmux function.
>
> Fixes: 7d29ed88acbb ("pinctrl: aspeed: Read and write bits in LPC and GFX controllers")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied for fixes. Good rootcausing!

Yours,
Linus Walleij
