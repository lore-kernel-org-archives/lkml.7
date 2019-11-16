Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D04C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D69C2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GLn3GsW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfKPQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:53:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40369 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfKPQxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 11:53:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id m15so10778904otq.7;
        Sat, 16 Nov 2019 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXtgv3ZMrjgjBz6CgZ0b7bfGQQBi49c5X2XfW8BjbXo=;
        b=GLn3GsW7yvmiMlfIvPSmzKDcm8Dak0w44KiKMBRGYSGWBtgg5dKTJymRmFkiX8frmA
         3bkBPEJh1gkg7bbnf14KpFLh0xrvmbpXSIo3s1/sEZcJC/N+CbPQQqjTc10PQrcqfDFP
         H+r8b1gOapO/TBc1PyTCCgeBvUqjpucbKhyDAEK6jQtSRu2bq8IagIljzdU9yEURzOsO
         fQJRJN7Hboj7dQlWSyzq7QuhQyfOq3cuYvLubz/npiq0PSMkv9dZWCADeSTZZluvDo1r
         L7I5/pQb1HuaiF0YVWms/u/mpupXtiXDuomxnAKqaQODAGv2q2Hu3w1X4dUJoYGug5eN
         ccgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXtgv3ZMrjgjBz6CgZ0b7bfGQQBi49c5X2XfW8BjbXo=;
        b=dRWv4KzhQvxdiRRB9YJuIv1/Q0q++UKlWU0/Qv/wKsT2As1SqJUN6R8NeNuTuToZlc
         5GX/k5F1pI1qZ8QBL/fwIKr0dxm8O4ohUiPTSntMcyFJx2XzxQTgU5Kclu5zipjHzNL3
         0QkRKaJ8e64hli9ZKLVZ1U5bA3jfFMRWh30hPoK0/eKN+EdbmUZzxTKgg9N5lKKOu0Mf
         vixE/Ykb0aGdOiX0yIXnN/DBafqZWfX+pDOMGLa98x/ZBCvCRfDvT/ouhoFcWw5HED3N
         AdtqvRSowssWyLsXvzG2Esog1BAcGPPkAIt7pguo9AO+hh9HSRdulh9+I55UqKHpCRCP
         /FkQ==
X-Gm-Message-State: APjAAAV+7hucj4HR8yIU10NyTOt1bWAUTG7rv+D47mftRfYdQXfJew/F
        mGOvJUbc2xb0yh0LWVdJIW9sFxDx/RPGofJJzqc=
X-Google-Smtp-Source: APXvYqyR3PXcNr8vt06aopgYnCoIGBtZvup0dKIFbYvImWezEBBB/Ap2vPG0iVW+wEBCjmsSZPgydmiLNy0Tr2Xh38Y=
X-Received: by 2002:a9d:5e1a:: with SMTP id d26mr14584710oti.96.1573923190609;
 Sat, 16 Nov 2019 08:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
 <20191027162328.1177402-3-martin.blumenstingl@googlemail.com>
 <20191108221652.32FA2206C3@mail.kernel.org> <1jd0dxf1uz.fsf@starbuckisacylon.baylibre.com>
 <CAFBinCBnUs0JdHT3TS+1++NMHtgbMvoT7RYRCnB0eNgs4L-2CA@mail.gmail.com>
In-Reply-To: <CAFBinCBnUs0JdHT3TS+1++NMHtgbMvoT7RYRCnB0eNgs4L-2CA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Nov 2019 17:52:59 +0100
Message-ID: <CAFBinCCQS_8w0x_dDqwjw2sUv1tHwQYjPBxTbH4f8mOetTCj+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: meson: add a driver for the Meson8/8b/8m2 DDR
 clock controller
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Nov 12, 2019 at 9:52 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Jerome,
>
> On Tue, Nov 12, 2019 at 6:20 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> >
> > >> +static const struct of_device_id meson8_ddr_clkc_match_table[] = {
> > >> +       { .compatible = "amlogic,meson8-ddr-clkc" },
> > >> +       { .compatible = "amlogic,meson8b-ddr-clkc" },
> > >> +       { /* sentinel */ },
> > >
> > > Super nitpick, drop the comma above so that nothing can follow this.
> >
> > I don't think it is worth reposting the series Martin.
> > If it is ok with you, I'll just apply it with Stephen comments
> I am more than happy with this.
> just to confirm, you would address all three comments from Stephen:
> - including clk-provider.h
> - use devm_platform_ioremap_resource
> - trailing comma after the sentinel
I'll have to re-send this series anyway, so I'll fix these myself.
still thank you for the offer :)

I think it's better to move patch #3 from this series to the "XTAL
from OF" series, which means I have to re-send


Martin
