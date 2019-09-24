Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAEAC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1A20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8zGPIRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439338AbfIXQWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:22:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfIXQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:22:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so1666783pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B/ALc/qTcQ4k/eCkDMCHCUlzu+44O0snaF71bHOvSBA=;
        b=O8zGPIRb6udzS8CeK12mIGTdihD/nbhSG3mye5euKo6yGM6boWQd3/J/ShzdWlhmUH
         3WBrBWZeqFa1y+iW4YT406eldU8YVPHi9w8OUNYhOwaDdqYG3u4b8q66J2P2/ebkbu6N
         JcQboVDtKw2Zwq/BUkz4IQOCXLe8MqkKZ++0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B/ALc/qTcQ4k/eCkDMCHCUlzu+44O0snaF71bHOvSBA=;
        b=rXcBeL+pWZzFQ5hXkWi2J6z5+MWTQ3KHQ31Xk0SPbz0ZfRsAYT3xx1aluXL330OChB
         UZTWUdy7+i0/hUqH53z24gCs3bW/JbejHPWLrinBhKpgHXZbxLjfDDnvW9Un8seJvGtl
         bbotbNXPV6AocrgCDk18Zuflfv5dKX0LlLmtp4OXM6npv+vqbJMGXCJ2y3Jb6+9A0wma
         sFyFSVVZfDPNuHyeKTv/cLrsh2+41jO+TV88aQNiitEYtgNxuo2mEm8jElsCDEAvq4b9
         vfq46DpxtoTR7X1QA9pXWm2SKrKrBRYQBzo7gegE2M4DRw4gQ4/WXLD7ViJabgYWmiwi
         JOJA==
X-Gm-Message-State: APjAAAWYyO+dSu6Pfo5jNmWX5d8sywz0zBddy7X/rS9Vsv4gubNk4Mr+
        blj+QmsU6901TSVVDmPImgUUGQ==
X-Google-Smtp-Source: APXvYqz6f0NZvQy5yYrKu6cts+T4A5fOIBUPykaVdTiHtcZ+MGdIGC42Mo2ufzIwEq03ic6ykQZRoA==
X-Received: by 2002:a17:90a:b012:: with SMTP id x18mr966430pjq.118.1569342132377;
        Tue, 24 Sep 2019 09:22:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r30sm2186167pfl.42.2019.09.24.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 09:22:11 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:22:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc:     pankaj.bharadiya@gmail.com, andriy.shevchenko@linux.intel.com,
        kernel-hardening@lists.openwall.com, akpm@linux-foundation.org,
        mayhs11saini@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] linux/kernel.h: Add sizeof_member macro
Message-ID: <201909240920.AE3CD67E87@keescook>
References: <20190924105839.110713-1-pankaj.laxminarayan.bharadiya@intel.com>
 <20190924105839.110713-2-pankaj.laxminarayan.bharadiya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924105839.110713-2-pankaj.laxminarayan.bharadiya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 04:28:35PM +0530, Pankaj Bharadiya wrote:
> At present we have 3 different macros to calculate the size of a
> member of a struct:
>   - SIZEOF_FIELD
>   - FIELD_SIZEOF
>   - sizeof_field
> 
> To bring uniformity in entire kernel source tree let's add
> sizeof_member macro.
> 
> Replace all occurrences of above 3 macro's with sizeof_member in
> future patches.
> 
> Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> ---
>  include/linux/kernel.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Since stddef.h ends up needing this macro, and kernel.h includes
stddef.h, why not put this macro in stddef.h instead? Then the
open-coded version of it in stddef (your last patch) can use
sizeof_member()?

Otherwise, yes, looks good. (Though I might re-order the patches so the
last patch is the tree-wide swap -- then you don't need the exclusions,
I think?)

-Kees

> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 4fa360a13c1e..0b80d8bb3978 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -79,6 +79,15 @@
>   */
>  #define round_down(x, y) ((x) & ~__round_mask(x, y))
>  
> +/**
> + * sizeof_member - get the size of a struct's member
> + * @T: the target struct
> + * @m: the target struct's member
> + * Return: the size of @m in the struct definition without having a
> + * declared instance of @T.
> + */
> +#define sizeof_member(T, m) (sizeof(((T *)0)->m))
> +
>  /**
>   * FIELD_SIZEOF - get the size of a struct's field
>   * @t: the target struct
> -- 
> 2.17.1
> 

-- 
Kees Cook
