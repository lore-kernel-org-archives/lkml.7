Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B11620823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553786405;
	bh=vStTkmXDZzvPLa1emFC4Iqm4E+QhhTJaNiXKs/o/edI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GoOYaBG8H76JPhLqyfokGkzn2SVZ5lZLR09kcR3MimP7WunYoBiT6IxcN3HIt+6Pr
	 G7bmzVELe9dDYRA/EtFq/L2iVHJQbTljy9B/qjFNihyjjMTY4L/B8JO99jxK2jsjbS
	 MewSlAqMD3Mpa4rJssYdBTjCCpy914dDe2F0SWIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfC1PUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:20:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35510 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1PUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:20:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id j132so16077567oib.2;
        Thu, 28 Mar 2019 08:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LIKjgwbWdsNSF3DkBYwypNrXn91U7Cv3w1BIgMAFQGk=;
        b=WdtZuheVfiBhnftIMYOSOGQt83Gvzmz6HLuBfGD1TFXlY1Un/szZz/798a07Bi1/n9
         ZGLPyZweVMLbQpEqzY3pRsufnOkJSBc61xDI3ZeWIyGnP2pkx8r8NKqN7eE40KNXT6py
         kEWMw3ARP/0ui+GL1u+M8WMz2aHbcOc3pKBYXd44T+im2NevLDIuCtQ/rO8/oiE44qwZ
         DeWvunSzFGmKJrphQUik6HP2m9aFWIxZy5uuCWo/NffzwB/54UF1vRGRRHvxngx6wCNf
         AZemJVFYW9/jpwmF/hCRCAlxb07kPN0vhP8622V5XK5YgSzPlfrYue0wFhdsHHgNLEA2
         GSxA==
X-Gm-Message-State: APjAAAVj9KQYFdVUbDF5e5UAGazKTLPOfCCN67ZsiD+J7VTiILaFzc/g
        +L78roRAXkY/93cz4zI2yg==
X-Google-Smtp-Source: APXvYqwdrY9J3KPWAcEtMHIgLYGoe0qkqhNvFQInntCaXx3yoZjmpJ5+yzx/6AJlkxCsZQkwS4Ek8Q==
X-Received: by 2002:aca:33d7:: with SMTP id z206mr362280oiz.51.1553786401977;
        Thu, 28 Mar 2019 08:20:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j18sm9904443otq.68.2019.03.28.08.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:20:01 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:20:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christina Quast <cquast@hanoverdisplays.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix PAD_CTL_DSE_X*
Message-ID: <20190328152000.GA24629@bogus>
References: <20190313142040.26694-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313142040.26694-1-cquast@hanoverdisplays.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 15:20:40 +0100, Christina Quast wrote:
> In the iMX7d datasheet, the PAD_CTL_DSE_X* values are different from
> the documentation.
> 
> Changes since v2:
> * Changed patch title to 'dt-bindings: pinctrl: imx7d:'
> 
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
> ---
>  .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
