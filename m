Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59961C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7982186A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NhG5otDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbfEXIJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:09:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39998 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389147AbfEXIJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:09:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id u11so7908934otq.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuE0856TsTDzOr+71DW3ES+79KQ8yfmx0fgvjM9w/1k=;
        b=NhG5otDuKj+xoYuqWMZ8PG2WA2QVSXgCAotFXiApL9qn+lNO9iLE9Iqscjht011rS7
         /JdGphDVJAgCROpPSVvDsWfZy5wi6hUW4hvYY9rBdAKg5cyUYwOTcd88yDwY2qkpBNE9
         wPxsQh/OoT6+xGc/qZ2ghPwLXHIymQxMHJods=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuE0856TsTDzOr+71DW3ES+79KQ8yfmx0fgvjM9w/1k=;
        b=t4QwaediUNTzvzRHM6W4t71En2suINhd+bB9Dvy8RMy8AqfxomDoW+vhUAHjVG+qHc
         DaHeIF0v/7eZzK73BjAFQuU//OJQxlWvNYN3Ze7yH5jAwXsgXTDRuXmfU66OJCYrvimS
         4nM6fAiw4QIdOgz8QoUzj4ilkCcWgKYa7QqG7r80zkNAardDyuOz8hLNI2n93bX65uKk
         4bvvcFyZZlyNYI9g92Mk0A4kJUhG6YcIBJdKMRuX/pU6dhs9eNIWf45alTS0uy7aQHEc
         deu2+ZNMKs/hKERrFX0XGn/yfAAskb5RvIyJzixsmmnJE3fFYysqktX/itGlx/SysqPv
         OQOA==
X-Gm-Message-State: APjAAAXvN6MxFgBcVQDoVi3w0qsH0CuRR9qcixq8eVy1575dZQoEZXiF
        c+B9zncVl29kGMZ+11X8JtFUQtDoWUQ0cOCLXmVAow==
X-Google-Smtp-Source: APXvYqwTQvXvByfrzF4XOqJaZR3DWhg2Aui8um312pfGys3LkCBzcYSph7Loao897bvhjCqFHYARbNInZuy8DwKhvxg=
X-Received: by 2002:a9d:6e1a:: with SMTP id e26mr61890768otr.188.1558685381035;
 Fri, 24 May 2019 01:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190524082926.6e1a7d8f@canb.auug.org.au>
In-Reply-To: <20190524082926.6e1a7d8f@canb.auug.org.au>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 24 May 2019 10:09:28 +0200
Message-ID: <CAKMK7uGSfOev71DKF+ygRjU0rMWcrW3rL7-=Xhbwdm9STUWntQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drm-fixes tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'load_dmcu_fw':
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:667:7: error: implicit declaration of function 'ASICREV_IS_PICASSO'; did you mean 'ASICREV_IS_VEGA12_P'? [-Werror=implicit-function-declaration]
>    if (ASICREV_IS_PICASSO(adev->external_rev_id))
>        ^~~~~~~~~~~~~~~~~~
>        ASICREV_IS_VEGA12_P
>
> Caused by commit
>
>   55143dc23ca4 ("drm/amd/display: Don't load DMCU for Raven 1")
>
> I have reverted that commit for today.

Seems to compile fine here, and Dave just sent out the pull so I guess
works for him too. What's your .config?
-Daniel

>
> --
> Cheers,
> Stephen Rothwell
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
