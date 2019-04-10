Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30495C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35F72133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554936835;
	bh=CovF7NPSaUf4wPavrIL9yXbYquKwUO53ecbE+/+hZig=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=eOKosRc9uMAzlqCrhC9sbpR9Km8Xb1WkFcLUhF9fWfYIC3PhU8hAilVExnEpQhagl
	 TY2aGiDV69exr4z8OGp6jqzX9W3MpuAKf0LFocCGD0EM3IAHmxNw1fmez8sAB2xXJV
	 oBDc34iemC/Qo/5ToPX0R4d1gInfW9TaButgIgL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDJWxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDJWxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:53:53 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACF320830;
        Wed, 10 Apr 2019 22:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554936832;
        bh=CovF7NPSaUf4wPavrIL9yXbYquKwUO53ecbE+/+hZig=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=oVg3/jksLKhu04X/K6Vpbso0C6OySfUNS1gkFiTMwJMq1z5JROecZp+k6wCXUOa45
         b1gM22Lw1aX0GEFhuZEJvMCGCvxEXd2EVBRJyHo4H4K2rty/TEaLaPrRbd088HtRXz
         M08MCqTkNWE3G2bojSKfSG9wbg3I541c+ZTbE64Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1554606804-29453-1-git-send-email-hofrat@opentech.at>
References: <1554606804-29453-1-git-send-email-hofrat@opentech.at>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RFC] clk: ux500: add range to usleep_range
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@opentech.at>
To:     Nicholas Mc Guire <hofrat@opentech.at>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <155493683173.20095.12913107010666279046@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 10 Apr 2019 15:53:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Mc Guire (2019-04-06 20:13:24)
> Providing a range for usleep_range() allows the hrtimer subsystem to
> coalesce timers - the delay is runtime configurable so a factor 2
> is taken to provide the range.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
> ---

I think this driver is in maintenance mode. I'll wait for Ulf to ack or
review this change before applying.

> diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysc=
trl.c
> index 7c0403b..a1fa3fb 100644
> --- a/drivers/clk/ux500/clk-sysctrl.c
> +++ b/drivers/clk/ux500/clk-sysctrl.c
> @@ -42,7 +42,7 @@ static int clk_sysctrl_prepare(struct clk_hw *hw)
>                                 clk->reg_bits[0]);
> =20
>         if (!ret && clk->enable_delay_us)
> -               usleep_range(clk->enable_delay_us, clk->enable_delay_us);
> +               usleep_range(clk->enable_delay_us, clk->enable_delay_us*2=
);

Please add space around that multiply.

