Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC1EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8992082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="at8BO+oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfFTKbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:31:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37543 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTKbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:31:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so2617288wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ai+Wy6RJ8sGq35lp3uO5IUu4Pai7vq0XaIREJxIsxZY=;
        b=at8BO+oj8pF0iW/JW+iW92lTCGSBSTAsC+nmKXWaFGnKD04nogA2jvzlvPVhL+5RVo
         sTLXn18/kUcuy/4szsJBCaPH5cbzWzS6oTTwyqoTec32rqQTQu3xtFqQ5nozEXVdSX8J
         PgyEQMydvrV39lkZhPoPb7eWyurKlmyY5PtnyzN5QRHJTKNvbvhM34NUvoT+ApG5mtT6
         u7NloIF3xZlY7+zWcXySQT+NrgUCfMyg/AhMehZrfuee+/IWir/BSz+QzjBCT3uhHrdT
         hcsbFCKM5hKFlC4xlVL/vkYbSjZ+GBA0mVL5DDmaLHxBFfpc8G5EzS45x1R2Wy0mOpHH
         vkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ai+Wy6RJ8sGq35lp3uO5IUu4Pai7vq0XaIREJxIsxZY=;
        b=OXXZ3l7YNxEd4+1c2f0bno07067dApTPvBKHyuLcKXOcL5N57H0vpFCarTrSY2p2A7
         3q/EyQcEaSZ52UzFFTSVPCQFn7qHc7fyNyQt2vV/bfA4+MbjWdvL0mWk8mZ5U6NTujyF
         j+0C1KC/mLbK7gBgO8jxbQF0K2cYHssPLCqnRilTDrFQ4o1N/r5mmhpLtPodSKATawhp
         B3bkbQ5buWhE9mZfed32YF8SQHzjiE1nJyvkTuVZwIoFHB205xTzJA60Zeipf4gYjGYd
         aqLSyY0SEiTs86+y7qkJDGKcozRolrXQ2+3+ymwPbSbz9WU5FKnpfoStFck0hcEXVp1Z
         IoUA==
X-Gm-Message-State: APjAAAXqCn45mnftXAYaJQk0l4DnFnL6Hrn2cZz0dZJ+V6u67dDBuca3
        KwZ31ixSM09GN0GxjEigFD27MfswKjCAew==
X-Google-Smtp-Source: APXvYqzTBFXeeN2WglfwzR3uUik6g7NQugCDX9CCrIkUM8frgpCxJx9WTpIXRcZBDSTqC+BXQyd9Tw==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr2230080wma.107.1561026667571;
        Thu, 20 Jun 2019 03:31:07 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id l12sm47385133wrb.81.2019.06.20.03.31.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:31:07 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:31:06 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: make pidfd-metadata fail gracefully on older
 kernels
Message-ID: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
References: <20190620031144.GA32182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620031144.GA32182@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 06:11:44AM +0300, Dmitry V. Levin wrote:
> Initialize pidfd to an invalid descriptor, to fail gracefully on
> those kernels that do not implement CLONE_PIDFD and leave pidfd
> unchanged.
> 
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  samples/pidfd/pidfd-metadata.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-metadata.c
> index 14b454448429..ff109fdac3a5 100644
> --- a/samples/pidfd/pidfd-metadata.c
> +++ b/samples/pidfd/pidfd-metadata.c
> @@ -83,7 +83,7 @@ static int pidfd_metadata_fd(pid_t pid, int pidfd)
>  
>  int main(int argc, char *argv[])
>  {
> -	int pidfd = 0, ret = EXIT_FAILURE;
> +	int pidfd = -1, ret = EXIT_FAILURE;

Hm, that currently won't work since we added a check in fork.c for
pidfd == 0. It it isn't you'll get EINVAL. This was done to ensure that
we can potentially extend CLONE_PIDFD by passing in flags through the
return argument.
However, I find this increasingly unlikely. Especially since the
interface would be horrendous and an absolute last resort.
If clone3() gets merged for 5.3 (currently in linux-next) we also have
no real need anymore to extend legacy clone() this way. So either wait
until (if) we merge clone3() where the check I mentioned is gone anyway,
or remove the pidfd == 0 check from fork.c in a preliminary patch.
Thoughts?

Thanks!
Christian
