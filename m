Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D8CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6115E20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wnTqEjP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfJ2RlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:41:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45911 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbfJ2RlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:41:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id c7so8895819pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7xSEaHgPrL2UMVtxpL/QZyWiD7SSfTEWfSkyz0gH5eU=;
        b=wnTqEjP2Tr9b5JhJyLAz1L4c7C4QhzqJWcOY+tdXJYJElTH10oMGQKbeC8gEGeBUQ5
         +ZvVFkcSODbxuaTDpe6rNxjMftbhaKWI67YeVSEffZFgXWUNmPRKLIjG3PsgaBf5EBsV
         CDiIZGcJ4ucM39YfWheBfyk+rAm84/Nfl5TauR91/IC9moGCnGEC46jgKz0OWmH+6/H/
         8WDG665mJuuBWFUwhDE8IbfluKH90ODUX8xAIuMYVFnrxWvxdEkko0n3eoOVsFHoOUjP
         uvH16Yh2SRkrErzDMgMm8PcAS0FF7bpOp7W0rB7eEHO6fZ8ebQoF/dmUEFxfKFhH56V+
         Mzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xSEaHgPrL2UMVtxpL/QZyWiD7SSfTEWfSkyz0gH5eU=;
        b=Z+wCMbuOXBVScrfeP029e0w4z+oaT9U+mC0hgRnV9SC9yedM4RY8Gh8JKb+u58phIE
         aXVgCAzXBufRSrdCh4I+X3ZVilXyPh2fMJFoA+7cZ89nTCxOyzO/NUAHV2SI0ww1/BtS
         g/K/NXpKqJF/xeT2xzooXQ8X0wNB66+e179RTuJZKb6v8NPlUfUtih5LhouHcZMjH7dG
         owj1o4ctFcyRIgLVOuQBH+ZHPyk25w272bAhX2gyY3sw5TClqai2sNc9sqWJfaUDs1VV
         qZBJwdEDGCS0ML719N29WM0a9vaXy81taraunz+Y1P+x1br2aOooQO5LJrgUs7tB8cPH
         /a+A==
X-Gm-Message-State: APjAAAX1LkmkG5SLM5uqiqCuuMscbNeQki85V+XspDI9UayiKHaqFzUw
        17zG60AQ2l8WwQzcBYoeocCpIw==
X-Google-Smtp-Source: APXvYqyd4hqnHPf92+j9leQi9Xj5QEv/PWa7fTRzsFDdaeWRUCsbNJ3+iDfBuDtveWhmFNd+HdMKNQ==
X-Received: by 2002:a17:90a:5d04:: with SMTP id s4mr8087919pji.125.1572370868152;
        Tue, 29 Oct 2019 10:41:08 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h186sm17651256pfb.63.2019.10.29.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:41:07 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:41:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] arm64: cpufeature: Enable Qualcomm Falkor/Kryo errata
 1003
Message-ID: <20191029174105.GZ571@minitux>
References: <20191029171539.1374553-1-bjorn.andersson@linaro.org>
 <20191029173915.GC13281@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029173915.GC13281@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29 Oct 10:39 PDT 2019, Will Deacon wrote:

> On Tue, Oct 29, 2019 at 10:15:39AM -0700, Bjorn Andersson wrote:
> > With the introduction of 'cce360b54ce6 ("arm64: capabilities: Filter the
> > entries based on a given mask")' the Qualcomm Falkor/Kryo errata 1003 is
> > no long applied.
> > 
> > The result of not applying errata 1003 is that MSM8996 runs into various
> > RCU stalls and fails to boot most of the times.
> > 
> > Give 1003 a "type" to ensure they are not filtered out in
> > update_cpu_capabilities().
> > 
> > Fixes: cce360b54ce6 ("arm64: capabilities: Filter the entries based on a given mask")
> > Cc: stable@vger.kernel.org
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Suggested-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - s/ARM64_CPUCAP_SCOPE_LOCAL_CPU/ARM64_CPUCAP_LOCAL_CPU_ERRATUM/
> > - Dropped 1009 "fix" as it already had a type from ERRATA_MIDR_RANGE_LIST()
> > 
> >  arch/arm64/kernel/cpu_errata.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index df9465120e2f..3facd5ca52ed 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -780,6 +780,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
> >  	{
> >  		.desc = "Qualcomm Technologies Falkor/Kryo erratum 1003",
> >  		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
> > +		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
> >  		.matches = cpucap_multi_entry_cap_matches,
> >  		.match_list = qcom_erratum_1003_list,
> >  	},
> > -- 
> > 2.23.0
> 
> Thanks, I'll pick this up as a fix.
> 

Thank you!
