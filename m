Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD1C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF0920665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPSkrDuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbfIXPeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:34:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38327 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390040AbfIXPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:34:13 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so5492900iom.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p4IW7lVwom9cm/5ki431GVwm+aXbWnyT6RgawcJ7NnM=;
        b=VPSkrDuuF8B7LOfygF6XX12A1DAJBaPDC1Z7i9Mds8nvKyDAkGRiYs32RSB6C7UAYY
         Jnk1bY0YKPBVv2nyiAXzzeojgFMEuCU4kWmE2VnjUyH/AEw1My987cPOQIE1eXOp3OcE
         Y/kONFZzy1s3xHT6BNAVtO5xwgV8TQckhOpw3ZZZ7XJ5jpnLZ+RW0OrxZeCV3s0u9ZEw
         IU/iUXcxacjBmlH4j+rRtexrhzRZaMYunPGanO1QWMSb8rEltZ3YgxFIjFyDHW3Guzj4
         S/hy7+Pxpr5pYAnybV9Ym6CtfYQqhKAi7ZYf+84KD9AQNU2oCHo17fvE2l7XieGruAha
         FGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p4IW7lVwom9cm/5ki431GVwm+aXbWnyT6RgawcJ7NnM=;
        b=CDXNv8usn8LBQ5tSPCMQDIByA0zaeGPuyF4ZNdBWvwqn4n9yc/e7/nEChf8mFK7FxG
         1uV1JwgfRA30P/t3F7chihByHhNhvQPBuJxgfdycWKduqi4AFd9Isy/lQavNKLNChWvS
         f+hvmhjySB9dI1wUoYcHXvGFt2ggyBLK2Kw+pW7M2A95bJWjj3/zUcuLh29DrTU/u8Kb
         RnPhbNm3L6x6fIdYEitAjvHb1m78diS82h+o6FsxHOuQHmBn+e/RrD+sSZao7xHDBcQ8
         1ddvsusMwdZgf4NKVQuq+bGyyNhdcBPfZoRK+pacMMl2+7JmCII8lVbb6gv0IH03Xf/R
         Q3zQ==
X-Gm-Message-State: APjAAAWqxuMwyiYrlhWcIG6kWHJkHifL8CkevTPHAeNhdFPA3U00VZkw
        phbNEMs4RTZtE+2Q+RyyRE1FGz4+s52VfW+bY/U=
X-Google-Smtp-Source: APXvYqwpV4pqbOSw/YoZK3q6p6UwZL/wN0ZWhYwEUFSJSUW3FqByMH7MMtTQpWMy0gA+5+LK8lNHif4RRFEthdqHjL4=
X-Received: by 2002:a6b:7b01:: with SMTP id l1mr1739481iop.292.1569339252384;
 Tue, 24 Sep 2019 08:34:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a92:a04a:0:0:0:0:0 with HTTP; Tue, 24 Sep 2019 08:34:11
 -0700 (PDT)
In-Reply-To: <20190919071828.GC5016@dell>
References: <1568801744-21380-1-git-send-email-gene.chen.richtek@gmail.com>
 <20190918105121.GB5016@dell> <CAE+NS37XG+kfbj6yJrL5A-d2O_aiRU90yV5TUk3Kfa0Rv7dWmw@mail.gmail.com>
 <20190919071828.GC5016@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 24 Sep 2019 23:34:11 +0800
Message-ID: <CAE+NS342Kn6OEz4D9Y0yfXStnW6KQ6N2yuQtgN2q2bXafofShg@mail.gmail.com>
Subject: Re: [PATCH] mfd: mt6360: add pmic mt6360 driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-09-19 15:18 GMT+08:00, Lee Jones <lee.jones@linaro.org>:
> On Thu, 19 Sep 2019, Gene Chen wrote:
>
>> Lee Jones <lee.jones@linaro.org> =E6=96=BC 2019=E5=B9=B49=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:51=E5=AF=AB=E9=81=93=EF=BC=9A
>> >
>> > On Wed, 18 Sep 2019, Gene Chen wrote:
>> >
>> > > From: Gene Chen <gene_chen@richtek.com>
>> > >
>> > > Add mfd driver for mt6360 pmic chip include
>> > > Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
>> > >
>> > > Signed-off-by: Gene Chen <gene_chen@richtek.com
>> > > ---
>> >
>> > This looks different from the one you sent before, but I don't see a
>> > version bump or any changelog in this space.  Please re-submit with
>> > the differences noted.
>> >
>>
>> the change is
>> 1. add missing include file
>> 2. modify commit message
>>
>> this patch is regarded as version 1
>
> It's different to the first one you sent to the list, so it needs a
> version bump and a change log.  There also appears to still be issues
> with it, if the auto-builders are to be believed.
>
> Do ensure you thoroughly test your patches before sending upstream.
>
> Please fix the issues and resubmit your v3 with a nice changelog.
>

thank you for suggestion
may i ask how to disable kbuild test reboot for s390/x86_64/ia64?
we want support only cross compiler =3D  aarch64-linux-gnu-
and we have test build pass with our patch

>> > >  drivers/mfd/Kconfig                |  12 +
>> > >  drivers/mfd/Makefile               |   1 +
>> > >  drivers/mfd/mt6360-core.c          | 463
>> > > +++++++++++++++++++++++++++++++++++++
>> > >  include/linux/mfd/mt6360-private.h | 279 ++++++++++++++++++++++
>> > >  include/linux/mfd/mt6360.h         |  33 +++
>> > >  5 files changed, 788 insertions(+)
>> > >  create mode 100644 drivers/mfd/mt6360-core.c
>> > >  create mode 100644 include/linux/mfd/mt6360-private.h
>> > >  create mode 100644 include/linux/mfd/mt6360.h
>> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>
