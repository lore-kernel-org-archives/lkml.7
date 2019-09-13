Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F9C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCADC2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfIMTEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:04:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43313 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730539AbfIMTEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:04:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id d15so18624402pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=J8WZu8kPZWoeeQELgw+yQTV+q40PZLs/qmgDReqeZXk=;
        b=QHwZq/eKg6glENi4dOHryZED/oeEsGRUFXRu8f96DULCF43CvTNoSfpZLFhF7p0K6y
         WNFhz2VveOLsfGGRl9pPHERQpxUR0Dy/sSUDHfwLVUldD4zWRQ9v73x1WHL1uA74OeXB
         YejPsmSAukVf2rPAn6CO5LZD3puboTekCwndl15Iox6jFavx2NMSAmmW3JxhrL9d6QeZ
         OezJQX6xu1jLpSMLPINl7U/wg0lgRC2BP2Z6X8lEVwOQSeqVUGv8QJpd3W1GTyPsxC4O
         vYTd0wRlC98TVsf899aoZrG0MYgAOOI/g0NczenON893/hlUX6Nr+bnukSvi0luMf6+e
         q98g==
X-Gm-Message-State: APjAAAVb9KCpgrM0u9YjFFI9FWYHG5XIo/PhNQgTega2DofZ4j3QKyjA
        uB2ik/NssxMVWzWBSqp1swtlMg==
X-Google-Smtp-Source: APXvYqwJvSZDMasTEVNh5WsVDJxEBgwmLv1wBQK4AVmpBtSBRz7G3lmSplJTYG6MBOAci2cPyDA12w==
X-Received: by 2002:a63:188:: with SMTP id 130mr44264209pgb.231.1568401473606;
        Fri, 13 Sep 2019 12:04:33 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id p68sm56933518pfp.9.2019.09.13.12.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 12:04:32 -0700 (PDT)
Date:   Fri, 13 Sep 2019 12:04:32 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 10:15:26 PDT (-0700)
Subject:     Re: arch/riscv: disable too many harts before pick main boot hart
In-Reply-To: <EUNbud4OiUlulXZR0_kXWEOnsI1rm5JrQehjVFXdgbThdfwL5mmYxRGI7pwlf9tpuYhjjGSDRj-4jL1CtfzuOxhY62TYGw-d9L05FQxi7N4=@hardenedlinux.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        citypw@hardenedlinux.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     merle@hardenedlinux.org
Message-ID: <mhng-0a85b4e9-be39-469c-9a50-4ee1310f6e8e@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Sep 2019 23:51:15 PDT (-0700), merle@hardenedlinux.org wrote:
> From 12300865d1103618c9d4c375f7d7fbe601b6618c Mon Sep 17 00:00:00 2001
> From: Xiang Wang <merle@hardenedlinux.org>
> Date: Fri, 6 Sep 2019 11:56:09 +0800
> Subject: [PATCH] arch/riscv: disable too many harts before pick main boot hart
>
> These harts with id greater than or equal to CONFIG_NR_CPUS need to be disabled.
> But pick the main Hart can choose any one. So, before pick the main hart, you
> need to disable the hart with id greater than or equal to CONFIG_NR_CPUS.
>
> Signed-off-by: Xiang Wang <merle@hardenedlinux.org>
> ---
> arch/riscv/kernel/head.S | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 0f1ba17e476f..cfffea38eb17 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -63,6 +63,11 @@ _start_kernel:
> li t0, SR_FS
> csrc sstatus, t0
>
> +#ifdef CONFIG_SMP
> + li t0, CONFIG_NR_CPUS
> + bgeu a0, t0, .Lsecondary_park
> +#endif
> +
> /* Pick one hart to run the main boot sequence */
> la a3, hart_lottery
> li a2, 1
> @@ -154,9 +159,6 @@ relocate:
>
> .Lsecondary_start:
> #ifdef CONFIG_SMP
> - li a1, CONFIG_NR_CPUS
> - bgeu a0, a1, .Lsecondary_park
> -
> /* Set trap vector to spin forever to help debug */
> la a3, .Lsecondary_park
> csrw CSR_STVEC, a3

It would be better to decouple the hart masks from NR_CPUS, as there's really 
no reason for these to be the same.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
