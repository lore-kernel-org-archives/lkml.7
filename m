Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44082214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfJll50J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfCLG1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:27:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35873 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfCLG1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:27:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id g18so1334346wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2e4HfmsCk7HpxlzO6/BB+sf3yIfxmeZGfF4H6NxUFj4=;
        b=xfJll50JfnEytBUmko2dHVOgLUrz6mpiVgyCF4wx4/PsKblafMCK3dWnKa+mg1bJV5
         aBJb/qU0lrfcde74WYKa7HBWtwV0EyTrKROSdUiiLCP2qJTA1/cPHIqVY0+WBD4vBUTK
         1OUFdp9zTxCqG6E1ntYwfILF27GJkyUaWgYpqWvMYBA8tNlQ/Au5IZNYR2/6PsULxv3w
         8XAz2u4fgI2bg9zo0/heODHztdDrLUNwOUR7EVqkycaSwaIPfU6Oz+abYLDHtRigcuWT
         PKmdgFJ7aneJqQjVbvrXmwmuhmQcvkuBwEKA2gj32RewksNBTcKbetPNL6mCjcRCIwR2
         PEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2e4HfmsCk7HpxlzO6/BB+sf3yIfxmeZGfF4H6NxUFj4=;
        b=k0nckChg/om3LSi94Asu2iO5g1aQipdLL/s6xjy6tq2hgKFpELwnrgFw2DWZgs+bAl
         dWzz2SG+oHqnUHYz96sjnk+TNX+qSWWcgo2BU96nqUi3B11m8IBfJjx1OsUg6VGJqCyx
         mSdCmEfqQssTlDRFmyatfNF29NJ+FO2PPR1h6XSxs6pFMcefSz6lonfcvpbQkcOU42nV
         8z3YLcD0sEZyny+0lpKpuQ+HlL5r8n1CEY4bZNpkVpSDfk42ytQLWoV4xAUStPOjbK1Y
         WcoU5qkBUeymBY1Nki8Sp7fX5u2XCg8bXGEbV7lsbv51WZCkmnSwKhC9EneWVwyXQM1X
         +rdg==
X-Gm-Message-State: APjAAAUxU3dR92S77Az5LWciUiwb113hYPgGuRdwyqhAAgvtDL57sDc/
        +qEyl0rA4dI69WY9lvFa52sd/5eIkSI=
X-Google-Smtp-Source: APXvYqy8DEHM0O/gb7SEAZ4LaqxxVrhAIk29qoNzlGNJAxqztd1bHlRL+CwJmgl2mUZRg8TAHpT4Mw==
X-Received: by 2002:adf:9361:: with SMTP id 88mr23217287wro.152.1552372070170;
        Mon, 11 Mar 2019 23:27:50 -0700 (PDT)
Received: from [192.168.1.2] (52.red-95-121-90.dynamicip.rima-tde.net. [95.121.90.52])
        by smtp.gmail.com with ESMTPSA id 132sm1492297wmd.30.2019.03.11.23.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 23:27:49 -0700 (PDT)
Subject: Re: [PATCH] PM / OPP: Update performance state when freq == old_freq
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "v5 . 0" <stable@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
References: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <288203c2-c822-b918-ce72-e2271125d374@linaro.org>
Date:   Tue, 12 Mar 2019 07:27:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/19 05:57, Viresh Kumar wrote:
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

Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

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
> 


[    3.048579] Loading compiled-in X.509 certificates
[    3.064282] cpufreq: cpufreq_online: CPU0: Running at unlisted freq:
1113600 KHz
[    3.064510] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency
changed to: 1248000 KHz
[    3.072072] hctosys: unable to open rtc device (rtc0)


...

and the ftrace on the registered driver handling the performance change
to state 2

     kworker/3:0-26    [003] ....     3.063824: cpr_pd_attach_dev:
reg[0x100] = 0x00000014
     kworker/3:0-26    [003] ....     3.063845: cpr_corner_restore:
reg[0x100] = 0x00000014
     kworker/3:0-26    [003] ....     3.063848: cpr_corner_restore: gcnt
= 0x000132ab, ctl = 0x31000428, irq = 0x00000014
     kworker/3:0-26    [003] ....     3.063851: cpr_ctl_enable.part.15:
reg[0x100] = 0x00000014
     kworker/3:0-26    [003] ....     3.064352: cpr_set_performance:
cpr_set_performance: setting performance state: 2 (prev state: 0)
     kworker/3:0-26    [003] ....     3.064355: cpr_ctl_disable.part.16:
reg[0x100] = 0x00000000
     kworker/3:0-26    [003] ....     3.064410: cpr_corner_restore:
reg[0x100] = 0x00000014
     kworker/3:0-26    [003] ....     3.064413: cpr_corner_restore: gcnt
= 0x000132f5, ctl = 0x31000428, irq = 0x00000014
     kworker/3:0-26    [003] ....     3.064416: cpr_ctl_enable.part.15:
reg[0x100] = 0x00000014
      irq/29-cpr-1320  [000] ....     3.079189: cpr_irq_handler:
IRQ_STATUS = 0x5

