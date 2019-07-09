Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C5C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8C62080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562702584;
	bh=u75c9cHN2fan7Oy+pqsNZh8hbDZiWtB0hwkhX6r9HiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z1pcgpooSNpcpHhOP5uhNc8x5NGORUx+Sgp4WAG+EsppDqGaUH25PXjuBu7z0fdcg
	 zrK86cwZSxv/xh51MaoLehYNLaJxuh1QyvSiDQMuAkizesgdn4RJYD2FNL0xzXzyfp
	 FZF6oKCMUYNUeCzUGzZUjymN6dYRp+uiPQEIqW4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfGIUDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:03:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46595 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfGIUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:03:03 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so45796473iol.13;
        Tue, 09 Jul 2019 13:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jPHz4QqBHrS2BSvDTJuFgnwoOlpNBE2VL44Wy2Ih4lw=;
        b=LVvfqE5V7rs2A8eRKn+ft5AtMiCKnDs1bWLPugbwYis4D7d934XJZQDR6KNC1l2ZOk
         HQKzzhok268HmmWO0Qt9TzHhnLOLnV3MIs8KuKi2c46PRy58AzjikUEfFrIk8325R6V2
         KwZl2YYZOFFdE8GoJVne1/krFgPEuxlPE+YLx+bSJikkf+3ELwqJrWoGJdfJFkMknWYj
         3itnSiNcR5qEcLjl2GElRxuhdXBsFP5cELNqmkGS/OkWA3lpUlq7sZK1ysN5A5PY/d/E
         dHrJ2F0a+dan0C+8NHWJ8Bbnzyh84eeX986zRJz+skYrgBSjAiv958YYFsrmU2lZFii9
         rw5g==
X-Gm-Message-State: APjAAAWjqgzRpygHdJv2ifVDqba+b2ahpGUYTkDK9pLio3MqinfRBDqX
        LBre7/VtlomDqMocao9jMA==
X-Google-Smtp-Source: APXvYqzgKQYb+XwMYBnbnTz3zd1GW8VmKjDMY4YwHWg7LZq268OY5HvYntEAtB7x7FtESHjvuZbESA==
X-Received: by 2002:a02:a1c7:: with SMTP id o7mr31287059jah.26.1562702582293;
        Tue, 09 Jul 2019 13:03:02 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id d25sm20972419iom.52.2019.07.09.13.03.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:03:01 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:03:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv2] clk: add imx8 clk defines
Message-ID: <20190709200300.GA29006@bogus>
References: <20190619074000.30852-1-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619074000.30852-1-oliver.graute@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 09:39:52 +0200, Oliver Graute wrote:
> From: Oliver Graute <oliver.graute@kococonnector.com>
> 
> added header defines for imx8qm clock
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> ---
>  include/dt-bindings/clock/imx8qm-clock.h | 851 +++++++++++++++++++++++
>  1 file changed, 851 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imx8qm-clock.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
