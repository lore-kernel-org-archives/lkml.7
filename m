Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55CC17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A0420865
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqonuB2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfKIBDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:03:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44322 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfKIBDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:03:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so6186380pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 17:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3n63UIaSs1CPhi4wfKNUy+gqncGrK9W+HZZDV7Zttaw=;
        b=OqonuB2pXRD4UC5y+YIWtS8XwsgZOkLk1FGLhfds97orzhnrwdfY31DGzGzORXY2AO
         Igz3ztoYzSxCdv9G7iMm0hOm2yuL6yeyS87i1ej6RpLZSp2h/95h4+RMNbWm3k3RwTJU
         ckpvZclF6dYDPgqqGG2zOui5iCS+emSUSq6Oi4+5EaoqRolH82PggmPUmgUGM0l0nMRp
         YbieH5G0uOHkveF586dnDU3IEIAFlm0/1D2a71N18F9gx7hovOiUyQXS8Mgv5/yxGqpI
         zZW4eox8joPY0rkstQe8zL8nDbauhUVh2B2T3U9xBjJwU5kOcm75G/bEVqqmduv3NOQE
         8GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3n63UIaSs1CPhi4wfKNUy+gqncGrK9W+HZZDV7Zttaw=;
        b=B9OXjmYXdBR3FEM/PMvr2MqUylhvi7L7cv3JFg840L2SBcqKzY1ckSkrerC61DXUKU
         +ZBy/4nCEcdFXVYB3JWM3KaXbtZ3kRKyEn5BoLmUd5WoDFDjhkuDKWk7i6PcEbDfgsyy
         3na1/AvPuPEuWps4RcSXwwh0hZEu8SbnI4V7R0AT06x0yVqEWK5E4cZfIiKGsIKAoS9v
         ocaZa3CraD1S4lOj33tSoA7fYPF45VqB+GDYXnz0tUc3ppRhdpyTYZtCi0zGVHlixPxh
         BGtXnQ4XMDsIo1ulZBhwWiiZam9WwT9Vj4Vqom26Ms6jhdRBuKfJElZkrUdNpyLL5TDJ
         7CnQ==
X-Gm-Message-State: APjAAAUIblJIcmDpPi9Po1usbxu3wkGmTBJ3sN4dPzXczS50Yy8+jdAv
        XS9r4ZzR1/b3Ahgr9fG/fYmLww==
X-Google-Smtp-Source: APXvYqwr/WG4ohtZ1QyXO7nAEnNK8soB4J7OXQsn5O2C4lmsT0qify/Bwh32NkM/h2x4eWLnWVxFXg==
X-Received: by 2002:a62:108:: with SMTP id 8mr15876535pfb.53.1573261431933;
        Fri, 08 Nov 2019 17:03:51 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s13sm5257597pfc.110.2019.11.08.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 17:03:51 -0800 (PST)
Date:   Fri, 8 Nov 2019 17:03:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com
Subject: Re: [PATCH 02/17] remoteproc/omap: Switch to SPDX license identifiers
Message-ID: <20191109010348.GB5662@tuxbook-pro>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-3-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028124238.19224-3-t-kristo@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:

> From: Suman Anna <s-anna@ti.com>
> 
> Use the appropriate SPDX license identifiers in various OMAP remoteproc
> source files and drop the previous boilerplate license text.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/remoteproc/omap_remoteproc.h | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.h b/drivers/remoteproc/omap_remoteproc.h
> index f6d2036d383d..1e6fef753c4f 100644
> --- a/drivers/remoteproc/omap_remoteproc.h
> +++ b/drivers/remoteproc/omap_remoteproc.h
> @@ -1,35 +1,10 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */

Please confirm that you actually intend to change the license from BSD
to dual here.

Regards,
Bjorn

>  /*
>   * Remote processor messaging
>   *
>   * Copyright (C) 2011 Texas Instruments, Inc.
>   * Copyright (C) 2011 Google, Inc.
>   * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - * * Redistributions of source code must retain the above copyright
> - *   notice, this list of conditions and the following disclaimer.
> - * * Redistributions in binary form must reproduce the above copyright
> - *   notice, this list of conditions and the following disclaimer in
> - *   the documentation and/or other materials provided with the
> - *   distribution.
> - * * Neither the name Texas Instruments nor the names of its
> - *   contributors may be used to endorse or promote products derived
> - *   from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  
>  #ifndef _OMAP_RPMSG_H
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
