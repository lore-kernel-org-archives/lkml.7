Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B00CC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF1620678
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0J5dSUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfIPQy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:54:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43906 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbfIPQy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:54:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so139413pld.10;
        Mon, 16 Sep 2019 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYN4b+NI1YPorAIhhS+f7mmIehASw/nOGjnAcJ1aytg=;
        b=E0J5dSUvECs/aM2rrVuk0JkvPgMq80hHCTpU3WGdUE1SSFyozYc/GLt9UFqy3rukKV
         L8iBc7mzyDR4W0oAnIGqzC39f9zE779/fywBJsiGtwq3TplJVLHNcrv0dby3HVkDCjpT
         84cTpfkh0fjSfWuLICSzwTmfvOEOE+OmOqeU9lTH5FVEGGKHMVpU0v5o3nepu4VVPhTb
         1hDLqpAiHoA8+AD1fVkG/UCmYNiOGwwziPSQlecnkv/mooIPsreUzgP3q2SGBrz8YfMH
         AgoAnU4snWw0jXQDbkzzQI4be+oCv/PlsvhYysHKUmB6FfrnBybv+GngDrY29kVzWDH2
         GAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYN4b+NI1YPorAIhhS+f7mmIehASw/nOGjnAcJ1aytg=;
        b=PtwfH0xZDINqqkZhoY/0Z98OBIHxx0L9ZiyQjmwgNeUc/EYn1P4CzMoONQB/ItH2QU
         q5b2sc2DXg/72O3VJyo5zj3ArKYkHHzK3KfeEjKwzzXf7Je1hpR5KFGp7XjYWZvsw3qQ
         Tuae3fAtHV7xq18t6Yf/HBAjZRPxPGUmW28eDYPTKFglML82cyhLrldXWK6xKBmMBKFX
         mQDStPEosS9tWK6e1VP7xriKxX/6U9oi3EsTUJ+HQ+8TI5U31D9VYtNVpz7knm0hHqeg
         Lm8YH0SXxAbfCO+F+Wcke1UvQ7ZnccX5SyieF5yJYuz8TXavV7+Nl5asd8MwonWlJ1h+
         UhDQ==
X-Gm-Message-State: APjAAAUfkgjnjgr6KdgdUEfa9VawpsUzis7p8vQPi0p6xO8Qu9F8LSBh
        r/JwHYmtyxOQQa7IL4C4BjFM+Z2s
X-Google-Smtp-Source: APXvYqyb4JOTccF6wqRiOtOK+GE+dhorpMejvX9BPOyiIDV5pMYcGVgtc2EYLuKO5XxaGzkJQJMffQ==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr713782plf.329.1568652867960;
        Mon, 16 Sep 2019 09:54:27 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm42787952pfu.104.2019.09.16.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:54:27 -0700 (PDT)
Date:   Mon, 16 Sep 2019 09:54:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: switch to using devm_gpiod_get_optional
Message-ID: <20190916165424.GD237523@dtor-ws>
References: <20190915071323.GA36596@dtor-ws>
 <20190916135904.GA7488@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916135904.GA7488@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 03:59:04PM +0200, Thierry Reding wrote:
> On Sun, Sep 15, 2019 at 12:13:23AM -0700, Dmitry Torokhov wrote:
> > We do not really need to use API that fetches GPIO data from an
> > arbitrary device tree node, as we are dealing with device tree node
> > assigned to the device structure. We can easily switch to
> > devm_gpiod_get_optional() plus gpiod_set_consumer_name() and clean up
> > the code.
> > 
> > Note this is part of efforts to get rid of [devm_]gpiod_get_from_of_node
> > in drivers so that gpiolib can be cleaned up.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/output.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> We can't do that. There's a special case in rgb.c that sets
> output->of_node to something different than output->dev, so we actually
> need to pass the struct device_node * separately.

Ugh, brainfart on my part. I totally read it is output->dev.of_node,
similar to another driver I was looking at...

Please discard, there will be another patch changing
devm_gpiod_get_from_of_node() to devm_fwnode_gpiod_get() once Linus
merges this new GPIO method.

Thanks.

-- 
Dmitry
