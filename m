Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEF2C31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C60205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pr542iFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfFQDHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:07:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41425 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfFQDHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:07:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id s24so3456596plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 20:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnsSUcv6POB85t4hdLFStM01b3sXymghKDPM6KTp/to=;
        b=Pr542iFNDYXLSJH9qAkojqrO3OFNPMBj6UU4xVeM2gPSbndsGvuP6Sz3ZXAzgt3U2a
         tIba80M6lBcwv6VyV/Ca8cl0d6FcdtWKQ8EnwJUz2Znt3ckjMauy7Ap7YSvb6Zj9RTEQ
         M2Xh+4O3QNenbeX/F7PsENSsUob3B/wsbxbJXpKIeUAGcYQeWiEG8V4SvxUhDmWuIEJK
         r9DYcewBTtE3VRz3k+zbEP9UtIkzxYtENcNsA9ot6pVl4EaNwVfgE0P8W5wLe0DdWjcr
         U3ZmvPV2Jy2EUFRfnYAFWYx4XB3nwKMlej2PSMhdM1I05376HJ6P+su2tOn3eLT04QAa
         ldrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnsSUcv6POB85t4hdLFStM01b3sXymghKDPM6KTp/to=;
        b=pTtEu+t7dIkwbVG/5Nd3z0Mm0UoQVc6xHYlcCE6lIbVOr6nU5/4ZrQEECVBTx7b08e
         EDM4MipUcyqTLd2dlkcJYDFODrxVk/9rBQedYCfJV6fGwO7Xu3ljIhGA2pk/BMjgr2RU
         hcUO87ImTAAIBpjbMjAe0NTT1JvDlH+PwwJugoG1sTfsKjbKPnYV19ArS3dn6mRthKtC
         emT70kDUAmATVzoHDwTPUFELtDcMr8UKutBR88pyTTW0yjcAtuVtp3U0VhdcWiiIuSny
         ti2kXzkSSC2Av3KZeE/M/vKZK2GOmem7Y4MGeXoVsyJ69QSAOj70ryMrUwmHKhStn/BC
         sOPw==
X-Gm-Message-State: APjAAAVxtEa73A1OLBeql879Mw97ktTderdmKpZvQW25bPakAAFZmTBb
        E21gM7veMYBg/t4xM34v2xR9Og==
X-Google-Smtp-Source: APXvYqy5jJ0iJpeAFxa9sswjhBt7eN0X1YqH+ZVC/J1NtaepSPezbtcOwcq1TXVxyd/FrlaPWbrpNA==
X-Received: by 2002:a17:902:1e2:: with SMTP id b89mr85458423plb.7.1560740860436;
        Sun, 16 Jun 2019 20:07:40 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id l63sm10107101pfl.181.2019.06.16.20.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 20:07:39 -0700 (PDT)
Date:   Mon, 17 Jun 2019 08:37:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/5] cpufreq: Add QoS requests for userspace
 constraints
Message-ID: <20190617030737.vb4k5g35p4igaq6e@vireshk-i7>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <d1a7585539ad2ced2bfcc9e232cf859b1ec9c71a.1560163748.git.viresh.kumar@linaro.org>
 <20190614171450.GQ137143@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614171450.GQ137143@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-19, 10:14, Matthias Kaehlcke wrote:
> Hi Viresh,
> 
> On Mon, Jun 10, 2019 at 04:21:36PM +0530, Viresh Kumar wrote:
> > This implements QoS requests to manage userspace configuration of min
> > and max frequency.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 92 +++++++++++++++++++--------------------
> >  include/linux/cpufreq.h   |  8 +---
> >  2 files changed, 47 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 547d221b2ff2..ff754981fcb4 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -720,23 +720,15 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> >  static ssize_t store_##file_name					\
> >  (struct cpufreq_policy *policy, const char *buf, size_t count)		\
> >  {									\
> > -	int ret, temp;							\
> > -	struct cpufreq_policy new_policy;				\
> > +	unsigned long val;						\
> > +	int ret;							\
> >  									\
> > -	memcpy(&new_policy, policy, sizeof(*policy));			\
> > -	new_policy.min = policy->user_policy.min;			\
> > -	new_policy.max = policy->user_policy.max;			\
> > -									\
> > -	ret = sscanf(buf, "%u", &new_policy.object);			\
> > +	ret = sscanf(buf, "%lu", &val);					\
> >  	if (ret != 1)							\
> >  		return -EINVAL;						\
> >  									\
> > -	temp = new_policy.object;					\
> > -	ret = cpufreq_set_policy(policy, &new_policy);		\
> > -	if (!ret)							\
> > -		policy->user_policy.object = temp;			\
> > -									\
> > -	return ret ? ret : count;					\
> > +	ret = dev_pm_qos_update_request(policy->object##_freq_req, val);\
> > +	return ret && ret != 1 ? ret : count;				\
> 
> nit: I wonder if
> 
>   return (ret >= 0) ? count : ret;
> 
> would be clearer.

Done. Thanks.

> Other than that:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
viresh
