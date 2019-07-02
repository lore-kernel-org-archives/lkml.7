Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E66C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDA02063F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mc9Zgzxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGCBcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:32:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40432 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfGCBcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:32:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so259957pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eB6S4cIG2ic7xIJ0b0BVpA8z0egoMH0hNtHA1F0tef4=;
        b=Mc9Zgzxi7WpN1Y0XEo1iD+dNo1ILtatcJksAae4nWOPbWm7s2Ed/HD0mGWbza1EhPs
         f9+5ef3wLIriMDbYvAeVswhba6w815dbKYeDrem+W/TdNTlX9rJYEzgxE+XVttyzoTgt
         a+QZZCoV7jcLA1bE9U/R0g1i0+VJUSz6AH6hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eB6S4cIG2ic7xIJ0b0BVpA8z0egoMH0hNtHA1F0tef4=;
        b=ZaKwL/0PgG4tqIwELtudWuBeAlNemy3OnQumtr743RwF+0Wdg3WxGTmlmT71f9mp5b
         cFSJlWz7DgmNlnYe2tYyfvhGzGtoi5DOxXbnl2d1iZGKW4JkOKuzD8WmwTsDKZ7mF+og
         NfuDBKpMznDMJVCnbRy/aQhivoFzG2PBMnIaXRC8uxt6OKbYaHOeouNogNlTBedl9dmQ
         mLn66NF6pf8jd/I8qJvduVGapH2whvpCxYHNpGMQ6iynTJUCXraSU0CNLzOgt9zK66cd
         A3STvTp/fBkCoBJyL80GQlCEN5zpSYXOyTM8gWit9dZ3D+xh51hraFCY0DKwzIIxljN9
         IFog==
X-Gm-Message-State: APjAAAVfEE5S6/O+TneBVj6tO6hqZSUzxTGk5J7cyBkyDF/ThQxOjmGF
        rVeIK9G8kQ6KCSpvjhJ1L+EFzqyrb+k=
X-Google-Smtp-Source: APXvYqwmPOBAaXQUnvIdrwl5iMJ1KFOaDS7/wjSob7es+yD/2C7SqHepeXjWMhCH7KaKi48XGbBdkA==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr10594527plo.157.1562102157592;
        Tue, 02 Jul 2019 14:15:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s193sm62332pgc.32.2019.07.02.14.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 14:15:56 -0700 (PDT)
Date:   Tue, 2 Jul 2019 09:03:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com,
        andreyknvl@google.com, hans.verkuil@cisco.com, mchehab@kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] media: usb: technisat-usb2: fix buffer overflow
Message-ID: <201907020858.66B63B24@keescook>
References: <000000000000089d7f058683115e@google.com>
 <20190702140211.28399-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702140211.28399-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:02:11PM +0700, Phong Tran wrote:
> The buffer will be overflow in case of the while loop can not break.
> Add the checking buffer condition in while loop for avoiding
> overlooping index.
> 
> This issue was reported by syzbot
> 
> Reported-by: syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com
> 
> Tested by:
> https://groups.google.com/d/msg/syzkaller-bugs/CySBCKuUOOs/0hKq1CdjCwAJ
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  drivers/media/usb/dvb-usb/technisat-usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/technisat-usb2.c b/drivers/media/usb/dvb-usb/technisat-usb2.c
> index c659e18b358b..4e0b6185666a 100644
> --- a/drivers/media/usb/dvb-usb/technisat-usb2.c
> +++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
> @@ -655,7 +655,7 @@ static int technisat_usb2_get_ir(struct dvb_usb_device *d)
>  #endif
>  
>  	ev.pulse = 0;
> -	while (1) {
> +	while (b != (buf + 63)) {

This matches the "62" from the earlier read -- instead of these literal
numbers, could you replace the "62"s with a named define for whatever
would make sense for this driver (maybe "IR_MAX_EVENTS"?), and then you
can make the above be something like:

	while (b <= buf + IR_MAX_EVENTS) {


>  		ev.pulse = !ev.pulse;
>  		ev.duration = (*b * FIRMWARE_CLOCK_DIVISOR * FIRMWARE_CLOCK_TICK) / 1000;
>  		ir_raw_event_store(d->rc_dev, &ev);
> -- 
> 2.11.0
> 

-- 
Kees Cook
