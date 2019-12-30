Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D122DC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 22:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24C5206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 22:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YJFfA9U5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfL3WCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 17:02:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33444 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3WCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 17:02:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so11560904oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YzvK3lw7REm+d3DorChVuNUjGAEcBQeyAFoY/nT0KFA=;
        b=YJFfA9U5/zxM8uThmIhHdSff5EiB/t7YyoTIqJWn5wxYA3R4rPc+kZvHhxX8JQ4rN/
         T5NnBcELhpGtUOUlRB7O8ztldeHkExKTseZwZ6eqysvJjc2SjtELbKU8e3rpan47cBoL
         2dISubjtDEISV3v9SvPG8msQa/SqVEyoXVvHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzvK3lw7REm+d3DorChVuNUjGAEcBQeyAFoY/nT0KFA=;
        b=TSL5u4I7IDPSCi0c4g5N8heez/1DTrhubA0MnrlUxoxZpE+SK2JQPCDqqQmpJI2CAA
         iBjyXtIQJQ+l+zVbUMhOMu1zeROD9AU4WaP9dY4Mx3jE8ukRUxgUPTe2FFYJsaQH9be8
         B1S1QIPPsH6JSiuMh5uBd1NHAwvm7BlBLOmDlomCYXgNoOmARSlmcj2wpdN86qcVES12
         7fQCCbvRojRQ1zlq5Lnt1a2tCx7ImZetJbi25ZxHubi6g4u5jgZBGAImlqY4gdvSciv2
         O3OESJbZEdnUVvDc63jdX0uBMN1nllpBDXx86iBP2wBNGmh9U2ekZUMlS2SwO3HaDEVS
         R77Q==
X-Gm-Message-State: APjAAAX/GjITS2TYfwW4BMCTZlCZt6J0xI3/HqISQ3uB5hhv3jLH9Plg
        4mEn38zY8rMQhTDu3C9pOakJww==
X-Google-Smtp-Source: APXvYqxiJccOeI8SFgqfsRl/LUjBmX53WNU+d8QYDSZK+ad+wpwJQQomgih0frMU0aixKHRwat0GhA==
X-Received: by 2002:a54:4602:: with SMTP id p2mr401583oip.138.1577743367953;
        Mon, 30 Dec 2019 14:02:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17sm14146392oic.45.2019.12.30.14.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 14:02:47 -0800 (PST)
Date:   Mon, 30 Dec 2019 14:02:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH] selftests/seccomp: Test kernel catches garbage on
 SECCOMP_IOCTL_NOTIF_RECV
Message-ID: <201912301402.DAA6ED9A0@keescook>
References: <20191230203811.4996-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230203811.4996-1-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 12:38:11PM -0800, Sargun Dhillon wrote:
> This adds to the user_notification_basic to set a field of seccomp_notif
> to an invalid value to ensure that the kernel returns EINVAL if any of the
> seccomp_notif fields are set to invalid values.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Kees Cook <keescook@chromium.org>

Thanks! Applied. :)

-Kees

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index f53f14971bff..393578a78dbc 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -3158,6 +3158,13 @@ TEST(user_notification_basic)
>  	EXPECT_GT(poll(&pollfd, 1, -1), 0);
>  	EXPECT_EQ(pollfd.revents, POLLIN);
>  
> +	/* Test that we can't pass garbage to the kernel. */
> +	memset(&req, 0, sizeof(req));
> +	req.pid = -1;
> +	EXPECT_EQ(-1, ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req));
> +	EXPECT_EQ(EINVAL, errno);
> +
> +	req.pid = 0;
>  	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
>  
>  	pollfd.fd = listener;
> -- 
> 2.20.1
> 

-- 
Kees Cook
