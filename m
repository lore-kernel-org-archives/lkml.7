Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9365FC32759
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B922064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/3iJHmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfHOIRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:17:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41932 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfHOIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:17:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so1110886lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hw7jSAIgwN+rABLfqVTMGBvkTFu0H8DfDB1Vzehui0E=;
        b=R/3iJHmXmu4t2d6jYnZwXJFu7xRlQdiL0AFbNMTP+brJ+S84E6ruCuGVEBHQti/gRa
         38IeRutQH5E/LECRnqD33FqoSANwovOb/qZv0fv+uD6lZPVvKAIJnzwnLhqnbWNalp04
         +b0bDrWP8WZJ3EuCIB2Oz/uoLFeRv+Ib/cLyqBIbO9EJiksmb7SWopg3EKVlK+X4FVYr
         V/Y4E3ctoixt9AZibQ30MYyLa1t8aSkQ+pJ9Gg69+XCyeccigxKZ8/JNYwY3HhgxcJHz
         ZMkoV9yd2MoGlIfF+OX7OcmShgcxNw2DqDwRPCskd1Mxe7jWF/6AKEJbgip4dylfABTj
         QngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hw7jSAIgwN+rABLfqVTMGBvkTFu0H8DfDB1Vzehui0E=;
        b=XxTe49VsLew5JDYAIXAVYSNBCuVr3atb5faCG/eeMpKjfXJl+97CMvUfuCn2WjsUr5
         9lqlheaJRRxs8ENjnFxd3p9hazetimSJwymQY3rMVGQaTnF63Hlj+BXsSZJXBiY6yqNY
         2ZZKCSiPhX3wqBVr3REaXdlCsyyzR/Age9Uch64QIOwZzj7767dLcycJ5xbczI0l4ExE
         eyAeZ0ZPbic6LqkvIFZ0TyypE4cXbV8mfHYdYq9N2yJ+jljIoTqg3qCeaJ6GS09nMbDe
         aai/v/V6nxhBklyK9F7ftCgN7r0iC+v8baWUq2gghS/qmnndL3+fozoY49b/ZoVuxX/c
         O2Zg==
X-Gm-Message-State: APjAAAV1I8hWQgFUeA6TezY9Gv/8tmj0+ZjXY6YeDILxNRtOZRKVOJf4
        E4Hq+us3LdYrmyj8rAz3Cb20kmYF0cF+w1ouAGHu9g==
X-Google-Smtp-Source: APXvYqxPxwQsBMfk/OX+yJdpAw36qGQSyoTJ+sTX7VpaAD6F51EWmcwNavIJr21um/O+pXUWt7FUxh9EGojVVK0Hj5o=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr1749758lfy.141.1565857070180;
 Thu, 15 Aug 2019 01:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190815004854.19860-1-masneyb@onstation.org> <20190815004854.19860-2-masneyb@onstation.org>
In-Reply-To: <20190815004854.19860-2-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 10:17:38 +0200
Message-ID: <CACRpkdZxSPutW1QNkYQ-T8cVFQDbVBcVyQM00g_8_i8WiFEMDQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: drm/bridge: analogix-anx78xx: add new variants
To:     Brian Masney <masneyb@onstation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:49 AM Brian Masney <masneyb@onstation.org> wrote:

> Add support for the analogix,anx7808, analogix,anx7812, and
> analogix,anx7818 variants.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
