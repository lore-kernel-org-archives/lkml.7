Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA86C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED7F222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEbnVhm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfKSOs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:48:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43238 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKSOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:48:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so23626602ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byAFlXzzH8jPBQ/aAVNrm3vOvpWN1xVTx4/MeZUVxQY=;
        b=yEbnVhm3gtJp5uGUSL7Pok3vTzWxNUWEt1wdLYeOpm9jbdCBolEwskTVQ5PPDzUlh5
         aasWp3wAeGWK7XJ7cTRBQEJmRMZF4DXusWa+M/9ixNWaB0xYJHE1+6XNAUcksjyT8/AY
         bVsChNiPEolUgUcff17R6SZYq72sKm00riC8Rvd02w9Ihz5auKvSUFdJfW0mEc51weHj
         4i4Mm+CCIg0kl4HPX2swUJOd4+Fj5InmXm+KjvmXCTl60j/d+VgpY/bnKkbsSw9mlopQ
         LtYKgQfjNOS+Q4ycfuSJGIVlUp3c+E0sJppMRHweG5oK4v+M/reknYklyUJDp4bE5/NO
         KwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byAFlXzzH8jPBQ/aAVNrm3vOvpWN1xVTx4/MeZUVxQY=;
        b=KrCQ23SCmiSnc60NuVW3U51Xui14kS41vyxw+hgMiKjcPQdZik5Fr5E301RzQdqQXA
         CqxDTZkpEDynj18MpZYB28xwkTa06BfSdW0/EC1O9WT3IUnE8y8j46HxU7a1P89ME7uE
         ouS3g1cy6tqETWR1YCKnVE6zLLCPBpdCdB/rf/X8K9nwT+rh2J4/TX7YvB5vhgLwtIw0
         +iXb9/oU67/Ips/2LRoMaVj8Efamg5oxJ3ww/WdUmPxku/7xpJF4myZvPltKyfSlJ46q
         QtudBdqNPno4cTzm+fXZ6A0+VxwA+7fYSoeS6GnQjKdovFjKQuGciHHxARbrBriNBIEb
         JI9w==
X-Gm-Message-State: APjAAAWDKnPBCscszt3gpVey9NuSIml2UVivcoX0f8eyx1iEqcQiKrBa
        HBNZSZubc5y9DCLEza+x1v80Tp+i7uh2LdowuttRPQ==
X-Google-Smtp-Source: APXvYqypBpdcDjYi+awRNbMnaJ0xM8pEhAZMyB5wBSCbVU5PNhff35CN/EVhx1NFDxhNSxkHQUg4ODsr5mR56jda/Ns=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr4247059lji.191.1574174905582;
 Tue, 19 Nov 2019 06:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-1-robh@kernel.org>
In-Reply-To: <20191116005240.15722-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Nov 2019 15:48:12 +0100
Message-ID: <CACRpkdbiBAU451Tt1NqTGhemg800CH-sZQ7YMZ-RR18rzjv6fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: Convert Arm Versatile binding to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 1:52 AM Rob Herring <robh@kernel.org> wrote:

> Convert the Arm Versatile PCI host binding to a DT schema.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for doing this.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
