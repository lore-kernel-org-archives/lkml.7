Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB91C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F542081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy/Sn6Xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBAxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:53:04 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55734 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBAxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:53:04 -0400
Received: by mail-it1-f195.google.com with SMTP id i131so528954itf.5;
        Wed, 01 May 2019 17:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SMeSIjBMoztFLs1N6yeylbhEwFQ8aE16zamS1zR69mw=;
        b=iy/Sn6XaDIKRiDSuy0xTaguACJf6ApHbDUyojNS1rXStyorLACsb0v6xqDZ/RxD+D7
         dn7+rhRXc69rcLC/sDFHT/DqJJBU9EbuhBQmC+AoUsq1I1DIPuSLxVNYuSzAxnVZy+LU
         yfriT2A10Lm2/4Zy1PSYiDXbmIKa0hgDeC0dT6oAIpVXH6xh3kYPPV6EM+hF1KTpLbJZ
         Nla30v/MTpGqk3M+hYHJEDR9Q1z45PSmeGhXGUv7X13IbgDVk+6RK7Rh7wcvFinFu+vH
         Yj3avo4TqzqlICz+BG7kCu/IChct8jmUxDs9pnXMWLUa/z4vEcAFYml4gvBh+40F5Usj
         3uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SMeSIjBMoztFLs1N6yeylbhEwFQ8aE16zamS1zR69mw=;
        b=jVHdkM1eLVj8fd0F5Qp3NZ59MeXG33pIhaj5r2rnFelYqVeptpN1s+q832jhBWkg8M
         UVaTLwKihCz4K4mLTrIMGQFlRt8H2jdhtZV3l+Rupt7TxTvh5dYhjuc0AFxTmAx7Jnma
         HeGND1W3NqI0AONWXY5TWdJk70rUYOHdTLljiTHmI1EeT2RnK9I9C6DD6S2odrWp1EZr
         kLfa6+4dos/qDQbPY9b3jO1b8N4B9kFCTOYN+y6ZOUM6U0hZkLUMlIX0T/0oMEhQBlE5
         OHe8iZVfpzol6dE3KBNkNZQNnnTVLtyWC2z30kMSxy4uS1aLIjhjUDUCCkbu+Qeb0aT8
         OZJQ==
X-Gm-Message-State: APjAAAVywGWpYJYN68igFdGKkrUAt2QJJcItKUPRL++nMWPgVIbAixPa
        xcmwmYUGS7OVzjVEVDZKrdjFUTgJ
X-Google-Smtp-Source: APXvYqy3d6dJXuMHx07TIlwjPLHrrzD18rTenNrcq63rPhYmeSCO98a7pjuckVpAlPuBAvYyFxZv3Q==
X-Received: by 2002:a02:6307:: with SMTP id j7mr525665jac.65.1556758383076;
        Wed, 01 May 2019 17:53:03 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id d10sm4370934ios.72.2019.05.01.17.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:53:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] dt-bindings: memory: Add binding for NVIDIA
 Tegra30 External Memory Controller
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190414202009.31268-1-digetx@gmail.com>
 <20190414202009.31268-3-digetx@gmail.com> <20190429220542.GA17924@bogus>
 <137c766e-66f6-828a-5c3b-f526d66d37bd@gmail.com>
 <CAL_JsqKCWytgQEDPLX27xdaDrARtHssbhFcL47RO0zfECm0Gig@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <27d24f4e-cf4c-b2d1-140a-5dcef021fa40@gmail.com>
Date:   Thu, 2 May 2019 03:52:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKCWytgQEDPLX27xdaDrARtHssbhFcL47RO0zfECm0Gig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.05.2019 3:17, Rob Herring пишет:
> On Wed, May 1, 2019 at 7:06 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 30.04.2019 1:05, Rob Herring пишет:
>>> On Sun, Apr 14, 2019 at 11:20:07PM +0300, Dmitry Osipenko wrote:
>>>> Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
>>>> The binding is based on the Tegra124 EMC binding since hardware is
>>>> similar, although there are couple significant differences.
>>>
>>> My comments on Tegra124 binding apply here.
>>
>> The common timing definition doesn't fully match the definition that is
>> used by Tegra's Memory Controller, thus the DQS (data strobe) timing
>> parameter is comprised of multiple sub-parameters that describe how to
>> generate the strobe in hardware. There are also more additional
>> parameters that are specific to Tegra and they are individually
>> characterized for each memory model and clock rate. Hence the common
>> timing definition isn't usable.
> 
> I don't understand. Every PC in the world can work with any DIMM
> (within a given generation) just with SPD data. Why is that not
> sufficient here?

Because this is not a standard PC, but a custom embedded hardware that
is simpler and also doesn't fully follow the standards in some cases.

> In any case, it seems for Tegra124 a different approach is going to be
> taken. Seems like an "avoid DT" solution to me, but if it's contained
> within the firmware it's not my problem.

My above comment really applies to all Terga's.

The Tegra210 is also a bit more complicated case because of the
proprietary signed firmware that can't be easily replaced with
opensource alternative without special hacks, but AFAIK the unofficial
opensource firmware will be available in some form for at least one
consumer device (Nintendo Switch).

Please write a detailed comment to the Tegra210's patch, saying what you
would want to see changed. I'm sure Joseph will try to do his best.

Note that it is always possible to define a proper device tree binding
and then also "unofficially" support the downstream binding, IIRC that's
what some drivers are already doing in upstream kernel. So I think you
could just demand for the proper binding regardless of the firmware
situation.
