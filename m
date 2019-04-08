Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A46C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EAC2148D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDHKm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:42:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36690 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfDHKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:42:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so10762323ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 03:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1LBzBut4o23TVwROVzr1nU/7TWSGTPMvEJV0oQCJtcA=;
        b=b7SWfNjIZwLBs4MWOnVIegDzwyZ+g6kE104tg/ZbAtWEoX0ZIGPhMlYwQcof5nwnXb
         /j5EHzCtuMatRs9kTgE/A6uyPfuetSL1ZDqNZDS3z6avKCrsSjU3d6BB9hNEO9+KkEMc
         fRzVGqY3e1LrPpppF9jJIhp358fAMHm5Z18KknLPQCjU7GecA5484DJuCoD56GUAeGBu
         N9wDi8gnlBLZq0eWUVqEUXXrMo/CvSnMLPrO28a6W3UQ6IQCYcIklQdT7ENtG7JLQ9lc
         rFSRVIYcPw0hf83oj++5S6AMifDzmNl/glYqrgfZ7O8SzhxJbSvznpD+royN1ZTkmZuI
         c/eQ==
X-Gm-Message-State: APjAAAVafnhR4pa9bLGVyh0RFQ566eHNKvq202gJmYt/AK6Jd7OGXzU8
        AKmzrfYO8RUNnxMjNeRSyfs=
X-Google-Smtp-Source: APXvYqyhAQoauIS2ig43OX8CQL7QOwQEVQk8I1kDMU/hGXWsUOwOJARX5A61PfoVABe9oOeEDHtgoA==
X-Received: by 2002:a2e:7806:: with SMTP id t6mr15165928ljc.143.1554720146441;
        Mon, 08 Apr 2019 03:42:26 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id s26sm6347313ljj.52.2019.04.08.03.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 03:42:26 -0700 (PDT)
Date:   Mon, 8 Apr 2019 13:42:19 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Angus Ainslie <angus@akkea.ca>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd718x7: Use rdev_get_id() to get regulator id
Message-ID: <20190408104219.GA17594@localhost.localdomain>
References: <20190407090302.10918-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407090302.10918-1-axel.lin@ingics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 05:03:02PM +0800, Axel Lin wrote:
> Use rdev_get_id() instead of directly access rdev->desc->id.
> While at it also remove unneeded init for ramp_value variable.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/bd718x7-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
> index b2191be49670..fde4264da6ff 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -27,8 +27,8 @@
>  static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
>  					   int ramp_delay)
>  {
> -	int id = rdev->desc->id;
> -	unsigned int ramp_value = BUCK_RAMPRATE_10P00MV;
> +	int id = rdev_get_id(rdev);
> +	unsigned int ramp_value;
>  
>  	dev_dbg(&rdev->dev, "Buck[%d] Set Ramp = %d\n", id + 1,
>  		ramp_delay);
> -- 
> 2.17.1
> 
Acked-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

