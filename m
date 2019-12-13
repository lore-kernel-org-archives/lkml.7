Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632CBC80D5E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9395D2477D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269664;
	bh=irQB7XfqVcrHTID7Hl74AzsdoIFGThig7okTIO1hY1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0O1tmYs3XTbohNbyvTK543QkoZQyCcwnoNjRJIOxIp82B+2lasZANniOdxMnXUivY
	 gxMo0X8d80cvYjqsZPBozD3zHe5unTploJmP41PJPKdSqBdokztnUy0EmZEVTza6fZ
	 h6qsH+ZfgfKhSWdPeCYLMgiIB66i9+0HpTqdFPGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfLMTtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:49:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45627 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfLMTtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:49:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id v10so1726626oiv.12;
        Fri, 13 Dec 2019 11:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=puPqkib5wW1ufDZCsroCWU8Z4B1OBGBUiK23E46Afz4=;
        b=KNPJ+NEkbAYAtH2YP5ecMo23dU1OAPH53alMBJ/ExXs5qY/KcukrxcrQrb+Bkrolas
         +jxbPooZVJk0gpYd7Vazpg78RswM1k9VY5DIbUtV/Km6eqjOVFYJyR8xbN1cGPs8yqF2
         BUZV70ykp7f7E0m80Y4mfAsEtDxtgSPC0kgQo73EAnu8a8P3inKsAb3ehsUtSsg2sXWJ
         NgT172gi6WbKOJc7mHuudjc2MqkdOuMDhMThStr0cpkfZdiIoXFIOf3F3Mmyg6esiPcq
         UjpIp2Xuxmm2NaYU0MWysBfRjoyP/aN67E50sxSgSMIRD7QNSEk5+Asv+fffL34GMmSs
         22GA==
X-Gm-Message-State: APjAAAV5oJRLwhV4HZFnuxnzzroFwC5WYqv+pLVNJzQv0/SHyL0Z4hXQ
        mMaX8cv5HgrsxL2nfHUeNg==
X-Google-Smtp-Source: APXvYqy9I8IPN8N57ObqYrugXpghM9TdPjB6AiccNCqXdBpXYtudSo6lvGrpH79nOj6dlId4HooUgQ==
X-Received: by 2002:a05:6808:b1c:: with SMTP id s28mr7980503oij.2.1576266560907;
        Fri, 13 Dec 2019 11:49:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j130sm3633161oia.34.2019.12.13.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:49:19 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:49:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v3 02/10] clk: clock-wizard: Move the clockwizard to clk
Message-ID: <20191213194918.GA13693@bogus>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
 <610b14b71d4c3c4c28cbedc340f6a92f15e25241.1574922435.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610b14b71d4c3c4c28cbedc340f6a92f15e25241.1574922435.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 12:06:09PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Move the clocking wizard driver from staging to clk.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/clk/Kconfig                 |   6 +
>  drivers/clk/Makefile                |   1 +
>  drivers/clk/clk-xlnx-clock-wizard.c | 335 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 342 insertions(+)
>  create mode 100644 drivers/clk/clk-xlnx-clock-wizard.c

I don't see anything moved here.

Rob
