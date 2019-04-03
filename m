Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26113C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E624120882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZPpFmaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDCRv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:51:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43569 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:51:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so8681783pgu.10;
        Wed, 03 Apr 2019 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x260aecoqnYvgaGz2sM+JUpMrXA7MWBDVaxzH7/23D8=;
        b=OZPpFmawqry7/pwK8xNefAgc9v+4DLf6KqNcgBEjcIHuaGID1RfWfw48oD32KYicjs
         +nvmeGtguvKgWQAwz0EYIBPtvHRnBMKkP+8QB21BNiBgJvuDXiARfjJLHLncbBXfBnzN
         RLtZhni5t9fkG6nnRoMm48qdDPgp00jjENvssanA5sFQ4ThZudBqr8gM5XkVgHtgDmlq
         fkmwY/vbin45dvhKvXQrFQwdh+2rjEELy2tDEGEO56VpKu0HnXeN6udhrT76JfoSeylD
         RdmhGinqYZA40+bhQjQAI0hZMrTlkopk7NwOYNxQfwgdAuKqhqopIIMzEc2f8X0tIV6Z
         ZMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x260aecoqnYvgaGz2sM+JUpMrXA7MWBDVaxzH7/23D8=;
        b=jOhywAmAU/g0scFxnUh3VWO9CqGX8RtFk2Ub/bf3NJOWmlqW83ukEUO5dQ6+FgeL4h
         9xr27Gk19FD9ftS8wrhKlwT4d/1U+WFXnAiUjG4rZxqpy2N4kEu10Gj5cvRt5qXTzZAa
         Pg40O/+yq8/OXXhl5iPWwrcq7pOidrpEVZbHbQBMx2NrxR1D7pjot/wz83LoVdAKdghU
         LLkewhQkB3eGMbZulccqbAN/Jz3yEPeKy9ec6x2XP6YnWturVGzwiyBGUkU7ek9m3Q34
         Zr9YC4iS2c1iPp8IRQGvGyFCLCskTOhPzrkEdcyYe3JPB7tgeinSoRi6+AYQDMTHOKYr
         fEwg==
X-Gm-Message-State: APjAAAUs8RxEECdT0OwXUu0lP1o8fX712lf6d98dC2ZiJLAgll2EGzER
        p4uozCJNdrb5+9aM/l+wFGA=
X-Google-Smtp-Source: APXvYqxaMEmFmgzM+z4/+WZUiYyTLeY04LlO3+vVomTeNyGvLVRQ+kQAhSc0Qmh+yUgKogAwxNVMlg==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr750493pff.131.1554313885453;
        Wed, 03 Apr 2019 10:51:25 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d38sm19877908pgd.40.2019.04.03.10.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 10:51:24 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:51:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: evdev - use struct_size() in kzalloc() and
 vzalloc()
Message-ID: <20190403175122.GA53104@dtor-ws>
References: <20190221153738.GA17825@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221153738.GA17825@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:37:38AM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = kzalloc(size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> Notice that, in this case, variable size is not necessary, hence
> it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/evdev.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index f48369d6f3a0..ee8dd8b1b09e 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -503,14 +503,13 @@ static int evdev_open(struct inode *inode, struct file *file)
>  {
>  	struct evdev *evdev = container_of(inode->i_cdev, struct evdev, cdev);
>  	unsigned int bufsize = evdev_compute_buffer_size(evdev->handle.dev);
> -	unsigned int size = sizeof(struct evdev_client) +
> -					bufsize * sizeof(struct input_event);
>  	struct evdev_client *client;
>  	int error;
>  
> -	client = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
> +	client = kzalloc(struct_size(client, buffer, bufsize),
> +			 GFP_KERNEL | __GFP_NOWARN);
>  	if (!client)
> -		client = vzalloc(size);
> +		client = vzalloc(struct_size(client, buffer, bufsize));
>  	if (!client)
>  		return -ENOMEM;
>  
> -- 
> 2.20.1
> 

-- 
Dmitry
