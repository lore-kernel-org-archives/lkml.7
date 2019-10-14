Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5539AECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D16D21835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571060452;
	bh=R2o6W0/0TblgmHzx3gM9A0NpSoKcJqRz6eDlfXz6XN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yf36qYH8C+OB1xBmKhigHpVOKDTmQmsuqpqVQwgMx3Ew2GastvCerMwByFmknzFjD
	 efnAHDF0x0WyiYw7Kz5fJZ5PEcYP0r1g46VOSbj1O5mztY1U3qhjYk5hVQRCoBH8Gn
	 cbfdSiw9lR3iiFkkDpDsq/gQxtf0SNsnerFEO/dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfJNNkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfJNNku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:40:50 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F66E21835;
        Mon, 14 Oct 2019 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571060450;
        bh=R2o6W0/0TblgmHzx3gM9A0NpSoKcJqRz6eDlfXz6XN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U2+L9VzboJXV0N3iftjQmcLOkVpTPd5h8a/0GAviicYaukfL5/dLsE4lf7lSH0ACk
         Vv4eA6G7K/0BV90zL5Z+XEIGJo7fPNvZGdrSU3v/Aja4yzQzJCYCa+YZVDD//0Q0qb
         tQUbwRrDRcdblcJEiUnn2SZTwWu3zI8ltJPTG6yc=
Received: by mail-qk1-f171.google.com with SMTP id x4so11974170qkx.5;
        Mon, 14 Oct 2019 06:40:50 -0700 (PDT)
X-Gm-Message-State: APjAAAU6wAFIi4jnw/WgdKxCBemFbs4TOzsdjLJrUKtfZPZ9+3rlgLUK
        Su/yeDfyXX7rHfLb8SRU8LdZyIfk8CLgxVbrhA==
X-Google-Smtp-Source: APXvYqw/XEhT9N8hvT14EapDveukSRwkiTGjVKsI0xDGkASddUPwUJUAUDUmd6r/1mVppKuUWMVz+jQgVxNyuUJCq6I=
X-Received: by 2002:a37:98c1:: with SMTP id a184mr27642670qke.119.1571060449437;
 Mon, 14 Oct 2019 06:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191009024343.30218-1-jckuo@nvidia.com> <20191009024343.30218-4-jckuo@nvidia.com>
 <20191009233900.GA9109@bogus> <20191014131752.GF422231@ulmo>
In-Reply-To: <20191014131752.GF422231@ulmo>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Oct 2019 08:40:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+aKxfAir3skanfqmM+nFFzXPFL4eMa-+pq1kH-90YTbg@mail.gmail.com>
Message-ID: <CAL_Jsq+aKxfAir3skanfqmM+nFFzXPFL4eMa-+pq1kH-90YTbg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: tegra: Add Tegra194 support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     JC Kuo <jckuo@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-tegra@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Nagarjuna Kristam <nkristam@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 8:17 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Oct 09, 2019 at 06:39:00PM -0500, Rob Herring wrote:
> > On Wed, Oct 09, 2019 at 10:43:41AM +0800, JC Kuo wrote:
> > > Extend the bindings to cover the set of features found in Tegra194.
> > > Note that, technically, there are four more supplies connected to the
> > > XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
> > > , but the power sequencing requirements of Tegra194 require these to be
> > > under the control of the PMIC.
> > >
> > > Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it is
> > > possible for some platforms have long signal trace that could not
> > > provide sufficient electrical environment for Gen 2 speed. To deal with
> > > this, a new device node property "nvidia,disable-gen2" was added to
> > > Tegra194 that be used to specifically disable Gen 2 speed for a
> > > particular USB 3.0 port so that the port can be limited to Gen 1 speed
> > > and avoid the instability.
> >
> > I suspect this may be a common issue and we should have a common
> > property. Typically, this kind of property is in the controller though
> > and supports multiple speed limits. See PCI bindings for inspiration.
>
> Given that support for gen 2 speeds is dependent on signal trace length,
> it doesn't really make sense to restrict the whole controller to a given
> speed if only the signal trace for a single port exceeds the limit for
> which gen 2 would work.
>
> Also, the USB PHYs are in a different hardware block than the USB
> controller, so this really is a property of the PHY block, not the USB
> controller.

Okay, but still should be common for USB PHYs IMO.

Rob
