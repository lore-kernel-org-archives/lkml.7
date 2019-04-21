Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D125C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 05:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0425B20859
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 05:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAeJXdzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfDUFiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 01:38:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40001 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfDUFiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 01:38:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so4398745pgl.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 22:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2ZOxKq1NRE/y1pktrwgjjX25p1w7z3FXQMCsOvF6cc=;
        b=PAeJXdztIKcUnPiDJJg7snfPod+xCQiABPwfheAHk3qKamAV6HpaCXe43bkzoChIzT
         4qr/t8Y3acoAdWaDF0ZcmI7Rfomqs8lWgGQUCgTlhWoY4Op17kGtrErG0CcWpjxltNDL
         iWPUqXvSdW317lvwvUQfTw14cJA1Gxt1DazdbVx0CnNhEWfJ0z5xYa/pLUrMgAUTzY2J
         /5zFZvSbBbSQVpDfCXt2mxPdbj0Qf44uLx189yVO3BVe89oLTFJFGBj9k5sYgvYLwjK8
         18DijB4jyq3MJ8Y7VwVI6E0wFggjudk4HbmmtYUKCqXReZXv+srnC8y/oRKPPSookc+Y
         Q5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2ZOxKq1NRE/y1pktrwgjjX25p1w7z3FXQMCsOvF6cc=;
        b=Qqp3vte9ATI6+dBfnKcaSwF6OxkMvNWzpJ7NF8fidgJbSnYm+wsYgN1eIzz6vS54Gf
         Zw8oimgxwAYQgY8Fs6fTWjnS6PxFD85xIR7G4mt8pzFDOn3/6d98MA8upPWDRJ3OaM5X
         EwFOwx6XwnzPcreDs4ynJK9AadRzQJBRbaw273W1CKAzcIcF8uedG/h+L1nmxbjXDPIr
         APhKuTEbdHRW9IdotwLpcCsPw7Y8W5Z50XEDtDFf/RZzEcRLVurtaOnGWEG3H9pKxvkK
         qOCMkdjRyIhD7YJDI0sE4oYJ2y6lXl0zY/odmnR/mETurrMl6TKwyJlLOHH/u1itOmJR
         JLjA==
X-Gm-Message-State: APjAAAVMlVKR+GNzVWrZBINhsjbUtoqHRUtyrU82iPbdV4O5dbnGXBCs
        oXySAz3O3GUoOySL1AT5Qco=
X-Google-Smtp-Source: APXvYqxf5aRnlN+xYMVyL2Pt9c3xXNJ1fz9WE1pVQ1Ncq4Z3g0jDbU9jWPJSawL+lNo4WTHhp/0XLA==
X-Received: by 2002:a65:424b:: with SMTP id d11mr12575693pgq.205.1555825079594;
        Sat, 20 Apr 2019 22:37:59 -0700 (PDT)
Received: from Asurada (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b1sm11047245pgq.15.2019.04.20.22.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 22:37:58 -0700 (PDT)
Date:   Sat, 20 Apr 2019 22:37:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Message-ID: <20190421053749.GA5552@Asurada>
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420154038.14576-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By following the pattern of previous Subjects:
ASoC: fsl_sai: Fix clock Source for mclk0

On Sat, Apr 20, 2019 at 03:41:04PM +0000, Daniel Baluta wrote:
> SAI provide multiple master clock source options selectable
> via bit MSEL of TCR2/RCR2.
> 
> All possible master clock sources are stored in sai->mclk_clk
> array. Current implementation assumes that MCLK0 source is always
> busclk, but this is wrong!
> 
> For example, on i.MX8QM we have:
> 
> 00b - Bus Clock selected.
> 01b - Master Clock (MCLK) 1 option selected.
> 10b - Master Clock (MCLK) 2 option selected.
> 11b - Master Clock (MCLK) 3 option selected.
> 
> while on i.MX6SX we have:
> 
> 00b - Master Clock (MCLK) 1 option selected.
> 01b - Master Clock (MCLK) 1 option selected.
> 10b - Master Clock (MCLK) 2 option selected.
> 11b - Master Clock (MCLK) 3 option selected.
> 
> So, this patch will read mclk0 source clock from device tree.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d2a4dc744fd7..faa8de87ff83 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -829,8 +829,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		sai->bus_clk = NULL;
>  	}
>  
> -	sai->mclk_clk[0] = sai->bus_clk;
> -	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
> +	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
>  		sprintf(tmp, "mclk%d", i);

Firstly, according to your commit message, neither imx8qm nor
imx6sx has an "mclk0" clock in the clock list. Either of them
starts with "mclk1". So, before you change the driver, I don't
think it's even a right thing to define an "mclk0" in the DT.

>  		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
>  		if (IS_ERR(sai->mclk_clk[i])) {

Secondly, this would break existing DT bindings of imx6sx and
imx7 platforms as they both have clock-names defined in DTB:
	clock-names = "bus", "mclk1", "mclk2", "mclk3";
Since there's no "mclk0", the entire probe() would error-out.
And mainline has a DT backward-compatible policy, which means
you can't just rename the "bus" in the DTBs but would have to
support them, not to mention "mclk0" is still questionable.

So the right way to fix it is, in my option, to differentiate
the mclk_clk[0] clock source name with the compatible string.
Then you can get the clock name and simply do:
-	sai->mclk_clk[0] = sai->bus_clk;
+	sai->mclk_clk[0] = devm_clk_get(&pdev->dev, tmp);
+	if (IS_ERR(sai->mclk_clk[0)) {
+		/* error-out*/
+	}
