Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144EBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE52075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMzp+XTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfDDIRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:17:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38409 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfDDIRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:17:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so849626pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Nz34GvCXZ9ywAVPzoxERaJjdLP40iQvaHH3afmL9we4=;
        b=aMzp+XTh9WEIw1XApocWwwUiqCjSvwqSuLo6WHa1ueIioTQ9b3nIfQABwmbNZvdJzk
         oeoLeKQ5eQoy4ULADB+6Pc4G3NDWdEBM454aE/N2HxLLJZT0RbNvITWsOOTdpeqaMCb7
         LeKUPYbyEDRf2f0DUSzezy5Qd//c3Y29hB/JhYrkGSYx/bMyLdkBE2r4iVIw8U2Qmuvj
         ia83A44lSR3KNeZ6szEyAT6Rtww8Pe5AfnGgRIhvYrX6EvMFuB3PKIEdfoPnPYVW++cM
         xwFiaUQCa3Xcs0i4Wb1Nh9y2qDqfEuHIZSz9kNF37st43IvCQ3wkq0g6aX8NE/50pRc2
         MjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nz34GvCXZ9ywAVPzoxERaJjdLP40iQvaHH3afmL9we4=;
        b=HstgtSm7Sz+vNF+L5TwDQzBEddUj62yFLl+4dbHyVGxxRVOt1efoOopbWNFfUofPb/
         g03Ye9X4gVYPTjqNmJU0xXcEnEs1GQS/j1PfXpj842No+aTB3AFynDHtQzybHxe3LpNB
         Y1PWAJl5iUGhRB/VRgz7eiIraGHpeXRk/CC+qcWnRBCPHs7LOKV2yxYUrDWmkv4d8NKo
         LaMULD7FPk97WuaX7ofCnn5DqGeSKiBxXUO+g1ZJxLHEgdVxzuaBD/0vgwDYP6wIqRKE
         w/krjecpDNjDJATHm9rWS/t2xPf2qkvGDcz2mjDSVafGrEnia9w5kp1/sK4YbecgKYYl
         vdPA==
X-Gm-Message-State: APjAAAUc/mBzSuBs5+yAisvkUSlmEYvPz3XxPf3lLvydI0/TZRhiKRWR
        V/RwhYvUfcD3lpfB+ETY/TE9iw==
X-Google-Smtp-Source: APXvYqx5LeMuXbqMVmTMRzwvXUDhy87AaSuYxTuaL0Z1fEfRIzdA3m3NsDPg+OQBH9do1DWbkdGGiA==
X-Received: by 2002:aa7:9389:: with SMTP id t9mr4562938pfe.60.1554365862205;
        Thu, 04 Apr 2019 01:17:42 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id f65sm29363125pff.21.2019.04.04.01.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:17:41 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:17:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 4/5] mfd: ti-lmu: Remove support for LM3697
Message-ID: <20190404081736.GM6830@dell>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-5-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325142403.30447-5-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Dan Murphy wrote:

> Remove support for the LM3697 from the ti-lmu

Bit of an odd place to insert a line feed.

> driver in favor of a dedicated LED driver.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/Kconfig                |  2 +-
>  drivers/mfd/Kconfig                 |  2 +-
>  drivers/mfd/ti-lmu.c                | 17 -----------
>  include/linux/mfd/ti-lmu-register.h | 44 -----------------------------
>  include/linux/mfd/ti-lmu.h          |  1 -
>  5 files changed, 2 insertions(+), 64 deletions(-)

I'm fine with the patch.

Can you edit drivers/leds/Kconfig as part of a separate patch please?
Keeping this in sync with this change is not critical and would add a
whole bunch of process which we can really do without.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
