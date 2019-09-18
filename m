Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E980C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218DB214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fk/TzG+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfIRJYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:24:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34500 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:24:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so4007308pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gxoSuJQ6tFLYp4g2neEbM8yU2CStuYNj11hMjYPafM0=;
        b=Fk/TzG+zR7aMVIWtTy+Yxf3cDDmJPfGy2lwVIWxXmfAmZzAlaACNEJbKJkPHu2ia2E
         YXjLa9LF9NBR2KfrMTDAoPx3l7enK+r001ZMoNtsxj1kPshqgLP0pLTeQ91lqKaiWCOu
         V/f2DW71FndaBt7uaP1SE0hsTLfZW+fEcvwj8mfYS6QqtidCeGNT5KvLVtkYTPKr4Qs/
         ffcOfOcI8t8FEOiuOA6DrqjMNMkLVJCn08H9tZymDF3iN3mVcWFUCL8c9UxfacKhBkiv
         GMv+kOMZ01UA2RSI/0DzJJtz25hxRKvTdbmOJORLhNCqUBnjcVqihD//gNsgoVXi5GAq
         axEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gxoSuJQ6tFLYp4g2neEbM8yU2CStuYNj11hMjYPafM0=;
        b=ohIwmweklXk+lXD/Ih8VPcX1lO07wUNUCR/bLWQWKFl5AIPEEHyoDTxgFDAswYFDaz
         3faaL49nK408yzNYSb89elAdPuLJH21c4a8xMwUl2XON0e3A0nXtSfdCx7bVF3nB5hiQ
         MlmWTUgkz+L9eFjF2/wPDh7Zp4Kqh12Q5xx40WhHboX8PUubAI8muk5QFnlU/VSyw9Vl
         neHz6ct6n7CKBR05yLFsYI+gWCP+onfRk7euahT25B+ERk8/joUQIHhKTcJeUDaEgrrI
         C9uDYLikAhZzCCZSB9QMuxUSt7RaSxfBOyJzC8KowG3XMkxdTzVXIhRgpfss1Yd/tT9I
         DtXw==
X-Gm-Message-State: APjAAAW6XQUkdo1bVADpFeiITxNRgB5afbWxhSinHJNDHeoGugM+sfms
        BCQKdehadYHHjHnegppe9An/PQ==
X-Google-Smtp-Source: APXvYqz7Ynw9js8OL9E7HFrRlFKBtt+IpGnyik3APBXO5zcuV+d4IhN19kTq6wgZbJpIvoCMlNjK6Q==
X-Received: by 2002:aa7:8d81:: with SMTP id i1mr2935659pfr.191.1568798661686;
        Wed, 18 Sep 2019 02:24:21 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id t8sm3523628pjq.30.2019.09.18.02.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 02:24:20 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:54:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Adam Ford <aford173@gmail.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        =?iso-8859-1?Q?Andr=E9?= Roth <neolynx@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Message-ID: <20190918092418.que4c5jpcn2dcavx@vireshk-mac-ubuntu>
References: <20190912183037.18449-1-aford173@gmail.com>
 <51bb8890-bfd7-c241-1ce5-151df3a90513@linaro.org>
 <CAHCN7xKjwkJHysSkNymF=sw6KuS=FqbapuRFZODuj6E_hmRG1A@mail.gmail.com>
 <2ef812a4-2f2d-b2e2-9fa4-080775e24bc8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ef812a4-2f2d-b2e2-9fa4-080775e24bc8@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-09-19, 00:33, Daniel Lezcano wrote:
> 
> Hi Adam,
> 
> On 12/09/2019 23:19, Adam Ford wrote:
> > On Thu, Sep 12, 2019 at 4:12 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 12/09/2019 20:30, Adam Ford wrote:
> >>> The thermal sensor in the omap3 family isn't accurate, but it's
> >>> better than nothing.  The various OPP's enabled for the omap3630
> >>> support up to OPP1G, however the datasheet for the DM3730 states
> >>> that OPP130 and OPP1G are not available above TJ of 90C.
> >>>
> >>> This patch configures the thermal throttling to limit the
> >>> operating points of the omap3630 to Only OPP50 and OPP100 if
> >>> the thermal sensor reads a value above 90C.
> 
> Oh, that's a very interesting use case.
> 
> AFAICT the thermal framework is not designed to deal with this
> situation. I agree this setup may work (even if I'm not convinced about
> the stability of the whole).
> 
> May be Viresh can help for the cpufreq side?

Sorry but I am not able to understand what's not supported by thermal framework
here and what can I do to help :)

-- 
viresh
