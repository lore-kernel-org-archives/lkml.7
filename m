Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B9F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGlLH6m3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfHLGZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:25:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37939 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfHLGZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:25:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so6647475wmm.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zNM9CQE2nH0MfN9gL6cFS6VhCkj3/pdwb+Kpr2qK1RY=;
        b=GGlLH6m3vmzSx9ZoEWu0rHrchVy7wHSg+SV38pq8jUYMU/pkHeuEpS6EQmgBNTwvib
         Gof6YA2GgVzg9BshC6HK2fLyAgheCJeEr6FdgFECcU+W+IaaM/XgB+UlIxbVb6IYAFed
         VWl+SevhfrbOtGzpTWO+VgzafItAxRFEPEAgbw9MfhmAiQEGnmf4zmS1jayadb/g95tQ
         HZ8NJZF/SLNYYFsax3aIZY4OeeJS48ZlVPMMHPpNnSQhOPz1Awqm+qXSgV1j4DofDZOf
         tqO3l2MI3oOeJ8qCzr/Fpe5GrMu3NGU7kXllNluhwJDQbF2T9gv8QmpRKM9dKW1Tb2NR
         tWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zNM9CQE2nH0MfN9gL6cFS6VhCkj3/pdwb+Kpr2qK1RY=;
        b=g589lyQRZ5VQ/uG7Sne01zLRbv4kMCWXw9n0n6oCjjF7jDVtzY2u+ZhILbUDynZJcV
         CyUp/XN3KF9mnf1yHyu+fIEbd9lHzNlMWBS2ANt+n8o2ZEei0udirBRD5CUm8ioculxM
         Hu6tDvsIqUDpFQ5wSzmECsu6Nst9DCZvgtHno5vUlJuIDDsA6lokY+WJKvr6w3So224H
         tMV955YiVKIDFGZR/aIY2PVAOcCDnSY/B9CS5kX2dwhphos4VKuX6+9BNe21vqS00+GD
         bKV35vY/UMdvjFKv9WfpWcnz1ImtSGzE1ViaWDjzRvHautFk1iBq/WrqoFYys1074Yhu
         zGEQ==
X-Gm-Message-State: APjAAAX3/Eg5rvPioHybKkC46xY82fl+grp2hy9RUOVzDvqcpGL5gcJW
        4uZ+n0XyLDLfvn4wRiWslB2dAQ==
X-Google-Smtp-Source: APXvYqwrfxaGz5ztqxyzMHpAK9TC89kgQXpG97kTymw+X1Gwrp0Vy+khA9CnCoXcKDnPh/EO+FO50w==
X-Received: by 2002:a1c:4803:: with SMTP id v3mr25906217wma.49.1565591122813;
        Sun, 11 Aug 2019 23:25:22 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id b186sm19879747wmb.3.2019.08.11.23.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Aug 2019 23:25:22 -0700 (PDT)
Date:   Mon, 12 Aug 2019 07:25:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: rn5t618: Document optional property
 system-power-controller
Message-ID: <20190812062520.GB4594@dell>
References: <20190129135917.29521-1-j.neuschaefer@gmx.net>
 <20190201092411.GG783@dell>
 <20190808183924.GB1966@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808183924.GB1966@latitude>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Aug 2019, Jonathan Neuschäfer wrote:

> On Fri, Feb 01, 2019 at 09:24:11AM +0000, Lee Jones wrote:
> > On Tue, 29 Jan 2019, Jonathan Neuschäfer wrote:
> > 
> > > The RN5T618 family of PMICs can be used as system management
> > > controllers, in which case they handle poweroff and restart. Document
> > > this capability by referring to the corresponding generic DT binding.
> > > 
> > > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/rn5t618.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > 
> > Applied, thanks.
> 
> Hi,
> 
> apparently this patch got lost somehow (I can't find it in mainline or
> -next). Should I resend it?

Yes, it appears that it did.

I've applied it again.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
