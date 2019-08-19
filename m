Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F00C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682FF20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lD+FTcFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfHSLZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:25:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41395 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfHSLZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:25:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id 196so1001984pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SRz2qLg3b+5ryCMRr2awnBnODV1H2CKHh3/qqtN+h2g=;
        b=lD+FTcFa1U9Of+5ZNZJ4YzlGWcZ8HOoCw+P7Jzn4XSaWCEbXSy/g2lO+F2ffBaBafe
         292sSYMHHbv0QCQB7XFFf8fwAaH0ALND8k/JZkSr/H3gLdiFUVqwRTFfvtVdHfQZc7Lm
         G/idNOcBUhb+WqQrmkWp2fwQ21qbAwXofZB1HOBJCIcuj1jYmCYHV/Qtt3Fdyypzblpc
         TX9ffHnGRwEMO7hL9oMp/6BMI2dHpkk5UcPBQIqfBAsD4re9WiGlQ8JNtCjoO4kdBUv/
         dLpWghx1aCOIscxqykPKATABc9EUpyLTFXlRqHB81XgqNGSWQIboH8b5OfXK7BElzCDh
         lbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SRz2qLg3b+5ryCMRr2awnBnODV1H2CKHh3/qqtN+h2g=;
        b=pzezU/qKyxRK1ifhXLtyKVHqq/svBE431IAVmvw/zSi0MbhJwmdmWGJ5hZda7VEYxz
         4VHRDjjEDK8Xp1Cdj/7tfeJrOIzMz6Wo/5twBCkz0c6ilmGStZO5FPVFALCLCOkGdQTn
         mlQ/7SRnCDDAGu8Uy2EOBGcxdv7q16YR3jehFMAeN5L55YFGL9wtUF/RbIKaYfFFHhyJ
         q2Cryk6s/cnwxWw2sjYanAjipJByTTcy/v8TVjY3geiMWCEKrs3XRUTYeGo15rdIPFVH
         UkbBz9zxa2LWQS+7+/9q+bnDW3pweGQEYv1zwgyUwoBVogS6gG8rzf94TC5Qvkd5wtMJ
         1CHw==
X-Gm-Message-State: APjAAAUISvSDcKfPa06BvxXoiixtKep8CwWGsIMUtPiM8fQSd5707543
        nEOLw0a2kC5r6vgUMck1WUSFBA==
X-Google-Smtp-Source: APXvYqyAkY+QkAa+fLhBUiqT2uTFDrLHRUyWTSqggEurMHSU6YVq9XlEShl2Oc8P09iG+AuUVAQXtw==
X-Received: by 2002:aa7:9dcd:: with SMTP id g13mr24046044pfq.204.1566213936145;
        Mon, 19 Aug 2019 04:25:36 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id q8sm11992733pjq.20.2019.08.19.04.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 04:25:35 -0700 (PDT)
Date:   Mon, 19 Aug 2019 16:55:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Message-ID: <20190819112533.bvfyinw7fsebkufr@vireshk-i7>
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com>
 <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
 <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
 <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
 <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
 <20190819090928.pke6cov52n4exlbp@vireshk-i7>
 <b831d7c5-c830-fd65-20cf-02e209889c28@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b831d7c5-c830-fd65-20cf-02e209889c28@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-19, 13:16, Sylwester Nawrocki wrote:
> On 8/19/19 11:09, Viresh Kumar wrote:
> > Will something like this help ?
> > 
> > https://lore.kernel.org/lkml/1442623929-4507-3-git-send-email-sboyd@codeaurora.org/
> > 
> > This never got merged but the idea was AVS only.
> 
> It's quite interesting work, it seems to be for a more advanced use case 
> where OPP voltage is being adjusted at runtime.
> 
> We could use it instead of removing an OPP and then adding with updated 
> voltage. On Exynos there is there is just a need to update OPPs once at boot 
> time, so it is more "static". However the requirements could presumably 
> change in future.

The API is about changing the values after they are parsed once from DT. You can
change it once or multiple times depending on the use case.

> If that's your preference I could switch to that notifier approach.

You shouldn't be required to use the notifier. Just add the OPP table and update
the values right after that. So no one would be using the values at that time.

> AFAICS the API would still need to be extended to support multiple voltages,
> when in future we add support for the Body Bias regulator. 

Right.

Will this patchset solve the problems for you and make your DT light weight ?

-- 
viresh
