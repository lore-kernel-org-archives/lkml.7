Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E4C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99727208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZIENBkuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfFGGgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:36:14 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38401 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfFGGgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:36:13 -0400
Received: by mail-vs1-f65.google.com with SMTP id b10so530468vsp.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUw9ISMPGHSgRh2KdM2HGIT34kJ3x6jiWvQJ3Y7JEOw=;
        b=ZIENBkuV+65B17001zA6jR4EfLu0gUD5mQO9Uehe+MYtDvP7sg6FaHCpOTZn0V7moO
         aeQeggPButGXdlh3l+1CJ0LRez4REvNOPCkvZfM0rdwngG6OTerORMZoab7XIizXIDdf
         VCk2Ekwn0j6PHyUBOsWjmlyOjzKJU2vVWjdPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUw9ISMPGHSgRh2KdM2HGIT34kJ3x6jiWvQJ3Y7JEOw=;
        b=YE17Uc8NJU4ftwo9HR3fQg6KykfA6LNNOkdGFhK6BILFZRGnNcK6Pu4FyO0PqshdtT
         EMm9Oh43N6z568ex7YU9HLAGjS+oKDvqnGs4TfPAq8mPSXDD5Tup0W77RhURe+rD0EJq
         yZ6QmeN4fK3+FjtloUWOcdemaG8ogsIFRtxCvIupmkceAgboEJCUsczg8nJJoQJxEuSk
         n3o/R86WQZeaiUULDu+NgnYInExEX+aHNm+tl58MZHDIUFGFjDRpIZH3sSqhwhAfYkTv
         SN1uBXlOhQXDPsUnalOECwHT4OgfAZeJRqM1IFtwhawqgys1PDaTZiWigI8QZ26Z4NVg
         OkFw==
X-Gm-Message-State: APjAAAUCI1vMQAq8uWo2zuzvEGiP2AKA9L6Le+RwEQxEZHp2jO1iC+KQ
        k/xd2YwoN35saxusu+nAr/K/nUMkFCHe6XqOvLL/xQ==
X-Google-Smtp-Source: APXvYqw9TJz+d26iMe8IX5YhwPQItF/uBMG5lcq6EkUJxtv8WLmxNcmMsoJw1P0kitqbTkvFQVVSXTEFjJuWpguXvAk=
X-Received: by 2002:a67:ebcb:: with SMTP id y11mr476318vso.138.1559889372706;
 Thu, 06 Jun 2019 23:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190525123705.8588-1-yuehaibing@huawei.com>
In-Reply-To: <20190525123705.8588-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 7 Jun 2019 12:06:01 +0530
Message-ID: <CAL2rwxroDkKSRCN9inYZTGD79h+8AWn6LO3+=ND316=BVm40ug@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used
 variable 'sge_sz'
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

On Sat, May 25, 2019 at 6:07 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_create_frame_pool:
> drivers/scsi/megaraid/megaraid_sas_base.c:4124:6: warning: variable sge_sz set but not used [-Wunused-but-set-variable]
>
> It's not used any more since
> commit 200aed582d61 ("megaraid_sas: endianness related bug fixes and code optimization")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index b26991dcf137..25281a2eb424 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -4121,22 +4121,11 @@ static int megasas_create_frame_pool(struct megasas_instance *instance)
>  {
>         int i;
>         u16 max_cmd;
> -       u32 sge_sz;
>         u32 frame_count;
>         struct megasas_cmd *cmd;
>
>         max_cmd = instance->max_mfi_cmds;
>
> -       /*
> -        * Size of our frame is 64 bytes for MFI frame, followed by max SG
> -        * elements and finally SCSI_SENSE_BUFFERSIZE bytes for sense buffer
> -        */
> -       sge_sz = (IS_DMA64) ? sizeof(struct megasas_sge64) :
> -           sizeof(struct megasas_sge32);
> -
> -       if (instance->flag_ieee)
> -               sge_sz = sizeof(struct megasas_sge_skinny);
> -
>         /*
>          * For MFI controllers.
>          * max_num_sge = 60
> --
> 2.17.1
>
>
