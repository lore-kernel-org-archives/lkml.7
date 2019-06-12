Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D657C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088F820684
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3WDjTm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407268AbfFLHSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:18:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32783 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbfFLHSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:18:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so11242856lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLHfkrcZKTo38F+HaUI6ckV79OZ0o6Qwqt61e1BrVrE=;
        b=T3WDjTm70bMNjTMTCWqVSg7AlbbkPQ8m68HplITNSif9lb4dM1J4+qSqh7Bvp7O3Ww
         Yysk1R0j0bTNnoYt8zCSs1qZ2Mvg/HDYnUQjzbxPpjFkVJ64dq01UEDZ8S/Rt6thbZw1
         5NajMHZbFg4j/a5wyeEch9lfQlmmQ4wly/T8T+D8yAuCtTqPsuadEWmNpYEWD+qI3Ujf
         Qsiq2AHo0pbd9cDZZocdVrxiX+rjbf5XzFWkKficu/3zleLrwS4ImuQ7oGn//+LMWp8f
         mTOFKEPWKMLqcqWoNsoh8P7l1Xaz0bzm+e7F2zYbglE2PY28+hh/H8bTV2RSeAHKygwB
         hNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLHfkrcZKTo38F+HaUI6ckV79OZ0o6Qwqt61e1BrVrE=;
        b=XhnnqrsEMIwAQ5Bq1hNnKUYaX5dmXs8PfykWrRfztTUHkyHs8OlVa2Utt2FW1OTl58
         Ot+DCXL9ZxsfeBFHbuMKTbGTy3weHfLRu274GrCH2tRcabeBsUEttkGRan7CF3zPWRW/
         DXTTXw4XQVKUSwvraCkVY1ye1Um6QifKkbpXwMKrInsJ2iEPp1TEMr9FtOvpQjN4HUhn
         8DHOgtRSo76or6UWX/1AQigrBpLOX1/nUb2/KDu1y0ploNXLIhm+JGZD1tRXMnzSHTkr
         z0YQ4Bp0vlQpC4dXCjiqfUsCRFUowXV8geX2udllg62bbkmUO6cVP/BMiT/MPf3KMkuz
         2qcA==
X-Gm-Message-State: APjAAAX4HrpfbgQOGuleb3hpB5Ck+IxBusVQlwa0Uw/brQZLTEckHtQm
        wRI+VR6jsLnNc32ebCntHbN7ex+rBen1JOju3sLkIw==
X-Google-Smtp-Source: APXvYqzDh4d8Jgxhz1KUU0UefThe5Mfao7GnQlNr1l1ciJMnwpzLb6ZT/NclpErH3pe+BXltkLCsA/57T4H+XLB/VdE=
X-Received: by 2002:a19:7616:: with SMTP id c22mr36520290lff.115.1560323915112;
 Wed, 12 Jun 2019 00:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190610084213.1052-1-lee.jones@linaro.org> <20190610084213.1052-4-lee.jones@linaro.org>
 <CAKv+Gu_s7i8JC4cv-dJMvm1_0cGzzhzf+Dxu0rxcF7iugF=vHg@mail.gmail.com>
 <20190610085542.GL4797@dell> <CAKv+Gu8rhxciy1cOG3B3pda9+p4R_COGrrqa7S_Rj9y2HeBxYw@mail.gmail.com>
 <20190610092245.GN4797@dell> <20190611183945.GP4814@minitux>
In-Reply-To: <20190611183945.GP4814@minitux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 09:18:23 +0200
Message-ID: <CACRpkdZLO0tOuaribTWK5eMYD6_drdGJk9x7tG7YDxJKVJqOVg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] pinctrl: qcom: sdm845: Provide ACPI support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 8:39 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Last time we discussed this the _only_ offender was the loop issuing a
> get_direction() on all descs towards the end of
> gpiochip_add_data_with_key()

I think that is still the only offender.

We were a bit back and forth: adding that code, removing it
and then adding it back again.

In a way it is good that we detect it so users do not crash their
kernels by asking for these GPIOs at runtime from userspace
instead.

It makes a lot of sense for us to ask for the initial direction for
all pins, as they get registered as GPIOs, which by definition
makes them available as such and we should be able to inspect
them.

"GPIOs" reserved by ACPI arguably are not GPIOs anymore
since ACPI have dedicated them to a special purpose
(no more "general purpose").

Yours,
Linus Walleij
