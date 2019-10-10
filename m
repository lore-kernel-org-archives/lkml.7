Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403F9C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1163D206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TQZ07FMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfJJNut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:50:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42916 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJJNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:50:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id y91so5519251ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o898Z3trs0jH/OlBQbiOm8e/1sEfrvM2Vk3WyyK56M4=;
        b=TQZ07FMvCXrWciJ7O9lR+yonpxUCVIcHnhmodCVsy5Dh/Y5im2arlnqViBllsFZMoz
         FX1zMJwHMqtbjlVh/VFK76TKJ5qMTJkhvErbbOvUl3k+Ss1ZPSUdmEOoFoKO4bV2Iigr
         iZ9kCTkHefQMk+aqix6L1jZn0EltF9d/5eWS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=o898Z3trs0jH/OlBQbiOm8e/1sEfrvM2Vk3WyyK56M4=;
        b=jXXN8erfClgIss90vCLxhZvqT1FO7wZv4UOy/S0AwCSRrKNGTPbIyWpjsRG8875C5r
         nhoN0B6IzXwfwTP3RUw4q+IvPLFm9gDDkRqkZfeWx/8qN+ahaeBWfY1oate6mpVm6ZBz
         82q7iEZjecYhxO0f4YY9HHXCpPcnjfPdOY+Lw48SuBwyBtrXbt8xWkOaep35RFoWBmnI
         wNM0dDpT4xJsV59DVUOz85jNxanXRucnhm9PKucUnHA5f2lW7vByfLffF+QPFVxfzIR2
         rJD/dwMN360uEB6nTYTwT2cTnnWTTSI3XGwnTH9FeMkBQycS8ONNxvowTCEE3sAJyT0W
         PHuQ==
X-Gm-Message-State: APjAAAXvjYexhVr8b/5F25NNgv8+cF33mMUcLlN1ERsjQBTK3bxfUr1i
        ZbGWWawxmMlYn9FiqitQaWhwMg==
X-Google-Smtp-Source: APXvYqwDTtGo4w8HEdRUZir73TR7uahsebmS6NjOfoevZfEYTOWdmz2kjDkxMdcPaAEi5/omDEtt/g==
X-Received: by 2002:a17:906:7e17:: with SMTP id e23mr374597ejr.205.1570715446752;
        Thu, 10 Oct 2019 06:50:46 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id 36sm988776edz.92.2019.10.10.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:50:45 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:50:43 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/4] treewide: fix interrupted release
Message-ID: <20191010135043.GA16989@phenom.ffwll.local>
Mail-Followup-To: Johan Hovold <johan@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20191010131333.23635-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010131333.23635-1-johan@kernel.org>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 03:13:29PM +0200, Johan Hovold wrote:
> Two old USB drivers had a bug in them which could lead to memory leaks
> if an interrupted process raced with a disconnect event.
> 
> Turns out we had a few more driver in other subsystems with the same
> kind of bug in them.
> 
> Note that all but the s390 patch have only been compile tested, while
> the s390 one has not even been built.

Random funny idea: Could we do some debug annotations (akin to
might_sleep) that splats when you might_sleep_interruptible somewhere
where interruptible sleeps are generally a bad idea? Like in
fops->release?

Something like non_block_start/end that I've recently done, but for
interruptible sleeps only? Would need might_sleep_interruptibly()
annotations and non_interruptly_sleep_start/end annotations.
-Daniel

> 
> Johan
> 
> 
> Johan Hovold (4):
>   drm/msm: fix memleak on release
>   media: bdisp: fix memleak on release
>   media: radio: wl1273: fix interrupt masking on release
>   s390/zcrypt: fix memleak at release
> 
>  drivers/gpu/drm/msm/msm_debugfs.c             | 6 +-----
>  drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 3 +--
>  drivers/media/radio/radio-wl1273.c            | 3 +--
>  drivers/s390/crypto/zcrypt_api.c              | 3 +--
>  4 files changed, 4 insertions(+), 11 deletions(-)
> 
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
