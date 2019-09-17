Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EC121852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bg7owd06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfIQJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:23:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44177 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfIQJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:23:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id q11so2260319lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuVy/dTL0zVi8KB992cYfUvwyuZX5WJTHthmI6rNOT0=;
        b=Bg7owd06h9hLmdCxdxpcsTn4LUAfPv+Fcad1/azM2mPLlkqQ4BA424Bz+zbIl7/0Hs
         eKql7oCqUtjwx6PXZjoG/nwv5HrreuTAcvZ22zX5/ZSYJ3TM5Rinqf7M8W82SSWcvMWg
         YSLh9gDvs6Mqwvm5x9/8dVcbnvYrMQ/KeSV3CfLkQVfLHExiI3Dhk7e7l6N5u2Lz2//t
         7q9JTi9j2t3cIjkWN+E3eFFZgLeB1Z94tulowjh6MTjXFfEIUDCNsqWeDKB8Or4vFAv2
         0dohKXmgO1WZpJVIDpYo839ISYtq/0s54FIlTR+binuYt/vRVT5HXVG0FRBUr7DAK/JI
         IASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuVy/dTL0zVi8KB992cYfUvwyuZX5WJTHthmI6rNOT0=;
        b=HEnHr4uRSG6t85z/X6FzXl1fHITewMiA8Jysefi64EQ17k4MLs/7y19O1fk3KORzl9
         ViQ6FNR8IJYe8xsqdqTONYZ+bFFE9EVRDgGX5XViZWOe/2aH3oW6lPHlgKwzZeLAz0FS
         GPm2qsk2huvI9Aq6K/B4ccmfdEh09avBt8ToYeCDZfVqUhVRO86TYDs+tjruvhaGn597
         wS7NuKlBJVJFuBBhgOlPXjQDYMrEnUqFRW9ymOilTkwR1vFLCTyg5wZTRUPOWV5ADlIi
         nwZyrkd/lfsK0UWYghg/5OzO8D54dc8o3jsOh0TORTS7jPwb/xvpnOlOD6b4bAEQcr/L
         dUHg==
X-Gm-Message-State: APjAAAXml1iwqT5ECATXGOV/4sxmUcS3tpoqLEWAooMnKCOIGj0PHybq
        Qx8fiVM6KC4RaTZEn3orukTIPEHA8HPKuv4f48sdKA==
X-Google-Smtp-Source: APXvYqyM4ltTpXf24i1Q7+nxADNrEfPqDVLlQFkkrDB0olL8Fa3A6yeao2uouudfGkdBTJevKJ2kRjPEu3NmeskBU6c=
X-Received: by 2002:a19:3f47:: with SMTP id m68mr1524926lfa.108.1568712205010;
 Tue, 17 Sep 2019 02:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190917085627.4562-1-mail@aurabindo.in>
In-Reply-To: <20190917085627.4562-1-mail@aurabindo.in>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 17 Sep 2019 17:23:13 +0800
Message-ID: <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     Mark Brown <broonie@kernel.org>, palmer@sifive.com,
        paul.walmsley@sifive.com, linux-spi <linux-spi@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan <mail@aurabindo.in> wrote:
>
> platform_get_resource() may return NULL. If it is so, return -ENXIO
>
> Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
> ---
>  drivers/spi/spi-sifive.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index 93ec2c6cdbfd..67485067a694 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, master);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(&pdev->dev, "no IOMEM resource found\n");
> +               ret = -ENXIO;
> +               goto put_master;
> +       }

Seems unnecessary, the devm_ioremap_resource() already validated if
the resource is available.

-- 
Baolin Wang
Best Regards
