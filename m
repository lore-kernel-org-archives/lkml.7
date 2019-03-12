Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDCFC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62306206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c68juVVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCLMG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:06:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38467 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:06:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id x13so2054257ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aHKN2rI8EX1oDz7odjEpO6IHPSAZqE6/3iXfu3TqE6M=;
        b=c68juVVzPwXR+ur/fcDehljDhMgS56sDsnUANOUY1Y54lLdiNmrhvkoVkOvrnTuDnj
         FR9K3Yb79Zk9Sh0NdjQcXyYeIpH/OeLg7tDFs2LZO7sXSYgbZmNolkI2+WkwETSTRjwg
         4KurMfmIi433xXlgL1uN+xQAKc1RDaQUpv8akRNey1Ko8oyjd1VleWZR64tWTmj5JjyF
         QaOoiU5qKSELjoeShq0dEwTnkSPx6BEo2kCtZ45bQHLZTtILCFscYzCsYsznYYJDcQrT
         PCZHnd+i2xGw8FBov08qikowt3hJ0sD7Gse5EUhiMrRHbX6BYy0YtguxMlTgrDcgJPIn
         mhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aHKN2rI8EX1oDz7odjEpO6IHPSAZqE6/3iXfu3TqE6M=;
        b=I72yvS13SYiqgfSA1yi97h1GMYaVbIVTPlyFN5jCkF6IvsWcdbrMZbE8SQtD8jU0WA
         kR5TT6IR82CS1irM8I4tKI7ISj7mCgoiMUA9ZFHut0+IY5GnrJmiySpxuTL8goWPSuwW
         YnFX7A8YfJaFdG/kIKoZbONihDVA3ChRxq13SZUm/tksardwyZ2Kf43qT/lRh+bQIKCb
         jJFDyFNqlU0p/xuSCF5HPKESGZjRedwepVwdlnbGWWFSkV6zEnkKiAUwWFH2V9txq7FN
         yIwd7v4Ro8WKkommlq6msLA2pqD1jP/sV8IszKYlKdbcU04PvlH8/QJV5nL3oCyrHozo
         YIZA==
X-Gm-Message-State: APjAAAUL2PyZ4TVwc2MMaODNYQfnIT/MmZFlNjVKxJH7z2euthJcYrdD
        MUTK5GXIcedM2IaQc/S03UZHKA==
X-Google-Smtp-Source: APXvYqwDwsxItOE+D0SoypPmFuQLMMs4Q1sIZR2DI4EcXsdvqXNZGkQ5Jns+1lZxpk2Jggo/n2MvmQ==
X-Received: by 2002:a2e:719:: with SMTP id 25mr19695101ljh.122.1552392386575;
        Tue, 12 Mar 2019 05:06:26 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id z7sm1340308ljk.34.2019.03.12.05.06.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 12 Mar 2019 05:06:25 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:06:23 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        jorge.ramirez-ortiz@linaro.org, "v5 . 0" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / OPP: Update performance state when freq == old_freq
Message-ID: <20190312120623.GA21536@centauri.lan>
References: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:27:18AM +0530, Viresh Kumar wrote:
> At boot up, CPUfreq core performs a sanity check to see if the system is
> running at a frequency defined in the frequency table of the CPU. If so,
> we try to find a valid frequency (lowest frequency greater than the
> currently programmed frequency) from the table and set it. When the call
> reaches dev_pm_opp_set_rate(), it calls _find_freq_ceil(opp_table,
> &old_freq) to find the previously configured OPP and this call also
> updates the old_freq. This eventually sets the old_freq == freq (new
> target requested by cpufreq core) and we skip updating the performance
> state in this case.
> 
> Fix this by also updating the performance state when the old_freq ==
> freq.
> 
> Fixes: ca1b5d77b1c6 ("OPP: Configure all required OPPs")
> Cc: v5.0 <stable@vger.kernel.org> # v5.0
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index d7f97167cac3..0420f7e8ad5b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -760,7 +760,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		old_freq, freq);
>  
>  	/* Scaling up? Configure required OPPs before frequency */
> -	if (freq > old_freq) {
> +	if (freq >= old_freq) {
>  		ret = _set_required_opps(dev, opp_table, opp);
>  		if (ret)
>  			goto put_opp;
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
