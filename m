Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89968C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48388206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a48INu+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfFEOmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:42:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56032 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfFEOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:42:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id 16so2525843wmg.5;
        Wed, 05 Jun 2019 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3vFv+9zEqsMX4iOvV90D7yujY9zYQAWPx+3AS1AwwC4=;
        b=a48INu+57UfDJPyfFCLneJ04BtvLlFadHfCG6hUUgCZsFiMnI+Zd2MnlJGiT3BnXWI
         m73A4O8U/wNpUIoQYx8AbY6TjCX8CRMzSnJjRAwyUh2V64NQA3PteMsr9X8LYEymzQe4
         U7CNJc1FsXVeURBmEowZY8TXxUxGj+/2Dl3P5ORosjcj9DYvKEITnDaO0VvbsWZ9BSAO
         myMyagp71quqj5Zd47rwP7LCju2MWABgHSIcvokcdtuEsLxYKDtPM6RfaKIm2xF4jTqd
         9TEZqUPNANhVoZxcQvRz6zb3kKPx4opJC7G39aX1DUQyYWKKz/GDs9VZ85lTFluVhHhy
         kXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3vFv+9zEqsMX4iOvV90D7yujY9zYQAWPx+3AS1AwwC4=;
        b=QYLaxRXuAC/V1p/KO14Nah37UUeF3kcn4/oPNNWNfz115Uxpp80/MELL2R3dcHkadY
         Aroq6xMQWSQ+5CH+P4keihnWVZoKST8W5/ZbOBdggucFGrSliSKm+k9xm04CcKPEZupa
         mxeAW6bUvEvRBX1H3itJP5bEzbwiilujFdGXrF64tWWEN+vXXEdSUUUGMN93/vTIZYvV
         JosOpbriknefJfYjqHyP+L2doPpmHjasRyVjcxf5+bzeziSX6GYpVzGbMoc6IqJgCwTc
         a7Ypyw5dwKMl0K2praIOUNwbck//4+6NtsbCwNLDv5Tev155xIy/VvZ/wJqmMoya2GuG
         RmfQ==
X-Gm-Message-State: APjAAAX99Wv/j0dD+Y/lort/HOVGnMczC8pNuswikDQNGu+aCD14DlmB
        DZ5rXMg/tpMCuAJrWe3FoNY=
X-Google-Smtp-Source: APXvYqx0yNYuf8WnnkxZ9MvxUzd0Z29ns36ss0TxfJv6MvrDfPWtpLgoRrRwktrdsvxXoiinsDosbA==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr11252035wme.39.1559745762496;
        Wed, 05 Jun 2019 07:42:42 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y12sm18083581wrh.40.2019.06.05.07.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 07:42:41 -0700 (PDT)
Date:   Wed, 5 Jun 2019 16:42:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: alps: Drop unlikely before IS_ERR(_OR_NULL)
Message-ID: <20190605144240.pfrvlgxsdpacpwxf@pali>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
 <20190605142428.84784-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605142428.84784-5-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2019 22:24:28 Kefeng Wang wrote:
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
> so no need to do that again from its callers. Drop it.

Hi! I already reviewed this patch and rejected it, see:
https://patchwork.kernel.org/patch/10817475/

> Cc: "Pali Rohár" <pali.rohar@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/input/mouse/alps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 0a6f7ca883e7..791ef0f826c5 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1478,7 +1478,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>  		/* On V2 devices the DualPoint Stick reports bare packets */
>  		dev = priv->dev2;
>  		dev2 = psmouse->dev;
> -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
>  		/* Register dev3 mouse if we received PS/2 packet first time */
>  		if (!IS_ERR(priv->dev3))
>  			psmouse_queue_work(psmouse, &priv->dev3_register_work,

-- 
Pali Rohár
pali.rohar@gmail.com
