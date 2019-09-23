Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA226C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B830820820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LjoHSQ2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503534AbfIWXI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:08:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37552 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfIWXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:08:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id c17so5002pgg.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lUmIWwjCw9tKb1V4oInEEI7B4DoFaOZl9dicqXi8yx8=;
        b=LjoHSQ2MZUNS8YwOIGmx1EzQkMKztdyFnJhIrztQZjamdl0FhVdpK+kRUIg2xK9fM3
         nzKIXOCNYb73WfyTdqsIMykt/fjY2kOPIzmJxUOrjqCv2kdfzKTAFKk0KoK/4pBCyvLr
         dqQWL7cbj2ERtYl0a/8B1nuab/QrSo7HvXM1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUmIWwjCw9tKb1V4oInEEI7B4DoFaOZl9dicqXi8yx8=;
        b=jNM300osXm2Kna1jt6PjZl33M4doc8lL5ycm4+D4fzp50moy1l5M6FIeSfkPI++LYn
         /VF7H1F6nqRsnXWH6GABdwX6N4fPIvF6cj975PglpNc/fFKhT+Y7rKBsBw/4J7U/Bcf9
         yEeBkLhDtgA0rozDb2bZPnuhHM0M5KsAgzkQlpZwMQr/fn648VZAas/NtkmG0viz8Kwq
         KtXDrHgj3/d0pliTvkYvQ1fw2KSZ2vfG6WqOgoxjJ5OJMW1w8yEO8eOoCv81RTZxTdtd
         wDWQqss/kVrRDm8i9qKN5sKBwOLlczOcEZV/H9rHz5qyMMwUVb8ryGUWi7GPll1SN5E8
         L4Dw==
X-Gm-Message-State: APjAAAVC5RiZmKsLDsbsmBHt2tlXKWXaZN0os+jVbTCkmTDRFBYj5v48
        Sb8KcWgcdoccBmicwbfFrdFBtOQJQp4=
X-Google-Smtp-Source: APXvYqzqLv2u32kh+ixoUxO78idlNf5YkCBqm80ZxS26I1D4DO+MRsSxjOBQQeolMGpScG7b/i/lmQ==
X-Received: by 2002:a62:8209:: with SMTP id w9mr2304102pfd.112.1569280136394;
        Mon, 23 Sep 2019 16:08:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w7sm11742134pjn.1.2019.09.23.16.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 16:08:55 -0700 (PDT)
Date:   Mon, 23 Sep 2019 16:08:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uaccess: Disallow > INT_MAX copy sizes
Message-ID: <201909231607.B6A0736@keescook>
References: <201908251612.F9902D7A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908251612.F9902D7A@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 04:18:56PM -0700, Kees Cook wrote:
> As we've done with VFS, string operations, etc, reject usercopy sizes
> larger than INT_MAX, which would be nice to have for catching bugs
> related to size calculation overflows[1].
> 
> This adds 10 bytes to x86_64 defconfig text and 1980 bytes to the data
> section:
> 
>    text    data     bss     dec     hex filename
> 19691167        5134320 1646664 26472151        193eed7 vmlinux.before
> 19691177        5136300 1646664 26474141        193f69d vmlinux.after
> 
> [1] https://marc.info/?l=linux-s390&m=156631939010493&w=2
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

ping! Andrew, can you take this?

-Kees

> ---
>  include/linux/thread_info.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 659a4400517b..e93e249a4e9b 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -147,6 +147,8 @@ check_copy_size(const void *addr, size_t bytes, bool is_source)
>  			__bad_copy_to();
>  		return false;
>  	}
> +	if (WARN_ON_ONCE(bytes > INT_MAX))
> +		return false;
>  	check_object_size(addr, bytes, is_source);
>  	return true;
>  }
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook

-- 
Kees Cook
