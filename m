Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CDC205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmwXQ3k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfCNJIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:08:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39637 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCNJIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:08:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so3543440pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uZCZbVWvjMcSe3Gq3aWQrxKbzamdcnkBDPRD2xJtoGY=;
        b=mmwXQ3k4rCuFovOKIyClyz3NR/FFnocQLNt5WWTiRUTKiu14KegmlAh0tYZi5aASx+
         MA9Li8rOuctuo9dQOSkGtwRaJIw9ee0XiW05PNqyg5qVlhUbNbbbQgT3Mkb2tAjvqbvo
         rtfZrTq9J/KrtkRlWeWYMl2FIzqIK70Is5CykeXfIYVXCHkKC4nXND1GwtbO5AgCTK5s
         z3OYrslha+pTpd/mOJRgUfxI4lMUIjnXzqYxOqUrTlE1rKB6prak4aLTQWP930RcRVzS
         wR70R0KZ2iV5gKMWbMh8zHhwWgpkkxUPzfva6AbjdsKHcEE0sojQ0TmgcB7nFVm60SK8
         YyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZCZbVWvjMcSe3Gq3aWQrxKbzamdcnkBDPRD2xJtoGY=;
        b=LASKR/HckhWbF94RnE2f4WodMeZibuPFER6Mst1/kegwdiL3ze3n54lRNTjQcLf3It
         p4aZHsKonCeiIGsTwrZSu/LhAAT9z33qHZqndElm74N902D6piVeyC0CC1EbL6ObL2kL
         NIHl0Fd5SG6s0vsD7FrOK0B7akpSuLyWi8db/9/5d+90nP6G2zxswMSroEBlvpw1d3sF
         +6Afhyi8rqwrWo1+KwYeXR8F3Jg4ovNbmrUVOCRG1t88OwoD+ptKo6AX8fzHvewRqEan
         BK2fgBI9vohAo+x+XRqhyeMTNh9sGLrSQ1YpOCqs/xM4e3+2lm0bLjdV1MHQqFjkvkt9
         sKkw==
X-Gm-Message-State: APjAAAW+HnA+AJ0YyTk1/8RD32725P+j0uqvL0oiYGfYQTGpwyOhNpZw
        JErLrPNM45LcvvSZ5Xzs8J0MtQ==
X-Google-Smtp-Source: APXvYqw6JcM0OFAWNy2Hp9qFPVqo8KbWYvRM92mfbx8BL9KeeCQ5RMAoU0kWBcHg/nGjxb+1fy0DEw==
X-Received: by 2002:a65:64c3:: with SMTP id t3mr31389008pgv.14.1552554522308;
        Thu, 14 Mar 2019 02:08:42 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id a2sm18289335pff.58.2019.03.14.02.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 02:08:41 -0700 (PDT)
Date:   Thu, 14 Mar 2019 14:38:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        pakki001@umn.edu, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] greybus: audio_manager: fix a missing
 check of ida_simple_get
Message-ID: <20190314090838.ort5tluai4t2zvcu@vireshk-i7>
References: <20190314064525.15756-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314064525.15756-1-kjlu@umn.edu>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-19, 01:45, Kangjie Lu wrote:
> ida_simple_get could fail. The fix inserts a check for its
> return value.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/staging/greybus/audio_manager.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
> index d44b070d8862..c2a4af4c1d06 100644
> --- a/drivers/staging/greybus/audio_manager.c
> +++ b/drivers/staging/greybus/audio_manager.c
> @@ -45,6 +45,9 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
>  	int err;
>  
>  	id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
> +	if (id < 0)
> +		return id;
> +
>  	err = gb_audio_manager_module_create(&module, manager_kset,
>  					     id, desc);
>  	if (err) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
