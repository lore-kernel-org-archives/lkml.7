Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13C8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781CD217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1LdET+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfGQKOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:14:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32824 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfGQKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:14:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so10618175pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PrtH8Kksib4dUXTG8vDDfJrfFptIvUSjdQBJsI2iu0I=;
        b=f1LdET+KRqIqj9PnA29N8nNQaxzbjiZ1JbKHviB/BsS+AsQOPL4XhHv2A4MUIeQuvc
         F+gYsmL0JB7hb85aYAftvNVt3oyy64kpgQSawB3nlXdZ9N6/Z+QyXLQHhvMms0O9aiiu
         NOpnPL6tFJ5HCABcFOMbcFOjP63kP8qNSOlsCzyWQmFyVPDpdL1LUEqRGuuNPKRNP3hD
         R1uWasEL3FHU1fmMNPabLuVF0rpSlM5z/Di3BmBIh3DA8niPmOkVE4S6E8coh6tbuzcE
         Cp9i0nNJNQx2wB/pyblAm8KxortM3KD83m5NsqibpBGKyLrKyv5quGCchOTw5kRpav7j
         giPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PrtH8Kksib4dUXTG8vDDfJrfFptIvUSjdQBJsI2iu0I=;
        b=OAs1S7/8lsiOp6SkAjh4w0kI/DOxgg/ojKQq3t2Of3/6T/zYfdIrAO7djZ2LeALxGU
         G1oXkqTDS7v001ikBwcq9J7h8TDCUFFwP6pWxBCpDF4DouluGuYR202FsqIw2DF+BLW6
         9Iz84M7g67Ih/hvvUd+q4P+RuBG+EZBmGp3PwHyE/WRk2kEMFLkmk8nkhuv7CGOFqeQH
         O2qpKqnskN0LHHF2VXi0B/DLk8ARQVbrvahdixiEN26pnvPMQ12flVz77WDWgfqCeYB3
         K3XxxrE9OHfngYQNeV9PLw2EK6YRZWVgpQ6WTg59JNjSzhzUM+6yqzURTr6Ac9goE7a1
         JMGQ==
X-Gm-Message-State: APjAAAVzkrbQdkDSA/xIVgxUIbpSjWsvq5Mzu43/L/GIiV+1eWvcfDwl
        nNiuHocxUSK2sUurOEd9rTgeCw==
X-Google-Smtp-Source: APXvYqwgDelo1R0pRbDg83TwcxWu53VaHcsIJ299vAGkcFkrH9OXpupDlA5aqqlZy1Ny7BKUMPBgCQ==
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr42202505pje.123.1563358447438;
        Wed, 17 Jul 2019 03:14:07 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id i3sm25297361pfo.138.2019.07.17.03.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:14:06 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:44:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Return genpd virtual devices from
 dev_pm_opp_attach_genpd()
Message-ID: <20190717101404.a7p5zjweq5m22vf5@vireshk-i7>
References: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
 <2ed7993d-523b-270a-2be9-83ad2426e946@codeaurora.org>
 <20190717054713.vn65cfiqebhzdvjq@vireshk-i7>
 <2fbfc0fc-7d61-bf8c-67de-28183d03e26a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fbfc0fc-7d61-bf8c-67de-28183d03e26a@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-19, 15:34, Rajendra Nayak wrote:
> 
> 
> On 7/17/2019 11:17 AM, Viresh Kumar wrote:
> > On 11-07-19, 15:09, Rajendra Nayak wrote:
> > > Sorry for the delay
> > 
> > Same here :)
> > 
> > > I seem to have completely missed this patch.
> > > I just gave this a try and here are some observations,
> > > 
> > > I have a case where I have one device with 2 power domains, one of them
> > > is scale-able (supports perf state) and the other one supports only being
> > > turned on and off.
> > > 
> > > 1. In the driver I now need to use dev_pm_domain_attach_by_name/id to attach the
> > > power domain which supports only on/off and then use dev_pm_opp_attach_genpd()
> > > for the one which supports perf states.
> > > 
> > > 2. My OPP table has only 1 required_opps, so the required_opp_count for the OPP table is 1.
> > > Now if my device tree has my scale-able powerdomain at index 1 (it works if its at index 0)
> > > then I end up with this error
> > > 
> > > [    2.858628] ufshcd-qcom 1d84000.ufshc: Index can't be greater than required-opp-count - 1, rpmh_pd (1 : 1)
> > > 
> > > so it looks like a lot of the OPP core today just assumes that if a device has multiple power domains,
> > > all of them are scale-able which isn't necessarily true.
> > 
> > I don't think a lot of OPP core has these problems, but maybe only
> > this place. I was taking care of this since the beginning just forgot
> > it now.
> > 
> > What about this over this commit:
> 
> Yes, this does seem to fix my concern mentioned in 2. above.

Great. I will include your Tested-by:, Lemme know if you have any
objections.

-- 
viresh
