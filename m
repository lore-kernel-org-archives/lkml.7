Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44DBCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6221872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="IbRlo7Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfJWRWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:22:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51739 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbfJWRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:22:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so14978287wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QbTra0uJ3GAK5aRJqKs09WvEOgigU1h/A1zQ/ViboTg=;
        b=IbRlo7RbDs6RKF2lRHfynAfbkUxVBVujJoTmSGYxMfIyrepEAJRAWqUB6W9NosHMFd
         MGb62Ulg8FZmhsPagKjXGsDGvTXx29y9VbdwHUpoXlAA4eahExIpmqF0ya9HF+57dXey
         VBMk52BrwKfhkZAJi3CWTajtr4Z9JCoInbEkPgK2imdbnJisADco/9jdbVbBEJa2F21o
         /kRw+H3Yp+nOcCl5Fuhb/0D1/cBkKZFHmNEcFryuM9bLW9wLBgFH8SL/Yyi5AB20cBn5
         y9Yvyq7h/OvsET9rwKzOXeP3OePyKos8O2Kw/C+osRxoZXES9JRoWCZo7ZdFR+daPWpo
         UtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QbTra0uJ3GAK5aRJqKs09WvEOgigU1h/A1zQ/ViboTg=;
        b=WADMHsdh7754eX/9okG3ip70OAM8mdp5wLHGYxGw6n5bEt8dqeIgh5UpcqOupRWNij
         Fc5HjoDyyoXLjxjE1QBXufjWQ7JOl3Muho8L9Wap/IZz/8NlOgBIAJeeQdSa7mlAA0Go
         lMWyX7tkN2vrFwKM2Hm2xwdjpPEWonZBvLY6XRAz6Sn/mRiimj+Jqj0JqwiKKOHVJsLO
         +fOrbUx6Ny39dwuEKsBNYkU2/lHHe95rt7T0csYSWV37PoTL5mLLGMyWp7tuvJKduG5B
         auoH3s7ArInfPxafrvFDoIZ018E8+GZzZTjCAhcYPtC5FDDM1EcR9p5XOTSWbl7btayn
         GGkw==
X-Gm-Message-State: APjAAAVGCIf6UVElMvnRuiL9cl642oDoEe+hmRY11WvpOP3Q43n72kOS
        YSJtmWOCx1oytqtFnXzaSUwtfA==
X-Google-Smtp-Source: APXvYqyEPTDJfwPpntTOrPlMjxRx+A1Aaeut5CV2NFF2pZSD9ukVtTP4DXj647WsJWur7fhrRMjWvg==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr905258wmc.139.1571851366834;
        Wed, 23 Oct 2019 10:22:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id g5sm7020355wma.43.2019.10.23.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:22:46 -0700 (PDT)
Date:   Wed, 23 Oct 2019 18:22:44 +0100
From:   Alessio Balsini <balsini@android.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 4.9 4.14] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Message-ID: <20191023172244.GA164146@google.com>
References: <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20191023171736.161697-1-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023171736.161697-1-balsini@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ops, please forgive the wrong in-reply-to messge id :)

Cheers,
Alessio

On Wed, Oct 23, 2019 at 06:17:36PM +0100, Alessio Balsini wrote:
> [ Upstream commit fdbe4eeeb1aac219b14f10c0ed31ae5d1123e9b8 ]
> 
> Enabling Direct I/O with loop devices helps reducing memory usage by
> avoiding double caching.  32 bit applications running on 64 bits systems
> are currently not able to request direct I/O because is missing from the
> lo_compat_ioctl.
> 
> This patch fixes the compatibility issue mentioned above by exporting
> LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
> The input argument for this ioctl is a single long converted to a 1-bit
> boolean, so compatibility is preserved.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index da3902ac16c86..8aadd4d0c3a88 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1557,6 +1557,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  		arg = (unsigned long) compat_ptr(arg);
>  	case LOOP_SET_FD:
>  	case LOOP_CHANGE_FD:
> +	case LOOP_SET_DIRECT_IO:
>  		err = lo_ioctl(bdev, mode, cmd, arg);
>  		break;
>  	default:
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
