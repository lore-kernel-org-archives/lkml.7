Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5121C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C3D20866
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU5pM3BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfFPXVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:21:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44255 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfFPXVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:21:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so7441380ljc.11;
        Sun, 16 Jun 2019 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXpKt6gWW20yw9T+P1iuF5WONvvDKQOR+kKRgVpbTwg=;
        b=TU5pM3BB/GIQukfbzVMV9fH53Ktg/mugM3gnGasFWtYIF03pcT0Zbg+nKtx2JzXLwu
         77USxRwKw48qyqqdd/OOUXOHfi2MR+wKeFifow4ZErMvlo4RPyR527yRkUmvIjfCCD5M
         oGQwHv8725JoAJXaPBv93jkhiRRwVrPtF5RGI5nXkRC8Eit+BbYkVGqGWbaqWXnIM5vc
         Hn8ejuz4YN4E00Zp74Pe+iFWxjf9sMHqbaPQ2o62QUKv9aVVW96h+TbU9vKZuQJuzVmz
         uBvwG/P/iUnJ2sinKop202IL5bM9vSFsP3e3woKdsMz+LmPFoWv2oRPdJ0XHRh/Qg8li
         fiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXpKt6gWW20yw9T+P1iuF5WONvvDKQOR+kKRgVpbTwg=;
        b=tRRsaV8tOX7wW753246f1CeoFc6d6iLKgBNU1FqW9F1JXzlhjuQ/uZcGD6Bb4aSoot
         xM9OneYVVoNhXob904zniPrwMpHFQKagaHGPW99Maf4mvuVLS9u9gXfIIlCPf2iWlFKa
         hVHlPeCigF+FYyTGvDJEcg8BPfVL5LkK7k30i5kN7DY4iEKH7T7diSjbKmuYEdxCkEjX
         pzxoae8mK0t1eYun1iBDTo51BBh8yn5m3BIktLFn63EGdTcZEZOHM4C/KnwTsZmO7vtc
         ohi956R2nA8y5q3nNqMn1pRybTPauttGLm/HAcM9WavEFBfSBtQU04xGjQHCre/6CQBn
         S/sg==
X-Gm-Message-State: APjAAAXMbsK5ZLRdHOnBrEPQEN5Xr+wN3kYv9C67OwWBlAMFsXMl9l1K
        qvAGBOpEeMtu1iGvQcdn/qpQUuxZgK3GMpSO5aA=
X-Google-Smtp-Source: APXvYqxfTZNXDzQZaA2y9stVc88vFamxGkheySz+gCelCRvNO2IizDWgxf/+T92tJ6JdbZEni1wXZ4Ac/1HNyqmuJ0Q=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr17587606ljs.44.1560727299408;
 Sun, 16 Jun 2019 16:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190614080317.16850-1-andrew.smirnov@gmail.com> <20190614080317.16850-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190614080317.16850-2-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 16 Jun 2019 20:21:48 -0300
Message-ID: <CAOMZO5DNAEGWqG6VTn0KAJ5J5kKy=YurQJZ0FCTDunUADJZ3Pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add support for ZII i.MX7 RMU2 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Fri, Jun 14, 2019 at 5:03 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 407138ebc0d0..8fb4dc1d55e7 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -158,6 +158,7 @@ properties:
>                - fsl,imx7d-sdb             # i.MX7 SabreSD Board
>                - tq,imx7d-mba7             # i.MX7D TQ MBa7 with TQMa7D SoM
>                - zii,imx7d-rpu2            # ZII RPU2 Board
> +              - zii,imx7d-rmu2            # ZII RMU2 Board

Nit: Please keep the entries in alphabetical order.

Other than that:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
