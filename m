Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C78AC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4F12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZhhQ0nQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfE0IBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:01:12 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35341 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfE0IBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:01:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id r7so3916223ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBSUB4SN9OQHrj4cS3m08A0jB5J8vJS1S0v+4XLlE6Q=;
        b=ZhhQ0nQYNF4NIRNcn8EBoMCENvbjo/FT16CK5aZsaQlVJzsTPPRM1WjKPMMVjZMqa0
         NMLtpPdg0Z3+IdtejtnhYB8qZEupLY4/qS90T+Uf2jaMcSJFK9CEAQ2T3MFDXkPDDddD
         bZJbsRElCU//XHK/eBO0PhkTi93SQzsshlT5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBSUB4SN9OQHrj4cS3m08A0jB5J8vJS1S0v+4XLlE6Q=;
        b=NcZ+4iqJS4pEtmlzgjr9+5SfFUJQuCQLTDkWoTBT+rWM/TxVyx+7VeA5ukfyNUlLST
         fnzb0W3PI6YqaQd1K3bjUiuWvREV+LgczgCgPUSMeJi+ClzD96Pmcx7WmOsYpkOhZyKX
         uMOBDEoWv5q9pB+KYO1nlPtG8uUE23nEz84UDMJeHznyrp9MceK09HH/ZhKp9iQlMKNo
         A/NqeFQlsn3C2dsLXv8icuoel467SjmDKnNLR/cWV4Kif93J5KtlETlcwQKtyslTVmyr
         TqwoStG0c2+Gf4g8Pkct6JfWfxQ0y2QVswV3caMc1PyS3/lSUdg3jNbmDgw4xgs6K3Ae
         pwhg==
X-Gm-Message-State: APjAAAVlXAwCcYgZvHxug1a2QcbXC9NPSyZvU441blHKwku9rAt5Mnwr
        XDHPIA0zBIX9n+JRAbtSr/hvfZvBq1gZdv+KXTyD7WQGQsY=
X-Google-Smtp-Source: APXvYqzkfGtl1QOJitY9/IYlk2BjiUCahgGT/Fg6vPpgSQhBy5rvKcyR1VEpJW2OnRnxzyHMeqdv4eqfq1dQsogSskQ=
X-Received: by 2002:ab0:70d1:: with SMTP id r17mr20075942ual.136.1558944070794;
 Mon, 27 May 2019 01:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190525124202.8120-1-yuehaibing@huawei.com>
In-Reply-To: <20190525124202.8120-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Mon, 27 May 2019 13:30:59 +0530
Message-ID: <CAL2rwxrmVuTsR=JY4h5agyTPMdsZA1xgvdC09O9XV3gDMTm2BQ@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used
 variables 'host' and 'wait_time'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 6:14 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_suspend:
> drivers/scsi/megaraid/megaraid_sas_base.c:7269:20: warning: variable host set but not used [-Wunused-but-set-variable]
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_aen_polling:
> drivers/scsi/megaraid/megaraid_sas_base.c:8397:15: warning: variable wait_time set but not used [-Wunused-but-set-variable]
>
> 'host' is never used since introduction in
> commit 31ea7088974c ("[SCSI] megaraid_sas: add hibernation support")
>
> 'wait_time' is not used since commit
> 11c71cb4ab7c ("megaraid_sas: Do not allow PCI access during OCR")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 92e576228d5f..ed0f6ca578e5 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -7239,11 +7239,9 @@ static void megasas_shutdown_controller(struct megasas_instance *instance,
>  static int
>  megasas_suspend(struct pci_dev *pdev, pm_message_t state)
>  {
> -       struct Scsi_Host *host;
>         struct megasas_instance *instance;
>
>         instance = pci_get_drvdata(pdev);
> -       host = instance->host;
>         instance->unload = 1;
>
>         dev_info(&pdev->dev, "%s is called\n", __func__);
> @@ -8367,7 +8365,7 @@ megasas_aen_polling(struct work_struct *work)
>         struct megasas_instance *instance = ev->instance;
>         union megasas_evt_class_locale class_locale;
>         int event_type = 0;
> -       u32 seq_num, wait_time = MEGASAS_RESET_WAIT_TIME;
> +       u32 seq_num;
>         int error;
>         u8  dcmd_ret = DCMD_SUCCESS;
>
> @@ -8377,10 +8375,6 @@ megasas_aen_polling(struct work_struct *work)
>                 return;
>         }
>
> -       /* Adjust event workqueue thread wait time for VF mode */
> -       if (instance->requestorId)
> -               wait_time = MEGASAS_ROUTINE_WAIT_TIME_VF;
> -
>         /* Don't run the event workqueue thread if OCR is running */
>         mutex_lock(&instance->reset_mutex);
>
> --
> 2.17.1
>
>
