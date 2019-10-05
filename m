Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BC0C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406692245C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yjBGb7Yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfJETBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:01:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38628 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJETBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 15:01:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so9723054ljj.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLnPIVbBJS+TxpO+SqFajYphNiVo4QZ5RCiCT+hdl/0=;
        b=yjBGb7YkhVlUnWVh1z11Gt4T3I97PkNYGB6u4AujbJIlRcsROUQ8lx59RmCuXDtVnY
         JfEWnWsXwUbqOoYErwHaZXi9lFD8Ayfsp0mlFtidGFrHL2LKYDLTcBcMTnjxc3C70RVq
         DYrDQLnn6ZPatonqM+3qWgFGx3No3skQVde3fwBREmdmPk6ZzSy8a9UPJi1n8B/Z0ODl
         muwChKMZQyZH6wvqbjQ1c6JdYQ+y+0/Ljcqlmw3wvaWn+nr9WxkwR6papCF1gwnqJSk7
         ks/UQQjnVMMNw8op4JJ/oNy1yd4x3ehqU9P+Yj5j5bfL0I7fP7r2pEqRwPevh90q6EN9
         GW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLnPIVbBJS+TxpO+SqFajYphNiVo4QZ5RCiCT+hdl/0=;
        b=E2ewy9o/AJ3dyVZD5xtpvgj/8vP75zz+diI2x/cy9TkF1ZNFIVEt8k02F16u6Ayuws
         ftv42QjT1xO69LLp5ikSffWvrXkWylyzbfRMSqQTnRwBzz277HSvKUy9ONlpF6mLCARW
         +HsyZag3aBpj3CVyZSQIAaR7NMObry/+BsTgK/kNX3YVlS4p34CYxKRvNy9WZD8E2TXg
         cONaOzljWZU9JhmvxzN7K4REaXSc0JzNN69JzpG+hRHGrEB/dvRi8B5N1142KgJB9DoC
         0fyCwPmQ6XR9WRkRpSN4dQ2QiWPX2X6yFPgSaExGeTUiiAtNO5b2yhHVKtjCl1SC2H+n
         2qqA==
X-Gm-Message-State: APjAAAUv2gErBPMe8Vn2NBmXmegbzcFa7F+sD7zySkZ57j2BdCczKk1m
        H6Kpojh2dz0OtCHJY3G/K3KFybKKCI3ZlmGCruei27kK
X-Google-Smtp-Source: APXvYqzKaW2NgNBp6MUPtuvXz9pw5/psSZ8RIpsZPr6vu/11xyyRUj+RCR6PRRrx5s83L0M46vj7xj5KMzhRPKRww8k=
X-Received: by 2002:a2e:9094:: with SMTP id l20mr13767405ljg.35.1570302112498;
 Sat, 05 Oct 2019 12:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 21:01:37 +0200
Message-ID: <CACRpkdZ_+YKKmNrho5edu7hn8UsOCPySSn2YMWz+qjYwMxgvpw@mail.gmail.com>
Subject: Re: [PATCH 0/7] regulator: switch to using [devm_]fwnode_gpiod_get_index
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 1:10 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This series swiches regulator drivers form using
> [devm_]gpiod_get_from_of_node() that is scheduled to be removed in favor
> of [devm_]fwnode_gpiod_get_index() that behaves more like standard
> [devm_]gpiod_get_index() and will potentially handle secondary software
> nodes in cases we need to augment platform firmware.

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Too bad with the build robots being unable to parse the
pull deps. Now they hammer out complaints.

Yours,
Linus Walleij
