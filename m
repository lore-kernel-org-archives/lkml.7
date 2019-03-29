Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76976C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418672054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AitOjv1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfC2IQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:16:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46224 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbfC2IQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:16:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so1389423wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BlD6VMkCe5xLw5Q7JuApqRY+x99uFC+suvVK7/jEtI=;
        b=AitOjv1E7DnR5LIcpHtjt2Ck5UTPwRTsi9Ts+RjNNc0hLxZiNTN8RxfAr7C3zXsbqD
         oMf9QDS10sRrd7/XcNDrkKmMjUd7i44oCG7e7a/D0+aLQFc13rKmif7ts/qsUf7VA8Cv
         MdDgvYdrPBH8LJDXA7oLpSOKNS6JGDtQqIYLOFu9VMR/iHYLaUzZDzPwqjTRaLlZUofy
         Djbw15Rd3AG+e65koDZF3uZMz9dCfc+056FYAE8G/WGpyiRfSI2A+XI6IEJCJ1Ec39iD
         vc7PM0mZtSf7/LCqpPBhmAm804eMPgMsRdjjrIRODTYUBCwWnqbKLXqBGrfeLpf702fR
         YAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BlD6VMkCe5xLw5Q7JuApqRY+x99uFC+suvVK7/jEtI=;
        b=HptaNQT8lz3mmDYCui5GlQxrAwoF66VWdAk846w89ZmuUdFfZUdtRWxj5RGxzZ+enA
         k4G2NQw/ObjRSAuhl7dErPVWCOoSu0R5ARqd/Ayc4eilhFxSSkqTTQ+xCUU7zYEFusov
         tbjrnMQcxsL9mKPLwUBmvcNbafBXTwo7xhiYv5bPYCHCUYV2XAjmbU/k9ljHU4BVKl+F
         8K1Y9GgmwRx9qdmUQSirJ1MUUX1e88ReAi14hekfBDXhPobuhpeKSTvoA48n1S8uSBj5
         arX0YSjy7X0e/U/Vg24abFQ5clh6PQiKaInUjtMiak32GxEjJv+96z8zJKKXoDQSC2ar
         AYYg==
X-Gm-Message-State: APjAAAVHYr/7l1/0aQk5BBBGly2Eb/3VPKaG1j7RMKVJYAM5w4jDXyhr
        VgBWfXiMqDK26bIx4rHDq4fxJTCDnSD0Y8++5oPi/A==
X-Google-Smtp-Source: APXvYqyi9OYvo6IDDR5vozj62Dcv3jTa9zAuTSjBcry+S+I6wUJD8wVOQd8zwQjAsAB/JPa/+Xzcjs+zPjts/SYHU3o=
X-Received: by 2002:adf:f60e:: with SMTP id t14mr28241557wrp.39.1553847394591;
 Fri, 29 Mar 2019 01:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190328234328.15860-1-colin.king@canonical.com>
In-Reply-To: <20190328234328.15860-1-colin.king@canonical.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 29 Mar 2019 09:16:23 +0100
Message-ID: <CAMGffE=F-NUsfiBpDTO=U_7vOaEQ3QeUQ1+pw4GiEs9WMNj-sg@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: clean up structurally dead code when
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

On Fri, Mar 29, 2019 at 12:43 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> When macro PM8001_USE_MSIX is defined there are redundant dead code
> calls to pm8001_chip_intx_interrupt_{enable|disable}. Clean this up
> by compiling in the appropriate enable/disable handlers for the
> defined PM8001_USE_MSIX and undefined PM8001_USE_MSIX cases.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks, Colin,
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index e4209091c1da..7d81246a432b 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1204,6 +1204,7 @@ void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha)
>         }
>  }
>
> +#ifndef PM8001_USE_MSIX
>  /**
>   * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
>   * @pm8001_ha: our hba card information
> @@ -1225,6 +1226,8 @@ pm8001_chip_intx_interrupt_disable(struct pm8001_hba_info *pm8001_ha)
>         pm8001_cw32(pm8001_ha, 0, MSGU_ODMR, ODMR_MASK_ALL);
>  }
>
> +#else
> +
>  /**
>   * pm8001_chip_msix_interrupt_enable - enable PM8001 chip interrupt
>   * @pm8001_ha: our hba card information
> @@ -1256,6 +1259,7 @@ pm8001_chip_msix_interrupt_disable(struct pm8001_hba_info *pm8001_ha,
>         msi_index += MSIX_TABLE_BASE;
>         pm8001_cw32(pm8001_ha, 0,  msi_index, MSIX_INTERRUPT_DISABLE);
>  }
> +#endif
>
>  /**
>   * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
> @@ -1266,10 +1270,9 @@ pm8001_chip_interrupt_enable(struct pm8001_hba_info *pm8001_ha, u8 vec)
>  {
>  #ifdef PM8001_USE_MSIX
>         pm8001_chip_msix_interrupt_enable(pm8001_ha, 0);
> -       return;
> -#endif
> +#else
>         pm8001_chip_intx_interrupt_enable(pm8001_ha);
> -
> +#endif
>  }
>
>  /**
> @@ -1281,10 +1284,9 @@ pm8001_chip_interrupt_disable(struct pm8001_hba_info *pm8001_ha, u8 vec)
>  {
>  #ifdef PM8001_USE_MSIX
>         pm8001_chip_msix_interrupt_disable(pm8001_ha, 0);
> -       return;
> -#endif
> +#else
>         pm8001_chip_intx_interrupt_disable(pm8001_ha);
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
