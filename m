Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C275C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1F52087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="scmnTBde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfCKVTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:19:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45211 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfCKVTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:19:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id t82so293402oie.12;
        Mon, 11 Mar 2019 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vl+etrAUgCpe9fsjHd06euM2vV1upm3SvdC8UB6mEEg=;
        b=scmnTBdeU1WLv8FGWntVQlu71VYSiwb4WArqky8UJw158K+g1Sx8hThMfpbl7Q72CT
         3ur6NDyCChD8KP0nBAhniV/Ch1hgnjEvIbLXk8a5Q7JOMXXKS47ZwiWwSbXFMG2ForNA
         ry1QupgOMUBCcy2bzfw34YDPdfMNRN/1QkK2zbvtT0mLimwje9dX4XFjXFKTSLaIvxma
         QuaYTiYElUWcl2cXVKXM3yryobx937YrBmgwWHLDlvK3LFjloQFQ2fFtoRm6XeBBu8fk
         WKN578XSGV8T6hu0dwRXWEYSQSZfMllwjJmfCIScITddCVDkeEIErBzUULWZI4RbkkNv
         KPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vl+etrAUgCpe9fsjHd06euM2vV1upm3SvdC8UB6mEEg=;
        b=rZt0ZjPW9dCML5md+2pJgmK++ZAdsNU4fJ5rJ7Zc58QLqnW2sneytY57mDZlfjmge9
         C+2AS/jc30b150JQjKryOYqUgNpiV3fkovgFo42QHRTOXM7L9UeW3UqLicHkQ1YUFnVZ
         kMIX8mXRpB+MjiwpLm9fnjYncQG6kkNs5xOlnm7Yq4QF9pbLa5rbxS7/nKAl3b5tJLQw
         tNEp+qvpMm2igxXaJprPjn3W0J7jE2IaI2XBKnOPoxwucSBAILnLwXI4hbY7XMFEsvjZ
         0FaeGiGev7qTg4jTDwxo5XOEjrSPDQDvIkjdQG6AVvz0HTc5D3mZXEl7SlXf7Hofwc0x
         qx3Q==
X-Gm-Message-State: APjAAAXnGM4H6rRh+XoU9e9Y5UJhP5wVSQx4QtAlJazPvYkgXFYLOTVE
        8fkzlISlVH4iv+av9DGEFmnJ3+MIvDG9ESOMTx4=
X-Google-Smtp-Source: APXvYqyHe9QPMFYdAufSMRbPPGqAb+8CcQWIIfPWsC828Moci52N5yUQIeMvh5JngJp06jz3riVakXooHaVEKj82QiE=
X-Received: by 2002:aca:c286:: with SMTP id s128mr177191oif.39.1552339151283;
 Mon, 11 Mar 2019 14:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190304103846.2060-1-narmstrong@baylibre.com>
 <20190304103846.2060-9-narmstrong@baylibre.com> <1551924176.2210.104.camel@mhfsdcap03>
 <6eaff413-d2c7-125a-f165-e4226c7a153e@baylibre.com>
In-Reply-To: <6eaff413-d2c7-125a-f165-e4226c7a153e@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 11 Mar 2019 22:19:00 +0100
Message-ID: <CAFBinCAUMNBeTABNeyOiYu9Gu8zWWmG3dBNJwFpop3QNp6ZG0g@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, hminas@synopsys.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:46 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> >> +    /* Setup role switcher */
> >> +    priv->switch_desc.usb2_port = dwc3_meson_g12_find_child(dev,
> >> +                                                            "snps,dwc3");
> >> +    priv->switch_desc.udc = dwc3_meson_g12_find_child(dev, "snps,dwc2");
> >> +    priv->switch_desc.allow_userspace_control = true;
> >> +    priv->switch_desc.set = dwc3_meson_g12a_role_set;
> >> +    priv->switch_desc.get = dwc3_meson_g12a_role_get;
> > to me, use a local variable for switch_desc
>
> I'm never fan of changing a local global variable for a driver instance,
> is it strictly required ?
usb_role_switch_register (which is called a few lines below this)
copies all data from "struct usb_role_switch_desc" to a newly
allocated "struct usb_role_switch"
in other words: you could make it a stack-variable

personally I have no preference so I leave the decision up to you


Regards
Martin
