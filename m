Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FFCC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA17620848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB20p2dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgABORk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:17:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40770 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgABORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:17:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id s21so15132569plr.7;
        Thu, 02 Jan 2020 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=//H4mrg81x/IyMZipkYjmIUpZEnfAe6S836BMrRhuK8=;
        b=NB20p2dp5Y3fHkCRPUHw306L50/kdCdxvjJcTU0+zzehndAeE0lbAVjbT7WUVfv5QT
         T/UbjPSc4vHBmeZOMGfTYxVq+xUnKwJXhQKJ8661Nd739xyzAG1vbYsY20ckbGaNYSlO
         G4TCWgv16S1E5v9ZL6LOS6fjfMjGloZOgNk8EP2NSpStMhFTTd/nBOVd7dZTlc4rNRd+
         6m2YbpLu78rhCPiDtrJ5BZYHw8PerVjQr7GJmp6SrKFHNxyV3sVMURFNdqQWbeB7z6WW
         jG6jaO/320MDE1OhVMFkIri2EcxsIGnXFj7QzeNk4worA8A111fwJlY9cHoOSveCMPHm
         EGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//H4mrg81x/IyMZipkYjmIUpZEnfAe6S836BMrRhuK8=;
        b=RUHJXEycqoQ2tb11oxpG0FTngGNhHaCOf/A7GKWenjxTyyE3f2QHAHy8gr87Daekmb
         xk5sDgBd+1LJhoJzjnXplffTjeeRMZ5WtrCBhqoPYFhQzcMhucWxs7P2RmUvwKOKTC7w
         cDRuikrPvd+dC9PNp1Wo551+zxYT5PhEw1d6OVBypse8KSmzzhRBLDoAFLuNyPt41VQx
         gbIJgvaLP52JcuM38UUbX+3XOvsMe4hHdd+On/4224Imzdmh8fd4Oi0Xiql0MrL0ch8j
         eYQPtiF8Xh8/rwnFPaa0t0rCaUwu3sFEDMafTO26auHb2ydhKpkR3froYJV8+e58kKbC
         u+5Q==
X-Gm-Message-State: APjAAAWw5rlF3nN4Ier4eA8CyAYVhpfsLMEf+oF/vU6cLVO3yWwyu9k1
        xg7kRMOfpp/viN1QTwSm7kBWQEKe
X-Google-Smtp-Source: APXvYqwe9y9fqxjk7owBc10/WmKtlqGmdb14fLDVDktweQVNUHqXULApbdEb99t+u4TpKTE/N2Jg9Q==
X-Received: by 2002:a17:90a:8043:: with SMTP id e3mr19595166pjw.24.1577974658868;
        Thu, 02 Jan 2020 06:17:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c1sm31138536pfo.44.2020.01.02.06.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 06:17:38 -0800 (PST)
Subject: Re: [PATCH v2] clk: Warn about critical clks that fail to enable
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20200102005503.71923-1-sboyd@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6d4e8c19-6cb8-b242-3efb-0854ee2a107f@roeck-us.net>
Date:   Thu, 2 Jan 2020 06:17:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102005503.71923-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/20 4:55 PM, Stephen Boyd wrote:
> If we don't warn here users of the CLK_IS_CRITICAL flag may not know
> that their clk isn't actually enabled because it silently fails to
> enable. Let's print a warning in that case so developers find these
> problems faster.
> 
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes from v1:
>   * Switched to pr_warn and indicated clk name
> 
>   drivers/clk/clk.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 772258de2d1f..b03c2be4014b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3427,13 +3427,18 @@ static int __clk_core_init(struct clk_core *core)
>   		unsigned long flags;
>   
>   		ret = clk_core_prepare(core);
> -		if (ret)
> +		if (ret) {
> +			pr_warn("%s: critical clk '%s' failed to prepare\n",
> +			       __func__, core->name);
>   			goto out;
> +		}
>   
>   		flags = clk_enable_lock();
>   		ret = clk_core_enable(core);
>   		clk_enable_unlock(flags);
>   		if (ret) {
> +			pr_warn("%s: critical clk '%s' failed to enable\n",
> +			       __func__, core->name);
>   			clk_core_unprepare(core);
>   			goto out;
>   		}
> 
> base-commit: 12ead77432f2ce32dea797742316d15c5800cb32
> 

