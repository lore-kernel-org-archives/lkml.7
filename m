Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19B1C4CED0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AFA214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMIKcF3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfIRJ3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:29:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35967 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbfIRJ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:29:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id m29so3693675pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGfSZf6zpqugWLz9E/ECTaAWk5AflbcZNfQrHqcfJiI=;
        b=tMIKcF3VViDMpKj4XKmRBULjrjqaQ3bDWghhbjeJPdxAI1tGEJH+Dd1yUsdxorGzCU
         vX1pls9dszPLX9gZQtzLNbplTyPa9bkOieccxfMinLHCoQwgzD71ejncb9sDa3oZ/cOg
         yS2/hctP+HmUBJZvrUFp0MWC7o6Kb8PwlsW55EiUB++a0T4VExjmE6VRDWTlFa+L0pz0
         OHYUXbMiWJMAUC8zKjTMZIpRA7rkoKzf1jKCf3K9VIb+sqK9BzQses2ZbQatt0gUt2Zh
         rDGwvgQiyId1Lzm0DtBjV3JiXPSpb2Ymjn903sOwMOiOwPL3pp4hgwNNuSqtyazFLr9q
         pS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGfSZf6zpqugWLz9E/ECTaAWk5AflbcZNfQrHqcfJiI=;
        b=PU/jkV0eaqyfA0yzy/rWIw2zxFfKnuG7FE3amQBYIwzcHEDuT8aN+lauemqom/5U7Q
         IsLIlpXexzcBmDtwDJpPOcdQIA29rjqQL/tfcg63DTSFH5lNzjqXAEnkH3cXZuVkXaqw
         2ZRRWZ9Wbzahg7oD4wTD+r3X6Hl/6HU9abnrFBsyVTQtGPoctgEFpUMZvsLhC4QxksCC
         m4ND5E5TXIFLy/Q9C4zVnV4lkHSqJ0NwbxVP0RUh+bEc6XdVZRqGugIOdrUDreIY6JG9
         g5Xw3Cwn2a+z7uX6nVwMORreF+ICju0h3uPmozODkVOOhEvRxatGS7yFHYZb1Hcj/Fct
         Ou9g==
X-Gm-Message-State: APjAAAVZ2dfdwlLgsyzI6Y3ovZg+as1M/WYVnjw/7vsqGUN/Meg1+yLa
        ZsJF0RARBfkjcV/k0RFM8mRhGw==
X-Google-Smtp-Source: APXvYqyYA7P3uo4EMeZ0CyHqcdj3f3idzeWXRKKFvYXjT1q3TSTfQLukJan+2vTt2Z1VXThtAF4SmQ==
X-Received: by 2002:aa7:955d:: with SMTP id w29mr3107878pfq.60.1568798967721;
        Wed, 18 Sep 2019 02:29:27 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id c11sm10674911pfj.114.2019.09.18.02.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 02:29:26 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:59:25 +0530
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
Message-ID: <20190918092925.5hrvbcdorm2qw2j4@vireshk-mac-ubuntu>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
 <20190917093412.GA24757@bogus>
 <20190918090938.b2fj5uk3h6t56t2p@vireshk-mac-ubuntu>
 <20190918091747.GA18121@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918091747.GA18121@bogus>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-19, 10:17, Sudeep Holla wrote:
> Ah no, I am not referring to building as module. As you mention, that may
> work just fine. I was referring to timing dependency during boot. The idea
> is minimize the number of such initcall dependency. They should all work
> fine even as modules and should have least dependency on initcall sequence.

Yeah, so things work fine for them right now but that can be improved by
changing the sequence of boot here. And that's what Amit is trying to do here.

Even if android builds this as a module later, things will continue to work but
that may not be the best performance/boot-time wise.

When I had a discussion about this with Amit earlier, I asked him to send
patches even if he doesn't have any performance numbers for it as this is a
platform driver and I find it okay for them to decide the boot sequence that
they think is the best :)

-- 
viresh
