Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC9CC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278832089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f4OdmP+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfFGGkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:40:08 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38529 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFGGkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:40:08 -0400
Received: by mail-vk1-f195.google.com with SMTP id p24so196421vki.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKhb4oCF7D3bqEsoqNhCVNdLG8S+Ey80GvxfLYnC/Lc=;
        b=f4OdmP+qS6pC/zAcoeFc32wmbdUfirfCvBWVMueiLutQhc9DWgoSGN7oHAgSTMYV3I
         gmE44ShcRgS7eSRmdtWScatlgVhS3ESP++RYpg2JF07acIMELQWV4q5mBacMmxuPc4rX
         1S0INFUsptCO60dtZmVlSapJ7fwb5lTSbX9/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKhb4oCF7D3bqEsoqNhCVNdLG8S+Ey80GvxfLYnC/Lc=;
        b=EWOkrSVCSaIR6hYUBEmRYbnaM/kbbPV54cIzubF2mNPDi0ONtFfVP38VQEx3CoRvTW
         tYfzTClNsTowZjxetzawSofLxW1orK0C10ZC8zG1gBygW4bFLlfxKuk0YddG5zhI9+TD
         edS8EsGkT6pxa09S1biW8Pphqn0pH5AUGL7mzQYQ9acUwxahcEuc9OKwj8hspdrw21rJ
         OWqlDwr47b2+1mhbW4UPpb8qK11C3gcQt/mRnkhU3PB1lX3GfrNdd/jHczZZFvwxGpEW
         LlFlpDrIUOVlAZgyxoZwqivgNYtvaaxH6GGLLy/kwDEwY+uzcmQQ1gW8O57cDKdicN5W
         P99A==
X-Gm-Message-State: APjAAAVhm6StZvHaoDfC0CLOj+FMVDoJhyuhikOykCkcibabfalmtmgP
        FeAyN26SDeK/sWSaxrFATMK6yCxjVGpkHwxY093+6A==
X-Google-Smtp-Source: APXvYqx5lzcXabWM0mfXfKnyl8GMY3abr37WvKDF/0SGDSXb7F0V+Uk7Rd1wKFD/vKUBvTY6sAPm5qWY4W/STmImnck=
X-Received: by 2002:a1f:e184:: with SMTP id y126mr14807148vkg.3.1559889606637;
 Thu, 06 Jun 2019 23:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190525124006.21284-1-yuehaibing@huawei.com>
In-Reply-To: <20190525124006.21284-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 7 Jun 2019 12:09:55 +0530
Message-ID: <CAL2rwxpg7b8H1+xxNgw4tw2yOnNhxRfsnwfxUPA5b93ajvX9Hw@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used
 variables 'buff_addr' and 'ci_h'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 6:10 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_fw_crash_buffer_show:
> drivers/scsi/megaraid/megaraid_sas_base.c:3138:16: warning: variable buff_addr set but not used [-Wunused-but-set-variable]
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_get_pd_list:
> drivers/scsi/megaraid/megaraid_sas_base.c:4426:13: warning: variable ci_h set but not used [-Wunused-but-set-variable]
>
> 'buff_addr' is never used since inroduction in
> commit fc62b3fc9021 ("megaraid_sas : Firmware crash dump feature support")
>
> 'ci_h' is not used since commit 9b3d028f3468 ("scsi: megaraid_sas:
> Pre-allocate frequently used DMA buffers")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 39d173ed5b69..92e576228d5f 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -3135,7 +3135,6 @@ megasas_fw_crash_buffer_show(struct device *cdev,
>         struct megasas_instance *instance =
>                 (struct megasas_instance *) shost->hostdata;
>         u32 size;
> -       unsigned long buff_addr;
>         unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
>         unsigned long src_addr;
>         unsigned long flags;
> @@ -3152,8 +3151,6 @@ megasas_fw_crash_buffer_show(struct device *cdev,
>                 return -EINVAL;
>         }
>
> -       buff_addr = (unsigned long) buf;
> -
>         if (buff_offset > (instance->fw_crash_buffer_size * dmachunk)) {
>                 dev_err(&instance->pdev->dev,
>                         "Firmware crash dump offset is out of range\n");
> @@ -4401,7 +4398,6 @@ megasas_get_pd_list(struct megasas_instance *instance)
>         struct megasas_dcmd_frame *dcmd;
>         struct MR_PD_LIST *ci;
>         struct MR_PD_ADDRESS *pd_addr;
> -       dma_addr_t ci_h = 0;
>
>         if (instance->pd_list_not_supported) {
>                 dev_info(&instance->pdev->dev, "MR_DCMD_PD_LIST_QUERY "
> @@ -4410,7 +4406,6 @@ megasas_get_pd_list(struct megasas_instance *instance)
>         }
>
>         ci = instance->pd_list_buf;
> -       ci_h = instance->pd_list_buf_h;
>
>         cmd = megasas_get_cmd(instance);
>
> --
> 2.17.1
>
>
