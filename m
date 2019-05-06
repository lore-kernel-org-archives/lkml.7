Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003EBC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCC820830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfLTotQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEFJBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:01:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46006 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfEFJBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:01:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so6128664pgi.12;
        Mon, 06 May 2019 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0n69/DsQD9K9+bJ+RtBd6iIMeJwJ9oa9m5rGfgLmjI=;
        b=hfLTotQCYGrJ5jihb2l2fhqq5kuXMsDW3KBrtFdw2AplUEhu/82+ovw9M5pT/shIAK
         I/pFosfrxqUglupkVfC5pLsBsQ9wtg3GTPPKMLcCovfCJyqDLD4nhPFovWUXKWUSqSb8
         5kuvYudTmFpUjqfAcHZi4pbU8NWIeujRkFqxyYZS7GLZW1gDSFsSkm+tTlbyV4AcDaDk
         inhGHWK7X2F6xSBkqdFNq3wuq6/3jX9nK9czxyGcg4qcdUK/ispiTT9HwdjEpU9vLFsU
         SOE1UZZoVLbMvAjwjWYb2WjQw3XC1wado5cw2g5Eyi2AvHtjpnfTuxycvXGZDhXBAzOz
         cRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0n69/DsQD9K9+bJ+RtBd6iIMeJwJ9oa9m5rGfgLmjI=;
        b=CFgxWjUTDFSKR8Ii7vqqzBLijjN65My18WaPv0x1dPlO6EVQ+J0MTjz/IQEyQ99QLl
         ozg6rqIN99rKgtTNXIaZ2M2+EKJX9EZY838qr0E1BctF0o5CtVMC9/jNB5pfpMuvydhG
         mB5uv93LU/EZRQJ67O3fIzpTRwCTfvmRhhLxOfIlzLU2/10N+Ikflt5VmPz7Qe+Ydzqo
         c6lmlOwimblCZBYfg/yAoE76HXIeONhNg9bR8gB95ghERbEdert7kxhKQ+iEtxLF48pl
         3dAarEcMXvXVkfER3wAayc+SnoQjRIZRen/7Pu3TWbMqfO6hqYDcL7LjBnyiZ6FkadK7
         HqUA==
X-Gm-Message-State: APjAAAW0bF/Q9A+iV/4QAdv7CRa5A8mCarvqtTB5AaHr7HtR0iztq2k/
        Gule4JIQLFSz2d0j4Hk1iKllEtbb4zdbEkTuR14=
X-Google-Smtp-Source: APXvYqwkAsWdsnYPIxZtJnwPPP9XmtarR1eMWiIykyXJZHHtHir0e2sq3FoHU3MEur8t4iaIK3Lq0nA16t+QAbs6bZY=
X-Received: by 2002:a63:42:: with SMTP id 63mr30819969pga.337.1557133312275;
 Mon, 06 May 2019 02:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com> <20190423075020.173734-21-wangkefeng.wang@huawei.com>
In-Reply-To: <20190423075020.173734-21-wangkefeng.wang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 12:01:41 +0300
Message-ID: <CAHp75VcmM0mx7-3P96n092cz0mfV22OK+jB_Gvqsrhv2PsqEFQ@mail.gmail.com>
Subject: Re: [PATCH next 20/25] platform/x86: asus-wmi: Use dev_get_drvdata()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:40 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Using dev_get_drvdata directly.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ee1fa93708ec..fb9e4e02c068 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1361,8 +1361,7 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
>                                           struct attribute *attr, int idx)
>  {
>         struct device *dev = container_of(kobj, struct device, kobj);
> -       struct platform_device *pdev = to_platform_device(dev->parent);
> -       struct asus_wmi *asus = platform_get_drvdata(pdev);
> +       struct asus_wmi *asus = dev_get_drvdata(dev->parent);
>         int dev_id = -1;
>         int fan_attr = -1;
>         u32 value = ASUS_WMI_UNSUPPORTED_METHOD;
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
