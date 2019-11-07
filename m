Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010A5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ECC214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rN6LrlHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbfKGQQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:16:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38940 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:16:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id p18so2933694ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7kVd9FarYpVpIKscAjqYl6LRrnKSeFeSP0krGXflic=;
        b=rN6LrlHSKT2qOQK5ltr/br77qUF9yv79uygmhFo59z/vq0k9ViIIZikZtCuEiH0D9O
         Nu6V4QMAQ3F9Wq9d/aBstjFh86Oifi0mzmY1jz07EoMcuIiofNEksrlvwyzCVAdBsEIM
         FWzgH1QVhoH8vEBpmj4yDgDbmTCbMqx/sBsCu9r3pWhAtlrOQTngMvPamSxYakdQNa8r
         3h7iMATyaMX4+1z002syjAofPeYqQK4+whpnFgpUjuhI7HJumenh8erI73xIqmziAx1N
         S+gqWwgVgnHyB5JBwZ5hoYdxLGOyh+inXFbGkGBX15DCKmTb6+sQTB4aZUXNKT2AlkJl
         E3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7kVd9FarYpVpIKscAjqYl6LRrnKSeFeSP0krGXflic=;
        b=tkkAUHRzvcHN6ik7PoPndvi0ohn08vt6bVeMZ0+19oA2Uq1VUsBhwcnAIfBbuDD8N5
         aGuBFw2kIOnobUBwswh9d/wb1H0b4PPAcBzTS/axM9bKRCHCoKqY48keGTulC7eYlYVh
         kivv3CgU3g3hrDTO6qolPL5yF2Z+guLJ4mCic64+aBrYsh6TPs8fvDwT5/HAPOSpo5iC
         y/iOj6+uVcW0Y7wr7/1sjPQ0XSMgz05a+222vUiaDKFn37XUJ4OcIZZi8nGiLHwNltg3
         zo73A1IfbsX90jUjiHO5p0wUrDde4dYHZMwawpleNwG8uy3C1m9mG4SurTW61bUPZD45
         zviw==
X-Gm-Message-State: APjAAAWgyex8/V+Z90IG+ierRc12P53FpJXUVoEFPfuONgyHV7H7e5Sw
        EDv34a9pGYMfZFbaciIYy0jMLkRAGzE=
X-Google-Smtp-Source: APXvYqzEarZA7i5yNLQDKnCZ6UdjoZrknJdst/e11rKs7LKIEVTzKZbJlEp2WGsGfTZOPtQx8Dn0dA==
X-Received: by 2002:a2e:998a:: with SMTP id w10mr3111225lji.66.1573143406950;
        Thu, 07 Nov 2019 08:16:46 -0800 (PST)
Received: from jax (h-48-81.A175.priv.bahnhof.se. [94.254.48.81])
        by smtp.gmail.com with ESMTPSA id f3sm3263212lfp.0.2019.11.07.08.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 08:16:46 -0800 (PST)
Date:   Thu, 7 Nov 2019 17:16:44 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee subsys fixes for v5.4
Message-ID: <20191107161644.GA8304@jax>
References: <20191107121159.GA9301@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107121159.GA9301@jax>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 07, 2019 at 01:11:59PM +0100, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull these OP-TEE driver fixes. There's one user-after-free issue if
> in the error handling path when the OP-TEE driver is initializing. There's
> also one fix to to register dynamically allocated shared memory needed by
> kernel clients communicating with secure world via memory references.
> 
> If you think it's too late for v5.4 please queue it for v5.5 instead.

Please ignore this pull request.

"tee: optee: Fix dynamic shm pool allocations" is not good without other
patches, which are not included here.

Sorry about the mess.

Thanks,
Jens

> 
> Thanks,
> Jens
> 
> The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:
> 
>   Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-fixes-for-v5.4
> 
> for you to fetch changes up to 61435a63b15233428088ccb0ad34e19fc00416c9:
> 
>   tee: optee: fix device enumeration error handling (2019-11-07 12:07:44 +0100)
> 
> ----------------------------------------------------------------
> Two OP-TE driver fixes:
> - Add proper cleanup on optee_enumerate_devices() failure
> - Make sure to register kernel allocations of dynamic shared memory
> 
> ----------------------------------------------------------------
> Jens Wiklander (1):
>       tee: optee: fix device enumeration error handling
> 
> Sumit Garg (1):
>       tee: optee: Fix dynamic shm pool allocations
> 
>  drivers/tee/optee/core.c     | 20 ++++++++++++--------
>  drivers/tee/optee/shm_pool.c | 12 +++++++++++-
>  2 files changed, 23 insertions(+), 9 deletions(-)
