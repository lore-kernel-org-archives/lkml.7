Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE0BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A665206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VnFNPKri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfLPO4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:56:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40878 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfLPO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3zBj6S7cwbWsVQLzYyhiT0zmek9MdQQXjrf7Gfxlmzw=; b=VnFNPKriAgQmCyl15gxSVX3YB
        x5wY88163f3vdws6jQCmIRIcoVWVIP1jmmizGcloh1h1pjbY7NDl7QkStx6Q79sXFyMiHkttJLG+D
        GBroGHysoJJ/uMBZcKsBrVq99ue8WOICC34fYah2Yxrc0fJfmFgbPoUuOasexBKpPI7vHkr+3rAPo
        Fv6Z/DnX/8Vy+cCpNlAJKFrfjGypC1gL8AB7fmgkYTy1rlb8EmNKeLCk2IyhRPDYdkwx7qh5pDovv
        8dBQSKddWrGtH76Fr6pjEtSMTARixsEHrhFyw0UFhRdMvcag/rbr8KSIH9II4hBoLeQAhdvhFyqwi
        78jOHqVkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igrnO-0008Gz-CK; Mon, 16 Dec 2019 14:56:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B39C3035D4;
        Mon, 16 Dec 2019 15:55:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6CC62B2A1918; Mon, 16 Dec 2019 15:56:24 +0100 (CET)
Date:   Mon, 16 Dec 2019 15:56:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 0/7] Introduce Thermal Pressure
Message-ID: <20191216145624.GU2844@hirez.programming.kicks-ass.net>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:11:41PM -0500, Thara Gopinath wrote:
> Test Results
> 
> Hackbench: 1 group , 30000 loops, 10 runs
>                                                Result         SD
>                                                (Secs)     (% of mean)
>  No Thermal Pressure                            14.03       2.69%
>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%
>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%
>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%
>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%
>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%
> 
> Dhrystone Run Time  : 20 threads, 3000 MLOOPS
>                                                  Result      SD
>                                                  (Secs)    (% of mean)
>  No Thermal Pressure                              9.452      4.49%
>  Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
>  Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
>  Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
>  Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
>  Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%

What is the conclusion, if any from these results? Clearly thermal
pressuse seems to help, but what window? ISTR we default to 32ms, which
is a wash for drystone, but sub-optimal for hackbench.


Anyway, the patches look more or less acceptible, just a bunch of nits,
the biggest being the fact that even if an architecture does not support
this there is still the code and runtime overhead.
