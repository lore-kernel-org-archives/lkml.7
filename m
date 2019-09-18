Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387C2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D108206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4FNd9Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfIRJJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:09:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44459 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfIRJJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:09:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so3943390pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G4hxKX4C+UwHppyagtwLzLYaYfdx3vbwuhfidaVb/nQ=;
        b=P4FNd9RhBzPlUfc1CQgYZsdIp18bxRVlkkoZx0inyMmXAe3hlUh8czZiU3x2EXhloM
         xvD7raK2qEG2tfvU8zA8qkG9bqGM+K9BtXJeoSLDVDCpiWqJcwOx0JVNpFJqD12g0ALM
         3EVMoKO99I+KmpFFCWKFqTQtlLC9xXOML1tFkkzbnLZDxZev7cUSKP6ICbBh4Dlo54XM
         O1gfiHx0z+t/QTOgydvUKlpylJGKx1yxBHMv8eUX4a93dnJaj/iwojIWEAcxBh/x7zsR
         cGujmLM//sZv8mFmZmasmc1fV8975M2mO3BtZHVkgGhL2Qcvd1i9qrgWoLMWkbmv0T5a
         /eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G4hxKX4C+UwHppyagtwLzLYaYfdx3vbwuhfidaVb/nQ=;
        b=BOQv1WgcQXPum5klY2z4K+j31Rzpo6gjaylVX+3/MmvOedoC2T8Qo3kBoizbXP7KE9
         ccgIzZ8L83Sl2xVeRHFeuZXsq0pgRvwu6Kse2xLim1g2b9XHZRISHXyIyQxn06mWOI/4
         mn3DYEQX0jKbR1eoCDMFm6y8DvyCUdtZOl1RoHfiEZU9mneRAszu+edkAkKnY8oC1EOE
         FZzVKSvFZq8J2PKLLoRZ7N3h8dlKihHYqZAssh4fHNA0DLQi7x4WKeMwFaW2MWbMpJ77
         VD0F9huLSPMJiGroscxcMdL8izJwKWDt3rHkhEcSliL/+KPxYZ8CpXtt5BAbFJgK/vIR
         92xw==
X-Gm-Message-State: APjAAAUsrFHkAFWjb1GQ8BHx03eqWwSAgDjrNe61WiV/MuQeI2t1S4oP
        aBv9GJDfGJTUQy3SO4JBvYdf9g==
X-Google-Smtp-Source: APXvYqxuV3bkoKSY6omGfYg+Szis0+eINu6ixhAs6qhxUbtS4C+EJcXtKq6zOKPNR7eTL+V5NLEaCw==
X-Received: by 2002:a63:465c:: with SMTP id v28mr3046498pgk.310.1568797781919;
        Wed, 18 Sep 2019 02:09:41 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id v44sm13954434pgn.17.2019.09.18.02.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 02:09:40 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:39:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
Message-ID: <20190918090938.b2fj5uk3h6t56t2p@vireshk-mac-ubuntu>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
 <20190917093412.GA24757@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917093412.GA24757@bogus>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-09-19, 10:34, Sudeep Holla wrote:
> On Thu, Sep 12, 2019 at 04:02:34AM +0530, Amit Kucheria wrote:
> > -device_initcall(qcom_cpufreq_hw_init);
> > +postcore_initcall(qcom_cpufreq_hw_init);
> 
> I am fine with core framework initcall pushed to earlier initcall levels
> if required, but for individual/platform specific drivers I am not so
> happy to see that.
> 
> This goes against the grand plan of single common kernel strategy by
> Android moving all drivers as modules.

Its been long that I got the opportunity to work on drivers directly, but as far
as I remember (which should be incorrect based on your reply) we can still build
a driver as module even if it has some postcore_initcall() declarations. They
will execute at module insertion. Is that incorrect ? If not, then how is it
going to affect android effort ?

-- 
viresh
