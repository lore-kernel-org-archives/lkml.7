Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9817FC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA822086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEL9oCZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfF0LSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:18:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38107 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0LSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:18:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so1934512ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8n9+wAZmn5Fd4Bzu+75sf62mEboo0TEMxpHy4S/JDDc=;
        b=cEL9oCZ+zomWJ2LmSGc4fuxflwhDPejxyVo6c+Rrs/G5ajtyDASQo492gEPQbHBHeC
         kq2jja8VgsqeyP+QTo5k9C1iud716f33VVhYiaF0S1ifrCTPqGBA3agxt3h4qp8PogBb
         HAjqSFBfrIo3Brf1SoGU3Lrycq3Z/djnv+/ohRmtMo8JSvOptyWZ4wR2DbecRgcyamsL
         sAkedb2FQ4o9w3DtYSfbMDvQNMVvQ36osCybYA/9i+32Df7OcVRSOfvO1IubOE+6SGOy
         pCkSz7JgrJFkWpR8mCBCB7y10iOSH5pbaz+CXHodmK0K3BaNNWlRFQbn954OwIf5nzV0
         hYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8n9+wAZmn5Fd4Bzu+75sf62mEboo0TEMxpHy4S/JDDc=;
        b=BhDCVuaea6Ru1FsIbuc/JJhk3Vlri9vbYmY/GH+bpRJJ6tdL7gFQa2lU4UVk92J11n
         98B1j2vP+IOJiQcV2q6HJyHspx7/kcqUc2eATRoFrdPpYy1YQrwcjjh1bu4pIAypGZu8
         8fVgJllf+H2Krt+YUVCbbEnX0yDJq/4/3oRl0/UOIPrsVpO1QUD1ZV2c80WOLDqra5nW
         /kR+OHkppkTN4rcUX0eWjKcO/6PKkZylHTm3YdZIYZBdoJS0WuUXB9SAotwflOIbrEgw
         weu/hXLVekjn9XL0bNKgfZoMmdUytDemTQCmg1Ijt0QEEo1hdQlAHTPtqOnwBV2mbBei
         y41g==
X-Gm-Message-State: APjAAAXEoH7rO4D3u3GVnBji/K3IFHmWKpzl/N9oKM6bsT4mNqbAKjnc
        31OD/a0R6L0Fo6wi54oeMa803ZeeC+5mIc6ZIWwvYS1x6uo=
X-Google-Smtp-Source: APXvYqyJgd2+Ftd/iJyvgwExAYZa4Qg2yTKy4cVImG+ErCp4ffuDePBsvOgPaNQqma8bvu1LdZ28/ackt3s9WUPQPiw=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr2275133ljs.54.1561634312954;
 Thu, 27 Jun 2019 04:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190625163434.13620-1-brgl@bgdev.pl> <20190625163434.13620-9-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-9-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Jun 2019 12:18:21 +0100
Message-ID: <CACRpkdanZPmKrRwY9nvEGx=BzoVFxzU7ENgvoOzH+0u=-YTC0A@mail.gmail.com>
Subject: Re: [PATCH 08/12] ARM: davinci: da850-evm: switch to using a fixed
 regulator for lcdc
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 5:35 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Now that the da8xx fbdev driver supports power control with an actual
> regulator, switch to using a fixed power supply for da850-evm.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
