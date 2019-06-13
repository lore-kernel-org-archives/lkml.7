Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10219C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA552147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560466860;
	bh=1ycc5XhBbegExJr3IT+ebLCLz63PQBCaXSPNuxaDnaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dWvhJQWWHitDUbgt0w6H4O7tenygUD8QThtDnXOgPNBvR4w1jU6c4M0SwEIZDgc8z
	 w5NCqGIMriH9JSktTrNPtsHEi7MMc/wUxNtl5Ppm3mDaj3ER0NcLO+mwhTk5M4GUnY
	 7iU0D4E4hj936SrzAXpge4Q23ClexAWEF0fn0xxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFMXA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:00:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43610 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfFMXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:00:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so350767qtj.10;
        Thu, 13 Jun 2019 16:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G79DWXHKgxClAySaL1um3UbwoRauIDKIz2yJHIv30Gg=;
        b=qeqSo8GoNLE+dKxQc0f4MEpZMTcLL9+LP7UBBJiYrAhyuFsDpW5l0ouqOjP/UEFT5C
         c0JKQn/kqkWJyaOC651hFs8lKhX1WO9L3XYgQM0JVwXZaY36/9OKYnMvepduKLuVYP0v
         srjk89QueGX4aKA28IJ3bC1BUlCYXyRMlNFPLVPgZv/w7dJXRYxe6yk4zfnZ/eImJzKW
         YtmiYczWGuhVYkAgluJRTgHZ0npRfgoyLgEGMYASeGndk1YS39RtmPtGeQPd356h/RPP
         cbWtcT2tgPywR0OcV8LImOqlJGLj1WTaHXbN4GyIfgAMrc76Zd3jtR0i64NhgzNEIOT0
         W/WA==
X-Gm-Message-State: APjAAAVLsqPaGd0fmWALH8fTj7DpInaaGmzLgV8kiBvBdGTiypDahXdE
        zxUiVqSaU5JyWUXOiJIRUQ==
X-Google-Smtp-Source: APXvYqwO8MrRxA4IbLmzYlI+M/YrQOnAWJYgHuPsnvehk+Nb8nAc5Jq4q/qt4ywjdBg+E8zmH8NyaQ==
X-Received: by 2002:a0c:aff8:: with SMTP id t53mr5602907qvc.47.1560466857634;
        Thu, 13 Jun 2019 16:00:57 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id n5sm655080qta.29.2019.06.13.16.00.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 16:00:56 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:00:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Message-ID: <20190613230055.GA19296@bogus>
References: <20190520032020.7920-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520032020.7920-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 03:06:35AM +0000, Peng Fan wrote:
> Introduce fusable-node property for i.MX OCOTP driver.
> The property will only be used by Firmware(eg. U-Boot) to
> runtime disable the nodes.
> 
> Take i.MX6ULL for example, there are several parts that only
> have limited modules enabled controlled by OCOTP fuse. It is
> not flexible to provide several dts for the serval parts, instead
> we could provide one device tree and let Firmware to runtime disable
> the device tree nodes for those modules that are disable(fused).
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> Currently NXP vendor use U-Boot to set status to disabled for devices
> that could not function,
> https://source.codeaurora.org/external/imx/uboot-imx/tree/arch/arm/mach-imx/mx6/module_fuse.c?h=imx_v2018.03_4.14.98_2.0.0_ga#n149
> But this approach is will not work if kernel dts node path changed.

Why would the path change? The DT should be stable.

Rob
