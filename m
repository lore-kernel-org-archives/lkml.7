Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96758CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6404721835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAJAZ7ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409609AbfJRFHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:07:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46186 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405806AbfJRFHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:07:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so7297469qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BZNeQBeDGAyLMoRdSAbVO0kzqdA4HOw3dFZcIwAbSRY=;
        b=bAJAZ7tswXf0oXbHqjYQDAMHA3fSiDLD+u26iHQS3x7Py/AcVrPNdS1oryA/TMrWe1
         C9PD+y8lawPz88eAyR5kk9Ml2o0a2TFQNKQxu5nv0Wko1NLrNPGhbDP2SiubBiHlhq0v
         1/91vfMvcO6zUodpEcXtTf8sait3hj8kvN3nmEjjbwNbCByc65QH7tQoCwZ/LtTheEIu
         JSQoVll7PmAV+02dufnMm9xRZK1sROHW51Meb3G071rNEmxfzM4+2ywSAAVe158ND1G1
         S0cq0spmyRYEcz+YmtAujZEgme/2JwqP/4M5ouQeOV35ynsE5W8NRjmV3HAGu0kn5htQ
         A4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZNeQBeDGAyLMoRdSAbVO0kzqdA4HOw3dFZcIwAbSRY=;
        b=JAM7FC45Oab5yge2AiY8kUntMsc3cTMdnybx/hX3p5TGWGq5O7OuL/yo9YfMEqpgS+
         Z0Xs4512cCKhDwh6a37aqQ3p1bsui+yrTgDWusw5ckjFa4h0vT8dyBPP3fBWoWN55Ake
         VnUHsZw/wx3q3Ohh+Lu/wSDpAXVhcmjFDMqkZZKzs0f/X89YKpWV7EbVV/5j/xKA6l8O
         7hhTzcjL5u5rf7a5FXYHlpQdHbUsUQRHgLW7F/ALZSgZtPJwcoADt0F6sQIr58QspBqy
         U55SRSGsMf88WphTLJe64fP1ystyn3HDS8jnqskAPAaETFrKd6Tw5dXjuntpy2Fnlor/
         HCag==
X-Gm-Message-State: APjAAAUKZojKRHn6fEfBSUURciuFuKzxsS7lrPqxJ9B0Xhsoo8W3VqkP
        I/diyL7sjFoVUG+4xV5+yvjSlvuKjfE=
X-Google-Smtp-Source: APXvYqydfwa25JKZYYeWbwxFsqUZQ8NzYboAYSS65MWiR5DAcXqWJJZyILycxPAp3epGgyJMNw3bqA==
X-Received: by 2002:a63:1b59:: with SMTP id b25mr8029273pgm.267.1571373538882;
        Thu, 17 Oct 2019 21:38:58 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f185sm5139382pfb.183.2019.10.17.21.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:38:57 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:08:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpufreq: powernv: fix stack bloat and NR_CPUS limitation
Message-ID: <20191018043856.srvgft6jhqw62bx3@vireshk-i7>
References: <20191018000431.1675281-1-jhubbard@nvidia.com>
 <20191018042715.f76bawmoyk66isap@vireshk-i7>
 <c3f16019-5724-a181-8068-8dda60fb67fa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f16019-5724-a181-8068-8dda60fb67fa@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 21:34, John Hubbard wrote:
> On 10/17/19 9:27 PM, Viresh Kumar wrote:
> > On 17-10-19, 17:04, John Hubbard wrote:
> >> The following build warning occurred on powerpc 64-bit builds:
> >>
> >> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> >> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > How come we are catching this warning after 4 years ?
> > 
> 
> Newer compilers. And btw, I don't spend a lot of time in powerpc
> code, so I just recently ran this, and I guess everyone has been on less
> new compilers so far, it seems.
> 
> I used a gcc 8.1 cross compiler in this case:

Hmm, okay.

I hope you haven't missed my actual review comments on your patch,
just wanted to make sure we don't end up waiting for each other
indefinitely here :)

-- 
viresh
