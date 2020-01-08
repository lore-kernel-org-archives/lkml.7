Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27A0C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93C2205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEKtLl/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgAHIRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:17:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32933 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgAHIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:17:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id z16so1246885pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wKcCES/d4/KeU/NbfZOHeDU0TekdBewHLd32C6AO1ck=;
        b=SEKtLl/2LU1rqULv4K0YiLjIIU6CfLWc6zgCHzvxXn6rxs3MloRGcaY+mmpntrk4bR
         qqWP66RHO1/y3UFLDjZ5vX9LWA6WSWYaNyehUzftiFo/A/vpzLr7FOczpYhalxh/g+ct
         a+Gfmtpi+1j4iZzOSb68bV8GqPo5Mpq4dFFwZdtm8i1akjAn93MM63gkF9aG74vL07jw
         efvISDgtx7WPN8FQ3PapBNdjNSHXuyU5JaLAe48son4QVaPPZ0sHRPrbm8SedF+oLoOE
         vkTH/LFqRemsKya0qnLlhZsrwR+UHjzxT+UA8MxOW9nVh6Qhd9DaGwjqEYzs6LeHwavn
         ZdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wKcCES/d4/KeU/NbfZOHeDU0TekdBewHLd32C6AO1ck=;
        b=cHTCpZWP4Mi0iNedBeQ3VgYoZ8VSM/fCGs7GxaGlLvdkkPaluBJn4rxsn2cJmRSVVU
         AbbIwmm0J0wH+vi/qBJX/ZTwhtF3hkX/LRV9QP16UpDOjgZjXQOQB5yZYdGPVZ7YZkSS
         9lznhv1uT1fmwZ0z8zb47UWnj79zvr0susLzyVEu4LtE1FB+42HWIJJD90m7unR5Mf9e
         ASvWvd3ol2I38t5TUDS8AATqJrFRLIyed/dXFtdMfVOAFbWh9PWuBjs24zf6KhUG/A5X
         E5jQjcCJjppyGtKCkYeVqSmctmL7tMU2Yvk7V7rRQfJuvM15K+xaPa1rIdD5n3Lh1dph
         B9Vg==
X-Gm-Message-State: APjAAAXM4F8BUJtM9j15KynOhZWLLDMM0NP6uh6GPQZKdjb+oLo5Lt2Z
        hLCuQViGaopYrxlbVJ4y9F1l0w==
X-Google-Smtp-Source: APXvYqzegCxJYokSIFLdFNcsQ5hduGvbek0AbObhZQnUPnuTQ7IwQ4pkC8mnHCuGhr5jfepvFOz3+w==
X-Received: by 2002:aa7:92c7:: with SMTP id k7mr3844330pfa.8.1578471464268;
        Wed, 08 Jan 2020 00:17:44 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id j38sm2414849pgj.27.2020.01.08.00.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 00:17:43 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:47:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200108073500.ir4nvvzlz6z7d22m@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-20, 20:36, Michał Mirosław wrote:
> -	/* There should be one of more OPP defined */
> -	if (WARN_ON(!count))

Okay, you can remove the WARN but we don't need a lot of diagnostics around it.
Just print a single error message and drop all other changes from the patch.

-- 
viresh
