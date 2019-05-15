Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC989C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2A52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQ9N1mnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEOKWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:22:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33193 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:22:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so1160751pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 03:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k8VFYCF5oSPyusd7YzU9vI+LHK0xPFnRUxwFyUrCXLA=;
        b=EQ9N1mnr6ZAQq91qE17FWFlHoZ4Bl9lxk2XZrVv8D4dzNfpeTPdY4yjSYCJ/BGq6Ad
         pRw0mXLb6lIhWlkK4SgDPmsHvY/IMBXn13WhNY1RgbOSH7JVAwUV17GOrEjX2BEYId2w
         8GMP4LMKrYY+0Fodr89ONmqevJq/47UWBeMeiTuFr5Dct+zv4FmkIRniK8RG1ug3sIXa
         wU1smfWprasCjvoeBliO9XQ9ZCFAhYkFdf1a0PqqhU1KnPZbQ4zB0T6PjItaIVqqXece
         7CQVEGFgRQVINfSdZyIZ7fiHoWStH62Sf3jk1mSvPbdl/2JSxYYUCxkt7W8b6Dt2Wspf
         3rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8VFYCF5oSPyusd7YzU9vI+LHK0xPFnRUxwFyUrCXLA=;
        b=sR27WFCkloxOsgKRwp3FnOc9rysxmyS2xNd9J1x4tboocW0nAxruogBdUK5BoZMKbS
         3Tn9xElHovx2KPHLLxNd9ZffKK1mSL5rmyCWPv835k2b4sJQKy2uE0VWMRT6pcxVWsZs
         VkoVJeWycj471J0KR9xVAQaUi6JF0kSW4Ai0glcTmn8N4y2H+C/Fhsmk2/2Jz6IchQBo
         uurz/mUb4sEgNN2K9RDdYdIRxqWcpmYOaX7goZdHrHUeh4woBUH2nn88ZZUAQpRa6LZq
         fO7wwFriMr8tpD6f+gHNsuuiSpksStWxQl+y/Hdut6AslQiL9bfpPH2hlkzRPCGgfG5j
         uhFQ==
X-Gm-Message-State: APjAAAXDa/+T8kPub3zH6R3FlzGPBymFlARQm0Vwv0rCpNb7CZpPpJEO
        LCXu26yo5X/5cvn/75TvE7jBGg==
X-Google-Smtp-Source: APXvYqzzEK+huRkxpvvZM1btAPYw8+s8wBsDTQMcogYLW7ON2rMCIGENU0s1Jb8JEFb5VT952F7iiw==
X-Received: by 2002:a63:ee10:: with SMTP id e16mr37077998pgi.207.1557915723540;
        Wed, 15 May 2019 03:22:03 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id n13sm3827336pgh.6.2019.05.15.03.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:22:02 -0700 (PDT)
Date:   Wed, 15 May 2019 15:52:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Message-ID: <20190515102200.s6uq63qnwea6xtpl@vireshk-i7>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
 <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-19, 12:16, Daniel Lezcano wrote:
> Viresh what do you think ?

I agree with your last suggestions. They do make sense.

-- 
viresh
