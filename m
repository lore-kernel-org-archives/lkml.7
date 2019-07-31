Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E681206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gW1xlxN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfGaTxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:53:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35084 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfGaTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:53:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so70989809wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DebYcibpFlX9HWHSEI2N/34iRm3HFDnu/1MahZ1ImJE=;
        b=gW1xlxN4FGKnPnwokH6ImBm/2zHuAaIx5QLGZexzg+jqwNo2DRmxv3BJJOTF4QJzJO
         fS+ZEueC2a6T5bg49fh2tOpkJY2Th8AK/ilf2SVfuEiQbjby6BZ427lm0N1+kcr29gN4
         K6oFp3NZgoZqafToayZ+xoQ4KNp+1ZTq39319D7tMIjeVLrtpVAt8lib6sE7UtVnUHET
         sEWiAJssnj66BuGKgYiBbwp0f6fzUR9F6so/Bv4ugffrYnjWbbOcwHryuE+dY168XHg2
         o36pSlSOtXZ/Yzlja5yiBJuLMsipb1dBRj+UE3N04NA9h2UDquyd2PU4X10HSHJmpOyA
         QtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DebYcibpFlX9HWHSEI2N/34iRm3HFDnu/1MahZ1ImJE=;
        b=Enh7E4CvxbD7lq67NKzAGTpxQMDnboWxHPh8oQj979RT++KUOMqrEDJOBreIT9lBA1
         9sbDippafq5JJxJSJAaM9PAsQTKt60Gj6Rpg5ifJJPDWA9EsNIQVvHXnhBbzMkiIT0J6
         K5GYIckbO1jUVGiRaQEHvzrKNQJjJWMe1NZkLvpEPqd2UXofzMyYz5yVNi6Kv/jUKSpf
         dJdXFvY/1T9GeaS3WdWGX3CbE9W+8veMP4IOdviVeZPL4QfrwNdqurzAcFEW8REhYDrH
         ydzMIBSWNJYU414HUFL1OVajadcnan2ofAMC5duJtaez3Pj33L2ppjDMPFpMpcxjpjO6
         lDXA==
X-Gm-Message-State: APjAAAV8fYlNoYOLmH71DqBT0agbz2LiyCujaG9iq23de17L3Svnv+yB
        85fShkG8XX6iEC6D/nwHH3ybwg==
X-Google-Smtp-Source: APXvYqyR3nZH8cS1o8duJ2kRVS3erqv31+gYqTrLlWnwZm0aIho44x9EJcFrKxxUCYkahKIWeudLQg==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr87769889wru.275.1564602813671;
        Wed, 31 Jul 2019 12:53:33 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id f3sm51237858wrt.56.2019.07.31.12.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 12:53:33 -0700 (PDT)
Subject: Re: [PATCH 3/9] clk: meson: axg-audio: Don't reference clk_init_data
 after registration
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <20190731193517.237136-1-sboyd@kernel.org>
 <20190731193517.237136-4-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <c81ead7e-3e29-2a7e-aa8e-79cc0a711fb2@baylibre.com>
Date:   Wed, 31 Jul 2019 21:53:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190731193517.237136-4-sboyd@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Le 31/07/2019 à 21:35, Stephen Boyd a écrit :
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
> 
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> Please ack so I can take this through clk tree
> 
>  drivers/clk/meson/axg-audio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 8028ff6f6610..db0b73d53551 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -992,15 +992,18 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  
>  	/* Take care to skip the registered input clocks */
>  	for (i = AUD_CLKID_DDR_ARB; i < data->hw_onecell_data->num; i++) {
> +		const char *name;
> +
>  		hw = data->hw_onecell_data->hws[i];
>  		/* array might be sparse */
>  		if (!hw)
>  			continue;
>  
> +		name = hw->init->name;
> +
>  		ret = devm_clk_hw_register(dev, hw);
>  		if (ret) {
> -			dev_err(dev, "failed to register clock %s\n",
> -				hw->init->name);
> +			dev_err(dev, "failed to register clock %s\n", name);
>  			return ret;
>  		}
>  	}
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
