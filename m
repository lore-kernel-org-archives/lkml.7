Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2CDECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9FB21924
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="M/2NAixW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfJBJLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:11:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45674 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJBJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:11:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id r134so12112436lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=snm/Nrqs5QlS5PiXAWfvh6paeZp4yNlu1hsumZL0i1o=;
        b=M/2NAixWfPaMv3ZQW8Iwvj3sYZDoLYGfcGEUPMvVVvRTO0GZtIAGlDedHIPNizgtIs
         /PLzYWTMsIkba6wIwEff4EucUGUk8nrIsz6BPQM3MbVfUA9LRQ+07VcP/QoWSp+XTN+K
         JIccWCDorvAIj8F3AMn9ahODS2anPU/p9rqnJr/uzBkaGYdCwIQdsI1kz6bLqe8kUdrj
         lE1kW7iIdsH7hTOiCe2dQKT4LufypcTvTrZYYOiDTGM6/D1FWO9PNg1ooBveodsGmmK5
         8prq4eTWC19Vtg8J1G/aI/3slaof/k2pbJ/5Ol+djQc6jbctJ3JvALeC02h/qNrFaCHo
         A4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=snm/Nrqs5QlS5PiXAWfvh6paeZp4yNlu1hsumZL0i1o=;
        b=JSQNRu0PqdzCOyOsnjp78GufFplUtDKgmGX0hmSBCwIOi618jzmwRHKD6EcJQ7HDyl
         ZFgQ4GVeDcEYuOwynDO+tFsBpC6oZMKi9q/aQK8Op4wau5XHnpKysLk9go5poF9OMzsr
         ww2P9RjpVkZYaXV5p88X6DGovVSCoqBbiHp/j7HybsAIFSQh/1wxrxphgRcb28y4iPuV
         gXgPldy/+icEyMF+rszDvl/Vq7RHowEblqvyknvLhFXYJwOMCigL3B31H/GyJLgFHd6g
         uaOWYa9jlyec3XbaDdeIOcrAWpev+32AVio0b+LSdf5yZV8NfnjUE/3LFItCT72Xdpv1
         sYZQ==
X-Gm-Message-State: APjAAAVv4F35UVdncgN6N8cvfDwSeQJKmBvnraNJzz+j/1UfFiQoCUZ+
        +Wue2S6lVzzDpiWBSdekVN0wske2dxxnAA==
X-Google-Smtp-Source: APXvYqxhVv3O71kzK8dErCIIZ8yCZStE0Zsvx1RSL5mpco8IJyDXSeXrRGypv1WRJKcw21Z5DvsCWw==
X-Received: by 2002:a05:6512:210:: with SMTP id a16mr1605247lfo.42.1570007509119;
        Wed, 02 Oct 2019 02:11:49 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:445f:5d29:e99c:20bb:1ee3:467? ([2a00:1fa0:445f:5d29:e99c:20bb:1ee3:467])
        by smtp.gmail.com with ESMTPSA id k8sm5693214ljg.9.2019.10.02.02.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 02:11:48 -0700 (PDT)
Subject: Re: [PATCH] mmc: renesas_sdhi: Do not use platform_get_irq() to count
 interrupts
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191001180703.910-1-geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <bc48041c-df06-8108-9c45-3dfb1d527678@cogentembedded.com>
Date:   Wed, 2 Oct 2019 12:11:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001180703.910-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.2019 21:07, Geert Uytterhoeven wrote:

> As platform_get_irq() now prints an error when the interrupt does not
> exist, counting interrupts by looping until failure causes the printing

   s/the//?

> of scary messages like:
> 
>      renesas_sdhi_internal_dmac ee140000.sd: IRQ index 1 not found
> 
> Fix this by using the platform_irq_count() helper to avoid touching
> non-existent interrupts.
> 
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is a fix for v5.4-rc1.
> ---
>   drivers/mmc/host/renesas_sdhi_core.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d4ada5cca2d14f6a..122f429602d825bd 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
[...]
> @@ -825,24 +825,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>   		host->hs400_complete = renesas_sdhi_hs400_complete;
>   	}
>   
> -	i = 0;
> -	while (1) {
> +	/* There must be at least one IRQ source */
> +	num_irqs = platform_irq_count(pdev);
> +	if (num_irqs < 1) {
> +		ret = num_irqs;
> +		goto eirq;

    This will return 0 with failed probe if 'num_irqs' is 0, I don't think you 
want this...

[...]

MBR, Sergei
