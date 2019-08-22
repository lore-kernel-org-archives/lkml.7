Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0766C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926DA21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6wBWaxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfHVGB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:01:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47096 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbfHVGB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:01:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so2856148pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGOK/aeV6wllM58ymB1HOVxByK2+4raXwd9FqZiG31g=;
        b=A6wBWaxdm4l0kPg3WfejXZYMtZSZkafevVrK68W4QcP39sJ+oJ3ScykX9C6MMenFI9
         AAGksjnnQmDD8Sm6eTz9jIrMjeqN02yrRa4m7Nb6In1ryQa3OGETXk1XMXgbjYuEgmRt
         Fd6rjqCxGNiBqSxHFhVFX+xzxUM2yhpqsVsqi1weXRzFmZv5RN6JBCSuQ6UR77OnGdQ0
         SkSwPHRHVM1Gob6a18uzwN1D4MTA05jQ8aNqUShPb3SVBm25EgljzfSrE84Atp07O3jv
         lBaTY1FCIcOfOji/B2qAxZjw6zDg5mNcxEnu+YIeVbDNZRJYJ0wcsKCxQVvrtaZyQ39C
         pxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGOK/aeV6wllM58ymB1HOVxByK2+4raXwd9FqZiG31g=;
        b=UyWDuvVMeYN+f6n9NOJQwb11MDRRRtNSeIgav/+3+rm9Lf9hHWa/+lpRBQx2bN5pnt
         GVtuJkKTZCEcnvBl9lbpfBDr0G5rSvpQyuaEzUt2vNeYKwtkVG/9ycQvSMUKAVFxOGkF
         23qxOAJxeiHnrjxchL7DJ6i3fkk6BA3p9f92RlSIUEeCkgfOTx2XZ1pRQA71pM5wGIJg
         z362yUeOFvM4X4cmC5dqR3AIUfyHupRflEFchTC45kofaik1EwxS6/bwLDub3k7gpkDl
         Xqq2Ir931P5iI0Dh1PBDH33JTEoPXdGtvLzF3a0Awg1gHwNzouJ9N4eG4l6/Fs8FabkU
         oz9Q==
X-Gm-Message-State: APjAAAX0xV2freu1PsJiju61D2ZjYNwaXkCX1ZdSRon7vFv6lfP8ZsOE
        8D17HL/zax4kPVvSnCW7Yq4ZDA==
X-Google-Smtp-Source: APXvYqxv4NVeiFvjfAZaGPzviWL08bYWazxBVM3wDB/0/GBKJdrmVajkKdL44cHCfgPLd9Kxn9tb6A==
X-Received: by 2002:a63:6901:: with SMTP id e1mr31280923pgc.390.1566453716840;
        Wed, 21 Aug 2019 23:01:56 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id q10sm31712808pfl.8.2019.08.21.23.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 23:01:55 -0700 (PDT)
Date:   Thu, 22 Aug 2019 11:31:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, agross@kernel.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: qcom-hw: remove set but not used variable
 'prev_cc'
Message-ID: <20190822060153.gasv4okmeuvbtmbi@vireshk-i7>
References: <20190821121445.72588-1-yuehaibing@huawei.com>
 <20190822024051.eubzzxh3b2ip2gzv@vireshk-i7>
 <6c485d00652f873b98664ff211e496cd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c485d00652f873b98664ff211e496cd@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-19, 10:25, Sibi Sankar wrote:
> @YueHaibing thanks for the patch.
> 
> On 2019-08-22 08:10, Viresh Kumar wrote:
> > On 21-08-19, 20:14, YueHaibing wrote:
> > > drivers/cpufreq/qcom-cpufreq-hw.c: In function
> > > qcom_cpufreq_hw_read_lut:
> > > drivers/cpufreq/qcom-cpufreq-hw.c:89:38: warning:
> > >  variable prev_cc set but not used [-Wunused-but-set-variable]
> > > 
> > > It is not used since commit 3003e75a5045 ("cpufreq:
> > > qcom-hw: Update logic to detect turbo frequency")
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index 3eea197..a9ae2f8 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -86,7 +86,7 @@ static int qcom_cpufreq_hw_read_lut(struct device
> > > *cpu_dev,
> > >  				    struct cpufreq_policy *policy,
> > >  				    void __iomem *base)
> > >  {
> > > -	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0,
> > > freq;
> > > +	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
> > >  	u32 volt;
> > >  	struct cpufreq_frequency_table	*table;
> > > 
> > > @@ -139,7 +139,6 @@ static int qcom_cpufreq_hw_read_lut(struct
> > > device *cpu_dev,
> > >  			break;
> > >  		}
> > > 
> > > -		prev_cc = core_count;
> > >  		prev_freq = freq;
> > >  	}
> > 
> > @Sibi, you fine with this change ? I will merge it with the original
> > patch then.
> 
> yes the changes seem fine, I missed
> removing prev_cc.

Thanks. Merged into the original patch itself.

-- 
viresh
