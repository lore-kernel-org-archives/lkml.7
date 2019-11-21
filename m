Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC04C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D1D20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyrzdxQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfKUGIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:08:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35648 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUGIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:08:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id k32so1056918pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 22:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qO7u8hMCBA9SR1J8X70ILGB8LRQbTCIm17ibyeXRY3c=;
        b=TyrzdxQXnNUgWQc1dpvekmYvS/uKbLc1vemjBPsTKuV73FDqDCSImOhogREpg5aGs5
         KX524hE43gkQ+ThP5OqT7ZzIPehYhI9IDZ1i6JORbhkyFvMn3oJUbt5JijCLaMIXqflk
         tLZ/1frRKDHBRZlMWuVDzRaNB2+8ZI9R0GeXS9nkyyJdl+Gb2zMCYvh8mqT3MbPe3BBh
         nF4ErfriXVVhYs1jnI2983PTr00uFZBISu5BwDI2FMZDud9H7j98U2BEZSwV1nZID0e/
         BNND+yABoFY0g3cvhUkjAT2CgwSqguAPIXm4uFHWT/f3ha0NSdnFeiZWu3ujfnJGvmuz
         xgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qO7u8hMCBA9SR1J8X70ILGB8LRQbTCIm17ibyeXRY3c=;
        b=HsRkFEuAWrlnh7s4w0Hl6L0bAccAcFHy1o82xWQmAUupmAVB9aH7rkG4z08enO3Uv5
         wuf8SGfdh9RbRZ23eL2ZdK1VUT2zz1fEhmSVBBhN82IE8sulWze4An/qfYnaVBaKJowm
         U4g9Tuv8q6t0ZHC0neRr88EvCNYMLfOMLWWgYg4tlaru85AsdVOMyQAgi8OFPBWti1gk
         oYFIbhdRe3Cqhbkl7FKvo1F543XCCF5hDp6nutpUhPeWr/4ExcVH/YpvgXsC/Uwxi8Le
         s8XQOThxf9G20NX0mECBcAcEd1p+DJqjW4j76kirRetM3i2Nykxz6gpFH84skk1pKo+W
         nY8Q==
X-Gm-Message-State: APjAAAX7HkrXLHbw49w3JKKEqNTdas1iiUvwng9DbWblazFkxc53NlSw
        8EpdJH7i9q9vUNSLWeV6qh4nwA==
X-Google-Smtp-Source: APXvYqxDShr6iCwpcYfxVnrwCEYPFKwevNfQ4b3B5HfbCIH+GrMWSCxT6cdvpx0gPiliheSK79rerw==
X-Received: by 2002:a62:83ca:: with SMTP id h193mr8625885pfe.218.1574316495041;
        Wed, 20 Nov 2019 22:08:15 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id w62sm1598080pfb.15.2019.11.20.22.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 22:08:14 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:38:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sasha Levin <sashal@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        Niklas Cassel <niklas.cassel@linaro.org>, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
Subject: Re: stable/linux-4.14.y bisection: boot on odroid-x2
Message-ID: <20191121060811.mvzzh4zlfzlubzlv@vireshk-i7>
References: <5dd5fbf5.1c69fb81.0938.8061@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd5fbf5.1c69fb81.0938.8061@mx.google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-19, 18:52, kernelci.org bot wrote:
> commit 714ab224a8db6e8255c61a42613de9349ceb0bba
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Fri Aug 3 07:05:21 2018 +0530
> 
>     OPP: Protect dev_list with opp_table lock
>     
>     [ Upstream commit 3d2556992a878a2210d3be498416aee39e0c32aa ]
>     
>     The dev_list needs to be protected with a lock, else we may have
>     simultaneous access (addition/removal) to it and that would be racy.
>     Extend scope of the opp_table lock to protect dev_list as well.
>     
>     Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

@Sasha: Please drop this patch for now.

-- 
viresh
