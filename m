Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F7DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3716423431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UJfpyNDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfICN3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:29:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37690 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:29:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so19911815qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSCrsgtUDOrdMKexctcYwvLETgiF3cYlWaBb3HHaSbs=;
        b=UJfpyNDiEYeIfGsfuZHqmN1M22/sY3oHMoq+94AImqFUbIcEiMK18AUSiub89oF0DN
         6alIfIUEzABH9P29i54S9c3HRjoxEIWUFZlSXn4tbCzFtVnTtRGU7OBvWeVQ0Hz/vLW2
         Tmx0uTCD10/Uj09DGFmNsi70AorIqlmW9DvsbfINv9kmPzpQUm8VRfoeZaOpk7bkLtTz
         h7Qpp4kKpuHv5wS+X7ftnyS0ZTPad3uWxrg1KwoY5mKrAuIhyqWtjDxOwCdT9HKigZnY
         yV0mCdAJv0zY+I5VRRo5JeIQ90Bzn0cDW9nHSkv1dQjo6yHt6EC1UWUFAozXkCAPGQ0h
         hTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSCrsgtUDOrdMKexctcYwvLETgiF3cYlWaBb3HHaSbs=;
        b=Cmx3B6kH+KlEs7f456RMqtGS0XG1KhczBV9b0ELcvBrYgopytQOuCS94QAQPPyJ32H
         c1+4B7yPRPFWyXX8HKambx33b+b1wfI7Sh4i0tkSA0QvAjhri8n0QvwLwtHtPnG6v1+8
         imNPkT9XDLgRf7vPL4XNMPWK7w+vvGhCZN31zHdaRYcMPBm2e54WNChugpz7tNkVxlSV
         VkKaBZVcgBkhjtUpjz+tuXtCM3LRB3UyzzWdVcgwEH7DyeqlQspfcQFguXiXveTlRS6J
         x225OpvzWjg8cJziadNC3TTZ4ekD87dTHHUcKIeQDZ2Q9f/2nkX8q8njEc6o+n1eSPTN
         k5uQ==
X-Gm-Message-State: APjAAAVT/yhKgiz33MwlrZMEVywvUb2Fep/HWmh2yb2fLUG5AmYlTfGj
        BFdonyOiQeY0pIQCyWdw3+PASDyqMFk=
X-Google-Smtp-Source: APXvYqw/yxe4cj3zPsPpC0WLlYfi8qeZk7SV9W2df+c/k7Ixec4IezKnFBb6gQSOI8MGlLhcGrN34A==
X-Received: by 2002:ac8:7b99:: with SMTP id p25mr33996117qtu.243.1567517356351;
        Tue, 03 Sep 2019 06:29:16 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f34sm9330397qtc.19.2019.09.03.06.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 06:29:15 -0700 (PDT)
Message-ID: <1567517354.5576.45.camel@lca.pw>
Subject: Re: [PATCH] powerpc/powernv: fix a W=1 compilation warning
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        Christoph Hellwig <hch@lst.de>
Cc:     aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Date:   Tue, 03 Sep 2019 09:29:14 -0400
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

I saw Christ start to remove npu-dma.c code [1]

[1] https://lore.kernel.org/linuxppc-dev/20190625145239.2759-4-hch@lst.de/

Should pnv_npu_dma_set_32() be removed too?

It was only called by pnv_npu_try_dma_set_bypass() but the later is not used
anywhere in the kernel tree. If that is a case, I don't need to bother fixing
the warning here.

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
