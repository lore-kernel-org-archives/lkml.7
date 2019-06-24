Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68937C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A92920657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8kicrhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfFXJIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:08:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43238 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfFXJIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:08:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so6501246plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6ElPzoRkMG2TinGXMwV20PxkL1nbsID5tYeegoksow=;
        b=v8kicrhdNQzTJtKXz8JndxUg22PalL6KuNoWKtRWwuMR0+8xKgT1CPoBOauIH/nTgg
         1cyMtBAwypfjW6RsGeAava5D6Oc2VPRoMJLUSgyx6QnO2tkys5aHrNVt7sJ0Egz+SuIK
         MRKFQ3c0pvrqjgoFg44H07HsKnVkgiKtcyZpVg2WSFpIeJLJfsBK6UdPyl7pi80nhNM1
         iTDYaEXp3GgvXBXHmvrkEgyvNQMP51bLQlF7qYLKeXLB7Tw5oiLRPXqaMhz7Ijb3cjgJ
         IQLi/BcSMhtE6WD4PdKTubmalgyt6S7qBlK9AoWR2mrkvGddJOfN54fQHwfv2FnQfejb
         fP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6ElPzoRkMG2TinGXMwV20PxkL1nbsID5tYeegoksow=;
        b=ZuaNxKuOstzHHS4LfBhASksN8rmX0WgDU8f7pA9LB3/CTiX7B+r+MVQ7ct/0Sgr02g
         q2tE5LBpsdBVf8Z/Uow5cLZlw73PwLapkcaBAOHK8tojfBQ2s3JROJrnm+kYnC61SnIM
         JeQY5hHBZ2ojito+27u20biNq7Lm+rHXeIldfc6O0wl3M3ERSiTyhBIJ26X3EKdB10pK
         QYpFcUwNseqv93v0cEFwbpwws2GIyaQ9dC41Btsbv16j6xBG3sZZryGg3J89YZAFvcdk
         qDZOfoeV06UDYBB9ikN7M9cUmmXfNqawpTO2ATHTXzvOV7Ow5smfFQkFEJY5EkyFrrh8
         2e8Q==
X-Gm-Message-State: APjAAAUwqb8Fi5UUd2hcISNqcq5t8yrTn8cqQrZxYZMYIgmgVtPpwl3f
        MOvNo6rXomF7vhzNSKA2GLj05g==
X-Google-Smtp-Source: APXvYqywfo3cR2LLbjfwMjPXw9Ib+7wdfT2pRJKVQlmglRp4Kg8SdTQJXSlsk3dTIXqDMlAGL7USbg==
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr105908033plq.178.1561367327776;
        Mon, 24 Jun 2019 02:08:47 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id g8sm10563674pgd.29.2019.06.24.02.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:08:47 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:38:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/6] cpufreq: Use existing stub functions instead of
 IS_ENABLED macro
Message-ID: <20190624090845.tstzw6cruzsz5www@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <0ce0d1ca-154d-fca3-f739-573ecbd2b0db@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce0d1ca-154d-fca3-f739-573ecbd2b0db@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-19, 10:53, Daniel Lezcano wrote:
> 
> Hi Viresh,
> 
> On 21/06/2019 15:22, Daniel Lezcano wrote:
> > The functions stub already exist for the condition the IS_ENABLED
> > is trying to avoid.
> > 
> > Remove the IS_ENABLED macros as they are pointless.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> what about this one?

I didn't say something because Rafael already pointed out something
which he wanted. Actually he was the one who suggested it to Amit
initially.

http://lore.kernel.org/lkml/CAJZ5v0huESFqOADqyym-ci-XcWpL4tbcd9a-jxe_KArXKpHFyw@mail.gmail.com

-- 
viresh
