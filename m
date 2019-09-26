Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D74C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751B1222C7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4JJp7qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfIZRZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:25:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43117 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfIZRZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:25:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id v27so1899051pgk.10;
        Thu, 26 Sep 2019 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=t8KSaOsUA0A5+mnKTZ8gR5rlbkOnzjQQsfjJ840XQJk=;
        b=A4JJp7qYcNE79wFFw4ug9NrWVG1ouENyKepTkUqyu7bQIMdRc6liLU2w3bG5seaQuT
         LSO+YCCywdnVWigb9qRkIMsvB+XTbIlnWTZxGC8LWCbjCLarTkrN6FqCB9fmu7sJgTGr
         m6T8uV0jsUJbohPR8HsMHw/N2P3nCr3TybgZBckxRuJ1k43A79nn1eDFiVlz7aqMTFjy
         QGHIKO6kxObLdhC8hVgxbKPyTPfnq8mdoId5uyeIYf1HFRRLVgaGdeBqc+i/dLyRwwhI
         YT3HU0j9ZQWpJx2wTuqaBS9qh6rMzAFJXjmyo1MFgHeXpm/gY03qVA7AENSwAefDqTUl
         cujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=t8KSaOsUA0A5+mnKTZ8gR5rlbkOnzjQQsfjJ840XQJk=;
        b=aKRlHlLk76InFVyP7Ghsm6eSmuuBQWnpMnLfnMBgyBS8q7Pie3L0PtSNk2YmOSmxtt
         Fmm0Kzyn5b4higPZFRZZw7m5Sx9oVsoyeCZWiYo6t8lAu1uCwl5izCtrcNck+Ak+M5t+
         2xu01PRkHjYVKtLaiMEI7GE/QG1j9ypmUIVv6ENhu+Hfy9futCrQTgk3CyhQdOvQvhBX
         K+wU18nACPTwSMRx53QAVZM+SeN3EGaujkVdS9+58QHDMQlBTzQ9zWgfzpwScZ+PeK1v
         6QlDVd4IEJ4lBLKHkC9RvQNrtqnlB1Ont1xnsiVhTWPjwA7aVnhhtonRp1qc2NeA9cM8
         OMbg==
X-Gm-Message-State: APjAAAWS8dpCfgvmcmgWIcWnBm9CDXhcE9rYhggmP20DYBDg3MCohcDP
        q2mAaJMYP4vDdAuXH7gNTsHc5mP07HOptA==
X-Google-Smtp-Source: APXvYqx4m+E7/H+s5Lc/cis9LXP8X2+1ZKGkWbYibcJmL4EcS/TtoInNtol0fEES4fLZX1bOcPPTKA==
X-Received: by 2002:a17:90a:77ca:: with SMTP id e10mr4659549pjs.24.1569518701338;
        Thu, 26 Sep 2019 10:25:01 -0700 (PDT)
Received: from arch-late ([12.206.46.61])
        by smtp.gmail.com with ESMTPSA id 127sm4941845pfw.6.2019.09.26.10.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:25:00 -0700 (PDT)
References: <20190926155539.GA20744@sausagefarm>
User-agent: mu4e 1.2.0; emacs 27.0.50
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Jeeeun Evans <jeeeunevans@gmail.com>
Cc:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: imx: Use devm_platform_ioremap_resource().
In-reply-to: <20190926155539.GA20744@sausagefarm>
Date:   Thu, 26 Sep 2019 18:24:59 +0100
Message-ID: <m3wodvgec4.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeeeun,
On Thu 26 Sep 2019 at 16:55, Jeeeun Evans wrote:
> This patch fixes a warning by coccicheck:
> drivers/staging/media/imx/imx7-mipi-csis.c:973:1-12: WARNING: Use devm_platform_ioremap_resource for state -> regs
>
> Use devm_platform_ioremap_resource helper which wraps platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Jeeeun Evans <jeeeunevans@gmail.com>
>

Thanks for the patch.
LGTM.

Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>

---
Cheers,
	Rui


>  drivers/staging/media/imx/imx7-mipi-csis.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
> index 73d8354e618c..bf21db38441f 100644
> --- a/drivers/staging/media/imx/imx7-mipi-csis.c
> +++ b/drivers/staging/media/imx/imx7-mipi-csis.c
> @@ -947,7 +947,6 @@ static void mipi_csis_debugfs_exit(struct csi_state *state)
>  static int mipi_csis_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct resource *mem_res;
>  	struct csi_state *state;
>  	int ret;
>
> @@ -969,8 +968,7 @@ static int mipi_csis_probe(struct platform_device *pdev)
>  	mipi_csis_phy_init(state);
>  	mipi_csis_phy_reset(state);
>
> -	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	state->regs = devm_ioremap_resource(dev, mem_res);
> +	state->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(state->regs))
>  		return PTR_ERR(state->regs);

