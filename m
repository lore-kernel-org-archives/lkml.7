Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61704C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5602081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdUL7EUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCHGwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:52:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34614 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfCHGwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:52:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so13434346pfn.1;
        Thu, 07 Mar 2019 22:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ya/F34Jwz73llNEQ0TVl8VHqoCJ5jTaRTvAMz69fhs=;
        b=NdUL7EUcIn9e/ZXt3NjSa4be61aOadg/xmtVPdQYxkav1BSvgbMqX6xr3113v3LHvi
         ggSWsfh+VQgeU400JuwTRGM6mmrOT5mj40OLsgzjsGA3HdeNULBTiSo6C514aTaTveIn
         ZA54ABLrurJBQwidADg1ksdtBs0RJRfLGucuMn0AfPq6bGI+gTROEPu9kW2qj3JolwuV
         VD5jET7yqNwY2SF9oWZ2vIOSOWLjChgVq3HWvwr+82yuMJ9D1cz/BgZMwLdSg75llAYH
         1zrLsupgFM1oZOSr6Sf6zIvz4OeB0CuB7jDaEqzBuuWPr0tGXNzvk/jAEry9jq79uqGK
         HGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ya/F34Jwz73llNEQ0TVl8VHqoCJ5jTaRTvAMz69fhs=;
        b=sIPyreHtkzh1GzRJRep7EsfTDd7WpleMTB4cmXhyQLQcAQLvCcXXX0cU3TrTPEqGxi
         LOQisK33ngBThhMyjQr5Lqo7eKY+B3HQvk5nhw2Rwgu8QUBm8ITrbWtgnN2fGcTfeNqE
         q2VY72pM7Um3tdihv/MSFToGZQAxTkO+JecXdp/rmmZo0/oPudA86mtszUQmkYCh16Xs
         +z1ioSSLwYC1U5lKXrUqYzw3DtiudbWtN5DkPg8M3/DOyYeBOywFMj5MtD9X0LPGtzXy
         dk/P3OZjufoN/cYaDhdqKF93g4928n4ZV7yBEbYUsazmOxAsmuh5TufFAnF6W8X4sPwP
         F9+g==
X-Gm-Message-State: APjAAAXN4fucV7sV+AbGl2rFiwqNpUCqJpJVtBC0RiOLp7OZHvZhGzgU
        UWPLFKmHfgtJ8wwhKjZpRB64XVWUgsCoqQnd0kI=
X-Google-Smtp-Source: APXvYqy5TEwWjlj6kPQqsLhELdiheOknvMOhJTv91tJMlgb2GDVMx+WNc3c8S2Br+tiWbs/jJD0DYqvnnjH/mW6Qrnw=
X-Received: by 2002:a63:1c42:: with SMTP id c2mr15176208pgm.265.1552027938295;
 Thu, 07 Mar 2019 22:52:18 -0800 (PST)
MIME-Version: 1.0
References: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com> <1552025622-15582-4-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1552025622-15582-4-git-send-email-chunfeng.yun@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Mar 2019 08:52:06 +0200
Message-ID: <CAHp75VeW+NoaGQCnfMcZSz67V68ykRMO=BG9_U6NFODJ5g=1FA@mail.gmail.com>
Subject: Re: [PATCH 3/5] usb: roles: add API to get usb_role_switch by node
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 8:14 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Add usb_role_switch_get_by_node() to make easier to get
> usb_role_switch by node which register it.
> It's useful when there is not device_connection registered
> between two drivers and only knows the node which register
> usb_role_switch.

> +static int __switch_match_node(struct device *dev, const void *node)
> +{
> +       return dev->parent->of_node == (const struct device_node *)node;
> +}

Hmm... Shouldn't be slightly better to compare fwnode instead?

-- 
With Best Regards,
Andy Shevchenko
