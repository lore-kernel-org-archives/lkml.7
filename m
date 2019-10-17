Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B838FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DE22064B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YO85IQp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404842AbfJQGbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:31:07 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:39015 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392744AbfJQGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:31:07 -0400
Received: by mail-pf1-f181.google.com with SMTP id v4so956606pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 23:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fw1yYhZZ5QW5zX6QjJLpyykgbadh0BT1jKFS5XpcQIg=;
        b=YO85IQp6MRTrBiWnmv/pN2umttDZqF6DIetl5Fvi9BEt4iJSw8UM8eoknkoagueGLY
         CIJTyaS6OStNG8ys8xYrcccIgYObVbNMMjxpSr6tgEOpXy/SmmYrB4DgAd8gs4Ahuuzb
         MfcxPHi8vDOYUpDdJteDOFT/k5y8sKH7J2v5BvMRVtaF/zbv4QG3jhke6rNpYrBEfxM6
         IV4vl76nOIa7hxntrMiC/HUk0uj1isvhX9qQMdbLdZh+ENlyE4LGid2NH3UYnBPF/YuR
         A2XKvvlvWd9fIAu7e58oAdWtP4NUTfuwGcLDk0lPPbT6HqugJf/ljpz4Co6zKEBuCT6A
         i/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fw1yYhZZ5QW5zX6QjJLpyykgbadh0BT1jKFS5XpcQIg=;
        b=MU0qt95Ahc2snh3vrK8o4szeRk7hd0G9Kl055ut1Amsbmc6XF41vAkMGK3ojczI7JB
         9OVe4QkrHC0Topg6W8bf2d92wz3w5nSW3xvK8br3ZsQ0rbsD7QzhjQdw+18kDFEmHh8m
         lg9qQzp2fjzwOYp6BCuop5ju4ihSJhINueZE1+3HEEWRQiakFp+XERnMJPx8gynyS9r+
         kkyTDml0myP7mDTGmio/B5LQ+O3027xqkQtAe9/TpfXN5fR3GUynaK4Oni7u0JjwKw4n
         GKADuBC64Z/S6FlkDY20ZT6eSWu1hx+3W6anluddK01Ul9Og+d01l/zplYg5Eov25cqM
         9pIw==
X-Gm-Message-State: APjAAAXbSc8fZsaGvTv2ChMlrjCtILBMCnniaKrq5AO19DBeI24tfH8r
        UFz5bnLSI8I4ymmyAqRdA7oNmA==
X-Google-Smtp-Source: APXvYqy/3dKlQYrAL5ENKYviVbasbExy0Ou4NP5sDQoUA4ILd4XMCDRpjzbTMymafYYiopd0yHpkMw==
X-Received: by 2002:a63:4046:: with SMTP id n67mr2177350pga.200.1571293866371;
        Wed, 16 Oct 2019 23:31:06 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id r24sm1484239pgo.58.2019.10.16.23.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 23:31:04 -0700 (PDT)
Date:   Thu, 17 Oct 2019 12:01:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Fan Chen =?utf-8?B?KOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [v4, 7/8] cpufreq: mediatek: add opp notification for SVS support
Message-ID: <20191017063102.4jirlphdxdydl2bm@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1565703113-31479-8-git-send-email-andrew-sh.cheng@mediatek.com>
 <20190820033927.72muldasu4xd6wb7@vireshk-i7>
 <1571193828.22071.5.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571193828.22071.5.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 10:43, andrew-sh.cheng wrote:
> This is due to SVS feature need to fix Vproc for calibration.
> When SVS calibration, it want to disable all opp items, except one with
> voltae 1.0V. (SVS will change the voltage field of that opp item, if the
> corresponding voltage is not 1.0V)
> In this way, SVS can make sure there is no other module, include
> thermal, will change Vproc by DVFS driver.
> After SVS calibration done, SVS will enable those disabled opp items
> back.

But why is this required to be done this way ? Why can't we just update the
voltages without doing this disable/enable dance ?

-- 
viresh
