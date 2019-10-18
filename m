Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE40CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EC221835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJTkrh1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504235AbfJRFF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:05:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41040 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfJRFF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so4690161wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A/Tf4iJWS8qcGlBMvo/id14sOzyak6H/JZlFaeq1a2M=;
        b=GJTkrh1foXLVx/GfRMgwY/5lZrE6f9Fzp9iyjCdB5NFY+dJeU/d3QExp2xXE18QY5l
         INr6CRdIP/oYiK2MI54mC66XxUdHkBJ5zJ9iRnMQg4Ip05vhs6wu7zLobhVq7FEcJtH1
         Ljw7Rem15V6dQg65HgOc2KxvQdIvAa1422/x7Uyu+dheEEt6NGHDEC4X6Ekhc/JG8BLI
         Na48sFj8Fwlg6iDcfBxfSYCUkmVkdM0RLpEpPrnFNF1Q2O6n2ylRctHkI0vThzAulNdq
         8KOHE98G/wc1uq+arXQrfdACByJaIho595AG6ZxA0vC6qghDEuoRMz282Mfy77ii/kzn
         GodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A/Tf4iJWS8qcGlBMvo/id14sOzyak6H/JZlFaeq1a2M=;
        b=A46/C1uZInzw8FMiLvXU20VVDCIsGNFHEwrtKubtKN6zNXrY0DwriCf37ZD8GXgzrM
         RvG3li81ExgYtvpIqtQA6daJSrpp/I3lm+ejGmtg2dWqRgRFvnReBaPfZtOW/O8m4K6L
         wfeee0UqdgWVcqbPrfALPjIhVesxyjI78naIj3tBHmlji1AMJ+k4xWeR86quPlRT8KXU
         JPGhQuCV31Z8xKj+7bY586lNyai7uOlP8R2Y9G8aq+5NiysLY891hbuTPPYJDJd6LL+Z
         glyX39NXEOQIK+f4fhjE5bUpBQ2VsH66PdwL5dC5aVjTskV7WTGZg26ymX/U0ES26mxd
         fc/Q==
X-Gm-Message-State: APjAAAWODC77eAuWqzGcQ95nWCNp3BV2rBjYHcVd14yjGnMVyStTF+8Y
        EjmRM2hntuz2iCNM5vjhhXmqtsUc
X-Google-Smtp-Source: APXvYqxjFg1SXCQ+fipbiPTH8W1CtjD2slFtJSRD3RXU/MYRTMdtOmGZYYVkzVsFh9Oh91u3gt6q4g==
X-Received: by 2002:adf:a506:: with SMTP id i6mr5692969wrb.159.1571371582365;
        Thu, 17 Oct 2019 21:06:22 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:18e1:7d90:ccf5:4489])
        by smtp.gmail.com with ESMTPSA id w18sm3970796wmc.9.2019.10.17.21.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:06:21 -0700 (PDT)
Date:   Fri, 18 Oct 2019 06:06:20 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] riscv: ensure RISC-V C model definitions are passed
 to static analyzers
Message-ID: <20191018040619.o3qb5fyj4qdevwoe@ltop.local>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
 <20191018004929.3445-5-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018004929.3445-5-paul.walmsley@sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:49:25PM -0700, Paul Walmsley wrote:
> Static analysis tools such as sparse don't set the RISC-V C model
> preprocessor directives such as "__riscv_cmodel_medany", set by the C
> compilers.  This causes the static analyzers to evaluate different
> preprocessor paths than C compilers would.  Fix this by defining the
> appropriate C model macros in the static analyzer command lines.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index f5e914210245..0247a90bd4d8 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -47,9 +47,11 @@ KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
>  
>  ifeq ($(CONFIG_CMODEL_MEDLOW),y)
>  	KBUILD_CFLAGS += -mcmodel=medlow
> +	CHECKFLAGS += -D__riscv_cmodel_medlow
>  endif
>  ifeq ($(CONFIG_CMODEL_MEDANY),y)
>  	KBUILD_CFLAGS += -mcmodel=medany
> +	CHECKFLAGS += -D__riscv_cmodel_medany

I can teach sparse about this in the following days.

-- Luc Van Oostenryck
