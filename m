Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC0C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A311B21850
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="URMgG1bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGBTvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 15:51:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36696 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfGBTvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:51:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so96827wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g4cCYujEQzeh4PUwQfoS5O/VeQWPTq9nHlDkD9HoLjs=;
        b=URMgG1bTe3xaN/40CLTX41HuA2XKSeaj2XFYGO+nnYLCM4rMzwQsy7vgdDqq17hIEh
         ivBndVQeO8/YJaQ6t45CZbN/m9ZSQahtVJu3QOSr46sdA5Z1w4QrgTvwTqZnKiROBz+x
         ZJhv1DHSQ2/Hz29nMwoqjDzmL6E3+mZKtEJ4GIaUrTkRh4xz72Ipsj3HR1T9XX/fsfXs
         SjK3JeE4pJvE1S7NlJyXadfC3tLJdKiDtwJBvV9XIbrObKe4mdwxUAL+bIEVtJ0075fr
         JOIQNVyBbm0U18ctXd3TYlU34C6mNLCG7oGZMp31VokGXKNXioIY9Dv10MYDBqIS+msv
         IR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4cCYujEQzeh4PUwQfoS5O/VeQWPTq9nHlDkD9HoLjs=;
        b=tPNCLBY5Y6cxD6NMplWaZZ7Yj80GNyjbNKBaozQVH+enVtY61HjDFO2zPTvObRdzaE
         eO3SieRImOmSqgbB2wjK00GCRBfIvxaqlcxjcKf0AcbAfmEZBPeEogC4rHbBZovtkYwJ
         HDQaM7sw3i1YOxdkl6R2KXnlXDYc2MeMEPapwFvYFHqUGlpuNaODHD+O5hHSOIl9CgJm
         HlFon6s5vqgZCyIPZUQyUjm6LU/dXwwGnp8xxnUaujMNTcWXLBpKtIBrRfYZHLX1ZUeF
         cARehT9DngQN5zjnvNf3Y548TJFLMaQhiYFj54+mPmFUkQmLZMUeHEwcApCQlsomdFif
         EHqw==
X-Gm-Message-State: APjAAAUUhd615JXXXjN9acwTyW+nF0mu39ZippwrAGIL+YmNT0ZyS5Fk
        KMyzEUj3aOJEuB7xTUsa3TYJ+8qzPnYcXw==
X-Google-Smtp-Source: APXvYqzq2QwExvLbyQs7Q4LyO/uIEH+2/zAG2xocN8TZreqGuvJNLoNnk9RfPU5MDFBS1jpc/zSrCQ==
X-Received: by 2002:a5d:4309:: with SMTP id h9mr11136838wrq.221.1562097100156;
        Tue, 02 Jul 2019 12:51:40 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id j132sm56961wmj.21.2019.07.02.12.51.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 12:51:39 -0700 (PDT)
Date:   Tue, 2 Jul 2019 21:51:38 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Documentation/filesystems: add binderfs
Message-ID: <20190702195137.xk476tr2fp44vmsn@brauner.io>
References: <20190111134100.24095-1-christian@brauner.io>
 <20190114172401.018afb9c@lwn.net>
 <20190702175729.GF1729@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190702175729.GF1729@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 10:57:29AM -0700, Matthew Wilcox wrote:
> On Mon, Jan 14, 2019 at 05:24:01PM -0700, Jonathan Corbet wrote:
> > On Fri, 11 Jan 2019 14:40:59 +0100
> > Christian Brauner <christian@brauner.io> wrote:
> > > This documents the Android binderfs filesystem used to dynamically add and
> > > remove binder devices that are private to each instance.
> > 
> > You didn't add it to index.rst, so it won't actually become part of the
> > docs build.
> 
> I think you added it in the wrong place.
> 
> From 8167b80c950834da09a9204b6236f238197c197b Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Tue, 2 Jul 2019 13:54:38 -0400
> Subject: [PATCH] docs: Move binderfs to admin-guide
> 
> The documentation is more appropriate for the administrator than for
> the internal kernel API section it is currently in.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Don't feel very strong about where this ends up. :)

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  .../{filesystems => admin-guide}/binderfs.rst          |  0
>  Documentation/admin-guide/index.rst                    |  1 +
>  Documentation/filesystems/index.rst                    | 10 ----------
>  3 files changed, 1 insertion(+), 10 deletions(-)
>  rename Documentation/{filesystems => admin-guide}/binderfs.rst (100%)
> 
> diff --git a/Documentation/filesystems/binderfs.rst b/Documentation/admin-guide/binderfs.rst
> similarity index 100%
> rename from Documentation/filesystems/binderfs.rst
> rename to Documentation/admin-guide/binderfs.rst
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 8001917ee012..24fbe0568eff 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -70,6 +70,7 @@ configure specific aspects of kernel behavior to your liking.
>     ras
>     bcache
>     ext4
> +   binderfs
>     pm/index
>     thunderbolt
>     LSM/index
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 1131c34d77f6..970c0a3ec377 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -31,13 +31,3 @@ filesystem implementations.
>  
>     journalling
>     fscrypt
> -
> -Filesystem-specific documentation
> -=================================
> -
> -Documentation for individual filesystem types can be found here.
> -
> -.. toctree::
> -   :maxdepth: 2
> -
> -   binderfs.rst
> -- 
> 2.20.1
> 
