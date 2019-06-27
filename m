Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FAFC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6954F21851
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ofOF3Pcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfF0CeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:34:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43546 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfF0Cd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:33:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so624173ljv.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YqSJkouCdbmz4bvieX9MmvoCdaOvWPYtwXCJEllW7aE=;
        b=ofOF3Pcn7Fsnx8bfodWEdspjWibel0QtIkMI76mLhMU7ufARyT4XCtgDrRSrGGAaPH
         K81LLtmZ6Cxq4q9nNfAoZuEyOD+4GJ++Q3J2LwIOnvLbG2irctb9GISDQhF2Rv4Y+TKM
         PxT8lCnp17sR7UZqooYTXhH7Q0sMtRDufezoy1+MEK2zb44VvZ7A9W4XkzsXk1N4fscL
         Lr5vh7kbqV6fBSWJSEFgua0OQFEokSfI9D59D+DB/iOunGtmjf5z/bLOCuGuD9/fHEZ2
         85jcYLHjrUu26mXDn0xj9dm1tu1VJ2S2KDh2G/fH2S2IcQ/R7XyzAm98dVUB1UBAKBD9
         PUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YqSJkouCdbmz4bvieX9MmvoCdaOvWPYtwXCJEllW7aE=;
        b=FhJCL7CVCEGqJMKQmIjmFm+NJ3lr4RNe/1Zg/y9wypyM/rV82jUbNscl0C6uyjlFmk
         /sR8bTuQK89LrXv2fX2xw8tVtQmfSwZ56x0H77TDA7qfjYHH80Tdbo5+GcPoImji/8f7
         VFrRe7whzls3u2/jiqxWEoseRLqpUFHwiaHEJwAZuCKfXKuPNSR0dCiya5gCUK2Ihe+b
         ztv3YZAwcg0zky4iLbhWlGUrpbDL0VvxepTuhBXkoKP/j6ctjNs5EZnXpCjcedFQk9NH
         znokwm7EK/m1xIe5Z5Hsa2Op+EjBhoVGV1pdpP2t+3eF+63nsG6f54bTXqHw6MpIBhIT
         cygQ==
X-Gm-Message-State: APjAAAWFpwjZdzxuJoKuonNQQ6B+tpf/vrMbsiksK/kISRA9j8gHpCvM
        ObETZpRugnH1jlQ7C7xqbL1AjQ==
X-Google-Smtp-Source: APXvYqzUo/OMOEtxCgRTsVH9uHTyjCrqs+2MYNudDPes4ncQUwwtP9ffEH64O9IdQtyZOyUc3YK1nA==
X-Received: by 2002:a2e:7c15:: with SMTP id x21mr872691ljc.55.1561602836467;
        Wed, 26 Jun 2019 19:33:56 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f30sm106397lfa.48.2019.06.26.19.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 19:33:55 -0700 (PDT)
Date:   Wed, 26 Jun 2019 19:24:23 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 3/4] arm64: dts: exynos: Pull for v5.3
Message-ID: <20190627022423.u36lomov33w3smtr@localhost>
References: <20190625193451.7696-1-krzk@kernel.org>
 <20190625193451.7696-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625193451.7696-3-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:34:50PM +0200, Krzysztof Kozlowski wrote:
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.3
> 
> for you to fetch changes up to 4dc2a25d058d71f39e41da986777327b423b92f1:
> 
>   arm64: dts: exynos: Add GPU/Mali T760 node to Exynos7 (2019-06-24 19:52:48 +0200)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM64 changes for v5.3
> 
> Add Mali nodes to Exynos3 and Exynos4.


Merged, but updating the message to Exynos7/5433.



Thanks,

-Olof
