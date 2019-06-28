Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437EFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7A121670
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561736790;
	bh=ogM5DFuL0hpNwB08hnvvzh1goOaGyhrCIOR73aDgEQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RP/MKh1ZBmVdxgwihbgL3QMGG04wG3ZGf4an/ZFE61vWKb7mh+XQo5dGkRsdluzSI
	 EArBpIvI28X1DasSTIyoEhhHmzy9fZsh0ULDRW+rJIoy9+3LIgW35rsrCgt2ZPSZW/
	 yoRDYLRWMAh1Tvn9YH75smBuPUUGQI0NMR7ZGbik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF1Pq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfF1Pq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:46:28 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F213221670;
        Fri, 28 Jun 2019 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561736787;
        bh=ogM5DFuL0hpNwB08hnvvzh1goOaGyhrCIOR73aDgEQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NZ28gVG09tUT0i0jwUS2iQsrBsikCeynWpoIZLEW4lJl2MD/4E9HHsekABXJCrsjB
         QXUjawBUTAMvwJWKMqlRIr2pghSl7b+zwS5Vsb02ZIWINFUlAsGJGN8qOYSUqyUcPh
         81BW7HcKlY3bb2S5ugxN7GVkqN+vr3SaAXIiI928=
Received: by mail-qt1-f176.google.com with SMTP id s15so6769461qtk.9;
        Fri, 28 Jun 2019 08:46:26 -0700 (PDT)
X-Gm-Message-State: APjAAAWJAojNcm4gua4Br76vTVnBgxiqN5JEv1fmEXhtoHgLbpsu3nG+
        UyV2KSol+9MH/ry5nkzjcaxYZkmaX1GhFGK3wQ==
X-Google-Smtp-Source: APXvYqyYBF/8wndwALugA2vJeelD3HLa6psVbvGS9oxdpy8J0nCqfRMpO4Ufp2igGgyxsfOpTntYKJCwPnhVM1XNc7s=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr8814969qtc.143.1561736786114;
 Fri, 28 Jun 2019 08:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190628023838.15426-1-andrew@aj.id.au> <20190628023838.15426-4-andrew@aj.id.au>
In-Reply-To: <20190628023838.15426-4-andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Jun 2019 09:46:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKF1H6YtFTG-xFhGztdDpMKBihW732Wx6HMUhCw27vNw@mail.gmail.com>
Message-ID: <CAL_JsqJKF1H6YtFTG-xFhGztdDpMKBihW732Wx6HMUhCw27vNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: pinctrl: aspeed: Convert AST2500
 bindings to json-schema
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 8:39 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Convert ASPEED pinctrl bindings to DT schema format using json-schema.
>
> Cc: Johnny Huang <johnny_huang@aspeedtech.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> In v2:
>
> * Enforce function/group names in bindings
> * Move description above properties
> * Simplify specification of compatible
> * Cleanup license specification
>
>  .../pinctrl/aspeed,ast2500-pinctrl.txt        | 119 ----------------
>  .../pinctrl/aspeed,ast2500-pinctrl.yaml       | 134 ++++++++++++++++++
>  2 files changed, 134 insertions(+), 119 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
