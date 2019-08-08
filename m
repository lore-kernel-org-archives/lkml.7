Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F4FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B45C208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Gfx81Rb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404984AbfHHXvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:51:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41414 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404428AbfHHXvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:51:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so45003465pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/G0TFVjCUap+pDH4HwBYaUgixwH7p+g48u4h0lUf/g=;
        b=Gfx81Rb5sKUjj0wNVhcQPEeBzwNfWHUUVfG0NTwMHkz6ASP2Usv3QvC3SUCcxyQJik
         Zr3PBpyTYptMyWO3cf4GZNvU+8n2qqfofWVWeriVHxoNflgz++9Zsai6R0Etb+Na54td
         O6Z3rsfOd+dQ7QbAqrU9OTAMbU4uszormzKog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/G0TFVjCUap+pDH4HwBYaUgixwH7p+g48u4h0lUf/g=;
        b=I9Vwh1gFck8vlgs7F+aUyI7m/rywWzW5ZsHAezkuId5Q847ndYS8AhbZlmlkDc4Od8
         8A4sOzWGyrqxibuPn+/KUFrsidH9IhZIqfDKiq1VZRPkgmXa3vM6NMes0zU5JMl7k8zK
         mY32yPrefFfCGOKann5gEhDl1IjwYoi5WK3SeRqh+iValS8zrhYFL0/Oby2XfFZoB7rS
         YeBNU2NZ82XkgP5RldIvh1N51uDquqUSG7sN5/x+qQ3W8uT/l0+aM1Dmkq7CBdtDDMzK
         SgE19FgrF4/FvUM0Md7o/TM5jE6kCeq+f9ztOjRialfIJY3dyL//8+zB09C77SEZehPI
         QLww==
X-Gm-Message-State: APjAAAUFT/olpdamAIT5KlczkzI6vQJ6IjeafVTnttn7oNGoDNvkmIKm
        DJAEb1ETAR6dprtGP+2ST2dyJw==
X-Google-Smtp-Source: APXvYqxrlsqV8xbl4fIYfzaen4LDYxS+vtSz93UK1MF6HsVtP1GEJoMKeg1vRzCNvxmwShtwIpGecQ==
X-Received: by 2002:a17:90a:8d09:: with SMTP id c9mr6616809pjo.131.1565308313064;
        Thu, 08 Aug 2019 16:51:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z13sm3647295pjn.32.2019.08.08.16.51.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 16:51:52 -0700 (PDT)
Date:   Thu, 8 Aug 2019 19:51:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alessio Balsini <balsini@android.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, dvander@gmail.com, elsk@google.com,
        gregkh@linuxfoundation.org, kernel-team@android.com
Subject: Re: [PATCH v2] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Message-ID: <20190808235150.GA208797@google.com>
References: <CAJWu+oo=GrZ+SbA6=bboM4==TKXBsTRWkTrkWiZ55pqhJtgQqQ@mail.gmail.com>
 <20190807004828.28059-1-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807004828.28059-1-balsini@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 01:48:28AM +0100, Alessio Balsini wrote:
> Enabling Direct I/O with loop devices helps reducing memory usage by
> avoiding double caching.  32 bit applications running on 64 bits systems
> are currently not able to request direct I/O because is missing from the
> lo_compat_ioctl.
> 
> This patch fixes the compatibility issue mentioned above by exporting
> LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
> The input argument for this ioctl is a single long converted to a 1-bit
> boolean, so compatibility is preserved.

This commit message looks better now.

thanks,

 - Joel


> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 44c9985f352ab..2e2193f754ab0 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1753,6 +1753,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  	case LOOP_SET_FD:
>  	case LOOP_CHANGE_FD:
>  	case LOOP_SET_BLOCK_SIZE:
> +	case LOOP_SET_DIRECT_IO:
>  		err = lo_ioctl(bdev, mode, cmd, arg);
>  		break;
>  	default:
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 
