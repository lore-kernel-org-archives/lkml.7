Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BBAC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E25217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nhwHsvp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfGaUZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:25:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41438 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbfGaUZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:25:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so32506051pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0pLvL4XoGYF6/S/bO4KhBdgKs6/M0DxlhP6T+btdb0E=;
        b=nhwHsvp/32LnkrUUYeFQVJf6a5XG0VbCeyqdOhNKuGjJPAEI+E8IajZXhfy7iku3Nt
         GXQW8AaA5AJ6NNU8XIXmhoOriXYI/zGZfxRpnj3GAYC0ps7JvrlOec9TzP8ptbdIwQYv
         DKXypv6Fq73h5SZxLpblvCN/RVEvKIWxs0yCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pLvL4XoGYF6/S/bO4KhBdgKs6/M0DxlhP6T+btdb0E=;
        b=DQnEDz2U+7+ksD5FQX2sNUYfWb3ltLSlWTCpuDYAUjg7jVFhnJ9XurdU/WWJ2FnG5O
         fw4nmluU6krwIilEmyN/89/J7s67G3wYk79534hM7BrK8tR9Wb9i7ZjOkeowMqH4JYzr
         hlUyCfdV03q3bxEPNQpi/k4U+1Bk+6u+TCivy44G/NUHIgsU5z3A/519WkjsOq409JPo
         O/Ocdj1nzOHpQwSzc63rftHq6o0nSEheqRMl4WRk5oF5UA3VfJhmrNRgO8sT/DcJk+vF
         pVDlKfjtYERkEiUnzD/vdf4sn9BzFsijlJ8E+1hEd5JPEnXFIhu3vCbw3zOqz406DXoO
         oeEw==
X-Gm-Message-State: APjAAAV1lhhCZt9+8knHZYMaqMKmYwyrh0YJCz9yxAmahkkfvEZO8bPq
        8DUxdf0MlK+spW+hoMP74Tba7g==
X-Google-Smtp-Source: APXvYqwwz4QXBj6X4jmRiK5RdWk3VtwUDMP0wQe48ogv57D0i040spqUEUMSR5b2sInVDU1XTItkNg==
X-Received: by 2002:a62:ce8e:: with SMTP id y136mr49994255pfg.29.1564604710841;
        Wed, 31 Jul 2019 13:25:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p23sm74797789pfn.10.2019.07.31.13.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 13:25:09 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:25:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, crecklin@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, eberman@codeaurora.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
Message-ID: <201907311323.2C991F08@keescook>
References: <1564509253-23287-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564509253-23287-1-git-send-email-isaacm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:54:13AM -0700, Isaac J. Manjarres wrote:
> Currently, when checking to see if accessing n bytes starting at
> address "ptr" will cause a wraparound in the memory addresses,
> the check in check_bogus_address() adds an extra byte, which is
> incorrect, as the range of addresses that will be accessed is
> [ptr, ptr + (n - 1)].
> 
> This can lead to incorrectly detecting a wraparound in the
> memory address, when trying to read 4 KB from memory that is
> mapped to the the last possible page in the virtual address
> space, when in fact, accessing that range of memory would not
> cause a wraparound to occur.
> 
> Use the memory range that will actually be accessed when
> considering if accessing a certain amount of bytes will cause
> the memory address to wrap around.
> 
> Fixes: f5509cc18daa ("mm: Hardened usercopy")
> Co-developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Cc: stable@vger.kernel.org
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Acked-by: Kees Cook <keescook@chromium.org>

Ah, thanks for the reminder! (I got surprised by seeing my Ack in this
email -- next time please use "v2" or "RESEND" to jog my memory.) This
got lost last year; my bad.

Andrew, can you take this or should I send it directly to Linus?

-Kees

> ---
>  mm/usercopy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 2a09796..98e92486 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -147,7 +147,7 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
>  				       bool to_user)
>  {
>  	/* Reject if object wraps past end of memory. */
> -	if (ptr + n < ptr)
> +	if (ptr + (n - 1) < ptr)
>  		usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);
>  
>  	/* Reject if NULL or ZERO-allocation. */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Kees Cook
