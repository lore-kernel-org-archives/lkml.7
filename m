Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44204C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179C2206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CruhKYJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfIKNsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:48:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32873 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfIKNsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:48:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id d10so16512732lfi.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2FkzxTJQZdA1aRgr3g7IfWgwqRJ3678xnPBx6m4Fms=;
        b=CruhKYJ8uhTQJdaRfo2tyzYvg9E6mmNU5ANaIq7eKbkALix6+pkrNYYb1t3wDveFEB
         7lc7oEHFw+3quiJbkIMPHjxdfP+5NMe5SIouivEfceOJali8i759pEUADxaZrIH0RDh9
         PWzvmsrz2Zbaohm3XHRPoRPP6GboKe4XAB0Ipqq32wcAZae7kjrolvThM3ssdlJIjSGk
         CuZprMrpqDPpOtirA3qmQSmWA2KsVTt4QHIH5X9hW25QmI1PFj1bVBDDAcspjg8csjsj
         I7/FmmPZscKqLnfldovfwi22iVbGPTejdTnukUMmzIJiys02XHfOT2ufgycq4yvtJdXo
         +OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2FkzxTJQZdA1aRgr3g7IfWgwqRJ3678xnPBx6m4Fms=;
        b=j1hdKs2zARuIStrzC910YGD/2JsAf9OWTOvyw+Q19X8RxjsXqkndAA7QN9bRfk5k6i
         w/klMITyzo19EvvbbT33CCiR5yE2xNsUXM+uINIr0EvldOOKLli5yGfAHcSu2i95ygca
         h8kHTuX2/+OciFzvCGgu8iOzDTtuZFYXrryu6iNlUNq2CcllenEy/h5f9Rq0rPq7MzFb
         j+WRd7ZGeLdlRyQE4ayq8Q5e2+E6Wu4jS3zXJNw/NJJe4u/4UJ2HU/ExlbNt66BXuGFj
         U5/UJsrx1zSWGkeQ1rqioaafWYVI5ddknV8KUp1/G3bgQuk3ZYUkVEBl96DboM615ALl
         QZbg==
X-Gm-Message-State: APjAAAVF0ib05Ov4KNWD5azBkcEeHx2EDi8sEJ1kWSB1PQXX8HLTUdCz
        IP6P7o0jXrdjIfw7stN65D6f1o1ILpLGDUA5oORWEA==
X-Google-Smtp-Source: APXvYqxx39JIRa1vOCzPEEklvsJZB8Fu3qWvJg8QQa1U8FjndIfq7kjWGZ3O2VEZhadsF1jneYjTpoIdzWzLSyG3Bfk=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr24617653lfp.61.1568209691759;
 Wed, 11 Sep 2019 06:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190906084539.21838-1-geert+renesas@glider.be> <20190906084539.21838-5-geert+renesas@glider.be>
In-Reply-To: <20190906084539.21838-5-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 14:48:00 +0100
Message-ID: <CACRpkdan2XJZBCJHykhEQXipNK0x5F9ssg3TJPZKrwTGsDzkSA@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpio: devres: Switch to EXPORT_SYMBOL_GPL()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 9:45 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Change all exported symbols for managed GPIO functions from
> EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL(), like is used for their
> non-managed counterparts.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
