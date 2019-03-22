Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A2AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6632082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qlSkfQQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfCVG1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:27:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45195 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfCVG1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:27:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so800849pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 23:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N1bihhyxtOWgjXHkpSnkrfyywXh1+BcmZz5uiIbqwPo=;
        b=qlSkfQQR8uGm0lZMpUFJgozXpp6ffR6Ng4ryyiy4937f2FhFQp2tI+hxVBNxsIKhmT
         aw+UpdbadnfF1ua17J8E0J+zdwhOpPIhRHONFhvkrJgKk/E3uevcfEL7Cy1gkwdVBvHb
         ruPszS6kkasmq/Vs93AtIDYLQ5XIC/wW+zWWoUEGbzzZx6AIQe3N5ugRdzGtwdHfkVMu
         CifJiCych7wn5oXGPYnLukZ/5eekCTb+9Eh6muImaWhsDOKqe957NpYv1DyTnmrosXDp
         jrXMUCtTrGeHglzGELZBwOITAU/XHbIpLZovvJI0Ky2gz4B/aoxh+g08HD0xds9clhTx
         8d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N1bihhyxtOWgjXHkpSnkrfyywXh1+BcmZz5uiIbqwPo=;
        b=XQjXGAq6+i4RCL5wjz7YDq4HnSzx0SidhVhXPA4t1gnyYQ/0oy2DXs7YbBEdBtwh6l
         lInSsA1iwJcRbDUcZ9EBN02X2mJyJt8MDPP0yGHJ2hrAK8o8DeYtpTNuGJmiZBI7FEPD
         1sZ7GcbhK+AEKOOzwTB7l46ZipPL6H9yy7xfn78Vz+2dBowHk/+DevHXpfPVOhRUUzwp
         MMyHc4TUF0THVWc/5sjnPfQDfbdMrVRBGP+jQlf1bpnaaZwrssuEIcBjJhx5/hfc7cb1
         Wr9ZOKXPDVjbfIT43StrbfLB9QoPZIB0wOpXb0QPx2+PD+84KojZzzL+GgVGNmvDTsVO
         Q8Ng==
X-Gm-Message-State: APjAAAXV/ocee1O4/YWfD6ElwyOLazTaaPB7TSsFzDZnA7PgGlBC4gaC
        0c3eG2wmcI+dzMXYoYmKQYWZVg==
X-Google-Smtp-Source: APXvYqwCchnrwJELpib1NjBtituPpS1gmKw3GJO7j8n5EPOwqnXkVgjyQwkPCPD0HcAjTwHdJTSH2Q==
X-Received: by 2002:a65:64cc:: with SMTP id t12mr7502442pgv.438.1553236067518;
        Thu, 21 Mar 2019 23:27:47 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id o14sm8295768pgn.65.2019.03.21.23.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 23:27:46 -0700 (PDT)
Date:   Fri, 22 Mar 2019 11:57:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH V3] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190322062744.efpl4itnqtny7txf@vireshk-i7>
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
 <alpine.DEB.2.21.1903211645100.1784@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903211645100.1784@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-19, 16:49, Thomas Gleixner wrote:
> On Wed, 20 Mar 2019, Viresh Kumar wrote:
> >
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 3fae23834069..b2fe665878f7 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -958,10 +958,15 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >  	struct cpufreq_freqs *freq = data;
> >  	unsigned long *lpj;
> >  
> > +	if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1)) {
> > +		mark_tsc_unstable("cpufreq changes: related CPUs affected");
> > +		return 0;
> > +	}
> 
> You might add a check which ensures that policy->cpu == smp_processor_id()
> because if this is not the case ....

How about something like this ?

	if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1 ||
                         freq->policy->cpu != smp_processor_id())) {
		mark_tsc_unstable("cpufreq changes: related CPUs affected");
		return 0;
	}


Thanks for your feedback.

-- 
viresh
