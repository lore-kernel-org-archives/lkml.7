Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39787C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCED2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fEqFpleu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfFMPjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:39:02 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45653 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731940AbfFMJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:57:46 -0400
Received: by mail-vs1-f67.google.com with SMTP id n21so12223572vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xbxjq+/UWnkmz/Lz2NuZarwVK3ifkKHPS3ppszMgh6E=;
        b=fEqFpleuGhOamNp5m2EH71DOiuFlFeO8LAoM/7Lp8TSo2eVpZ9KPxeKGpTLl5GjcwV
         S3d/AsmOzAXn2VmPPGGFecfnZaHbXbcxYJ+UVbXEz+fkjYrgIs2yGsUVg9uCX7fQmPrd
         Vshj30LgbeysHLD1OUon+3yIb+M7yDp2isl3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xbxjq+/UWnkmz/Lz2NuZarwVK3ifkKHPS3ppszMgh6E=;
        b=VBEliNNxkrbCUerilVhqn8kKiPuc/D5PmhSGvMlwkXLAN4ml9ahq9l0ZojIDSZKhcV
         E3//5QdaQVtG5uSrpt9kwSgQfnMRGPLBlz740TGBB70s7/V8/gIapjwHf/7tD+Lv3WdY
         Pcie3CbYj3vIa9kkhQL+Hrjgw9lRmBvSXne9NJk4pRuzG1JOrhEyNJQhzbR+TwkHKIUY
         1z7vO/ZjgNSTPm16UCW6lL0j3EttDXH01s+20ZPBaHXvmDWTRRQS+Cxzl/LSTAU5LBSR
         zyxdkO8rnwQIqRAyEg58hox1hrQPUZl7HQWwXH2ZX8n0cF+QUcxJZcKZXMaT90BxSE3n
         4Abw==
X-Gm-Message-State: APjAAAXVXzKXquy8+bvy+uNxt5qUhpVN5/gXtbqhvL/E8kKQVX6b9+2J
        ZTdTKorKkFYQFGJC3dtkhGX53Xd+7YVbwec0oOrjdg==
X-Google-Smtp-Source: APXvYqy8eW2B7bGa1hDxGrsKEeZEhxQC13lqGDOpm+tCyesLdD1fgE55BDfcTpopDHtmpo3xBKwWIrlu4iHQQYmeJtk=
X-Received: by 2002:a67:ebcb:: with SMTP id y11mr8620799vso.138.1560419865266;
 Thu, 13 Jun 2019 02:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190607184053.GA11513@embeddedor>
In-Reply-To: <20190607184053.GA11513@embeddedor>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Thu, 13 Jun 2019 15:27:33 +0530
Message-ID: <CAL2rwxpUyVE5T2QBT7ze5QoeH3KgkXCWPwjgQKuAUrd4VxHEOg@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid_sas: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 8, 2019 at 12:10 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct MR_PD_CFG_SEQ_NUM_SYNC {
>         ...
>         struct MR_PD_CFG_SEQ seq[1];
> } __packed;
>
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
>
> So, replace the following form:
>
> sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) + (sizeof(struct MR_PD_CFG_SEQ) * (MAX_PHYSICAL_DEVICES - 1))
>
> with:
>
> struct_size(pd_sync, seq, MAX_PHYSICAL_DEVICES - 1)
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index a25b6b4b6548..56bd524dddbf 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -1191,7 +1191,7 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
>  int
>  megasas_sync_pd_seq_num(struct megasas_instance *instance, bool pend) {
>         int ret = 0;
> -       u32 pd_seq_map_sz;
> +       size_t pd_seq_map_sz;
>         struct megasas_cmd *cmd;
>         struct megasas_dcmd_frame *dcmd;
>         struct fusion_context *fusion = instance->ctrl_context;
> @@ -1200,9 +1200,7 @@ megasas_sync_pd_seq_num(struct megasas_instance *instance, bool pend) {
>
>         pd_sync = (void *)fusion->pd_seq_sync[(instance->pd_seq_map_id & 1)];
>         pd_seq_h = fusion->pd_seq_phys[(instance->pd_seq_map_id & 1)];
> -       pd_seq_map_sz = sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) +
> -                       (sizeof(struct MR_PD_CFG_SEQ) *
> -                       (MAX_PHYSICAL_DEVICES - 1));
> +       pd_seq_map_sz = struct_size(pd_sync, seq, MAX_PHYSICAL_DEVICES - 1);
>
>         cmd = megasas_get_cmd(instance);
>         if (!cmd) {
> --
> 2.21.0
>
