Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B489C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D730D206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fugdT4e3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfDDQfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:35:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34973 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:35:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id u21so2300586lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZahOLCtnRUM/rJE2XZcCtlHO18auI/np1DEkNkySzNU=;
        b=fugdT4e3CvBSOxu5/YfZUkYaeDjNh9+FQc1Q6Emh9LLiieXHPklC1J1w3zpi67Q+W2
         QG3LPu21hYJ7hftP6NfKLvip4gsOuzK5c4/9Y+2d7lb16INUzYlHbV/KV+6EXu5yitAb
         rXwlC5HUkqpRYd6irP+j9fNOsfks+1RGCmy3JzUKaL8la7XKFbhPTqKGTdbQ1ic64HFP
         IXM3C5M+h+JeSF0bdUmzIFqqiLhvIXwu9SpjRz3jyXIIymtDHnFTArF48drS4JqhRVHu
         HeSxR5Vjwy+msvNoytQBJuMN1yjIJHvSlHAR0c9tNuBo9eboPEgvv0AzIQDJwNOz8WrV
         m5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZahOLCtnRUM/rJE2XZcCtlHO18auI/np1DEkNkySzNU=;
        b=EroNaXK6cfyavePuucMBXTM1RURzY/Ww6fveFK9CeRng13bDGUp3/7AkelEMnlqYEe
         oTI1PQcIU4ew7FJO4qIzwR8Gbu4D8uieGLf+J+pYW1ITiPXyUgYVH1iDkCbiXOPivUlT
         7MJNqWBEDTrzbOFymGWM68/AulXRnKR/dUmKkwIKqyhgG65cWTx4MWb1fKpHyL5Ou95D
         66bgWZo1WCZ1ulwocQAjE+hA9DhkJiCzSP6jk03EsZx/PN+J4aUrY8Ei8Uz3tal/xYnn
         Br/tV/ZgBeufezJB4SLjXvdfD6QPcmupCgAQc+Dk3nHWlcPm038H30kw8uWuR8Vg++6C
         SsTw==
X-Gm-Message-State: APjAAAVKfjiUxGlAfP9AmRoQez6JtMEUCCC6ftWXf+ttkfTBgbjU7fSP
        GJW9yqEAPNdOgiSK5MCLgnJ/11fCHrC5x3C4yzNsFw==
X-Google-Smtp-Source: APXvYqyjKtOvNcmGc7HR5b9ygo6gcFyLXV4tWsC+Lf0el1ky2PNSnWI4AI3xWUzK1JYp4UTAyaoHv/1xFyYvE2grRHI=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr3970632lfk.138.1554395739090;
 Thu, 04 Apr 2019 09:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com> <1554257354-7440-6-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1554257354-7440-6-git-send-email-chunfeng.yun@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 23:35:27 +0700
Message-ID: <CACRpkdatNdzZ+97pZNBudyPNVtQDLKU_o31MSe=T7kJzWtaWUg@mail.gmail.com>
Subject: Re: [v3 PATCH 5/6] usb: roles: add USB Type-B GPIO connector driver
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:09 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> Due to the requirement of usb-connector.txt binding, the old way
> using extcon to support USB Dual-Role switch is now deprecated
> when use Type-B connector.
> This patch introduces a driver of Type-B connector which typically
> uses an input GPIO to detect USB ID pin, and try to replace the
> function provided by extcon-usb-gpio driver
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
(...)
> +#include <linux/gpio.h>

If you need this include in a consumer, something is wrong. Just delete it,

> +       info->id_gpiod = devm_gpiod_get_from_of_node(
> +                               dev, child, "id-gpios", 0, GPIOD_IN, "idpin");

This is OK if the child does not have any Linux device (struct platform_device
etc) created from it. Is this the case?

Yours,
Linus Walleij
