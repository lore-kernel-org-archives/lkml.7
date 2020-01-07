Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1BDC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3D82080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtBPym2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgAGKgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:36:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38286 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:36:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so38553168lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sG/kXuqLeJvqG1lAcs804RB5cd4ar5VVtWwgAsRdZ/s=;
        b=GtBPym2vWmXC28LTMAxnKxk7zjFcA0gTofCfYp/e1hRMRUzc/l8OWm9FZJZ6TDraA2
         q4bBSbz5y+eUEcdjmWNedK3ESN4gfVo8PNP7tyo830m/EXIkvN1LvV6g5cu8IzmZufSV
         z0Nagz0pJgHNuua3MtsiJsbWnaFNeNuD9wevv9jvuPn68bVazL3RAwXefpB3OPj5CrXh
         4/5bEiBbEQ0fKbcZ5BrnqRAHjAqdP0ALSVrbLbL7Mpum3/cQG9wIzWYkzMCXi3qgMAO3
         362Lw4Cj5hzHVXE85YnlCuF5u8wufzrOhJY+WEL03UrbpyzNNgJ3CKci3Yr256HLyHmU
         XaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sG/kXuqLeJvqG1lAcs804RB5cd4ar5VVtWwgAsRdZ/s=;
        b=Lor7wYoqwepP3V5+nWOP105AM20z6Fq7d/wfdZzKDlCTK2ouokJrDrStH8tn0AWp6I
         SHjHn2uGSzOcy9x8yoyF0IHq/K3q6zRamYOSvo9KgltBIWDGvwNczPq3Mdv15lcWKnL6
         LchVnc7ojywG/bGZbEfp50Xc2jgL12XBkDHruFLQ2s1aseyvoqKSNu8KnAIrHRApuHf2
         0QJzDFJrXhYR2jNZQzmRoDSrufpvns7Th29ZuhFwuNCpybmF4YZMVM2rg6zpKTBJPKdN
         rZir2kCTMr1D4cQjVoArZaa880V4XvLJgO9RogKSbqaifn7tPeC8LigGvoSoPyQzW/Ej
         OXbA==
X-Gm-Message-State: APjAAAWZY5qrxo6vLYcmA3h+pkBPxpkL3POuOKgOqZ36i/YH1qbyzu0s
        s3UELVtKMZQFgwlcxI+kLN7GSDi7vwQuSTvf1o/zbQ==
X-Google-Smtp-Source: APXvYqwtSih7jQpztMo/SWJRjyemZlwG1+gqydx7vYHxxHiA9/nJ8znZ/8sEt3hdZ1WVHXFNFrrCHonuUSWxZhzsjpg=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr58979605lfd.5.1578393374908;
 Tue, 07 Jan 2020 02:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20191230172751.17985-1-krzk@kernel.org> <20191230172751.17985-4-krzk@kernel.org>
In-Reply-To: <20191230172751.17985-4-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:36:04 +0100
Message-ID: <CACRpkdaKPWott93XQp1iWMO6m6TqqW+iuN33PnSDOnOMMdCEbg@mail.gmail.com>
Subject: Re: [PATCH 4/5] i2c: stu300: Use proper printk format for iomem pointer
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jean Delvare <jdelvare@suse.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Max Staudt <max@enpas.org>,
        Juergen Fitschen <jfi@ssv-embedded.de>,
        Elie Morisse <syniurge@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 6:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote=
:

> iomem pointers should be printed with pointer format to hide the
> actual value and fix warnings when compiling on 64-bit platform (e.g. wit=
h
> COMPILE_TEST):
>
>     drivers/i2c/busses/i2c-stu300.c: In function =E2=80=98stu300_wait_whi=
le_busy=E2=80=99:
>     drivers/i2c/busses/i2c-stu300.c:446:76: warning:
>         cast from pointer to integer of different size [-Wpointer-to-int-=
cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
