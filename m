Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163472175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QqbyYUtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbfDXTgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:36:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34094 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXTgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:36:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id a6so17024174edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q/yKWZQha9zOHwCzACjXE8LcZSkbRIr+kR0mIguf+4E=;
        b=QqbyYUtfn3yZz51xKemy3g/LwYvnat2oRUK8RCi3KYzW3xJ6vlJ4YxsWT0PMlbbzI5
         4hpVfrYg0CyTRaX0U0UBdog8Bg4GqNfkfGnoXhsAwJyi9Te/emFPQRHachmSmyHPaM3B
         sTDxKkPqhlfIaq8G5BrX250oyCq8eI5m1KsIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=q/yKWZQha9zOHwCzACjXE8LcZSkbRIr+kR0mIguf+4E=;
        b=CfvM/PshoqVekF4bF+WzsJd96Qzub8pHPK16LRW6UujEk+RQXp9VRr2GO6caXrHoSm
         9ErD+O3sLk59F7D7003x0y47IbN/NUyDmVQv3fFXvkIQ6BmIJNLYzXVvnvM35QtOV3lc
         qBjxavFnorubFvW7e0TTUhknvzwjbHM7yIGhc1+plop/Ks5zNCp5dQYZOetkKAO2y26j
         eCl5E+pe2mD4rlK4Z1CIRXUNyUTxY/I0C2uozm7Qz8W2FmtJ3BdT2Rkp/ae7DGgG5Dy7
         KBTWz/w/ns/+2DdAalntSQAOL9q0O7u1H4LhE/HTaBnBtwXwSZPisACbQ6KDSZCuEtOg
         olsw==
X-Gm-Message-State: APjAAAU2uX+LOhQ4EovUUCWOdp3OFzU6OxJx7JnVEc6D0o4bWD7/MQRu
        wzJ7daW+NQiLQtXbBnTDl44YdA==
X-Google-Smtp-Source: APXvYqz4A80128TmpcwY7Jw9RvTz2M6P3GstRBBf+pwR+tTaTJA8S2RzPMzePlc+ZldBFifc3EkuJA==
X-Received: by 2002:a17:906:1856:: with SMTP id w22mr17495371eje.130.1556134600351;
        Wed, 24 Apr 2019 12:36:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s56sm7655edd.35.2019.04.24.12.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:36:39 -0700 (PDT)
Date:   Wed, 24 Apr 2019 21:36:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 2/2] drm/doc: Document expectation that userspace review
 looks at kernel uAPI.
Message-ID: <20190424193636.GU9857@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190424185617.16865-1-eric@anholt.net>
 <20190424185617.16865-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424185617.16865-2-eric@anholt.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:56:17AM -0700, Eric Anholt wrote:
> The point of this review process is that userspace using the new uAPI
> can actually live with the uAPI being provided, and it's hard to know
> that without having actually looked into a kernel patch yourself.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  Documentation/gpu/drm-uapi.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 8e5545dfbf82..298424b98d99 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -85,7 +85,9 @@ leads to a few additional requirements:
>  - The userspace side must be fully reviewed and tested to the standards of that
>    userspace project. For e.g. mesa this means piglit testcases and review on the
>    mailing list. This is again to ensure that the new interface actually gets the
> -  job done.
> +  job done.  The userspace-side reviewer should also provide at least an
> +  Acked-by on the kernel uAPI patch indicating that they've looked at how the
> +  kernel side is implementing the new feature being used.

Answers a question that just recently came up on merging new kms
properties.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  
>  - The userspace patches must be against the canonical upstream, not some vendor
>    fork. This is to make sure that no one cheats on the review and testing
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
