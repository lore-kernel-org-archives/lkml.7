Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8551CC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC222DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bm7qZSrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfHTJVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:21:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41253 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfHTJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:21:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so2877036pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fNqn8jt+Eu/y3WAdZBc6pAlsOtl2wpEF2Ezb9uPuzFs=;
        b=bm7qZSrIUp7yfrt8m+6HQ+L0yN+04ev62t82CQ5xfoJbY9ugfFikx3iuSAvbmhTpFg
         1rxCbeHAR9Yu74VEgkJ/NCLgBT+vvo46ilJ0GSi92qPvxRlB4whvjXoc0KTkpOWQQgth
         qHRZAzKAHBUuasKjsfEeXe8lbZldF4DJ8J4+fVY3UScx6BERp1etA4IXQR7Ty7i4yvGe
         GG5Y8GAYJjCuT2VFdOToY7CULRMaHMOvOwvCYmaP3dd0e6/JUxXu0My+AxDtBeAUHgA4
         HIeSRSxc5fq+Q31UyD5zpQ+J3dGEIHWJy22zqGq1wz+N5seTYf3befQt64QvzxF46OLw
         Va/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fNqn8jt+Eu/y3WAdZBc6pAlsOtl2wpEF2Ezb9uPuzFs=;
        b=Qqw9ibDwy5Q3Uk0bo3vplUTZ/xhNMeKJ1kPHckTj0XXjzy6tODwj0Em/whso5uGQwk
         n7j/z1jlyNs3zEQZaPTvXA9y1U6+Ds9EFgSdfUowG8Nkrw0X4qVQUT+Zoly59Q0Wr22C
         Ff8zxgmgcHlRq9mwQhHhllazZFP1aba8h7YPo5XQ22afOZkMHtipUNGM7Oh1Mmu6U+BS
         viOtShzyxADTFIL/ZSHBYUqjJxpFE2dml43ktBJM1u7nFM9OlrOYSUs/EwmeoO2U3KfT
         AgHp2XNImOM5KfU+O6IeKzJQDJa2Ta+CgvnxJfNIy4YUQaoaWBvpWLWZJyBpeAm+uwHQ
         XBqg==
X-Gm-Message-State: APjAAAUimjR5Hy7QOwJcuESuax6uaSWE1qaSIjArv/wdGKTZOQmt0e+k
        5jjRgl6ztLyN36IGAuj+QRTfuA==
X-Google-Smtp-Source: APXvYqx3NGkLs8NsqtiC35VhZLducwJHY2iFYVWb66LyAIkzov9xYbt/7XwPAuKAdHf72ZcfwGfM/g==
X-Received: by 2002:aa7:991a:: with SMTP id z26mr24899786pff.43.1566292876575;
        Tue, 20 Aug 2019 02:21:16 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id 5sm17229250pgh.93.2019.08.20.02.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 02:21:15 -0700 (PDT)
Date:   Tue, 20 Aug 2019 14:51:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Message-ID: <20190820092113.gojhe3romdnvm7eu@vireshk-i7>
References: <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
 <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
 <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
 <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
 <20190819090928.pke6cov52n4exlbp@vireshk-i7>
 <b831d7c5-c830-fd65-20cf-02e209889c28@samsung.com>
 <20190819112533.bvfyinw7fsebkufr@vireshk-i7>
 <b7093aaf-ea56-c390-781f-6f9d0780bd8e@samsung.com>
 <20190820030114.6flnn2omeys3lih3@vireshk-i7>
 <06ccff05-2152-4bcc-7537-8f24da75f163@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ccff05-2152-4bcc-7537-8f24da75f163@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-19, 11:03, Sylwester Nawrocki wrote:
> On 8/20/19 05:01, Viresh Kumar wrote:
> > Sorry but I am unable to understand the difficulty you are facing now. So what I
> > suggest is something like this.
> 
> The difficulty was about representing data from tables asv_{arm,kfc}_table[][]
> added in patch 3/9 of the series in devicetree.  If you have no objections
> about keeping those tables in the driver then I can't see any difficulties. 

The problem with keeping such tables in kernel is that they contain too much
magic values which very few people understand. And after some amount of time,
even they don't remember any of it.

What I was expecting was to remove as much of these tables as possible and do
the calculations to get them at runtime with some logical code which people can
understand later on.

> > - Use DT to get a frequency and voltage for each frequency.
> 
> Yes, this is what happens now, we have common OPPs in DT that work for each SoC
> revision. 
> 
> > - At runtime, based on SoC, registers, efuses, etc, update the voltage of the
> >   OPPs.
> > - This algo can be different for each SoC, no one is stopping you from doing
> >   that.
> > 
> > Am I missing something ?
> 
> Not really, this is basically what happens in the $subject patch series. 
> 
> Then IIUC what I would need to change is to modify exynos_asv_update_cpu_opps() 
> function in patch 3/9 to use dev_pm_opp_adjust_voltage() rather than 
> dev_pm_opp_remove(), dev_pm_opp_add().

That and somehow add code to get those tables if possible.

-- 
viresh
