Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B017C742CA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2181D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pM5Hh4kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfGLP3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:29:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39157 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfGLP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:29:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so8480754qtu.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbIZ4fsnq/bMmsE1HOYvxUvp6AyyxU96K8pEGWgO1Z0=;
        b=pM5Hh4kgLt9RcG5UX8PPdOxYKCfmlBqPdN72rNJ7x/0KIScXNBki/H+h3I0d4lcdV6
         nypPvti7tSU9sfqkK3SgIDGMN7v9shbCMOEC0suFhhdUEr4Yg1gQH7MTXBqjUKV/KDMT
         +QgErgNZufptZIvx1+9HN4PRkHrVLa7/VrPI0+z8WK85xfHKnkiUrbfPYFX/VN6h4vEb
         gHRq43/vcLAk9RMy+9xFc2TA61O8y+CezknTfDHTxLpfGWUlduogiKcynU8k1MResXRa
         61xOMf9Da5xu5DnGU54yqXS2+EI4b0Ow5zmGR1ylDr0zQWFFiWXDT2HXdDaOyW73GKSG
         kXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbIZ4fsnq/bMmsE1HOYvxUvp6AyyxU96K8pEGWgO1Z0=;
        b=kpf+1LlTQ8A1yVhfpECGERx9L1cPst8WkCkYAbXWNdhE2+PT9xT8JmpVP5PEPniSnK
         B5g4Lw5NF1jrsLQco2pe/ZT5jEXPwO9ab0UOro2CnfJzezrsko53D4JOqU4yFcKm1LAP
         /SEGPUYGBDCUnHvJAOFt/ZEPfsR0nQpAElqNje8yeXKNUG+Ntk7PJXh+MuQXg/+OWPND
         TA81ClbyqSjBwg7LN2icXWI13PLLmc7QifNk8kCU153gPnR2eLYP/Yky8riPFPADizFA
         MP9SeEMrE5lyDF5ZG11MeaYtG8xCadFzU3ooo/GStzGfxUaNv9ecczjtjX7/iZTQrfdn
         DBEA==
X-Gm-Message-State: APjAAAVAk6YuOlNBYIw+cXWFdZsBjbwxbOgVFIEwxWljEsHHBEF9uVh1
        m0ejoGunKGsdqdN/BbmGt7DxyA==
X-Google-Smtp-Source: APXvYqx4GHYUh9QqZYC3BhOAfwgBw85mw+jPseU8wXr2ewenlgxU8gpnm9A2+7IF1NynsfUGiA1QSQ==
X-Received: by 2002:a0c:ea34:: with SMTP id t20mr7112177qvp.11.1562945350546;
        Fri, 12 Jul 2019 08:29:10 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u4sm4091905qkb.16.2019.07.12.08.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:29:09 -0700 (PDT)
Message-ID: <1562945348.8510.27.camel@lca.pw>
Subject: Re: [PATCH] powerpc/powernv: fix a W=1 compilation warning
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 11:29:08 -0400
In-Reply-To: <1558541369-8263-1-git-send-email-cai@lca.pw>
References: <1558541369-8263-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Wed, 2019-05-22 at 12:09 -0400, Qian Cai wrote:
> The commit b575c731fe58 ("powerpc/powernv/npu: Add set/unset window
> helpers") called pnv_npu_set_window() in a void function
> pnv_npu_dma_set_32(), but the return code from pnv_npu_set_window() has
> no use there as all the error logging happen in pnv_npu_set_window(),
> so just remove the unused variable to avoid a compilation warning,
> 
> arch/powerpc/platforms/powernv/npu-dma.c: In function
> 'pnv_npu_dma_set_32':
> arch/powerpc/platforms/powernv/npu-dma.c:198:10: warning: variable ‘rc’
> set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c
> b/arch/powerpc/platforms/powernv/npu-dma.c
> index 495550432f3d..035208ed591f 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -195,7 +195,6 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
>  {
>  	struct pci_dev *gpdev;
>  	struct pnv_ioda_pe *gpe;
> -	int64_t rc;
>  
>  	/*
>  	 * Find the assoicated PCI devices and get the dma window
> @@ -208,8 +207,8 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
>  	if (!gpe)
>  		return;
>  
> -	rc = pnv_npu_set_window(&npe->table_group, 0,
> -			gpe->table_group.tables[0]);
> +	pnv_npu_set_window(&npe->table_group, 0,
> +			   gpe->table_group.tables[0]);
>  
>  	/*
>  	 * NVLink devices use the same TCE table configuration as
