Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED1C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F3A21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmgRd6S1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfGDN0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:26:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39278 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfGDN0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:26:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so2441384pgi.6;
        Thu, 04 Jul 2019 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5iUsd23goTvarMTVqpK2sCw764StJ8ZSDbGkI3s2b8=;
        b=OmgRd6S12FaBdQHsShwhta+VQpuDk1YlDmFpmHgvDOqr2G2oLKyuD66zwe62aBBu01
         PWqkeqE23Qyb7IWZlbNeiDCqTWNWOtqnSbR4hz7ye8Nxpr4tBFRudyDcrz7yJjjdGZjS
         cdXxW1k7INxfQaOm/DCObKYnA1c0w5RzbKGFrwRz03mSEP9pgRjeyMjWQ0iJ4jxMDl4m
         vdx8byGagNGlKtcxBTkpp0j7yF0MTM+R/qmkqhGOSnQP41ekWhF86oyeaXRAtoXZU2oH
         4I+njhisLrAnZssOWofxwBdBn3iDauVAoi64cZP2QMv87IqbystVKLeATpYPpzPo1Ke2
         TayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5iUsd23goTvarMTVqpK2sCw764StJ8ZSDbGkI3s2b8=;
        b=bT9vOv+3GRlAW6n1tcseKb+K1nTyfqh+KU+1kovQwAOi05iIVDZcxLehKHoZakdm3L
         K9joUdgrPdKTUCCLXG2Um85ny9+Mp2ZrxAP0C/XDOgMxeJK7W4K8fpAfbUBx0c2cO2TS
         S5ByL2U43wMLabdeHtpp/UxZh3IFB3/UJ+REbo+OflIYYco9YGxL4YI4mT/htsUMG292
         0eZj1VqTkC2yBWs5sQI8yRvmyQRsBm9ogulr/V+k38jiFI3EwYqQPKft3WI6iuCIYI01
         17Nsqsg7h5lKCqKLIVLHIz4Ll8Yab/Tfo8A9Ijr+x8rUIvnenOqy7PLRcFF78IUqnVHK
         bIdg==
X-Gm-Message-State: APjAAAX2Yiqz+LNzQbN67+4dr5rirjQd4drT/jaEYu9XHpZ8zxhrso2u
        PU3amnUFdHFJWBffW1OGhm8IjrWedqUboD31WM0=
X-Google-Smtp-Source: APXvYqxka+yjbon9rkmgVolAvt54SAqyOq57dO7PoRUcSOjoTBq2//NQwKNuboXxNpMnv/PQVUUbanMutpDS85UkDAE=
X-Received: by 2002:a63:c0e:: with SMTP id b14mr43436137pgl.4.1562246762433;
 Thu, 04 Jul 2019 06:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190704023647.4873-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190704023647.4873-1-huangfq.daxian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jul 2019 16:25:50 +0300
Message-ID: <CAHp75Vc-8cmnaKDcnWPEZAOWTF5-4p_otH=Q926BCprQaL1TkA@mail.gmail.com>
Subject: Re: [Patch v2 10/10] platform/x86/asus-wmi: using dev_get_drvdata directly
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 5:37 AM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> Several drivers cast a struct device pointer to a struct
> platform_device pointer only to then call platform_get_drvdata().
> To improve readability, these constructs can be simplified
> by using dev_get_drvdata() directly.

v1 had been applied.

> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Make the commit message more clearly.
>
>  drivers/platform/x86/asus-wmi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 9b18a184e0aa..49049b02a015 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1353,8 +1353,7 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
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
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
