Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFFAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE482176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz0/vgpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLRXOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:14:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40772 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRXOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:14:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so2065509pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=19giDa73iAamoP9E5FulQ50cC/oQrQn2ADANTzOxjg8=;
        b=gz0/vgptUI3f4mZVJzy6ehJxc5tNsKuhTlS+lpxtyN986J0B/FFinrTSrnnhAVzeWL
         RxaB4+bdLSoGVsrLx0mpqfUBxydHs5P2AsHgOGINoZb2aO3IgdD+8rLxGJuAoTMpYZqK
         HelXeVMszK6a+HYLlw34i0YeKfwtycBSpsOI5QFqHWZyyhPioMTibzpVK1o/9w1Jh1EY
         +FkQTg6jz+ha9v6rASGq2nOyifRjpPWsDECVAVrnwjs2kBXCUbnkV9rl/jja0Ue6qhA2
         4zZ1R9p3+rcn24vCAaRuIpwQsztFDz1fQZJS7J6FVDXcOaI5A1gNLv5suU1k4PyI2uJ4
         wnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=19giDa73iAamoP9E5FulQ50cC/oQrQn2ADANTzOxjg8=;
        b=RiZDdAzqCoeP8rJl3eN1dGeS+RU1EiHGJw5A0BSpjBezh0fvb+Ya2TcvcZkllx+EW2
         DpEhQdSIjFwCxaUQq7UVpXCvo1T45rgx6U/BSUI/zPGx5pGEjsG8vJTiyWL7YcAXOCbN
         xwsY6XCOO0bqLBYDJO+Cyi3iNjNPeusavP5PkwpjavLc0PEIibbBWkWYayGZp/UKD88c
         yVf9tb9GdFj3FXOy2zXpHjKMXTL0tUCrS+gT4Vi4X3zZWc5XBx5vfL23h+AZUuhWccrg
         oYuPm3fw14U69kbKSQk46ObGWWhSFe9DL+3WyqP0hViDDl3cn8KKHhm4unnMicizx6AO
         8tiw==
X-Gm-Message-State: APjAAAUzfQ8w3x/1bfGD9VxHwfjVJBDJVJgLqboo3CXRs938iUxaFjT6
        nl+pMDOeysx51j9Fwg911+/sccxv
X-Google-Smtp-Source: APXvYqzL/hkws4Q866hOxvAOFOM6BJTPtxuM/KkzXFYIfH7tSXbcZAtTZtj7h3s2hcuxZlM4MpCyvA==
X-Received: by 2002:a62:1883:: with SMTP id 125mr5810192pfy.166.1576710864113;
        Wed, 18 Dec 2019 15:14:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p23sm4553251pgh.83.2019.12.18.15.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 15:14:23 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:14:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] init: Fix crash observed if there is no initial console
Message-ID: <20191218231422.GA23984@roeck-us.net>
References: <20191218230149.23299-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218230149.23299-1-linux@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:01:49PM -0800, Guenter Roeck wrote:
> Systems with no initial console crash in f_dupfd(). This happens because
> console_on_rootfs() was changed to call filp_open(). Its return value
> (a file pointer) is checked against NULL, but returns an ERR_PTR after
> errors. This ERR_PTR is then passed as file parameter to f_dupfd(),
> which experiences a severe case of indigestion.
> 

I should have pulled upstream before sending this. Sorry for the noise.

Guenter

> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 8243186f0cc7 ("fs: remove ksys_dup()"),
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index ec3a1463ac69..1ecfd43ed464 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1163,7 +1163,7 @@ void console_on_rootfs(void)
>  
>  	/* Open /dev/console in kernelspace, this should never fail */
>  	file = filp_open("/dev/console", O_RDWR, 0);
> -	if (!file)
> +	if (IS_ERR(file))
>  		goto err_out;
>  
>  	/* create stdin/stdout/stderr, this should never fail */
> -- 
> 2.17.1
> 
