Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAAAC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA7A20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjjaQr8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfDDISQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:18:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43382 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfDDISP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:18:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so964164pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jvdjM+9XfNVw7IHg3rerj/0byH91HVl+2bo5TX7v2Hs=;
        b=OjjaQr8YmR9EKpTk4TCwacvDhBSC8tJNng7OXfDCm8xy4i4gi4oKwP+ZmYteMElqMk
         kR6Vjr2ipab9lrkP3w2ZECcYfxPDObHAD7OE6cA665bNkNA763NkQZT/FvFGWkYn9Zdp
         +fzPp44U6/elVxvnKu8Jv068tBUdqB512m3UhujjLIWiz7L8GcufCdoX8jSoTbra5WBd
         Ja5QgiVDcnGFN8plxVv9LNhiBmHgNRWpfa5/yOQW1w8156ChOA1y8kR5mBTkNYMrnLrI
         iBk5FIn5p4+g9cZ7vsqXisNYvTboPe2r6RbQNjbpHRDwJTgdXWJ6KY7aqcvQNGRgDtCt
         /TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jvdjM+9XfNVw7IHg3rerj/0byH91HVl+2bo5TX7v2Hs=;
        b=uYMJ9envZ+9SXI/bR9Ch40dCsUK1BFXdmbCbN2TZocanBrtoRBfVUnaFjGnCGyclg6
         +nL4KpfYKIWBxjbAm4xTB9ZNxv2in1egsAGhiaQXULHzT5l85cYUa1uyTmPJQaK80xRm
         2H4dp2mRZMMhIE2AdnVpI+0DdWfOyXlhncK1zIdQqbdE2ErYgEYZory6RGbjQfHWi4UZ
         e9DXDzKmMWksklvjVBLD25uSXD3fbkcBOecOAmBbRl06cme1u/dlhxJKC32kMttlUyMO
         c7XT6lxFqFVFg5ge0X/7FZV3ayjq5aMLrvvcvXW68aVJB50UgFaDuZluu6rOtkASqb8L
         2gIg==
X-Gm-Message-State: APjAAAVlDD/ryCrE3QPzJWokSLDk7UPcxnaCKsfePJq/IzdjDkEGlybP
        NFrC1ReLx/Ekwm8rJEXGBvQATA==
X-Google-Smtp-Source: APXvYqy3LnDkFxjHpGgAGRcOCpH9cg1KypHyo0J0mlYgJJRh9JaCFhnZzEvcvk8gGKJtt9nIJM6DbA==
X-Received: by 2002:a65:6210:: with SMTP id d16mr4406902pgv.110.1554365894590;
        Thu, 04 Apr 2019 01:18:14 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id o76sm52237359pfa.156.2019.04.04.01.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:18:13 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:18:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 4/5] mfd: ti-lmu: Remove support for LM3697
Message-ID: <20190404081809.GN6830@dell>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-5-dmurphy@ti.com>
 <20190404081736.GM6830@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404081736.GM6830@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019, Lee Jones wrote:

> On Mon, 25 Mar 2019, Dan Murphy wrote:
> 
> > Remove support for the LM3697 from the ti-lmu
> 
> Bit of an odd place to insert a line feed.
> 
> > driver in favor of a dedicated LED driver.
> > 
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > ---
> >  drivers/leds/Kconfig                |  2 +-
> >  drivers/mfd/Kconfig                 |  2 +-
> >  drivers/mfd/ti-lmu.c                | 17 -----------
> >  include/linux/mfd/ti-lmu-register.h | 44 -----------------------------
> >  include/linux/mfd/ti-lmu.h          |  1 -
> >  5 files changed, 2 insertions(+), 64 deletions(-)
> 
> I'm fine with the patch.
> 
> Can you edit drivers/leds/Kconfig as part of a separate patch please?
> Keeping this in sync with this change is not critical and would add a
> whole bunch of process which we can really do without.

BTW, please add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
