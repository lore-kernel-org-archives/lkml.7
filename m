Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD56FFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883A320854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KgWCWfmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394627AbfJPT6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:58:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50472 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731337AbfJPT6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:58:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so130480wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QwGBNF2mfPZCSaxVM5L9gL5V9TjNG0cRrtA4XmOd9ig=;
        b=KgWCWfmOZGpSCZNWMRYQhncy0eSsPeH2NqSIWrW8U4soudxZrxYIUKF/yJ1A8BXJhW
         HfTp/eXqF1pKVvAYqaC7aemOzRNKbIatlTsXU+nTfKYc8paWI/riU2Y2Q49gzcop2N/R
         25AjagpuFiB+h1pWC0elrJSbnQIE7F10qziqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QwGBNF2mfPZCSaxVM5L9gL5V9TjNG0cRrtA4XmOd9ig=;
        b=PxnYfQkmAU89O81a8Xr5Phui9RSchkcObX+uUe0BRwyM4j9RXJrVTV82EbpJu4iD/i
         8NKW1kagr7gtVLjX+qKztQmV6ugWLcGRkTAAN3ggMUUee+6eeDR9Gm+7ef8tPn9vuXsa
         oBLXRRvn995Y0gASsyZXDjETIDmL2xndtf4/iXyld2Uuw0m1Ml8o659AaATRV6JCZr3a
         IkN+V71PYGBg5aTXRManp5TTjAmspKG+CBa502SkEm3oRO5N5qQzxAN79W22To3N/uKO
         wApDdDeejUX4fDK7HAlZc4UbtH3Cc+i1v77rVoEPb7pCAn4F9jIxhBKia1Lz/Edlkhv/
         iqrA==
X-Gm-Message-State: APjAAAV083FQ8aPTJI5C/E7mRENBDluxODBBomfMQhfHqVylq6mwGn0O
        +7Jv4coY2+K8KVkvvZeSt4YQBg==
X-Google-Smtp-Source: APXvYqxZwgDuBJqSQKKYZXwM7ec49oPND5H+SOWCdy5OpKj8FB3a3dMYc2MHsfEQE7nd+AiWGjbncA==
X-Received: by 2002:a05:600c:40f:: with SMTP id q15mr4805361wmb.30.1571255887783;
        Wed, 16 Oct 2019 12:58:07 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id z189sm5560530wmc.25.2019.10.16.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 12:58:07 -0700 (PDT)
Date:   Wed, 16 Oct 2019 21:58:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 28/34] drm/i810: Refer to `PREEMPTION' in comment
Message-ID: <20191016195804.GT11828@phenom.ffwll.local>
Mail-Followup-To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-29-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015191821.11479-29-bigeasy@linutronix.de>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:18:15PM +0200, Sebastian Andrzej Siewior wrote:
> The dependency has been changed from `PREEMPT' to `PREEMPTION'. Reflect
> this change in the comment.
> 
> Use `PREEMPTION' in the comment.
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Queued for 5.5 in drm-misc, thanks for your patch.
-Daniel
> ---
>  drivers/gpu/drm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index e67c194c2acad..5f6dcbbeb0c1b 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -397,7 +397,7 @@ config DRM_R128
>  
>  config DRM_I810
>  	tristate "Intel I810"
> -	# !PREEMPT because of missing ioctl locking
> +	# !PREEMPTION because of missing ioctl locking
>  	depends on DRM && AGP && AGP_INTEL && (!PREEMPTION || BROKEN)
>  	help
>  	  Choose this option if you have an Intel I810 graphics card.  If M is
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
