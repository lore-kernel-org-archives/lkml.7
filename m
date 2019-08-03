Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD8C0650F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 01:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950192086A
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 01:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lraF67Em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbfHCBGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 21:06:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40533 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfHCBGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 21:06:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so36861448pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 18:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Ztt+0LH1C0C+imT9nDiN3JF0EJqsLNGZKnYTWoc4aE=;
        b=lraF67Emsayr4DCaT/+QqRGFmU+ZyzldRD8G3f5CyEQco0E9gPpuUltAdRRBofElEe
         WZsh6XSHgWXr5qGdxPXSnsqQFzFqlsoT1twzTFj2Du5pxNxavuY2PaYw+/dvjmcDcoR7
         9Lu6HqtmTBP12D0vWhOzRf4RmVkpSjTPE12aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Ztt+0LH1C0C+imT9nDiN3JF0EJqsLNGZKnYTWoc4aE=;
        b=ItSQ1RVXQgsw/ErhmSSuI9Q3t5ZcGa3hQJ1250HhPpd5ddHzH0KvjIXfwqhfxkSZFy
         frC8UzDLosve6iWdhIAHINaOOSmsdR8iwJlre1JvgbRCe6TD4W60k/JJlgDAuTHAOiZc
         MmLqmEt2d4XpvyirTQstS634UgJ55abbdyz+kkAMZKWv/cUXrBTjvchDpH9TFJNN0cBt
         lXIAm6zyokUh3XgPj16oLeqUPG3lv3EHOI1W11EAw07tPq/kHeKBdIPUWrnPF7M6NRHQ
         MjFy4JXWCuS7yHr5e0tTRV/cXbwVI1qg6H18G19UQH1NdNmE1sb8suYM2vENmTAX+Lbg
         WV4g==
X-Gm-Message-State: APjAAAUMcPf7+sSBsYkYa8vvgiXPYYgm1kK3jAfI3LrUccimCz3VhKV/
        OuSDXoN8NNf8tqWItFP6os/Sdw==
X-Google-Smtp-Source: APXvYqzXhzi0GU6L69WI8i34F+64PwisUdJAQr7EWY77ROnxVBW2rou1YmcdGlyMbyzWipwLbSi/Xg==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr60107762pfh.56.1564794406182;
        Fri, 02 Aug 2019 18:06:46 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id k5sm8312942pjl.32.2019.08.02.18.06.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 18:06:44 -0700 (PDT)
Date:   Fri, 2 Aug 2019 18:06:42 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [RFC PATCH] Revert "mwifiex: fix system hang problem after
 resume"
Message-ID: <20190803010641.GA22848@google.com>
References: <20170331202136.100342-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331202136.100342-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Doug, Matthias, who are seeing problems (or, failure to try to
recover, as predicted below)
+ Amit's new email
+ new maintainers

Perhaps it's my fault for marking this RFC. But I changed the status
back to "New" in Patchwork, in case that helps:

On Fri, Mar 31, 2017 at 01:21:36PM -0700, Brian Norris wrote:
> This reverts commit 437322ea2a36d112e20aa7282c869bf924b3a836.
> 
> This above-mentioned "fix" does not actually do anything to prevent a
> race condition. It simply papers over it so that the issue doesn't
> appear.
> 
> If this is a real problem, it should be explained better than the above
> commit does, and an alternative, non-racy solution should be found.
> 
> For further reason to revert this: there's ot reason we can't try

s/ot/no/

...oops.

> resetting the card when it's *actually* stuck in host-sleep mode. So
> instead, this is unnecessarily creating scenarios where we can't recover
> Wifi.
> 
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Amit, please take a look. AIUI, your "fix" is wrong, and quite racy. If you
> still think it's needed, can you please propose an alternative? Or at least
> explain more why this is needed? Thanks.

FWIW, I got an Acked-by from Amit when he was still at Marvell. And
another Reviewed-by from Dmitry. This still applies. Should I resend?
(I'll do that if I don't hear a response within a few days.)

Thanks,
Brian

>  drivers/net/wireless/marvell/mwifiex/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
> index 756948385b60..0dab77b526de 100644
> --- a/drivers/net/wireless/marvell/mwifiex/init.c
> +++ b/drivers/net/wireless/marvell/mwifiex/init.c
> @@ -60,7 +60,7 @@ static void wakeup_timer_fn(unsigned long data)
>  	adapter->hw_status = MWIFIEX_HW_STATUS_RESET;
>  	mwifiex_cancel_all_pending_cmd(adapter);
>  
> -	if (adapter->if_ops.card_reset && !adapter->hs_activated)
> +	if (adapter->if_ops.card_reset)
>  		adapter->if_ops.card_reset(adapter);
>  }
>  
> -- 
> 2.12.2.564.g063fe858b8-goog
> 
