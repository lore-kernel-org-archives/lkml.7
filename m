Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A000ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D307520872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TuTgvHXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389594AbfJPCHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:07:21 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44444 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJPCHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:07:21 -0400
Received: by mail-il1-f195.google.com with SMTP id f13so859772ils.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 19:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=51zE725bGKn/TMsbEENR+3CzjGIUxaDayj5ujguNtv8=;
        b=TuTgvHXnCneheTiY92PhGPs5WuijQ83ksh7D0cAI0C9x8HFesAJhsgRelKOXXMWhPo
         OqxujUk6fNo9nnCyVfR4jMvaRh5xf4wNJB2sA24dA5vqWIOeC5QBMg28ArPEDqvaoYO/
         Xlqnm9+O+7chiIniytFR0+6+ilfWyuj1I42ho43TJElpTcx3EFSDRUjACD07pbp23Uk9
         BCeAWHUFcJGt8ndp69mhiOWm9hZZjPSIMEfubVfSaE/obSlmnea7kn8Z7cRTdh5/Qm7c
         yWzPqiQURMDSUSjD8uEawNfKYW/27caNwDVRpDlRc9RXyoK+KpM9mVvjJ5dKr1++Gjsn
         6IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=51zE725bGKn/TMsbEENR+3CzjGIUxaDayj5ujguNtv8=;
        b=i6BaX44VmkYDuVtx30qmdqaB0jJNnb3TvEYd6idhISrd7kHe34yho7lvdOt7OW4eDE
         KOEkFqwwBMxJeJCHyNj/yj1b1T4onUZsW40EpGcybWu02av8JdxTh59Po87b0Q3fEBKJ
         I60iOne9zWnklvI3RevRPnBSAkVaWAOgiLBsSAkNvl9lKORMoUPrKFZdUlvLWb+SRsMA
         NSiF58MvFhzVFatyWuByuhE5mWLndcHorv0/+1OPPRF6f5HNc3Zv2vqLTOR9BHxJ6MlD
         PSUzmCg/gfaSA5haP2Oy+FqB0SZfDVQX5mkb9QkToSgzwbKLh53p6QzVbiGTY/nsAp+Z
         gjuA==
X-Gm-Message-State: APjAAAWRrmliowDD3A+L+8g5NL3pYp45kcxlwKT0SDAVC6J6reaPOx7I
        XbX5IippBspdn4OvLu9lL5sXZg==
X-Google-Smtp-Source: APXvYqzIRB6Bwyz35Ayx6azyqs98nmZMFA75wpQMZvBBAVpBl4S4ChwRipQn2BBFVSTLizuvItE5jQ==
X-Received: by 2002:a92:1948:: with SMTP id e8mr9256429ilm.302.1571191640330;
        Tue, 15 Oct 2019 19:07:20 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id q11sm3509738ilc.29.2019.10.15.19.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 19:07:19 -0700 (PDT)
Date:   Tue, 15 Oct 2019 19:07:17 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 08/20] riscv: abstract out CSR names for supervisor vs
 machine mode
In-Reply-To: <20190903093239.21278-9-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910151902060.12675@viisi.sifive.com>
References: <20190903093239.21278-1-hch@lst.de> <20190903093239.21278-9-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019, Christoph Hellwig wrote:

> Many of the privileged CSRs exist in a supervisor and machine version
> that are used very similarly.  Provide a new X-naming layer so that
> we don't have to ifdef everywhere for M-mode Linux support.
> 
> Contains contributions from Damien Le Moal <Damien.LeMoal@wdc.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

[ ... ]

> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index fb3a082362eb..853af1b7837b 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -56,23 +56,23 @@ void show_regs(struct pt_regs *regs)
>  	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
>  		regs->t5, regs->t6);
>  
> -	pr_cont("sstatus: " REG_FMT " sbadaddr: " REG_FMT " scause: " REG_FMT "\n",
> -		regs->sstatus, regs->sbadaddr, regs->scause);
> +	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
> +		regs->xstatus, regs->xbadaddr, regs->xcause);
>  }
>  
>  void start_thread(struct pt_regs *regs, unsigned long pc,
>  	unsigned long sp)
>  {
> -	regs->sstatus = SR_SPIE;
> +	regs->xstatus = SR_SPIE;

Looks like this should be "regs->xstatus = SR_PIE;"

Will update it here.  Let me know if you don't agree -


- Paul
