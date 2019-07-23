Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BC6C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD62223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OvduF8Vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403823AbfGWSQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:16:44 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39494 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403792AbfGWSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:16:38 -0400
Received: by mail-vs1-f65.google.com with SMTP id u3so29480974vsh.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSkiUPoJaljsYuDHJ6lt9nP9z02pxAFNV5R95iqHyrI=;
        b=OvduF8VyLrORhFzZ1ICw0D8FhVCvU2bPRyb4Ovqq9bl4q+R6wqLjH6WHPV55cdEiI5
         zM+CE5EdZxz0bq9V7zR5EFyG0WHBWsoIopM6nOO/EJ33ylQtjloy+c6HAjHpiwbtd6S/
         7mTniaqNbKTBlMerJ3blS4uYtKo9NpbFYTNao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSkiUPoJaljsYuDHJ6lt9nP9z02pxAFNV5R95iqHyrI=;
        b=F3yjW9Kntr4p/BixPDwoAJAtvtZGjG/mBP3afXMyYAJEWHjifJJCNAN0L20Kya8vQ0
         b7lyUwrVD8bJUoB75rWpdOIDe6MR1OdKbqr80wdAMaeCz1/AD+cq7RidxPGsYQG4Grdd
         dJrLI0DN8/T6bUowlcUo/8qYiqkPGqTjq5NUOn18e255T1/RwRzTXtaj1vCv5ijMPE2O
         jsrQwQOR8P0P0R09nnlsL/sbwglpl7d/VyPfJJq17yhjRDt/DRujZ3PUao4OZj03jxSh
         pj+0iOfsBmvm8XJJsVULCIPJgGE8Wn3fjXetlTdbkhUQwcidWqmxj7LW/UwiFUPNryJY
         a6IA==
X-Gm-Message-State: APjAAAUmYxdNEWASrxBDA7tBhaj9aZdnYYM8MJmFrrdlEcxntJrcOtdx
        yi9vFrRQ/58fgri8MbeCB4GbANUGQBGmirOmK13fpg==
X-Google-Smtp-Source: APXvYqyIN5bGa/H7JHUbriHAu46jJ6x4alh+YsFWKmuC9+cT9DqsufkF9rej2EVnd6D+auRAci555vkg8ezzzLV9Bds=
X-Received: by 2002:a67:c496:: with SMTP id d22mr9422716vsk.205.1563905797030;
 Tue, 23 Jul 2019 11:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190722161524.23192-1-junxiao.bi@oracle.com>
In-Reply-To: <20190722161524.23192-1-junxiao.bi@oracle.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 23 Jul 2019 23:46:25 +0530
Message-ID: <CAL2rwxoGqznXyi_bdV-ODoHE2Mhv6gT=PH=3jXkQXPnUJrEUNw@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: megaraid_sas: fix panic on loading firmware crashdump
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 9:45 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>
> While loading fw crashdump in function fw_crash_buffer_show(),
> left bytes in one dma chunk was not checked, if copying size
> over it, overflow access will cause kernel panic.
>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 80ab9700f1de..3eef0858fa8e 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -3153,6 +3153,7 @@ fw_crash_buffer_show(struct device *cdev,
>                 (struct megasas_instance *) shost->hostdata;
>         u32 size;
>         unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
> +       unsigned long chunk_left_bytes;
>         unsigned long src_addr;
>         unsigned long flags;
>         u32 buff_offset;
> @@ -3176,6 +3177,8 @@ fw_crash_buffer_show(struct device *cdev,
>         }
>
>         size = (instance->fw_crash_buffer_size * dmachunk) - buff_offset;
> +       chunk_left_bytes = dmachunk - (buff_offset % dmachunk);
> +       size = (size > chunk_left_bytes) ? chunk_left_bytes : size;
>         size = (size >= PAGE_SIZE) ? (PAGE_SIZE - 1) : size;
>
>         src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
> --
> 2.17.1
>
