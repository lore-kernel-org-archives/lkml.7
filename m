Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73312C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1E2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556284794;
	bh=eQhNh7o6K93astaSV4v12phNB7KIxMx5xHVXdcTrKTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GEZ/8dS3GaTyeuJSrgE5nHgwSAndUcUui6ct/X+pCNbUUAnGi7v7jCNJ/GOb15nUw
	 IjzB6ywDrHvoIfSKlBVFy/cC2vEgjrlrwenGBY7oKCg2RcLhqoUu4x3m3QUVOX6Blo
	 dubJtzEN4ukqnRaisF+Q34TGbYjj+wKxHA3uozEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfDZNTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfDZNTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:19:53 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0465A20B7C;
        Fri, 26 Apr 2019 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556284792;
        bh=eQhNh7o6K93astaSV4v12phNB7KIxMx5xHVXdcTrKTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KrmV5GwD2HeQ3x8B4CLyTijxlaJ/VNU/FRoh0bSztHU0Ot44VsGFpTxIqrUTpjVSr
         rgHzhkx817SmeTU0+dd9tXWAohIDVKPn0m7h3u+cIWrPL+zefExDw+JeotDDkkm0rc
         NSdYmpALqvOnhuiTw4rI/MmLhjxDCctKAdJnacr0=
Received: by mail-qt1-f179.google.com with SMTP id s10so3958811qtc.11;
        Fri, 26 Apr 2019 06:19:51 -0700 (PDT)
X-Gm-Message-State: APjAAAWf9594wDYU/JUiaOlGsqfX4mwoUoOyrOIdUkJvDyg6xHhGMwuW
        i+wrTHmk5P6zfIE/KLPM43Su5MvfuH1QC50cmg==
X-Google-Smtp-Source: APXvYqyEDGc9XxkRrElLvLMqtGPLoQfG80HUApSg7bR+stCPSUrM6ibZOJJxdLiBMwAeNqjBvJnuGJqErr/1NunrnvE=
X-Received: by 2002:ac8:7647:: with SMTP id i7mr35354952qtr.38.1556284791208;
 Fri, 26 Apr 2019 06:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com> <1556261237-13823-2-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1556261237-13823-2-git-send-email-chunfeng.yun@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 26 Apr 2019 08:19:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+2jWJHm3-5BU6NUqFsSN=K15douOyYWeKoKseqhPDysw@mail.gmail.com>
Message-ID: <CAL_Jsq+2jWJHm3-5BU6NUqFsSN=K15douOyYWeKoKseqhPDysw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: connector: add optional properties
 for Type-B
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 1:47 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
> usb-b-connector
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4 no changes
>
> v3 changes:
>  1. add GPIO direction, and use fixed-regulator for GPIO controlled
>     VBUS regulator suggested by Rob;
>
> v2 changes:
>   1. describe more clear for vbus-gpios and vbus-supply suggested by Hans
> ---
>  .../bindings/connector/usb-connector.txt           | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
