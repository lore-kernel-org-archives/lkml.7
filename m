Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA9C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A032086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIqjqetM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfHEKJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:09:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34402 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfHEKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:09:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so78816296ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xtjYgK/kMd57m6KfrfOB62bKyZiiQD+dYMhD8L2z0Y=;
        b=qIqjqetM/iqya25mvO1vrbiO42qMt9IyCAJYzpv0Wqpo9wqOGNluE4klznlIk2yZfv
         9KNaZg8QzFZY4Q48l5+z4eup/m2cpfChPGFOc5So/f9zrbncbo1LdwCbt/dw/Fjny/Qs
         8hQB3eiqnuhdTMb10EfyqrD3JPS+t1xX8aimYVGXXyk2bZN8P/AXvG0DZYn9hRECbBdM
         KHITvzTv2nInLM5fAiQTjnMtAjqRx7hmRFWsdvHjhN0DX60+eJHy1THDkvhV2DlONPnz
         LBWK4DrWvRSIY9dvL9VTn4DQSlR2B5z6GZrJAw6qQq1nF78r/A95zOz6L6+4rnQ+9gtI
         /3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xtjYgK/kMd57m6KfrfOB62bKyZiiQD+dYMhD8L2z0Y=;
        b=F34m7wOWpRlpK8Defffs5u45zw6LqZn/T3gTAhVtjM5NIjiTKNMZw7pHuVCqJtWHTA
         tKitKSQwyB5ZZSLGwWBKpIFlWCCaVmFrlC8qd5YmFEdv/v2PpnPiptIs5jMQ5ZwVxh/Q
         mApH0TKV4mBuJ6Tow3P0khuRHtd2DSajjlqwi8oQqbcbxu9/RuudR3t2KB8nxB720c0y
         BCH6LLmAW+kDwcBVZI0d6loEemnFlLGwZ/Dw7zkhOInWVz+fev6aA+FvcTEyE8EpmF6b
         7qHMYqW1n9Pcszw3owH7XndAJamxSpT+tSKYZ3QRhXXd/i7TnQCHTmuA4gB9VXIbsE8o
         tHhw==
X-Gm-Message-State: APjAAAXYywytvbkvNoBj7BaTqLD1xhpLg+NqN/yw79iS3GIBY6NMAu+e
        kckZpg9gOfkM3Fihtsh40fk330WCBs1J4Q3FetkvVA==
X-Google-Smtp-Source: APXvYqzw2Nx2CZBhSBfHRJe0EXDJKGkQ1w/cgOlJvHSUKAdSOSviOHbRJqsbQQlq6jDi9G5H9DWZgPS60Bpa9u1KaYw=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr16414381ljs.54.1564999780576;
 Mon, 05 Aug 2019 03:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com> <1563958245-6321-3-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1563958245-6321-3-git-send-email-chunfeng.yun@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:09:29 +0200
Message-ID: <CACRpkdZRgUubUF3qc7S-6zoe_L-dLDy284R3qK93qRTLyYOwbg@mail.gmail.com>
Subject: Re: [PATCH v8 02/11] dt-bindings: connector: add optional properties
 for Type-B
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:51 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
> usb-b-connector
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v8 no changes

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
