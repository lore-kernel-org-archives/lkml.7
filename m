Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B344CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B33F214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFs2Q0eX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfJVC0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:26:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45550 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbfJVC0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:26:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so8966925pgj.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 19:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jqjDyYINco5zX/3d/HD5i73gQP0vQKo5KvrXR6/+e2c=;
        b=MFs2Q0eXF9XUrND1F2MJOxBu9xbjhSqOGU6EPkNbeFMZzcJ8ae2p9HucqK9c/SVS+o
         s9u9XS0jgoNVxI8exvI1ZocmtdKZMFNQr8zzVbkZVLutxGl0ZEt2HEBoHdXIQZreO32m
         BBhw5YArtVoQltlvAofF/1y+6Z469Vkt3cQflHKgLbzOl3duane7YE2luctwK7ucxpoN
         6GrN0F42OmDekeSSR8XyJlBStdagHrxed+3gVcr9AIjyeeHZ/mqcbi+U1p19fQpzXO8w
         KPfNOkWK4sqeHb5/u6m2dletcPwH3uNOXzGt4hjXxnAMEC3W9IU1OPvMe/DDfC2YtQhV
         VKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqjDyYINco5zX/3d/HD5i73gQP0vQKo5KvrXR6/+e2c=;
        b=Pwn7/kOJjAzu59oDCvA17Rk0lDU4U5JcPpsDcS9rRc0R2C2bNKR42HfUt2ptYYL7DY
         34Ip8hwI4YPUmqnRqTer+w5UxWhwJlICfYO5U2usSl0Gb7+4Z/hOkgTdqkA9P6bXt1Wu
         b99WaJnVi2sk6rD0zJTcQ8/h885XmlBR97gb+naUBR0QbIrk3cEAICU4cRhp5HIckjqJ
         4td2otPTsg6vgEoCFawsh/HWh7U7uh7AicVtItVoAO5M8kwyQYmo2FbX5ufbZYaRIkyZ
         H6Z1UMacCCF3GxZV4PvHryAH98qLoCf1F0DvO+7YhYQRqUP92FaK7/3gegrk7t6Zf+FL
         Kclg==
X-Gm-Message-State: APjAAAXVCd4lJfgMSAA9W2LdzE9FE9ezA1H0YSgdxumNhcKn2BuW7A4N
        7VI3KzcdbyrB2n+GI1jxlMjYQlIs87s=
X-Google-Smtp-Source: APXvYqwVLIBMQXiqD7AfzsiN2dabnPivlCcnteH5RiUBQ7Bm5cIT/ILRYjse8rfnqU0qx22DSZak4A==
X-Received: by 2002:a62:7a8c:: with SMTP id v134mr1371160pfc.143.1571711189526;
        Mon, 21 Oct 2019 19:26:29 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id n66sm23792844pfn.90.2019.10.21.19.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 19:26:28 -0700 (PDT)
Date:   Tue, 22 Oct 2019 07:56:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: debugfs: Document debugfs helper for
 unsigned long values
Message-ID: <20191022022625.dreyswengvmpzeas@vireshk-i7>
References: <20191021150645.32440-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021150645.32440-1-geert+renesas@glider.be>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-19, 17:06, Geert Uytterhoeven wrote:
> When debugfs_create_ulong() was added, it was not documented.
> 
> Fixes: c23fe83138ed7b11 ("debugfs: Add debugfs_create_ulong()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/filesystems/debugfs.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
> index 9e705026ac103b6f..50e8f91f2421ec04 100644
> --- a/Documentation/filesystems/debugfs.txt
> +++ b/Documentation/filesystems/debugfs.txt
> @@ -93,8 +93,8 @@ the following functions can be used instead:
>  
>  These functions are useful as long as the developer knows the size of the
>  value to be exported.  Some types can have different widths on different
> -architectures, though, complicating the situation somewhat.  There is a
> -function meant to help out in one special case:
> +architectures, though, complicating the situation somewhat.  There are
> +functions meant to help out in such special cases:
>  
>      void debugfs_create_size_t(const char *name, umode_t mode,
>  			       struct dentry *parent, size_t *value);
> @@ -102,6 +102,12 @@ function meant to help out in one special case:
>  As might be expected, this function will create a debugfs file to represent
>  a variable of type size_t.
>  
> +Similarly, there is a helper for variables of type unsigned long:
> +
> +    struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
> +					struct dentry *parent,
> +					unsigned long *value);
> +
>  Boolean values can be placed in debugfs with:
>  
>      struct dentry *debugfs_create_bool(const char *name, umode_t mode,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
