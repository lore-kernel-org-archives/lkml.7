Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FE4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F020868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/c1f5tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfFGVTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:19:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35121 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbfFGVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:19:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id h11so2946349ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uwQvvBLZhDAl9yhIggJq/EJTAtf+ICqBP+94QmKvpM=;
        b=N/c1f5tuWKYL8TC+mpD5tnEP7gezj/Sv0CKNXvK+vVV9p3HMyq0wWcteem8zBam5DR
         2XbGICxpKnalTKAESEL7c+epE+t4pCo88A27u4LOFET0um8g3iWYnRb4Z/5L8rkIylPi
         2jcYbG4YVFXcQkQ4q3ja1Cq9gYsYE5YNTR38P0gQDlZ16R2rHS0QdwGkOhpUJwIsJ5Am
         tWG0ZA9d55ys6+uAgGiJT/e0pgaq+cFehEqRSjDogyfw7AiX+d1jGhDPOni65wlYf/es
         rB3OsOg+4YpCsJSh06Xw88BD/TiZfHR4V2FBbVKphXXzjJXKekeEuRCKgDzPi/TxNalg
         cOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uwQvvBLZhDAl9yhIggJq/EJTAtf+ICqBP+94QmKvpM=;
        b=rsVZA+RvQcLbLf20SjWhGqsP7u/ofZlFU2BqiS/AJUu9Y038KyTq9sxqr4aWh1/ZHX
         s2Kll7Ey2OpcG9HulDOC+M6BwZ8nBuKZwjSmgqSIEKOLH1ik5BHsEx9uhTfJAsiNMCuf
         5i2o7obW8hr9O1cB2Ft4S5vBvZBSoVSZWZmaH1XZGPgnikXjP4JcGn1OVMwSoPr2Ntcx
         J3pHwhGEx0jFJQAfy6P4lWNbtsigZsfihQRE3FSbx5OQQmdhTHUnbZcaoUzuTLgZ+0Lb
         UZy/voiHd1DRq/gfceMDOUq4+m0iohTV4WTWMQOnmU+kjn4kbNWx/pK6wGLuH/ZAUDSm
         eCsA==
X-Gm-Message-State: APjAAAXqzWgmWkp5QemCH5W7xTeUE0Cpotgxy7VJhNbeuOGj77ZwxA0F
        CBkmld8Wet5RlAca5B5S5PCyDEc11hNDAfLzinEA+A==
X-Google-Smtp-Source: APXvYqxoSrFtpdn+Y/8JUdQf+IzKlqg5LfxsLNBpOURN47jOXNKje3csy/VgjGKZFSN/pgipJ/qQdxmih3J6j1aUAJs=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr5296121ljj.113.1559942347590;
 Fri, 07 Jun 2019 14:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190603073421.10314-1-manivannan.sadhasivam@linaro.org> <20190603073421.10314-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190603073421.10314-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 23:18:59 +0200
Message-ID: <CACRpkdY9j+4PGGyMC-bCKuhP3Cg6xj4mFBt1VuSOi_14JcphPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: Add drive strength support for BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        alec.lin@bitmain.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 9:35 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add drive strength support for Bitmain BM1880 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied, no point in holding this back about nitpicking.

Follow up if you want to change the below:

> +static int bm1880_pinconf_drv_set(unsigned int mA, u32 width,
> +                                 u32 *regval, u32 bit_offset)
> +{
> +       u32 _regval;
> +
> +       _regval = *regval;

(... lots of fun with _reqval ...)

> +       *regval = _regval;
> +
> +       return 0;

I would avoid using any _names and __names because of ambiguity
(no clear semantic meaning) I would just call the variable in the
function *regp and the _regval just "reg" but it's just me.

Yours,
Linus Walleij
