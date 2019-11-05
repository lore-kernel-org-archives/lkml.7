Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F3DCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D982080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsPxj4ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfKEAkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:40:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43132 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbfKEAkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:40:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id a18so7363361plm.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 16:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NH6Mp/TMaBiucUkeQscWI4mQOGsiLsHourLQo78kfqY=;
        b=BsPxj4exriEWDDIuD6XklU4ucr3XvJPr+KqdCeBAsvBxUXnZOfrDhuAy2JCIXBnDGy
         YdejkP0WG7gbsX2kBY6ff4EP8M2slwkZKun13jpT++xRlUaPMKudi8yUmhG5Bimt9+aA
         GoRJovuaPLMrbRzZhEMVutx/FtICE2iQtpTSEMXGlsryJsYesAVZqg4YobU6cuQkdiAm
         BaxElhQbpievopAtT9NQMwsPx+5oW+ajA08HrDIx8oqc0BOTZruanPCvZoxt9bA/aw28
         KAjlbrNs+m5gmi+38Jrwg8RLsq7yayJohS/4ARwCW9GnSb0hrqihj0vdPxq0FHfy4vy3
         ZzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NH6Mp/TMaBiucUkeQscWI4mQOGsiLsHourLQo78kfqY=;
        b=s16p7Dh7KYmHBRMC6URxGz56nl3BggQXecej8EWSPzdhwN4hSX0OaECCW51osmq09m
         3bNVBpRU/BP2GvgYiCzaDh/NKf/XqLLhSZpG1KbBd3Jl1gOdxSIACa0h2zqstUSlJNIL
         vZos+n5wJzdMfR3vAoej+3/TFVuHQuhgAjR9Uf/Uny+b+vFBZhdXloWyPPGXDLW4Oh2C
         fHsGaJtHwf4qEA3UcHzg8T99F/YJttnzmxTaJV00w7jxedvMzNV9W1sRDAJOMTZAI2Ew
         goavNJskubJdOdgVEZr1QaEb0gAUHxSy7gMZut9nVQfPXALMArJL9Krdi4rtEmBunzQD
         mF/w==
X-Gm-Message-State: APjAAAU4UvDvIza1YG+YiSkdVPjnPqXcV5JwVOxlISJssa+fRzMn5fSJ
        ojWifvDHWMsIjMc+26ESEUHHEQjj
X-Google-Smtp-Source: APXvYqx+5Q4UXBmsh0ZJhAGou536Uk8JpxpxlAhqK1O1BqXfqIe7r+QWdjuZqWIRDfUcDHdWDp6klA==
X-Received: by 2002:a17:902:7084:: with SMTP id z4mr29365353plk.15.1572914452984;
        Mon, 04 Nov 2019 16:40:52 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i102sm18000136pje.17.2019.11.04.16.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 16:40:52 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:40:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ti-tfp410: switch to using
 fwnode_gpiod_get_index()
Message-ID: <20191105004050.GU57214@dtor-ws>
References: <20191014184320.GA161094@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014184320.GA161094@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:43:20AM -0700, Dmitry Torokhov wrote:
> Instead of fwnode_get_named_gpiod() that I plan to hide away, let's use
> the new fwnode_gpiod_get_index() that mimics gpiod_get_index(), but
> works with arbitrary firmware node.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Andrzej, Neil,
> 
> This depends on the new code that can be bound in
> ib-fwnode-gpiod-get-index immutable branch of Linus' Walleij tree:
> 
>         git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git ib-fwnode-gpiod-get-index
> 
> I hope that it would be possible to pull in this immutable branch and
> not wait until after 5.5 merge window, or, alternatively, merge through
> Linus Walleij's tree.

Any chance this could be merged, please?

> 
> Thanks!
> 
>  drivers/gpu/drm/bridge/ti-tfp410.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
> index aa3198dc9903..6f6d6d1e60ae 100644
> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> @@ -285,8 +285,8 @@ static int tfp410_get_connector_properties(struct tfp410 *dvi)
>  	else
>  		dvi->connector_type = DRM_MODE_CONNECTOR_DVID;
>  
> -	dvi->hpd = fwnode_get_named_gpiod(&connector_node->fwnode,
> -					"hpd-gpios", 0, GPIOD_IN, "hpd");
> +	dvi->hpd = fwnode_gpiod_get_index(&connector_node->fwnode,
> +					  "hpd", 0, GPIOD_IN, "hpd");
>  	if (IS_ERR(dvi->hpd)) {
>  		ret = PTR_ERR(dvi->hpd);
>  		dvi->hpd = NULL;
> -- 
> 2.23.0.700.g56cf767bdb-goog
> 
> 
> -- 
> Dmitry

-- 
Dmitry
