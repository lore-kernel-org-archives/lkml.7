Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3728CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A7E2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh17YPqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfJBRHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:07:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53472 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfJBRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:07:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so8021001wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5t7DfaGuIJVfpW/6AOvG6x/d8yqj3D8O6SWcaOz/1Y=;
        b=jh17YPqpYrcU+CwePtEtDIfsCOK8JgI4JAEbOUfoN2nARPGX8zArPgMQCz+q57PDBi
         M24gQg5rQIj9pwthmeqeIp5ZSRSSAQsYPSk0tB3fajGWtDrThDnUyQDxniNuJATOf3th
         lnq/SDOi/snhoJBXP54CCqWjASa8VtKSGcpYDYCkQWUqUFF5iNVK6+6jiIzuMuftJh1B
         zJKT6dWzuV43g0BkNI19E3oP9NYC2oCYfbtcP9RQO9Mdex3fYemknycTMXvTzziu8T2l
         ksqsz9qhsEqnDHCtxf04twdJTYCrTUSLnr5ZRAaguVUHRmZ0GHZaS9CKTUk2tTus+dEe
         cuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5t7DfaGuIJVfpW/6AOvG6x/d8yqj3D8O6SWcaOz/1Y=;
        b=UxlaHzkNAIGozHXR2UyfZoKaMARF6ZritY+qLOg1/NRMl0aiCk7Ema/9uvwXZQ4h6q
         c/nK7mbtbLv4q8es63cdhcFgAUKbmqj2P64Vec1asZljC6JJyOA5zErpUqeo/YrfSW0Y
         +UACNCXH32Oj96UKEajcIWvz+gTkMjmOsaSscFvOBO4AGFT5hT8LcnjcksRfMq2jk9mp
         k60SAN4vmpz9hELI4rg/ralpu3pfEKY861+ShyoF95QWLsT/MxvCrqiGcsdgzp05qneO
         Ly8mK5r2HWLuKMpvAco07E4vCW19TFA14pNRugXviQ62JBIu4SXxw5phReSyGwyxq32P
         +rjQ==
X-Gm-Message-State: APjAAAV1WNljDNYwNeOEss+7laxZTWyH/gOYDaq939tinWesaAkVTJiA
        dRqlQUlfIXcSdwZjPZtdgzY=
X-Google-Smtp-Source: APXvYqzX5fLQw5wWj0pE3+sGCTmrFgoY5C9x3lumrbZ+x3yvpHDxD1HoY1ykVnkw0yAf0S1/X3xOxQ==
X-Received: by 2002:a7b:c34e:: with SMTP id l14mr3397429wmj.123.1570036055644;
        Wed, 02 Oct 2019 10:07:35 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c10sm31832408wrf.58.2019.10.02.10.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:07:34 -0700 (PDT)
Date:   Wed, 2 Oct 2019 10:07:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     arnd@arndb.de, David1.Zhou@amd.com, Hawking.Zhang@amd.com,
        airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        clang-built-linux@googlegroups.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, le.ma@amd.com,
        linux-kernel@vger.kernel.org, ray.huang@amd.com
Subject: Re: [PATCH 6/6] [RESEND] drm/amdgpu: work around llvm bug #42576
Message-ID: <20191002170733.GB1076951@archlinux-threadripper>
References: <20191002120136.1777161-7-arnd@arndb.de>
 <20191002165137.15726-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002165137.15726-1-ndesaulniers@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 09:51:37AM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > Apparently this bug is still present in both the released clang-9
> > and the current development version of clang-10.
> > I was hoping we would not need a workaround in clang-9+, but
> > it seems that we do.
> 
> I think I'd rather:
> 1. mark AMDGPU BROKEN if CC_IS_CLANG. There are numerous other issues building
>    a working driver here.

The only reason I am not thrilled about this is we will lose out on
warning coverage while the compiler bug gets fixed. I think the AMDGPU
drivers have been the single biggest source of clang warnings.

I think something like:

depends on CC_IS_GCC || (CC_IS_CLANG && COMPILE_TEST)

would end up avoiding the runtime issues and give us warning coverage.
The only issue is that we would still need this patch...

Cheers,
Nathan
