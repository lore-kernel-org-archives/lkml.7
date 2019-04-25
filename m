Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B698C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52474217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWZ9pS/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfDYHAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:00:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41972 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfDYHAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:00:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so6687836lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJ/BhGFCh4Gq3dSwXCEf8UirEmnP8yLWItBcfZLgxn0=;
        b=XWZ9pS/TJCZHQjcUAG5kdkY5i4RKHmP6jl+hxR+j+IIy+QysR21aAf8rQ8R2XaXGK6
         U5Phy4PMdYnQlDGwBJV+1naHnvzY8Gj6Tflx+01M3cBAdNdDxJLFEBZ5dQYUOqMQu25k
         db/siE0gykW2SyYKBOUQZ3/swnk83ZoEuGphVmPCumiRr3rK4ivLKJUYfyh5i7fnOxoE
         QSopvkbZbIEj4AFqWDy4dhyejh5I31PtptqbxNay/XPH9MtmpMwsw/lPYbaR8qNFc7bn
         8XDwH10CqS1n99Fh0pqSYMqgqsr7jI9gO6AcL6JKzl29S057TdAHUINem6iYwmLeXoVi
         gc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJ/BhGFCh4Gq3dSwXCEf8UirEmnP8yLWItBcfZLgxn0=;
        b=h5z4x6iFJdsB5kAbG/Nutnd9rDOmlzLEpy5Np7yIy4ghIAXP+rLVeuo6vw/t5rLOXd
         r5u8VMaWV5M93/blbbJLIkBB5m0ajEY51ivaFdYszXqR0g0+fN5RdD7HOiyu03VBgcU9
         7wVssyPb1gjBRLRvxOKL0dICnvGWMPwQYcANe5tG3WMtIVcwkxzBiAr9bmXuGj9/zrSL
         TxPoYkEJIgLfySlDH2YZKjAWZUNDtiahaBxkFPs8MLgnR2YoegE5oqDL4y40N+A0gmxe
         GIOC35q20Amr1V/CV9GW7om97sIHA5g59ql2Ir86SM0vaEf2Rdxvx1/sCLN30ubdZvp7
         VIFQ==
X-Gm-Message-State: APjAAAX1HCN1isx5pCwW/DjotFtpeC4+MDbq7Y2/fwwWtXVTdXk5i7HK
        lNA4PMY78pGX0ZmZlHxngY8V7Tn/RKnARFPQloIgVg==
X-Google-Smtp-Source: APXvYqwKe8R21oAGuobzQhdT71aOXgDNM7eUgtpmQeeFu+9fADyOwVi2Ly3JPIytD5rXIrvdiQ4wDvuLThnliPgkGNw=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr9907996ljd.153.1556175638346;
 Thu, 25 Apr 2019 00:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org> <20190424120224.22660-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190424120224.22660-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Apr 2019 09:00:27 +0200
Message-ID: <CACRpkdYMZFuQ-fOi+-oB0poOvnUkf9=BHRzYgc7eVSJXOXiy3Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: Add BM1880 pinctrl binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 2:03 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add pinctrl binding for Bitmain BM1880 SoC. The SoC is not capable
> of handling pinconf, thereby supporting only pinmux and this limitation
> is documented.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

These are just very standard bindings, so patch applied.

Yours,
Linus Walleij
