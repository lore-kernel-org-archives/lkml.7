Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184B21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE5jRrFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbfB1Lv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:51:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45315 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfB1Lv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:51:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id h10so14986413lfc.12;
        Thu, 28 Feb 2019 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kLHxOfuK4MGjEo3FgfQ9bLETvktCll1491FafIfmPxQ=;
        b=cE5jRrFoF7UmpSA5DB86soljtGF3nqYThuSzGfkriCubnj8Xa8O/cSUP+gf83fR+Yh
         o2cq7iwR7zH1VfQnN3AmZGPKSigRa5ExdZwNMYZgutTKTVURONE50TBS/toHfNFaWA5s
         rRII6QxfIQ7QQ9t6Q/YSnWPT1JCbjeq52Gt//CCuE9K0G4oZ4OsRZ6CJmok5QygY0ZMe
         38RPgC8D71hRp7A2l9Br0CigQ2SLGIPtDA2s+15XLkf4HGnvzG1XtN5OWSawHyniZlfa
         ahNES1ZWcXyh+HVtCNDeIlJBzuUFkgyxWwT8iQvk0NhZ+5N0nu2cXgkdqO5VRV5cRJhU
         b2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kLHxOfuK4MGjEo3FgfQ9bLETvktCll1491FafIfmPxQ=;
        b=BduXWIjsun24qYKc/u2cabor/yF/9yx/wHW1rbKkyg8tGN9QrZFqgkfABHDoGcxhDe
         YNmh73ewwkEk+5nMiPPAAb7uJLzJ78hEcvW7QJOXw3ea6JLE9BR+G1dNMhHXdLgRwWOd
         V50EijhHYfw/b3XGtZUwKiRZEIV9dCWKanUOZzbBbnGuxDUC7nNYFgkHcMmmmedhRrRj
         25SnSTzhqV08k8uDpyHjRdEpXktV2h5mOeRW/tIW73glCcp/37FIXa9tRqB5pphyAKMk
         o+H7RG2yZZcuP8WSDUpsQBEVk8MIBLOrRy4jo2Kf1tdWnR9yfYWFMoxfPxAra6Mqpk5j
         mW0A==
X-Gm-Message-State: AHQUAua0JL2Sh3ZfW4kAErjwINArFkJKRrV9aC21ztB6lFIYjDz8VwKg
        jKo2AeWKp5cEzbSsmjjCdgg=
X-Google-Smtp-Source: AHgI3IaBoXuqwLxeALITsrrPLFEXJhREV9lCt6aeotCm38INtY+jJdmQ6yG0y2WEKEtkzzAAl/2OpQ==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr3901408lfl.155.1551354715102;
        Thu, 28 Feb 2019 03:51:55 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id e21sm1476902lfc.90.2019.02.28.03.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 03:51:54 -0800 (PST)
Subject: Re: [PATCH] xen, fbfront: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xen-devel <xen-devel@lists.xenproject.org>
References: <20190227205303.GA1231@embeddedor>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <f8ff03de-9d7c-233a-cd86-37269667db0c@gmail.com>
Date:   Thu, 28 Feb 2019 13:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227205303.GA1231@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Xen-devel list

On 2/27/19 10:53 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> drivers/video/fbdev/xen-fbfront.c: In function ‘xenfb_backend_changed’:
> drivers/video/fbdev/xen-fbfront.c:678:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (dev->state == XenbusStateClosed)
>        ^
> drivers/video/fbdev/xen-fbfront.c:681:2: note: here
>    case XenbusStateClosing:
>    ^~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/video/fbdev/xen-fbfront.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 6a4bbc9e1fb0..a3d6b6db221b 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -677,7 +677,7 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
>   	case XenbusStateClosed:
>   		if (dev->state == XenbusStateClosed)
>   			break;
> -		/* Missed the backend's CLOSING state -- fallthrough */
> +		/* fall through - Missed the backend's CLOSING state. */
>   	case XenbusStateClosing:
>   		xenbus_frontend_closed(dev);
>   		break;

