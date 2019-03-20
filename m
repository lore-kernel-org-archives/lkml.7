Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D48C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942332175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhDTHJWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCTBAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:00:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46103 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCTBAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:00:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id c18so564824otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+fxZ2uU+NwwuUdaJPYPM/QmxmGfXVrSJft9hKbdRFIA=;
        b=uhDTHJWSmXN3/w9s+G0Rt6WYHHAMPyDpKo3Tcu+2SBVp/3T+tfH4VA7wRMaQBwHmbR
         n32XRB5LzBDoPvf24SBROCU+wesncht86BOFwriGPaiIJrtDsM/LfoS7AGlExyHpI7JP
         dJ7flJ1yXZaTb8g3x5tbOVYT7676aEFgJxhs4GLbndSo82Ay82LnXEbD9vIEvHzFmXH/
         pflBcPp0bprf39yvXE1dBL2EqDvGTa9YRQixD132cdJxrWTuTBbM0uVIlRw+8u1OlQib
         UD3JqHUgFJ3lFqSnRIO7+QNbonJOpUv+r/KCvLVmbJCmC4GHiq/26qWvtcgU237Ter4E
         jp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+fxZ2uU+NwwuUdaJPYPM/QmxmGfXVrSJft9hKbdRFIA=;
        b=IazNt59Geg9LYjScwf4oKVBEMHvnBfS7mxpfnBSv8g6hacx9Yj4qnj0lpfhlovF7uo
         lJDu4e9GNGNwLcbaTyYhcqSbeu0ZSW5dew7fX7Gpk35TA1xzxBW3fSf/SZ4FGSk2hduL
         j/jBQvXc869iv/en9LUPHYzI94HR5JYmbcNmabR2qmdGvJz2IVu+fWToYUCCnE3zJa8w
         oCoaRLXHM/WuHVYU8lB4zi5FiW1VHgT+Oda8QIkbG5UPV4uIUzF3j666HsJGAotGmseS
         RZkc56M41oRRe47AK+hIVvnaKMAhLsKsVIKiGNJB/wMlRCO2u1Hw1wtHDlGNLYA/lDUL
         1z7g==
X-Gm-Message-State: APjAAAX+k2ouDWoxUuOW9W9BTpGqBWwon+afguTte0XgLIeeXCbt9I9A
        2FwSB74rvaOaBi1PWpYa/Xd3wg==
X-Google-Smtp-Source: APXvYqwmUF/Rw9tDjAmb5fvOmBEBxT0pX5rbTBUW02BI62AGiWV81ZlhYeWtuUIkyESLstgUf2qdvg==
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr3955968oti.172.1553043605731;
        Tue, 19 Mar 2019 18:00:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id n5sm151996oih.19.2019.03.19.18.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:00:04 -0700 (PDT)
Date:   Wed, 20 Mar 2019 08:59:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [RESEND PATCH] clk: hi3660: Mark clk_gate_ufs_subsys as critical
Message-ID: <20190320005958.GA18687@leoy-ThinkPad-X240s>
References: <20190319093148.1909-1-leo.yan@linaro.org>
 <155302456384.20095.11089482394019450818@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155302456384.20095.11089482394019450818@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:42:43PM -0700, Stephen Boyd wrote:
> Quoting Leo Yan (2019-03-19 02:31:48)
> > diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
> > index f40419959656..32ba80181cc6 100644
> > --- a/drivers/clk/hisilicon/clk-hi3660.c
> > +++ b/drivers/clk/hisilicon/clk-hi3660.c
> > @@ -164,7 +164,7 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
> >         { HI3660_CLK_GATE_ISP_SNCLK2, "clk_gate_isp_snclk2",
> >           "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 18, 0, },
> >         { HI3660_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_sysbus",
> > -         CLK_SET_RATE_PARENT, 0x50, 21, 0, },
> > +         CLK_SET_RATE_PARENT|CLK_IS_CRITICAL, 0x50, 21, 0, },
> 
> Nitpick: Please add space around | and also comment in the code why this
> is a critical clk.

Will fix it and spin a new patch.

Thanks for suggestions, Stephen.

> >         { HI3660_PCLK_GATE_DSI0, "pclk_gate_dsi0", "clk_div_cfgbus",
> >           CLK_SET_RATE_PARENT, 0x50, 28, 0, },
> >         { HI3660_PCLK_GATE_DSI1, "pclk_gate_dsi1", "clk_div_cfgbus",
