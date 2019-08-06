Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9BDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86922147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cBNuGU4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfHFHGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:06:01 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41277 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731834AbfHFHF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:05:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id 2so57599040vso.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 00:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvNLdWRzNCcP/1tMguZTrB/Ret9xhkOHTVDfmzeadKU=;
        b=cBNuGU4Dr8PNxOG4ZXsD1SeAcDdS2PkACRvfDIJni+NMYiI6xg8Z3QBrHu8RM3OnDB
         8wnSQRm1UoqZt/3vMiKQ90iQxecWGqvo0J+py/fnUuxiWlqxMkXHQhOG0x85badHtAHY
         ZreuyxdeX5OU0y20ts8cmzeJZgM3pv7EjchVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvNLdWRzNCcP/1tMguZTrB/Ret9xhkOHTVDfmzeadKU=;
        b=nMhhBHdCHZapuV8ZaVkk4c5DerCRTh4TwGb1NrnjiKdAtiHCVd7HysmFXGcSQQj8YH
         77rZWwSlilXv+J8invCNCtW69eIj1fiuQlG4jt831NSHhfFBowbCSfoM2Armj57s8Hhl
         YqmKPJi0hZ9FcAIwHwxkNrLsUuGTd4jgdJjEpfCq1nk00r/I4n2MqNDFhfaT6SaryG3x
         8I/aQgRc8sUcF0Rp7R1mGpBUTwT8BAJGA3l70dtcaTGAxRWPlQN9xuucSN8WSa/cTueN
         PaXjUPgX6QiaR5RoHuECgTe4hcbpT7kL1kiYlIrH+1Ptlr1dxBTeQ1pLcO5MB+0iO4ox
         nUWg==
X-Gm-Message-State: APjAAAWsVxaVLojN4+jQBZKwNZhNt5sNcDQXVCqX+i2OYaDM3hfcR9AR
        KPIgJgji7LaHDfvmYOFyQEZI9VdV049hsyn+oMfMrg==
X-Google-Smtp-Source: APXvYqwYKN6dkaPv4TtdWshELFYcyApVXP7DfanyMLNrK7YPEHywULSCcTgrkVrXVdFSaMz6ImBxPm40vHRDi0p9GHg=
X-Received: by 2002:a67:f355:: with SMTP id p21mr1369725vsm.204.1565075156521;
 Tue, 06 Aug 2019 00:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <1564151143-22889-1-git-send-email-cai@lca.pw>
In-Reply-To: <1564151143-22889-1-git-send-email-cai@lca.pw>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 6 Aug 2019 12:35:45 +0530
Message-ID: <CAL2rwxpSNMDUD3gRwXmuMZ2ZMjAOdg=ebprhB2v3n8f+Z4AcxA@mail.gmail.com>
Subject: Re: [PATCH] scsi/megaraid_sas: fix a compilation warning
To:     Qian Cai <cai@lca.pw>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 7:55 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit de516379e85f ("scsi: megaraid_sas: changes to function
> prototypes") introduced a comilation warning due to it changed the
> function prototype of read_fw_status_reg() to take an instance pointer
> instead, but forgot to remove an unused variable.
>
> drivers/scsi/megaraid/megaraid_sas_fusion.c: In function
> 'megasas_fusion_update_can_queue':
> drivers/scsi/megaraid/megaraid_sas_fusion.c:326:39: warning: variable
> 'reg_set' set but not used [-Wunused-but-set-variable]
>   struct megasas_register_set __iomem *reg_set;
>                                        ^~~~~~~
> Fixes: de516379e85f ("scsi: megaraid_sas: changes to function prototypes")
> Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index a32b3f0fcd15..e8092d59d575 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -323,9 +323,6 @@ inline void megasas_return_cmd_fusion(struct megasas_instance *instance,
>  {
>         u16 cur_max_fw_cmds = 0;
>         u16 ldio_threshold = 0;
> -       struct megasas_register_set __iomem *reg_set;
> -
> -       reg_set = instance->reg_set;
>
>         /* ventura FW does not fill outbound_scratch_pad_2 with queue depth */
>         if (instance->adapter_type < VENTURA_SERIES)
> --
> 1.8.3.1
>
