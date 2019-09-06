Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69085C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450D8206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392912AbfIFOpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:45:15 -0400
Received: from foss.arm.com ([217.140.110.172]:57400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfIFOpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:45:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7AB28;
        Fri,  6 Sep 2019 07:45:14 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 752063F718;
        Fri,  6 Sep 2019 07:45:13 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Mark Brown <broonie@kernel.org>
Cc:     David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190904123032.23263-1-broonie@kernel.org>
 <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
 <feaf7338-9aa1-5065-7a83-028aeadd5578@arm.com>
 <20190905124014.GA4053@sirena.co.uk>
 <93b8910d-fc01-4c16-fd7e-86abfc3cc617@arm.com>
 <20190905163420.GD4053@sirena.co.uk>
 <58594735-c079-74e5-26c8-4911f073d4df@arm.com>
 <20190906105523.GR23391@sirena.co.uk>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1bfa2b93-301f-22ff-7208-b337b8f3820d@arm.com>
Date:   Fri, 6 Sep 2019 15:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906105523.GR23391@sirena.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2019 11:55, Mark Brown wrote:
[...]
>>> However you're probably better off hiding all this stuff with the
>>> generic OPP code rather than open coding it - this already has much
>>> better handling for this, it supports voltage ranges rather than single
>>> voltages and optional regulators already.  I'm not 100% clear why this
>>> is open coded TBH but I might be missing something, if there's some
>>> restriction preventing the generic code being used it seems like those
>>> sohuld be fixed.
> 
>> To be honest I've no idea how to use the generic OPP code to do this. I
>> suspect the original open coding was cargo-culted from another driver:
>> the comments in the function look like they were lifted from
>> drivers/devfreq/rk3399_dmc.c. Any help tidying this up would be appreciated.
> 
> Yes, there's a lot of cargo culting of bad regulator API usage in
> the DRM subsystem for some reason, I keep having to do these
> periodic sweeps and there's always stuff in there.  I think a lot
> of it comes from BSP code that just gets dropped in without
> review and then cut'n'pasted but I've not figured out why DRM is
> so badly affected.

I've been working on tidying up the devfreq usage in Panfrost. From what
I can see your patch is correct and I just needed to work out how to fix
my DT.

Steve
