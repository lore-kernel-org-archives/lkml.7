Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAEEC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68179208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aRSV8+6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfE2Gy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:54:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35565 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfE2Gy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:54:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id a132so1171045oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pChoKwIWurLwR+JcSuU1NNjyDM3j/trzD6X0wFNY0n4=;
        b=aRSV8+6iSGxARgcHjqu+worAprAztrfzegvwvu1xeYjMWRbmUICvgJ7FsEXWylX7hP
         MzephQNOCnMMUT1Egx1mwD4RPi9Qp4Lg9dANyWFRT1XICfOmX0E4ytSxoQ+84hOygtpo
         ChMNoXihqGT5C1eoF7EuG9MBKljOAjrFwWvYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pChoKwIWurLwR+JcSuU1NNjyDM3j/trzD6X0wFNY0n4=;
        b=JBC35+VaaMUyrsuT2gpinWTIhkn8FufBUqb60ul0imPai/eoPmdv/Ury36ez35gDc4
         1xZYHFOhvP8Tuz91tOy68N1RYBvtZAVuZDMoLZWiGZ9O1Gyjy62vgaJz1iYwaxir/yJV
         mbVvVRl93lSaB00S6uQX9c403qQegZ4L7SjyJPENVlb2c0Pd/yfegj15TC7BlNSOK01k
         kcT0xVfJ1z8N+60rrojgB+CW//J5syJdHqiWdKUStUDUs5KUQsFOhCC4yiBFrbu53f79
         K32nrTauo56UurcQnEtT7EKjrYnE9N9WY0KRHkOQ6g62IPUUeozdi/NqOxkDPPYjFqd7
         mDRw==
X-Gm-Message-State: APjAAAWF8aLRc0/tty6qx/u3H4rH67kO8rqCJi8qIAM5hj930OjSQihf
        VApb/165LrWpQKmQLZ25QhA5mzpebrIAy33LLsnNAkT/
X-Google-Smtp-Source: APXvYqxEFm7alRLONi7G8F6YaFxfCuYNB3CbojO+n4bQcOMY76gCc9bWruq40KNBeXkP9IsGt/WbcXln11o+AWenJIY=
X-Received: by 2002:aca:6208:: with SMTP id w8mr5374548oib.128.1559112867588;
 Tue, 28 May 2019 23:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190522205034.25724-1-corbet@lwn.net> <20190522205034.25724-7-corbet@lwn.net>
In-Reply-To: <20190522205034.25724-7-corbet@lwn.net>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 29 May 2019 08:54:16 +0200
Message-ID: <CAKMK7uFVP6o5jU_cEPshYXwWN39ohybid52yBj567dGBiejzTg@mail.gmail.com>
Subject: Re: [PATCH 6/8] docs/gpu: fix a documentation build break in i915.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:51 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Documentation/gpu/i915.rst is not included in the TOC tree, but newer
> versions of sphinx parse it anyway.  That leads to this hard build failure:

It is included I think: Documentation/gpu/index.rst -> drivers.rst ->
i915.rst. With that corrected A-b: me.

btw this patch didn't go to intel-gfx and all i915 maintainers, I
think per get_maintainers.pl it should have. Just asking since I had a
few patches of my own where get_maintainers.pl didn't seem to do the
right thing somehow.
-Daniel

>
> > Global GTT Fence Handling
> > ~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > reST markup error:
> > /stuff/k/git/kernel/Documentation/gpu/i915.rst:403: (SEVERE/4) Title level inconsistent:
>
> Make the underlining consistent and restore a working docs build.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/gpu/i915.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index 055df45596c1..cf9ff64753cc 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -401,13 +401,13 @@ GTT Fences and Swizzling
>     :internal:
>
>  Global GTT Fence Handling
> -~~~~~~~~~~~~~~~~~~~~~~~~~
> +-------------------------
>
>  .. kernel-doc:: drivers/gpu/drm/i915/i915_gem_fence_reg.c
>     :doc: fence register handling
>
>  Hardware Tiling and Swizzling Details
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +-------------------------------------
>
>  .. kernel-doc:: drivers/gpu/drm/i915/i915_gem_fence_reg.c
>     :doc: tiling swizzling details
> --
> 2.21.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
