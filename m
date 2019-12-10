Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1668720836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGUEOSg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfLJSYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:24:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43311 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfLJSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:24:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so14509989lfq.10;
        Tue, 10 Dec 2019 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J3Fx8Ozru3AuGWOjWvc6Qigb/OUj/LedRTw55RBNbbg=;
        b=aGUEOSg85AsreT39QBDzBQYeDUNVNG8qxblS0lqPAOh/mvDWQmp+aYHdObab0Ywr6/
         1D/erTOfgbnefovIimaS5RxuhRJzRjZAzlWjw+3mBPmcQTd3cYE2mBsLarWUoVtX7VYk
         oT+kg9iQJ6uc+Cxr22Q7UnhkUxJfa576lHzRkcvAz+SzCjgx3b657NXs3xUVmfkE4IXQ
         +OmlBtcQ2A/XCmuzcQIKUq2k08SSI4a+CsQhJbgXsRpIErzjxtkzDQQX3pQSEaVaDuJs
         aJeWxBsqMyv+4hceKG1UHxRONlmh9VgsaJS7tWPIZJuR1h3F3dx7ySRJQCm1E0wNvqH0
         amvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J3Fx8Ozru3AuGWOjWvc6Qigb/OUj/LedRTw55RBNbbg=;
        b=q8h2vAdskh7ZhZi57zvQZUQO5oofGECf/dxuguTPNCmk6z+AxWDysA+xOwIq3QVaei
         YC4Yr4VgwpwjmtoowwGn5emQaiczC8md1x+uDiWPJSdQ9BGKZe4Yt3sS2Tma/8ej+84W
         gAsPMM93BPVrckbMZzOAvQU59J1orAhdGPwUSV9hZWMMocfOcHwMT3ZUPdm+2nm9osUN
         tMBflmlL1Ccii6X9xPVFki8bQ2yGPedK7U6Et5d8NrqcypgaxOiXtGG/+HhH2LymEpXR
         ZEx6mir8fzG4s6cAk8iyBEySSoqVWxMGD+zOCLZeArtgAvGu8UGAGIfjxKLFiWpRGpHM
         blhQ==
X-Gm-Message-State: APjAAAV0ttT/w6z3uwq4axt55goUyxAMRKAngBSsudicHRFNK7+0Imrx
        7I24dKXOYK9ht9hD28sPxOk=
X-Google-Smtp-Source: APXvYqxF07iQXmiNXjFleXUWs9rwRg1kwAjgSyuguUjGbybN4u6GkAQPSegzeXZQNvdtozsIzp8rUg==
X-Received: by 2002:a19:4a12:: with SMTP id x18mr16433639lfa.158.1576002286171;
        Tue, 10 Dec 2019 10:24:46 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b17sm1999915lfp.15.2019.12.10.10.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 10:24:45 -0800 (PST)
Subject: Re: [PATCH v3 09/15] ASoC: tegra: Add fallback for audio mclk
To:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, allison@lohutok.net,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alexios.zavras@intel.com,
        alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
 <20191209164027.GG5483@sirena.org.uk>
 <7fe879fd-dae3-1e64-1031-cd9f00e31552@gmail.com>
 <20191209204735.GK5483@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <560185d9-32fd-a85e-5feb-105f79b953c6@gmail.com>
Date:   Tue, 10 Dec 2019 21:24:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191209204735.GK5483@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.12.2019 23:47, Mark Brown пишет:
> On Mon, Dec 09, 2019 at 11:31:59PM +0300, Dmitry Osipenko wrote:
>> 09.12.2019 19:40, Mark Brown пишет:
> 
>>> Why would this need to be a stable fix?  Presumably people with stable
>>> kernels are using the old device tree anyway?
> 
>> At least Rob Herring is asking to maintain backwards compatibility
>> because some ditros are using newer device-trees with stable kernels.
> 
> You're talking about forwards compatibility not backwards here.  Are
> those distros actually using LTS kernels?

I think openSUSE Leap could be one of those distros that use LTS kernel
with newer device-trees, but that's not 100%. Maybe Rob could help
clarifying that.

>> I'm personally also tending to use the newer DTB with older kernel
>> version whenever there is a need to check something using stable kernel.
>> Perhaps losing sound is not very important, but will be nicer if that
>> doesn't happen.
> 
> That really does sound like a "you broke it, you get all the pieces"
> situation TBH...  I'd be a lot more comfortable if the stable kernels
> were sticking to bugfix only though I do appreciate that they're not
> really that any more.

In some cases it could be painful to maintain device-tree compatibility
for platforms like NVIDIA Tegra SoCs because hardware wasn't modeled
correctly from the start.

I agree that people should use relevant device-trees. It's quite a lot
of hassle to care about compatibility for platforms that are permanently
in a development state. It could be more reasonable to go through the
pain if kernel required a full-featured device tree for every SoC from
the start.

But maybe Tegra / device-tree maintainers have a different opinion.
IIUC, device-trees are meant to be stable and software-agnostic, at
least that was the case not so long time ago and I don't think that this
premise changed.
