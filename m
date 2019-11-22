Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656FEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3861B2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="POFeHIe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKVSx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:53:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42942 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfKVSx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:53:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so3448293plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6E9NZkdr/kbq+mZ57VvACbVb5vZgZvusBXUrNoSxstw=;
        b=POFeHIe6ACfTnec5KX2EeN65fJwFF1hfvM4Lt1ZT7dwcHSth+HJwcXT8ra2mkMpwcO
         JPKJrDH1h40U/EB+aEw58r6Y+EAxEzYEtbQ6oOpocTDpdwjWjulybSIMZowaFNsgk+Vp
         ghsIg/vlAjDpeoBLoZ8F1xIj79m7XYbyz9Mic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6E9NZkdr/kbq+mZ57VvACbVb5vZgZvusBXUrNoSxstw=;
        b=LkcDoKDEHP+viSIAa9mwEPFCajFUWgv/1VoDZRIujmwI1nx4AUSsy6WS7C8Ho2fYKT
         7GKjLF8jUJFoe1cZ9aYwYx1b3GbyNQO2+1RJJGRxCFs5ULQdFA2k3YiA+DM0qaZmYZaC
         UWM2YqBiKi9C7I4WwmZwE4wgDqW9L24/ZxURv6gEkkMZMqEqk7gV8xzfQjxxjHz4GcDI
         oHEfKoiX0+ORY1VwK/BFiHb5+CDretMoEKaxx/71fEAbevH0cQBeqEfJhd2yGAm0ZiFa
         5NQkRYZYMqwALFFCpXtlp1nUZa4nbqrrtvXGfKhHND2IGb7zwNsxdWglZ9Jg3401zuu+
         Wo3Q==
X-Gm-Message-State: APjAAAXu1C3/iB/gaxorf6j9MeAm7TWr/J9Ty1bDYepMP870Aq61wXEo
        M7GW6pDPNZfhwXG7plIohaVNwQ==
X-Google-Smtp-Source: APXvYqwNt8Ri9QzXiTHxgQ0PwSNV7Vy8N8Sr1ln9LuV2RaZwHitgsHYZmwj6TeOre+Uwlpx7gTG7UA==
X-Received: by 2002:a17:902:8502:: with SMTP id bj2mr16025669plb.303.1574448804706;
        Fri, 22 Nov 2019 10:53:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm8161490pfi.187.2019.11.22.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:53:23 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:53:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
Message-ID: <201911221052.0FDE1A1@keescook>
References: <20180824211535.GA22251@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824211535.GA22251@beast>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping! I keep tripping over this. Can this please get applied so
we can silence syzbot and avoid needless WARNs? :)

-Kees

On Fri, Aug 24, 2018 at 02:15:35PM -0700, Kees Cook wrote:
> As described in commit 96c6a32ccb55a ("include/asm-generic/bug.h: clarify
> valid uses of WARN()"), this replaces a userspace-reachable WARN_ON()
> with pr_warn_once(). The reachability is even noted in the existing
> comment. This appears to be an "expected by unlikely" condition, so
> getting rid of the WARN_ON() means kernel fuzzers will stop reporting
> the problem. Additionally un-breaks the error string so it can more
> easily be found with grep.
> 
> Reported-by: syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  block/blk-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index dee56c282efb..470c3cea8cb0 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2166,11 +2166,9 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
>  	if (part->policy && (op_is_write(op) && !op_is_flush(op))) {
>  		char b[BDEVNAME_SIZE];
>  
> -		WARN_ONCE(1,
> -		       "generic_make_request: Trying to write "
> -			"to read-only block-device %s (partno %d)\n",
> +		/* Older lvm-tools actually triggers this. */
> +		pr_warn_once("Trying to write to read-only block-device %s (partno %d)\n",
>  			bio_devname(bio, b), part->partno);
> -		/* Older lvm-tools actually trigger this */
>  		return false;
>  	}
>  
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security

-- 
Kees Cook
