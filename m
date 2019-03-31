Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4232BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C41020870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="b/lsL4/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfCaRsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:48:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39967 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbfCaRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:48:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so8865628wre.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoDVc6qwD3yWLXry4REsZCGe/aZt6auFVMXcpkGOgYU=;
        b=b/lsL4/ys+IyaDTQbktPpdEgxEtsL5du3XD5lwlYTf9XIhCgsmZoQtOeaA0UIfEp5p
         KDbfsWUnB7RZVN47vEsHcJsdoXu8EER8zu6ocwwnvnZzmqYoc1RP3f6+SAtxAxTetdaY
         WnfCOexAQfft/LLXUJZjkAYu68SYm+0cxtSuaO2N6ci4OQL/oco5ois3tJ01dHT7WOyN
         GjSMdZjEEhml+sOcATcgUXcgoUpJsB3SOlBcIDQ9sIYE3yF02lkxMsFolKjgz7ARDJnH
         g6lpTVh7kwrrJHyLkWDRPuy87G/1HfcjOUDfeIxl4Uq1MHbcYi68y8dyVFNfsqu6SKAm
         Wb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoDVc6qwD3yWLXry4REsZCGe/aZt6auFVMXcpkGOgYU=;
        b=TMsOjfxOGsQTFO8JJTzcI838ayYZ1iLqLrOky/KO4Dgg4xWkyO9Zu9VG07umQqCMBc
         K3VcSh3HZUlMYx7v5PWndnwi4upzRyFV1GDvBce+6klZ9ahN7kAzi2BAO8bUjfRcUeA8
         AmReTzyIRlVCugvuqBpukKNaDNsnU62XgSnzXAENuGt3OVnxg4t6ERDmwF5+jcIkgekt
         vdgGip2UUJ2H5bBcXmz41/D/q34Tj+y2vJugzr7hb9iKusmOtYoqBUEJOIkaHqwbaEVU
         UFR15MTcp56N0H7DaMZP+2Q+OI0Pqty9vLHzW4LYYMEaDPU87AlTIFWC4G1fxb72yXdk
         paPg==
X-Gm-Message-State: APjAAAV1LkEyERPDZNQza59W9ce7X+ZQuiiI2nGHrHKLhWq5+1dbmyg0
        IjMQt9z0nRFo9dvlh4SatenwttR5Rw4w7tXMMjMJ1w==
X-Google-Smtp-Source: APXvYqwFf4nAMu0Ry8NXeuCogymFIdIrrgCmfxY/ncAiPL1c/lw5wu/riVMJ3HiUBv2Ca0r9srzvJz9qQ5c9TI4rT8E=
X-Received: by 2002:adf:e60d:: with SMTP id p13mr37490584wrm.265.1554054482716;
 Sun, 31 Mar 2019 10:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190329234423.5611-1-colin.king@canonical.com> <20190329234423.5611-2-colin.king@canonical.com>
In-Reply-To: <20190329234423.5611-2-colin.king@canonical.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Sun, 31 Mar 2019 19:47:53 +0200
Message-ID: <CAMGffE=2Gzx_LGjv9znERm0W38A3XpGF4r7nVgTvHrf+3Pg6-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: pm8001: clean up structurally dead code when
 PM8001_USE_MSIX is defined
To:     Colin King <colin.king@canonical.com>
Cc:     Jack Wang <jinpu.wang@profitbricks.com>,
        lindar_liu <lindar_liu@usish.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:44 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> When macro PM8001_USE_MSIX is defined there is redundant dead code
> call to pm8001_cr32.  Clean this up for the defined PM8001_USE_MSIX and
> undefined PM8001_USE_MSIX cases.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks, Colin,
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 7 ++++---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index e4209091c1da..434498a78946 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -4625,15 +4625,16 @@ static int pm8001_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
>
>  static u32 pm8001_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
>  {
> -       u32 value;
>  #ifdef PM8001_USE_MSIX
>         return 1;
> -#endif
> +#else
> +       u32 value;
> +
>         value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>         if (value)
>                 return 1;
>         return 0;
> -
> +#endif
>  }
>
>  /**
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 536d2b4384f8..4a176e60307f 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4619,15 +4619,16 @@ static int pm80xx_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
>
>  static u32 pm80xx_chip_is_our_interupt(struct pm8001_hba_info *pm8001_ha)
>  {
> -       u32 value;
>  #ifdef PM8001_USE_MSIX
>         return 1;
> -#endif
> +#else
> +       u32 value;
> +
>         value = pm8001_cr32(pm8001_ha, 0, MSGU_ODR);
>         if (value)
>                 return 1;
>         return 0;
> -
> +#endif
>  }
>
>  /**
> --
> 2.20.1
>


-- 
Jack Wang
Linux Kernel Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 30 57700-8042 | Fax: +49 30 57700-8598
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de


Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim Weiss

Member of United Internet

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
