Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F75C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D486521773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfC2Vuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:50:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33979 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfC2Vug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:50:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so2875015oib.1;
        Fri, 29 Mar 2019 14:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rs7S2foonqwWEFVwaHGYfcLOLiZaazzWH2lQCi+hjMA=;
        b=sygLuyCAJ0lYuF1fnjoqobyKERvh2F3QZmDCZY7aTJeIz9PJUHjseKEYR3f+25RFRe
         rDgrFuqZskMtGswsm70rqDVZVZ6xWVkydCsrnjjvRjGOM4HgFrpPjBY9+/8kGqoK3ews
         sgpzC+Gf/7+iw9no5Ln2BkuUqI3FVVrJiKlmLvrpSO0YYsDVwqG9MV7OztJOnNK1CrIO
         Tn6cDPB7ZfDzqOvffKGu/sJ45WWQpy6CD6i7P1f1OOaVHeJ7oowMeja61/8Ol8R3sCzY
         7H2KXACAlkx/5Te4nHAQUTrHSKu7Q7PvKNYP2i6QCeEsY3/X2sF5pIuzY8/Zp92dAlko
         efxQ==
X-Gm-Message-State: APjAAAVOkz+4qDvkvU5ZnE+KZWOMxc88iE8LMPNdUpH2G09iQ7/NkJcM
        ExNA0xQ2ZXNjz5ppQGxDYKSeEvZaJ8g=
X-Google-Smtp-Source: APXvYqwkVQgvKESgMO8tQ/CZ8tYJNWaiUxGGab5htJF5uIjO3AvZU5JLP5voYdVpflaGgkF0T8cP7A==
X-Received: by 2002:aca:d8c5:: with SMTP id p188mr4910723oig.144.1553896235992;
        Fri, 29 Mar 2019 14:50:35 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id 2sm857884ots.22.2019.03.29.14.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 14:50:35 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id u15so3372317otq.10;
        Fri, 29 Mar 2019 14:50:34 -0700 (PDT)
X-Received: by 2002:a9d:6d92:: with SMTP id x18mr20780140otp.112.1553896234713;
 Fri, 29 Mar 2019 14:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com> <20190329140014.8126-2-laurentiu.tudor@nxp.com>
In-Reply-To: <20190329140014.8126-2-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 29 Mar 2019 16:50:23 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng@mail.gmail.com>
Message-ID: <CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng@mail.gmail.com>
Subject: Re: [PATCH 01/13] soc/fsl/qman: fixup liodns only on ppc targets
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Netdev <netdev@vger.kernel.org>, madalin.bucur@nxp.com,
        Roy Pledge <roy.pledge@nxp.com>, camelia.groza@nxp.com,
        David Miller <davem@davemloft.net>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 9:01 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
> longer making sense and it also breaks the ICID settings inherited
> from u-boot. Do the fixups only for PPC targets.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/qman_ccsr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 109b38de3176..12e414ca3b03 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -598,6 +598,7 @@ static int qman_init_ccsr(struct device *dev)
>  #define LIO_CFG_LIODN_MASK 0x0fff0000
>  void qman_liodn_fixup(u16 channel)
>  {
> +#ifdef CONFIG_PPC
>         static int done;
>         static u32 liodn_offset;
>         u32 before, after;
> @@ -617,6 +618,7 @@ void qman_liodn_fixup(u16 channel)
>                 qm_ccsr_out(REG_REV3_QCSP_LIO_CFG(idx), after);
>         else
>                 qm_ccsr_out(REG_QCSP_LIO_CFG(idx), after);
> +#endif

According to the Linux coding style recommendation, it would be better
to put the #ifdef into the header files
"drivers/soc/fsl/qbman/qman_priv.h".  And I'm not sure if this is
needed on PPC when IOMMU(PAMU) driver is not compiled, if not,
probably using CONFIG_PAMU as condition would be even better.

>  }
>
>  #define IO_CFG_SDEST_MASK 0x00ff0000
> --
> 2.17.1
>
