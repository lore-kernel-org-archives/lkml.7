Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF09C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90E5262EC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBsnocer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEaD3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:29:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41122 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfEaD3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:29:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so3198253pgp.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xnqDdr2i6Tf87P3bIRZEuiZG4fUxfuReHxw3r4p4RC8=;
        b=fBsnocer8Eo0a/7ZyEvb77ep2wXmQNF2ddphCXGtR0y5+sn6HIoTt0yVC4KOD8cUxa
         qXpIgccbgPvVe0OnwST9m/M74rcUUFM/XwjAYZr1xb8t27cdRD0OlNqZQ+VqFd/e4Ixl
         tOqjZIVNDeucsAkU58TcyLlAatlIau55Lt3MT2Amo71qNoLEw84wREUslV9JuGoSVFVE
         xSehbwGds3LND33ak8RKrLpFC0s1lF7SHrHJJLfMUZIUJ7KNICNCjxxnqIhfAc+yuJ+J
         KynfcJXonA62yial/IHpza8IKPtVNPB3YrAbJzKMUQa74uGzYNrDQaKx2mKHoD+Scaue
         LofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xnqDdr2i6Tf87P3bIRZEuiZG4fUxfuReHxw3r4p4RC8=;
        b=uQtB1rrywSb5fiqE1UxNiJ20SNBMR+TzE0vfP7/BBM1gxxhbguMP4ltyFObNKZg3CJ
         6aGcJtDFNAKtB7SrWsDosndRsxWUpvuyeU/Mt16pvW7WCgehqRon+pttgP+Ik7CvKb22
         E4YNGX1/SUyLtccZv3Yzj4jqnoWny5jVlHQdPFOFovOBGiG8FEIcuCxkdWMIZDzSygUP
         Ky7E006Hnnwc7wMhZ9JOhLOe++plQ9wkLTxgtAChaHKqUT7RzhGjPXkjn1IvMuZ7a/XL
         UHLzwyzqJFNS/j9ke0/488pukYsxNTjgG1c7Um/WT8delYsdiUJx0VU+9XnhVA/c/h4d
         5PdQ==
X-Gm-Message-State: APjAAAVhYXF9BEU6gKulF75LHXqvQbR1KFQZIC7v+Eh16lGcs78q8WSh
        fbZUiYJ5AGpHJNBr4NKt5PPlMA==
X-Google-Smtp-Source: APXvYqxsTLouYZB3eteNn2krrJisXBfEBpoWYOTWJAM8j6ndwI/IhwV6+UAuPkSBV5p5JJAAW7PeQg==
X-Received: by 2002:a65:620a:: with SMTP id d10mr6784558pgv.42.1559273340471;
        Thu, 30 May 2019 20:29:00 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s134sm4959835pfc.110.2019.05.30.20.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:28:58 -0700 (PDT)
Date:   Fri, 31 May 2019 08:58:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190531032854.m66ugtyjyjnksrqr@vireshk-i7>
References: <20190530092038.12020-1-quentin.perret@arm.com>
 <20190530092038.12020-4-quentin.perret@arm.com>
 <20190530112747.nlfyctzjkz5lak7o@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530112747.nlfyctzjkz5lak7o@queper01-lin>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-19, 12:27, Quentin Perret wrote:
> On Thursday 30 May 2019 at 10:20:38 (+0100), Quentin Perret wrote:
> > The newly introduced Energy Model framework manages power cost tables in
> > a generic way. Moreover, it supports several types of models since the
> > tables can come from DT or firmware (through SCMI) for example. On the
> > other hand, the cpu_cooling subsystem manages its own power cost tables
> > using only DT data.
> > 
> > In order to avoid the duplication of data in the kernel, and in order to
> > enable IPA with EMs coming from more than just DT, remove the private
> > tables from cpu_cooling.c and migrate it to using the centralized EM
> > framework. Doing so should have no visible functional impact for
> > existing users of IPA since:
> > 
> >  - recent extenstions to the the PM_OPP infrastructure enable the
> >    registration of EMs in PM_EM using the DT property used by IPA;
> > 
> >  - the existing upstream cpufreq drivers marked with the
> >    'CPUFREQ_IS_COOLING_DEV' flag all use the aforementioned PM_OPP
> >    infrastructure, which means they all support PM_EM. The only two
> >    exceptions are qoriq-cpufreq which doesn't in fact use an EM and
> >    scmi-cpufreq which doesn't use DT for power costs.
> > 
> > For existing users of cpu_cooling, PM_EM tables will contain the exact
> > same power values that IPA used to compute on its own until now. The
> > only new dependency for them is to compile in CONFIG_ENERGY_MODEL.
> > 
> > The case where the thermal subsystem is used without an Energy Model
> > (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> > frequency table which is already a dependency for cpu_cooling.c anyway.
> > Since the thermal framework expects the cooling states in a particular
> > order, bail out whenever the CPUFreq table is unsorted, since that is
> > fairly uncommon in general, and there are currently no users of
> > cpu_cooling for this use-case.
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Viresh: the patch hasn't changed much so I kept this, but please shout
> if you're not happy with the new version :-)

Yeah, it  looked fine and so I didn't complain :)

-- 
viresh
