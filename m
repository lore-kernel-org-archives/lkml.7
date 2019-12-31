Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771BAC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E3C206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s773QcfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfLaPzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:55:37 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36074 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:55:36 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so30470267iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 07:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3DNheO3oS1Fazjy7+wOUP9je7WySuIpsBaJSqQ+NApo=;
        b=s773QcfHyOlV140Bzd6aNCFnrw0uIV6s50/TY+aEsI1m3O5e2knjR5JnriC3eu7T0p
         sK719RKGjCC3Lt4uVPYQaCuZgJH+D5Fv6YgVO/lLDKfMvz7JU2xaDtVWYEaY9lbCRcK+
         DyBwhDjfbuYEWcluCl6RBxFL460nMvb7uX1z9aUSEYh1Ey7Q6rp7n3VLDMZzH870Aljq
         26e10iVWEM3+fou3mk+7BifbbHMASb/Fj4Gd+OcdvE9wLwS0IicPp8O7HPiOsdns+GCA
         eU2yeIukqN1FuC6h8tg6aRFVG4delSOQmUH2TK6PGP5fE8IHxOLXGgUenbiNv4t9gieA
         /PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3DNheO3oS1Fazjy7+wOUP9je7WySuIpsBaJSqQ+NApo=;
        b=qDoC6sc0jxgDyoo/BEdfdJfyMlBPks+zls+p+nBhlmdjbCIH8IMCJMuLJFWQBNt0qr
         ZRTtNXs0dfJhrUXO9O8OkP+wQyooxXupCwu2BIEXtrGmGrKbY/Ztn1nZGm1qF3cB/pxs
         8Wqss44NgdKGwWxIswf78KnzOCEJ98kw0TJ0HwK67DNK6bpMluDyuR+LVN3Y6xspndMI
         VTrkSepXsOMNd+Wj5gjKISJG8Uy/MW6ADbRoi84+uNiAfhONgcOiM6iywMEb3QOYj8NZ
         UHkg84evHkJ0S8g44v93i3XLtY1BZnUxRHpV34KFg8NW/f64SKROWmEdMd/dOdEHcspx
         7hWw==
X-Gm-Message-State: APjAAAVYAMDm5MNRZjX6Ydyob1RHCzqqJQtfZfR4D2sTm5h6IhKLphxC
        t5CqN4+BBRj5jrvK1e4hDw5K5V1um5VliHV9thlTnLDw
X-Google-Smtp-Source: APXvYqwfj+BpzOwe/8fjcueBMWO7c4PNAPw15oIuvZXpyaDKDUoJFxhXneOYOTtT+PKCz3r4VFlJhonJdzcZPwMj7Nw=
X-Received: by 2002:a05:6e02:5c8:: with SMTP id l8mr64411761ils.287.1577807736045;
 Tue, 31 Dec 2019 07:55:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Tue, 31 Dec 2019 07:55:35
 -0800 (PST)
In-Reply-To: <20191231150226.GA523748@light.dominikbrodowski.net>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
From:   youling 257 <youling257@gmail.com>
Date:   Tue, 31 Dec 2019 23:55:35 +0800
Message-ID: <CAOzgRdaaxN+BFnx8p2OabC8E9JgcU2VKM=MeGmn9ecmdhJrfLA@mail.gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test this patch, still can see /system/bin/sh warning.
this patch no help for me.

2019-12-31 23:02 GMT+08:00, Dominik Brodowski <linux@dominikbrodowski.net>:
> If force_o_largefile() is true, /dev/console used to be opened
> with O_LARGEFILE. Retain that behaviour.
>
> Fixes: 8243186f0cc7 ("fs: remove ksys_dup()")
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> diff --git a/init/main.c b/init/main.c
> index 1ecfd43ed464..d12777775cb0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1162,7 +1162,8 @@ void console_on_rootfs(void)
>  	unsigned int i;
>
>  	/* Open /dev/console in kernelspace, this should never fail */
> -	file = filp_open("/dev/console", O_RDWR, 0);
> +	file = filp_open("/dev/console",
> +			  O_RDWR | (force_o_largefile() ? O_LARGEFILE : 0), 0);
>  	if (IS_ERR(file))
>  		goto err_out;
>
>
