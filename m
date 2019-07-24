Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2A922387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563994411;
	bh=k1q2SMe+r76Pwfl5LKScFLF1hPjA8nL032dg1IeZuiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aYA413cf4KLxjRWRznfsmNCHqEay+c53lcaglHdW/4iPi1V0RcfSPWuzwgCJ6IYE8
	 X5jSfoe0FfwE9tNrq55YmWK7/c/CUewH+UNQe3KJBPW/pgAGRxk0cEqT1j9CviK5RX
	 PzngL2mwgjSIrY6BaEVKEImvwNJP1LTs9gfoMnzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfGXSxa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:53:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40412 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfGXSx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:53:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so42568232wmj.5;
        Wed, 24 Jul 2019 11:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2zNZEJTuzMPjlqBT9RJzY55tpYLVrNhwFI08koZCEQw=;
        b=mH9+e+QbmGoMIJ9hUSENbpgdk/7beNrvdgyZZtO/QEsxFBjNIX7eBNTKzfJLVIuEdb
         pgwXRH2wjpoDBrFe2ig8hNvZjEG0dy9bKqyaB7hoTAKkr3GEinUERzC2veRxDq13g63c
         dJ+3zydLW416sczAgMijTzppv+Mle+Hx4veUOBtiKAU3BqCMb0RYJlqnB7K51DaBj7/L
         Z0+JY/vpexisXzvjuzMNsTD3ztrkxxJk4HdDEbLkHi4ND2Kbh0b3cFGG3OKl31NoBhV8
         ksQ8AOJy6apk8vzeyyYdiO06eBM2RWssqrq05/9wnO2dt67BRMgbWVT9ac+W1Iva7cub
         xQXQ==
X-Gm-Message-State: APjAAAUpGLbzlYOQSprSsmyGYG6zFNYsoMCTPuoCoPvwqfIFjehEJaSo
        7W3jzXxJDjiMI9MT3ihN14Y=
X-Google-Smtp-Source: APXvYqy0xTyUlF8khzfhL9sfMsBdP0ddDmFskR3W6aToym1NthS5JiFwI9kJq5H93SLqHuER2lIIBg==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr75602252wmm.96.1563994405214;
        Wed, 24 Jul 2019 11:53:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id a6sm34609206wmj.15.2019.07.24.11.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 11:53:24 -0700 (PDT)
Date:   Wed, 24 Jul 2019 20:53:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 00/11] Simple QoS for exynos-bus driver using
 interconnect
Message-ID: <20190724185322.GC14346@kozik-lap>
References: <CGME20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5@eucas1p2.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:05PM +0200, Artur Świgoń wrote:
> The following patchset adds interconnect[1][2] framework support to the
> exynos-bus devfreq driver. Extending the devfreq driver with interconnect
> capabilities started as a response to the issue referenced in [3]. The
> patches can be subdivided into four logical groups:

Nice work! Good to see proper solution :)

Best regards,
Krzysztof

