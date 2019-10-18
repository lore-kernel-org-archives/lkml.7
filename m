Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77C4CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984CA2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lziqmfp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409550AbfJRE5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 00:57:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbfJRE47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 00:56:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so2636354pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 21:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4JOjG0QUc189P6/WaRSOoK29dlyby423TPDBlUfjjUI=;
        b=Lziqmfp58ruDPDlAnaXX9i3ImvrJ8f7RhL0uRY6ovTLudo2mORUTvpbSWzM8/XTFPO
         dFk8WHRs3OF1tEwWHvb5wuKYHlZxMfAclM17/kR0QbxAuHs7cADgAJjT9R1tHPgjrTnM
         xjiO0KIFnQ7x6SlBm+hzBJRqmoyBnMOnImt+wR3FFhuS3wSEn1dLHiMzmktM4NPZVdRN
         WbHdFR3JDDRHZdjoaQCCVz0Dk1C3wyUMSqNmcQKVoe8DL4xYTP5PfAInbys6MErXbD63
         XO4rlKOJ4DA9Rc1pmJIHasULYT7aZfsuszsQdsQl1QMr6HTEFVABmCyYEKW7g+GaCzgO
         pYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4JOjG0QUc189P6/WaRSOoK29dlyby423TPDBlUfjjUI=;
        b=c1Q132Naw+YwgoyPUnLq/o7TGo6JHwAax5Vr5WhynfHeAXLGwM2Z9UiGGePNmVyLtQ
         +jZevlX+MM1FuI+tpTQeMoPgy4JfvuWcsDIaL1RGZgBOpRrX1ScFfVqe0svwbb6dUnMo
         rT6W9yCGEcbRUwNeWYaQb5YKEVeKS9H7Ws7d6UVbV0Kuuq7YfvnvGRbxnxf5k2laYndV
         E97hCcG841+WFR17RFbwECEweDPPyYQ18IQFMQwfd8ALanRl04rHzqDWwEI41JAdjkkM
         +3D6AMic81zDtroRHCEaEqBKwSyCy3fA0l2/7NmoWk8BF20sr+zUZGsONcm9in8x0ByA
         8vnw==
X-Gm-Message-State: APjAAAXXwru0BD+6PjqI/8fVjP5TJ4V16G/6QNhR2iL7S4fHOiI7Sszc
        s5PFUDv9QTJ7hjolHqn8BwbdN2QPWFE=
X-Google-Smtp-Source: APXvYqyuPtcqnmg+CxjS4b/CVJ38AAAsq1UNlBTr0YiXF/SJVY0vvLvaK1ceDkGa1t8Y8jOOs66R6w==
X-Received: by 2002:a63:3d41:: with SMTP id k62mr7844596pga.129.1571374241418;
        Thu, 17 Oct 2019 21:50:41 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id q2sm8125639pfg.144.2019.10.17.21.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:50:40 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:20:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpufreq: powernv: fix stack bloat and NR_CPUS limitation
Message-ID: <20191018045038.cytb46msqzmu4age@vireshk-i7>
References: <20191018000431.1675281-1-jhubbard@nvidia.com>
 <20191018042715.f76bawmoyk66isap@vireshk-i7>
 <c3f16019-5724-a181-8068-8dda60fb67fa@nvidia.com>
 <20191018043856.srvgft6jhqw62bx3@vireshk-i7>
 <a4a1467f-2c92-34f2-a8bf-718feaa17da7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a1467f-2c92-34f2-a8bf-718feaa17da7@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 21:41, John Hubbard wrote:
> On 10/17/19 9:38 PM, Viresh Kumar wrote:
> > On 17-10-19, 21:34, John Hubbard wrote:
> >> On 10/17/19 9:27 PM, Viresh Kumar wrote:
> >>> On 17-10-19, 17:04, John Hubbard wrote:
> >>>> The following build warning occurred on powerpc 64-bit builds:
> >>>>
> >>>> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> >>>> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> >>>
> >>> How come we are catching this warning after 4 years ?
> >>>
> >>
> >> Newer compilers. And btw, I don't spend a lot of time in powerpc
> >> code, so I just recently ran this, and I guess everyone has been on less
> >> new compilers so far, it seems.
> >>
> >> I used a gcc 8.1 cross compiler in this case:
> > 
> > Hmm, okay.
> > 
> > I hope you haven't missed my actual review comments on your patch,
> > just wanted to make sure we don't end up waiting for each other
> > indefinitely here :)
> > 
> 
> Ha, I did overlook those. It's late around here, I guess. :)

Good that I reminded you then :)

-- 
viresh
