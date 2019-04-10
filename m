Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C0420820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZToZX0v5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfDJLZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:25:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35320 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbfDJLZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:25:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so1262454plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 04:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V3z7E7vX/Yop5BjoNAELE+MNr+7RAoBt8v/LxIDaicU=;
        b=ZToZX0v5Ywv/bYGEbS76SR1WMuRCLI6Pq9LSQjhXvgh/+ZSkQYls5KVxFZMOdSVfVv
         NHktkpdN57vba5AeU0iKVS/HS0+JgSjCP6rxrQY/wjZxQk3urbs0ivwunEKwYzQGSx9Z
         KmAkCiJalWx9/Maf4vR2kyJNlrJo8MSll4SDHJ/snVDkniy9tbBkepCG8fnKoE7Q4S7+
         sXFQNxIzFcHZBuo48nH5SFOJ0/+WAn2jWQXR2WB9lKd/qZsiRGUXCqzMNjLtFxHGbw2m
         4FeZfuIecNMJPwwnmrnHGGZ57vZ0EHdLFn4734Ls/0DB4Q6iJfVI3yW4DQKlluQfLkIw
         6mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V3z7E7vX/Yop5BjoNAELE+MNr+7RAoBt8v/LxIDaicU=;
        b=DKemW6ZVUBmavmGjktSl4OLDApFTtZjYjTKneEqhMBlukA67Bx855IctiCCGPoTAYn
         T5jBstzfc+tUjmeuvVX9jSGFcQaLbYoj3CvEfy2rS3Qsr6AmxW09UkRvioajr3e35wfF
         3QoFyhOrMITSZw8bhzlBXoWSu1do6rqMIkkh+aUDvttn5TO+GXH1RIWu5sCtc2P0SuPK
         1JsFd5vkfugVK8OvIt58duHmq/oC6JdeFfhBd2rhHMspO9TNXHd5brhPRwGv2DOwROB8
         WI8X1o026OIFfD13X7ox+rxdtzq8fILOF+JihBoQUptZ0rMEMnPvZKFJk+w/NZwt/v4Z
         AOgA==
X-Gm-Message-State: APjAAAWwUGnp0ux7UoJfUlMH3bDd9/oZr2L2ImZR1/0/Ga72GTIiw/5b
        1dOl8K9WCcwf/ZbFmlJuwVIcsA==
X-Google-Smtp-Source: APXvYqxw/YUYIePFPiXoRZJiS4wi+DzDsqRkwRSvfWgeItOfVi7JntKqEeTP6pmIZ4zff65HZjm1bA==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr18372983plr.185.1554895519707;
        Wed, 10 Apr 2019 04:25:19 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id u5sm10732753pfa.169.2019.04.10.04.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 04:25:18 -0700 (PDT)
Date:   Wed, 10 Apr 2019 16:55:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        dianders@chromium.org
Subject: Re: [PATCH RFC 7/9] cpufreq: qcom: Add support to update cpu node's
 OPP tables
Message-ID: <20190410112516.gnh77jcwawvld6et@vireshk-i7>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-8-sibis@codeaurora.org>
 <20190410103316.sxev2f54klemq2p6@vireshk-i7>
 <8aeedc48150da49b7ab2ce27dd45a455@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aeedc48150da49b7ab2ce27dd45a455@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-19, 16:46, Sibi Sankar wrote:
> On 2019-04-10 16:03, Viresh Kumar wrote:
> > On 28-03-19, 20:58, Sibi Sankar wrote:
> > > Add support to parse and update OPP tables attached to the cpu nodes.
> > > 
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-hw.c | 29 +++++++++++++++++++++++++++--
> > >  1 file changed, 27 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index 4b0b50403901..5c268dd2346c 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -73,6 +73,25 @@ static unsigned int
> > > qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> > >  	return policy->freq_table[index].frequency;
> > >  }
> > > 
> > > +static int qcom_find_update_opp(struct device *cpu_dev, unsigned
> > > long freq,
> > > +				unsigned long volt)
> > > +{
> > > +	int ret;
> > > +	struct dev_pm_opp *opp;
> > > +
> > > +	opp = dev_pm_opp_find_freq_exact(cpu_dev, freq, true);
> > > +	if (IS_ERR(opp)) {
> > > +		ret = dev_pm_opp_add(cpu_dev, freq, volt);
> > 
> > With my comment on the other patch, you can just call
> > dev_pm_opp_update_voltage() and if that fails then call
> > dev_pm_opp_add().
> 
> yeah that should simplify things.
> 
> Also through the above approach I cannot
> really disable opps that the OSM does not
> support. I can only try enabling opp's that
> OSM supports. But that would require all
> opp's nodes to start with "disabled" but
> that is not allowed I guess.

Yeah maybe add all OPPs from DT, disable all of them and then only modify and
enable the ones you need.

-- 
viresh
