Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02359C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84272082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9PWHo10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfFRLZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:25:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46687 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfFRLZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:25:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so7508819pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Acusobn0H7ivd+3Ff6plUS4gJZuqpT9ishJ0wNjK3Jw=;
        b=T9PWHo10Hob/6SbmVp1kh7KbimH0OWnb+jHmVV8Ri+dZc7WMk/fvAn/4dudCrva50r
         1ErmIXUWFbjk0ZsRYrW0NhA0bwwDJJmQ/kNwqA+M0z+qwxszTrz/Ym4lNOivt1p614Il
         dSHtisXiiVrMPHZVZPb4BX2+9tEkKb3n0NzOQrYPtFai+8AEGxNH3qzRLCUaEE4uXdYp
         Ipuf+lBW/pOArtOv5cWVyP+umUcQeHw3g0VyY154AbkRPmmeT1PghfuyeONbvfsLUmi9
         Jek2M4tU4fo9gqGVFHDjsZnioUkMQo8N3uubpPDFeIRJlDU+F89IDaRM/w9e79J67HLq
         lOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Acusobn0H7ivd+3Ff6plUS4gJZuqpT9ishJ0wNjK3Jw=;
        b=G+cBlseeaI8XgxB3t0RsIefyL7EGm0g42AI6BAaf0zSevr1ScV6PkUiHFwSNdwBsZ+
         z7FLf7PGTvfduJzyxoQ2Q7psYDPCvG8qNeVJnvluRg3kIcR+9O/CfGoY4te4T6vKFG8C
         ICT+u7yw9y+meyT6DkBKGMKq8aodctfXG4EvpnabRCTrwoGRRZYZRIRlw+xLqps+jP9l
         zbE/wdutjywdSywA5fbjDnQ6cB16v5NKAjPD25gn9JaUnihXyPSMGs1AY4GXeR6oUVh9
         zRl3HbAT9np11DQN4q9jbayQ7PFdROb85FP9NOtlnDOL4X7CrjJEJ8NK3s3Ci4Wmd3NX
         mRmg==
X-Gm-Message-State: APjAAAU+s4AQn+GdelzaJH8jiMNqs5g9OeyGOl5LPQqx8ob8sry5iYiJ
        wzcrDm7sXAG8kqJ4g7w7pCLMJw==
X-Google-Smtp-Source: APXvYqyNWEaw8XRM9dbybMqObwjT29HEOH7etliEeUq3gJ/DoZogGurCxXw/e4swi+H3k8vboBCfpw==
X-Received: by 2002:a62:640e:: with SMTP id y14mr115409767pfb.109.1560857126458;
        Tue, 18 Jun 2019 04:25:26 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id q4sm1979188pjq.27.2019.06.18.04.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 04:25:25 -0700 (PDT)
Date:   Tue, 18 Jun 2019 16:55:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190618112522.4odrysf7wmxgjlb2@vireshk-i7>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
 <3504053.Rmt1Mul0J4@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3504053.Rmt1Mul0J4@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-19, 01:26, Rafael J. Wysocki wrote:
> On Monday, June 10, 2019 12:51:35 PM CEST Viresh Kumar wrote:
> > +static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
> > +				void *data)
> > +{
> > +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
> > +
> > +	return cpufreq_update_freq(policy);
> > +}
> > +
> > +static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
> > +				void *data)
> > +{
> > +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
> > +
> > +	return cpufreq_update_freq(policy);
> > +}
> 
> This is a bit convoluted.
> 
> Two different notifiers are registered basically for the same thing.
> 
> Any chance to use just one?

The way QoS is designed, it handles one value only at a time and we need two,
min/max. I thought a lot about it earlier and this is what I came up with :(

You have any suggestions here ?

-- 
viresh
