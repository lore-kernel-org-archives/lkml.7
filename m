Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8616FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A2E20825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkVCVtLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfFGXIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:08:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41672 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbfFGXIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:08:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id s21so3096985lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CJjAb+Z5ioBZ0AM/8mCFtzkkLn/OKSEL3IHSOtuKgfQ=;
        b=FkVCVtLwoVP2xNToV3V9nLLFBH8qK0uahCMEKeFCpaR2z9IF0rpEg8YFqnUmGXZsgq
         DfvxttPbgwKv51MItse2JF1YQ5TsRI5GCwNHRb9IYez7H3NYfXRNHgXB0gnp2gTndxNB
         LwkbDBxTrRmHrzyvFF13obVOy9KBAFVFFzTocL3+JUOgAFqMpgZ+U41+ABtrRyWnIodz
         eqN5ctPHY09xzgpkZFV2Tez9dxUvSL4e5wfFHFtt31VxWoUedzV9qMV9ZKUB51qacrdz
         tTCqV/urQYCK3kC4ka+GuQTTXl3BE0wjaSiIPmANYwxUqfk3h0q8w6gczsAnBL5+4gOe
         vC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CJjAb+Z5ioBZ0AM/8mCFtzkkLn/OKSEL3IHSOtuKgfQ=;
        b=flRuTukvO0GqYCnkhadrXLMj+GM8m/DoW2Fk8wj7+3DSFKPIXwhYPZb8myn5yY2Bz0
         tBKBhRjXPPdNooiCCCZ+cRicbPC7RnwmJrzDYpOdL3ZKrXTTgEjoA8+eLC4sMc3V9FzT
         Dj4gYxhD58/dMCAoooTeioTURkNjOgB4CiQoFpZptz7ABNe6RUBhG1rRnWrtOh7tsori
         aIglzXJrBz3TK2eCedaa2tAnIXFlmtUO1bEH41gLEpfUHQ5ym6aBIMLz8NMLnA4OSZ7y
         Ut9Vx6u3/RmUfijTHY4D6/7EpwnJfcA09VEYwGe6aJ77pg/lql+pWu2VPbbs+v9WXBX6
         B7DQ==
X-Gm-Message-State: APjAAAV2A7xYAta45lbYBDyvlCZAncfrjAmqs14cPBZL3NV8dF1v5FXD
        q725qE/HY3SU5n4K5K7Asy0oV9+tvpspG6Pqq2ptlw==
X-Google-Smtp-Source: APXvYqxUOi2ComwroPYJqL0+HmrxnRaNzTbxCzwrLY351hzZwjGfd8PvKzmcThTDM6zJHWY6X2LcwPf0/66wKSkFxIw=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr19985474lje.46.1559948910013;
 Fri, 07 Jun 2019 16:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 01:08:22 +0200
Message-ID: <CACRpkdbxUHR8Uo+M7+_0v77Pg6k_jmL79KeHKNzWmFhtq+mZXw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add minimal boot support for IPQ6018
To:     Sricharan R <sricharan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 7:16 PM Sricharan R <sricharan@codeaurora.org> wrote=
:

> The IPQ6018 is Qualcomm=E2=80=99s 802.11ax SoC for Routers,
> Gateways and Access Points.
>
> This series adds minimal board boot support for ipq6018-cp01
> board.
>
> Sricharan R (6):
>   pinctrl: qcom: Add ipq6018 pinctrl driver
>   dt-bindings: qcom: Add ipq6018 bindings

I'm happy to merge these two if I can get a review from
Bjorn Andersson on them.

Yours,
Linus Walleij
