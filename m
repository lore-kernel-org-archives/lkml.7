Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A0C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89442075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Qr9Hp/is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfE0HKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:10:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33149 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfE0HKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:10:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so25267350edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XL4d1ygyOVos6OxxzUja6aVyQpW0IYXJivlYSrfQHnA=;
        b=Qr9Hp/isXrkr9fuYdPqzaBtAjHowXQV6nHrgMW1iYQSKeh9qk1qaaRUheam0yRh2cl
         GgeR39C4Ti6Nd0i/BnNMq4m5LpI1efLep4sXRL7TWc3akV+9fqlxIKFgClGOCMhi4SkZ
         bom5FuFGCH7qbNmJAlech06iY2d0oRvQn6NxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XL4d1ygyOVos6OxxzUja6aVyQpW0IYXJivlYSrfQHnA=;
        b=cd2KGdy2a4+GMrWCqmQ/rOdgdS4gdFduIBYg+UUfoGEmEWi3DPBxi8cCDAoQOGJewi
         SVXj/UiwJwpb0DPME/xVZOYEYDKPea7Zs6LbrTkNhdi82ctWBSIi8NgGSQxN1cdPfRal
         6oxek9lNV/fvZaN+VQKGWUrSOkBfEKnxVx8GvihMtA2JRJcukFnsQAhx3EyZnP8Abl/k
         3x+UiLrSrGz7VN+IhlpJd3aU/DQtwQ0/fUb9EgaHKQBTqsZhqJmO4p+w0lt/EN3tqgil
         5sPiWuOGQuySCwlEDEjro4O5YPRyz3pjzmbpeThLUjarmewH6mJOLUtnZyQvQkILvvGg
         aDtw==
X-Gm-Message-State: APjAAAVvfxZBA4QZ/TzAWMcRh5ZviX7dPmKim2TozdIs36cLc4RpLTzI
        aYNi+3GZEMeNp/1IEENG57hs7Q+AdCs=
X-Google-Smtp-Source: APXvYqxmf4kZpf2kSzeL00JRYQz4ZuC7fNJI9lm/8bcGPpfy+gM69wF3uZnkD5Bwr4a8VAYhaNb6Og==
X-Received: by 2002:a50:8dcd:: with SMTP id s13mr119843031edh.247.1558941012817;
        Mon, 27 May 2019 00:10:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm3061491edm.25.2019.05.27.00.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 00:10:12 -0700 (PDT)
Date:   Mon, 27 May 2019 09:10:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: Re: [PATCH 14/33] staging/olpc: lock_fb_info can't fail
Message-ID: <20190527071010.GK21222@phenom.ffwll.local>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-15-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524085354.27411-15-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:53:35AM +0200, Daniel Vetter wrote:
> Simply because olpc never unregisters the damn thing. It also
> registers the framebuffer directly by poking around in fbdev
> core internals, so it's all around rather broken.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Jens Frederich <jfrederich@gmail.com>
> Cc: Daniel Drake <dsd@laptop.org>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>

Hi Greg,

Somehow get_maintainers didn't pick you up for this. Ack for merging this
through drm/fbdev? It's part of a bigger series to rework fbdev/fbcon
interactions.

Thanks, Daniel

> ---
>  drivers/staging/olpc_dcon/olpc_dcon.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
> index 6b714f740ac3..a254238be181 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.c
> @@ -250,11 +250,7 @@ static bool dcon_blank_fb(struct dcon_priv *dcon, bool blank)
>  	int err;
>  
>  	console_lock();
> -	if (!lock_fb_info(dcon->fbinfo)) {
> -		console_unlock();
> -		dev_err(&dcon->client->dev, "unable to lock framebuffer\n");
> -		return false;
> -	}
> +	lock_fb_info(dcon->fbinfo);
>  
>  	dcon->ignore_fb_events = true;
>  	err = fb_blank(dcon->fbinfo,
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
