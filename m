Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA392084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554818063;
	bh=J7gf1f+1gKKsoy//MU/aBOlh/aYPrM5Cr0FpbuJ2CcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZrkHKgmIUypS6nLjSoY4Rj2+k0JnPSll+NHNJ1W2l6OtSPgVa/5zAf0P8I4wYu8P9
	 TIxkQgqY3b1ycNYRph+E8pjxo/Cwki9gdxXCRFwlSjbYDOlDnadT1KoJvXwNmUwWdc
	 866f8GNembN24PYYD4RsT2OPvVKxYaap8/6lc6X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfDINyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfDINyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:54:21 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD93820880;
        Tue,  9 Apr 2019 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554818060;
        bh=J7gf1f+1gKKsoy//MU/aBOlh/aYPrM5Cr0FpbuJ2CcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PUO5vx9W7qoBPWlzYLnowQevj9bWUuMcisoO25lFLow+XGMXD8vQapBUlIyycE6td
         6raOt9BgjmoWt83ZUoCBNCaBbWTppt1jalcHPfS8G5WO9KIycT1EC2CHn5ZCOD2hb9
         f1YZpYhfWlaY1Hc71l2JVq4dWMQ/3u+tgLR4k3k4=
Received: by mail-qk1-f171.google.com with SMTP id c1so10276186qkk.4;
        Tue, 09 Apr 2019 06:54:20 -0700 (PDT)
X-Gm-Message-State: APjAAAVl97KRO3SdnC/59G4iu/leIxrYKekXyjD9GAM1Kd+TzfanZOVp
        Fa4jnVue5s9QG/OBdcX2vxcR2DvTUb4oHPopSQ==
X-Google-Smtp-Source: APXvYqzteXVhbMeolOkyVb5osFhluJgYQndJcQth+LhSee4WjxC7A3a5e8k3rpE4/vnKuNGUK53IYVF6Mx0MEqncUUw=
X-Received: by 2002:ae9:e313:: with SMTP id v19mr26403652qkf.153.1554818059942;
 Tue, 09 Apr 2019 06:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-1-git-send-email-rjliao@codeaurora.org> <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
 <535c74d4-00b1-eef2-578a-8807f4b9f640@free.fr>
In-Reply-To: <535c74d4-00b1-eef2-578a-8807f4b9f640@free.fr>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Apr 2019 08:54:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJycVn4wXOjXnmmYkm1e8RbVj0nGHNiSxitkixuN4K7sw@mail.gmail.com>
Message-ID: <CAL_JsqJycVn4wXOjXnmmYkm1e8RbVj0nGHNiSxitkixuN4K7sw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: bluetooth: Add device property
 nvm-postfix for QCA6174
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 7:32 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> +robh
>
> On 04/04/2019 11:08, Rocky Liao wrote:
>
> > This patchs patch adds an optional device property nvm-postfix to allow the
> > driver to load customized nvm file based on this property
>
> While text /before/ is indeed called a "prefix", text /after/ is not a "postfix",
> but a "suffix".
>
>
> >  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > index 824c0e2..70cda4b 100644
> > --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > @@ -16,6 +16,7 @@ Optional properties for compatible string qcom,qca6174-bt:
> >
> >   - enable-gpios: gpio specifier used to enable chip
> >   - clocks: clock provided to the controller (SUSCLK_32KHZ)
> > + - nvm-postfix: nvm file postfix to load customized nvm file
>
> The device tree is supposed to describe hardware.
>
> The name of which file to load can hardly be considered part of the HW.
>
> Possible solutions:
> 1) derive the file name from the compatible string
> 2) pass the name as a module parameter
> 3) something else

Or use the 'firmware-name' property to define the full firmware filename.

Rob
