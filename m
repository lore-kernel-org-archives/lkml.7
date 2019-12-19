Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618A5C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E99924682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXn2SZ2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLSLGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:06:09 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52059 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfLSLGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:06:09 -0500
Received: by mail-pj1-f67.google.com with SMTP id j11so2356949pjs.1;
        Thu, 19 Dec 2019 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeU5cykjSol+qLZcNorquHgyVRaSfGk/fzrWLtz7hiU=;
        b=YXn2SZ2u6mgIy8SgB+oCrKt8xgvdBbYfrcAbtbb+wjR9DI/h9ImuUqWm7Wq2xhfFkz
         BXxMZtwCrcJtNi2sK/gi70DUJoToJefvxLEsL6x1B1boNxuBLFkBqsFK2XBeCheKI5Ds
         zymlJgYNjNnwa41GXevc1FDzJMIoAyQsQioPEkicLZdznL6h2DV5MTpbCFO0SBugplfl
         q5DBfYXqMGuE3IdwJ7UClNlCKeUOHVy6+loVqRB64shxLTcctTuAM8uLzOPre2FCKfeg
         /RbiI8i046380+5u8EiDqOFHjFz9ZiPR7ZzBeQmSb57H74LAF1Xkeuv9jRWzKW/Pr87B
         SZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeU5cykjSol+qLZcNorquHgyVRaSfGk/fzrWLtz7hiU=;
        b=q1yXWTpfvd+4yy7baC+FP36qssaN4i5Srbe7IiRBYLvsRsRJEXa+RWDCFrxpUIOdCd
         oXGXam9VVXccn9EJL5cpIpm+MlItMeVjNZ/fLVL6fvBMUfbIRhtM+9A5l7Pvk1bYa6W0
         bPB474Hw50O8Sjf3iz2dizN7SpqPmWIp+MsVCJ7ennhNdSszcMuCXPo4XCaJlBDsJSYr
         fTeiy0AzXj95jpr0eUWTlK7V2Vs68iJa2zblwK2+MZMo3QrqKGDImbs8HtG0ruT/829Q
         DSQ8MgWMS5FbGMpFziwRk9c43WZsmjvmpEF7z8Gzon+t1A5XS7/+WX6rJKxlLTgc9tqk
         E9Kg==
X-Gm-Message-State: APjAAAVoPeJo1ozXcWp6Liowo3MJv5WUlHfEnHLYCWjGLkcAtX2j03tm
        dpIEgCGSWdJXYggBmIbRxt4RjK7Dd5mrBqXDhK0=
X-Google-Smtp-Source: APXvYqwcUHHMKxpyE4zUGneVf52K6qTcpvep2/VfIq1crR6JYbfe4kA0PZYLgbc812IP8qiqXGQIPhvSN773wFQma0Q=
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr9086509pjc.20.1576753568464;
 Thu, 19 Dec 2019 03:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-4-dan@dlrobertson.com>
In-Reply-To: <20191219041039.23396-4-dan@dlrobertson.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Dec 2019 13:05:58 +0200
Message-ID: <CAHp75VeU07TsV2NC5Myvmi7Q6tARbmt9=wQDRnXFqaX2G2Luiw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] iio: (bma400) basic regulator support
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 6:28 AM Dan Robertson <dan@dlrobertson.com> wrote:
>
> Add support for the VDD and VDDIO regulators using the regulator
> framework.
...

> +       data->vdd_supply = devm_regulator_get(data->dev, "vdd");

> +       data->vddio_supply = devm_regulator_get(data->dev, "vddio");

devm_regulator_bulk_get() ?

-- 
With Best Regards,
Andy Shevchenko
