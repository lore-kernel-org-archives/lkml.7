Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C95C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 01:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C232085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 01:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyQQJ5Q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfEBBjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 21:39:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44585 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfEBBjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 21:39:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id h18so605024lfj.11;
        Wed, 01 May 2019 18:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKKVG5737NrpS/LA8GajQUyTQUsuWWyVh2aWGz7aFb0=;
        b=dyQQJ5Q7assiIarPt+M23smzYoQ+W/DKcGA0vmYLZIfEoQWhvipprsIhRiXZUyQ369
         k+5U7IQhHBUYDY5u/YQAIUgKkMS4c5eNjHC1mj4LcPiVetf3kT0gGe2XFWPihblQ0/Kk
         7pR0UcXnP1QuuuZ7NThrQXM2nxEe/gjwPvbuX6aVZ+F+NP3QAwd07XNkpcRqDQxEPPZn
         C3ka8R5jzCEaqhktwz6vDSPSZTiCcjycDJKAJ9C9/lmsu/g6KiMOMrmAI4lOwIZz52Mx
         befF8feppzk489cP7w/7qPRivEbjZqYRKXmyh879zZ1PZ08zJuvFu/mQoMOO+9z2IUwS
         sF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKKVG5737NrpS/LA8GajQUyTQUsuWWyVh2aWGz7aFb0=;
        b=XX5IQz3twV9Hj/gYiilUDpYDEG/IXUdYJGvRXVHaN6B6gdCeFg80GSw7vZSCFdH/3U
         yreb1oGobl4rsBQL3XrQo/bQm9sSSHmk0S0Z8iC6BynoDaNsTygHJ5GXuKoWKDp8Y2Hz
         O6mUkhl9w3nW+eLG1B3OGQnJC/rnUdpHcek80Ym51DR4upMYfco6Famtv/N+qbFHxkcr
         6xLSMjoYw/7Bp7PsmLnNw6rJtdIPTot84bG6xZy6rYCHHL8NfLzH/COEVdWuZf9dHmLu
         giK/LgctDcdmSqHVbSqGLF890pz2P1Hzi65BtS9iDjx8jREkTaacfDk79OUou6k0dIg+
         KgTg==
X-Gm-Message-State: APjAAAW5SLG4PWvu5AqANLbzzMv4s1BlRABMYTfVtW3G/UVIDZWRWg2X
        qMT3ZiFbQzN0KlZWoXsqL+BY+4Lh
X-Google-Smtp-Source: APXvYqx6rRBsJnpEx8oZbstFl0E7VH7dKBWlM3VvuClpu8+yxBlcocwTumm8qTINcHxH1fl5re0HcA==
X-Received: by 2002:ac2:538a:: with SMTP id g10mr484312lfh.141.1556761186463;
        Wed, 01 May 2019 18:39:46 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id f12sm5299832lfk.6.2019.05.01.18.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 18:39:45 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] dt-bindings: memory: Add binding for NVIDIA
 Tegra30 External Memory Controller
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <27d24f4e-cf4c-b2d1-140a-5dcef021fa40@gmail.com>
Message-ID: <7b6867f4-54b2-f3b5-2b4e-87ea3000fa44@gmail.com>
Date:   Thu, 2 May 2019 04:39:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <27d24f4e-cf4c-b2d1-140a-5dcef021fa40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.05.2019 3:52, Dmitry Osipenko пишет:
> 02.05.2019 3:17, Rob Herring пишет:
>> On Wed, May 1, 2019 at 7:06 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>> 30.04.2019 1:05, Rob Herring пишет:
>>>> On Sun, Apr 14, 2019 at 11:20:07PM +0300, Dmitry Osipenko wrote:
>>>>> Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
>>>>> The binding is based on the Tegra124 EMC binding since hardware is
>>>>> similar, although there are couple significant differences.
>>>>
>>>> My comments on Tegra124 binding apply here.
>>>
>>> The common timing definition doesn't fully match the definition that is
>>> used by Tegra's Memory Controller, thus the DQS (data strobe) timing
>>> parameter is comprised of multiple sub-parameters that describe how to
>>> generate the strobe in hardware. There are also more additional
>>> parameters that are specific to Tegra and they are individually
>>> characterized for each memory model and clock rate. Hence the common
>>> timing definition isn't usable.
>>
>> I don't understand. Every PC in the world can work with any DIMM
>> (within a given generation) just with SPD data. Why is that not
>> sufficient here?
> 
> Because this is not a standard PC, but a custom embedded hardware that
> is simpler and also doesn't fully follow the standards in some cases.

Even if there is a way to derive at least some of required parameters
from the common timing, I don't have information about how to do it and
there is pretty much no chance to get it into public.

Rob, please let me know if you're okay with this binding.
