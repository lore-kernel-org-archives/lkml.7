Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090EEC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC78A21479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8t5NdbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfIJT4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:56:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46499 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfIJT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:56:35 -0400
Received: by mail-io1-f66.google.com with SMTP id d17so18511561ios.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zx9RruwRe5f1Ff7sViLmajLBLyseLMriFK5R4YJwKDI=;
        b=F8t5NdbZlr0e14Gj8JyrmwrxNoV1i5R4GZBWzL/cqtmbCyf7utIMUFytyklopxlo2T
         vJnodZZ4JRmjvk0x9HGKb+WIilJJuSq8IaRfYtQUETJBmGAYVJFRHFiNxRE7pIvaoDzi
         +vl4pCpATFIYpDBEaPp3qC3c2nsF7fjrBEcoQ3QqEU++FbtwHsa/ib5/8TtXVEc2H+gD
         oVcd8ba5FvubmdHY26ngUldqJjAiRAQJqFR10uE/8c8vNTCzKCDJeOZGIumkHGt9qfnk
         6z1LfqA28WQFa16Mfgvyr8QTp1yW6VQX5vgW4eFnJ8bxNSYB97Pd8lhUrLKsIQ0YuWco
         X4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zx9RruwRe5f1Ff7sViLmajLBLyseLMriFK5R4YJwKDI=;
        b=CUCKm5ek013dZ3CkgTA/j64BI0hQT4OWkE7+h8QsvPexIFNoN2tQiZyWcnFtEcscwN
         bWnT/yyTwr4kzysneJ3o6JEsdVP240lD132uX2JnK7iRfoFh9cJeje7gyMrpAOOnwtj1
         kzTbSyc5wC4sR8FeVv6mPW6aq5wPWrLM3NZLImgqHP4cyLjt3ncDI+exhv51G+Ah2yia
         KE5OOTrx0HpQoeBe4m4xmnpA+eYr80LH8CxQ9ro92J2ta9JaMNsHQMATPx041LP+PKgU
         u7f/C2C6EDAiwTt9zkLHm4Y+F/hHfb1UoYEAr9pWGJwP6F+JMGRAmxBWMcROeA0kSCUP
         JPbw==
X-Gm-Message-State: APjAAAViHjh9Tpbl/kIEZbwJWQJXiEihribufws9xtKv+RwqS2+G+z0o
        6ZqpnYGXCDNt1UmpbBEzYQlPx+/4oxOncQe57GT/SA==
X-Google-Smtp-Source: APXvYqwBl8+Ackaud5chkPbWe+igJyLx2dZCCHiicVMKyYGaqk1iTwm8+mHXpe9JKs0+LhEX9C6nNNp3yOp0c04Gr3U=
X-Received: by 2002:a6b:cd81:: with SMTP id d123mr4232828iog.78.1568145393530;
 Tue, 10 Sep 2019 12:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <f37f2a1276efcb34cf3b7f1a25481175be048806.1568143348.git.hns@goldelico.com>
In-Reply-To: <f37f2a1276efcb34cf3b7f1a25481175be048806.1568143348.git.hns@goldelico.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 10 Sep 2019 14:56:22 -0500
Message-ID: <CAHCN7xJbeYnNLbKOWFXrBLovjFNdtweuOu-arbQF1-=8JNojFg@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Fix error return for /sys access
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 2:22 PM H. Nikolaus Schaller <hns@goldelico.com> wr=
ote:
>
> regulator_uV_show() is missing error handling if regulator_get_voltage_rd=
ev()
> returns negative values. Instead it prints the errno as a string, e.g. -E=
INVAL
> as "-22" which could be interpreted as -22 =C2=B5V.
>
> We also do not need to hold the lock while converting the integer to a st=
ring.
>
> Reported-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Tested-by: Adam Ford <aford173@gmail.com>

> ---
>  drivers/regulator/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index e0c0cf462004..ea48cb5a68b8 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -564,13 +564,15 @@ static ssize_t regulator_uV_show(struct device *dev=
,
>                                 struct device_attribute *attr, char *buf)
>  {
>         struct regulator_dev *rdev =3D dev_get_drvdata(dev);
> -       ssize_t ret;
> +       int uV;
>
>         regulator_lock(rdev);
> -       ret =3D sprintf(buf, "%d\n", regulator_get_voltage_rdev(rdev));
> +       uV =3D regulator_get_voltage_rdev(rdev);
>         regulator_unlock(rdev);
>
> -       return ret;
> +       if (uV < 0)
> +               return uV;
> +       return sprintf(buf, "%d\n", uV);
>  }
>  static DEVICE_ATTR(microvolts, 0444, regulator_uV_show, NULL);
>
> --
> 2.19.1
>
