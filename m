Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5DCC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 07:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732902067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 07:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsKM1f3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfJLHkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 03:40:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33201 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfJLHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 03:40:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so7098975pgc.0;
        Sat, 12 Oct 2019 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4TDuPQi287pEOKB5KDxBxduuED1DoZ5ekjPeswwjz8=;
        b=LsKM1f3FbF6OHL1tNl/PxgPPPztiIcuum+4w1rji5Yk8tqvR3cQRcmFt/lBOzvkiok
         wR8RTuoEuLBZs2R4QWBcCQlm+IABIX5BrEQKwMbZkmiL65Y9dBhFua9TqyxCCOhjPkw+
         K0DzvrTIvi+buWy+H9Hi3MRGXUfq6hGlO6Jxu3LUJfVjw0A4XoTW6bzefZu8gKm/AVrZ
         7VHZZo77uxQ8RAWkloEDgL3/zIa1FXuMeh2VSWsZG20L3TQsg49NbVsvhuSp1H5ExlqI
         3pHMuJtd6JWUtrouisaTk1KU2C172bmFuNHjRCtrgucss5q/8pAkLPAHNoX0PMQXK5A/
         OdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4TDuPQi287pEOKB5KDxBxduuED1DoZ5ekjPeswwjz8=;
        b=fetXoQaEgALCAVjJUyQAYC2N2fJD35dSP/ym+cF6ghNqdbA0bi72vXU2iW5O67RAjD
         ClQBP0ncK/FuK8KJN8e4HmupLC56oUb/bcFw5jHvNV+QVHHKsEFLLuo7hNtzFMeg/Vsc
         74Km2zKV1wcFEQSUuUch+o9Z/FAmT9ydrQQ6B4YtS7P/AV3X2DLQdEFBKVzfOfmqTZJx
         Vb2HNF+JoNY/ZWD7PTMp7GFqq1VOGGBzAmG0WdCW+fmJw6In136hf83M/gCSfAnVenHi
         NOKNm30zjrOeAVQFip+rZDmUPOp3qVNg/TybreXG2qAsXyv4eO6nPRgdiWvgq3n3u47P
         kpjA==
X-Gm-Message-State: APjAAAWUNAJLDmhorgfL/hG+o9plAjHB0urrj4IWblvhuIdePkI0rtYw
        fWg8yA3I+6CPz2OYfEh+fXHhaVs644Dv/pmNbhM=
X-Google-Smtp-Source: APXvYqwfmCVkEWAsj6lmyugjeKaYtOhruRdv352/bSJ8pJfsVuQYh5jAatnO3LWV27Y7Y4E3MEhIGO1Mz7qXq1cxFME=
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr23177858pjr.132.1570866006928;
 Sat, 12 Oct 2019 00:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191012035420.13904-1-dan@dlrobertson.com> <20191012035420.13904-3-dan@dlrobertson.com>
 <d6f44aea-81b9-eb5f-71e2-637246c89491@infradead.org>
In-Reply-To: <d6f44aea-81b9-eb5f-71e2-637246c89491@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Oct 2019 10:39:54 +0300
Message-ID: <CAHp75VeBrR0Ln5XOw5zA+JSoXM9BdoYw7p9D5c7u+2=Lfht75w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: (bma400) add driver for the BMA400
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 10:07 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/11/19 8:54 PM, Dan Robertson wrote:

> > +config BMA400_I2C
> > +     tristate
> > +     depends on BMA400
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +
>
> The bma400_i2c driver seems to use some OF interfaces.
> Should it also depend on OF?

Please, avoid unnecessary and strict dependencies when it's limiting
the area of use the driver.
The driver does not depend to OF. Why to stick with OF?

The actual change has to be done is to switch from

> #include <linux/of.h>

to

#include <linux/mod_devicetable.h>

-- 
With Best Regards,
Andy Shevchenko
