Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A20EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C12620830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFdy+CBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfCDCWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:22:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32956 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDCWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:22:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so1846425pfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 18:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sPivnksh9g4etmqH1gGZOjaJGhgb/76+FKYGDOO4t30=;
        b=TFdy+CBJ6SVfvUemc46f9IB7LZK892xOtuiRQFcY/Snv6gUVGjtbDu3lB9Ao4E0Axd
         agBVcG3na8aPNNDn1eXWkglQn/wTVEKV7RgpnDnL+TvEKEUbAJr0hpTBeLNP2XeWfT9M
         VVVJG2+ZzgvhdXFDnSunhI66G9Nb8jlqLy9FlZJfXPWvx0YNF1T0JcofoSoZwZE5nfxY
         Hba3Lsx8uZXrQqlcFt8H8eAKHLsdJdUJzIch/tut3+f1WP/YsFp9zABFypClwTeudE5J
         ouA3v5faTWzcH1/aTfYLfcEkByoHpitO0D3UjqCnwV11G5+4Nc9XhwrNLH5mben7O3ng
         ckMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sPivnksh9g4etmqH1gGZOjaJGhgb/76+FKYGDOO4t30=;
        b=FMd6xOSfJ7gM6jPfkukQ0H3c8i11Sy2dvxsTiYeyb6sbZ4XKhr3tDDGOGlBWM2QEEd
         NHHKP0gyHb3QdN5v5PYv8DExjmVaamnRMMIGI6yinugqfCDWhs9fU3VofSWPe2zNFvlj
         RmRDzhCKNJka3tFpH8FQlMlzZygjpjAORua1mkwbul37DA1vGIZ3X8M2cJWof0aZhCgf
         SpyolR3r9VxW1wSqtAPjfCbW2qqgIqrmWXXhViKeZHQb47vIDxcz2silHunCcqjuoe/s
         cfSyNAzuDLiZXdUpZZ4nYXwsMLaSqOVyOLQk6o0KJOFVXS7oC2xFNM3YotSRvbWwtYuC
         MhZA==
X-Gm-Message-State: APjAAAWCudl3FoMJYjZe6deuZ1Ul24MjX2629QQGti5Rq07WXnHXynwT
        o38Bcu+EiVK2UPWYqVAtqR8=
X-Google-Smtp-Source: APXvYqy9uywUMMn4M6JHYbAeGzGqk4KX8va/ufGXMEyJ0FV64PwdqtjZBJvL31Jr5VpVhtu9n1FWJQ==
X-Received: by 2002:a17:902:282b:: with SMTP id e40mr17966744plb.111.1551666152801;
        Sun, 03 Mar 2019 18:22:32 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id p86sm9992604pfa.104.2019.03.03.18.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 18:22:32 -0800 (PST)
Date:   Mon, 4 Mar 2019 11:22:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Remove no longer used LOG_PREFIX.
Message-ID: <20190304022229.GC23578@jagdpanzerIV>
References: <1550829580-9189-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550829580-9189-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/22/19 18:59), Tetsuo Handa wrote:
> When commit 5becfb1df5ac8e49 ("kmsg: merge continuation records while
> printing") introduced LOG_PREFIX, we used KERN_DEFAULT etc. as a flag
> for setting LOG_PREFIX in order to tell whether to call cont_add()
> (i.e. whether to append the message to "struct cont").
> 
> But since commit 4bcc595ccd80decb ("printk: reinstate KERN_CONT for
> printing continuation lines") inverted the behavior (i.e. don't append
> the message to "struct cont" unless KERN_CONT is specified) and commit
> 5aa068ea4082b39e ("printk: remove games with previous record flags")
> removed the last LOG_PREFIX check, setting LOG_PREFIX via KERN_DEFAULT
> etc. is no longer meaningful.
> 
> Therefore, we can remove LOG_PREFIX and make KERN_DEFAULT empty string.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Looks good to me. Well, at least I don't see any problems with the patch.
We can do a tree-wide KERN_DEFAULT removal later.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
