Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E681BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DD420674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfmI5wC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfDBDrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:47:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34951 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDBDro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:47:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so5832851pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vx2O7alVszfLdPUbbXgHP9IhqLmut6UF9ZQ2M8xsv2E=;
        b=WfmI5wC9C+nmRY+RSBWfiL7xYWidgwFL/Vfxr9O86mjHgwVg2MWaOZm6X7QknQ5G/p
         8ft/70Yl17hSsnPJmK927YJt4CFSH1DhnDiIUAHX6Pw1h4eIyX8dHUw5ZveckDp4wDhw
         +CL7aY0SnIXPLGKdVBbffJTxxTUg8wuOVleL9nQ/qthz8DnPhk51KzV0sfQWzLhizIYQ
         J5qkrDGT34MtTSJdznbiMHqNIAG6RQTgMsDOpnLyH0BIMta9Sg9ByYkMGh4itwfsYCvB
         eKKCR+mzD8zec1LCVR4uz60qs/RSYdf2jW0QGz6ZBZeNP3xyxfKCRnLJ93AobI6Oxb2B
         Fm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vx2O7alVszfLdPUbbXgHP9IhqLmut6UF9ZQ2M8xsv2E=;
        b=phs+pUvJv5Z6dxd6I4CEIugBdPIcMWTOIug41PUIJiuLNKw6hQhUV4ysKnZBYRhPvQ
         rVVJcjJB+mYJ2/JyHSGhMvp5gbxO9ahDtpnmn9AGhuXbprHF7HbCmbfc7FyCiWKbnmkV
         5albPq4Svj5FES9oRH6GCpe1LkRBrAHP9RZkEUtKUymzMhsGHuSfF1gdGJlio9sBJuH7
         zriwurkx2Si/9BPZMXsK7X1zqV6GicUXRAyrs66At+Ev5/GsZMDzVpq9ocQ6p49k/aIF
         BXhSf1n0350b6DTTnHJIh8QGhzfZiTnfJyzXUJf2Dnco6tIHHYVAgFe0th0utZH8H7bD
         OzhA==
X-Gm-Message-State: APjAAAVU0QEu+kBaCD2mB885snwDxyjKKJ5beAVJYzWDseaXgWwYvWdz
        kpla5PbiZy+CWqRpvifYj9FaeHgJko0gsw==
X-Google-Smtp-Source: APXvYqyEhW99VqIFS7RdKYDVHolwoUs4Yw4ZvWr96FvG5pSbBvwFvefyauVcin0wuvrpZunHNrhF3g==
X-Received: by 2002:a65:4183:: with SMTP id a3mr13977386pgq.121.1554176863986;
        Mon, 01 Apr 2019 20:47:43 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id a129sm34415308pfa.152.2019.04.01.20.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 20:47:43 -0700 (PDT)
Date:   Tue, 2 Apr 2019 04:47:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: wm8400: Get rid of
 wm8400_block_read/wm8400_set_bits functions
Message-ID: <20190402034738.GH4187@dell>
References: <20190227013053.9517-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190227013053.9517-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019, Axel Lin wrote:

> The only user of wm8400_block_read/wm8400_set_bits functions is the
> wm8400 regulator driver. At the context of all the callers, we can
> use regmap_bulk_read/regmap_update_bits directly.
> Thus remove wm8400_block_read/wm8400_set_bits functions.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mfd/wm8400-core.c            |  6 ------

Acked-by: Lee Jones <lee.jones@linaro.org>

Mark, can you take this?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
