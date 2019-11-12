Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A91C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7646E20674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUSRVio+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfKLG0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:26:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40879 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfKLG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:26:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so12597735pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 22:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=29y54PPjXheeJnkAIV+/9rtCAbjMmayyj5shoryCFWs=;
        b=EUSRVio++bqwLyCrsbzAnGBh+zpVum1h4Tx8yIalq0oP530ikl+eefPueFj2aIvjQP
         YpqB4V8LclH6h22+a4HR0SgbMnpd1xgyzo/2z5q2T89kO235UZ0XrLYCZ/eFCBe2ycoO
         ZtHpc/+9n0bkfGbVB/DeTGjK9xfv9l247CvRf889HW5D53/09CFma2T5mi1QsBwcPz1q
         8MOPhtL7orrl1a41RSkrk6p5mX0EV3m/TFBYxWe8HcSvG8Vl7vUFgzj3GxhvAf9r6qz3
         t7aqg7wCrrkaDI+5kheSEhjvb177U+9R/ahpqEWgnk4G2wLXUHPSZ5qG8VILN9Lx/Y2K
         dZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=29y54PPjXheeJnkAIV+/9rtCAbjMmayyj5shoryCFWs=;
        b=iNpnAVWl62btuAqS5u16yhXMvv+SIClhpLBP9Jh43a1GhEBKhIKneZ/4n8Hjlc4yAx
         EewofrdImquOpEhhJE3NeO3tp15ZcgvVAGn9mKnL0sW/6KY+YiLIDVNLQWpiXjoWejac
         xY9ABvs8yFZ+2+FiRslJpe0PR21hfazJrvethKZw1btDymhOpuPbefdyBNhIqp7CCQmw
         +m7LTrBKoiX5YsNO4nRMwjwhuF52MskK3KWvZ14ea2PUusFjZw/5pprQFCnoP2gS2qhl
         4+OIl5M7xJUC3VH00R1thy3mbkmW9n11/cR1ALJuwB9aqBV9ovQ2MiNZoT+aR2ClhXFb
         NRLw==
X-Gm-Message-State: APjAAAV25iWdVQdGEt9gO6KjLLOLYuttqS1xCSix/1nAmXLgpxidMZfY
        xPviPDMqTwU7FzAfyPf9o377YA==
X-Google-Smtp-Source: APXvYqw8NSYCabsNjDVxITf+aai970UaPE8g9uaB51GTRrRgTmGQbTE8GazIEwa9XdAJeWtrwnOAmQ==
X-Received: by 2002:a62:7dd2:: with SMTP id y201mr35491160pfc.90.1573540005185;
        Mon, 11 Nov 2019 22:26:45 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b1sm1285492pjw.19.2019.11.11.22.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 22:26:44 -0800 (PST)
Date:   Mon, 11 Nov 2019 22:26:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com
Subject: Re: [PATCH 15/17] remoteproc/omap: report device exceptions and
 trigger recovery
Message-ID: <20191112062642.GP3108315@builder>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-16-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028124238.19224-16-t-kristo@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:

> From: Suman Anna <s-anna@ti.com>
> 
> The OMAP remote processors send a special mailbox message
> (RP_MBOX_CRASH) when they crash and detect an internal device
> exception.
> 
> Add support to the mailbox handling function upon detection of
> this special message to report this crash to the remoteproc core.
> The remoteproc core can trigger a recovery using the prevailing
> recovery mechanism, already in use for MMU Fault recovery.
> 
> Signed-off-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>

You're missing a Co-developed-by

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/remoteproc/omap_remoteproc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 8bd415c8fc86..6f797025bb6b 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -360,8 +360,12 @@ static void omap_rproc_mbox_callback(struct mbox_client *client, void *data)
>  
>  	switch (msg) {
>  	case RP_MBOX_CRASH:
> -		/* just log this for now. later, we'll also do recovery */
> +		/*
> +		 * remoteproc detected an exception, notify the rproc core.
> +		 * The remoteproc core will handle the recovery.
> +		 */
>  		dev_err(dev, "omap rproc %s crashed\n", name);
> +		rproc_report_crash(oproc->rproc, RPROC_FATAL_ERROR);
>  		break;
>  	case RP_MBOX_ECHO_REPLY:
>  		dev_info(dev, "received echo reply from %s\n", name);
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
