Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2EC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A8E205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiQikR6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfLKCjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:39:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43021 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfLKCjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:39:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id h14so982925pfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 18:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lkeETUhQ3f8lWNeTP8ytVN52+By7QmgfsOQEQVp/5Bk=;
        b=QiQikR6kEHX9KZ1Ty8ohFw4WHZKRp4hr1Qd30w5/P5llrwO/ghQvr5AVO96DGVV/iQ
         zUlSw9bd3ZcVlEopdECizjka55M5lzl/Wf/45NGHMMsJQLOW/TrmVP788fJsQQ70A7T0
         xBSdCDZV8jPuHHsFDM3Mssemmmu/UydbPzPAKKrV9z67P+iaSLPmDdiQn77BrVmU88TZ
         r5yjmGbkbcMEBx5HFS6LgJll/Z8K9vMyK4PlxQEBw7UQ2BYt+cNA6N9u36EVxMZWWjM+
         txxz4bz5rM3o1QfR4C+p67D6MKRGg9p85mESLdzx0CPcdazh5iyhqbaWgD1TJ8gFWqG1
         8dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lkeETUhQ3f8lWNeTP8ytVN52+By7QmgfsOQEQVp/5Bk=;
        b=jBmcZTWCoOrQHGun22n0bZ5ZFOFC1MnEr7TSHct8UWRnVp46tAK93CTmsr1kf849J+
         NmdZHGVdGY9VfgAag1jw4Dys0QLvcD84mtTMfIS5TxqtHPNJJwaty2nb73BOhSTWk6ys
         uZALiyGPR4DW1VLynWG8o4NxtCIoVQGGWp5sPTk2aFIEUI41v/Ymwl4ucHAOGLd3Prnv
         xHkqxVKYGe1PTUvK3S39/5qc+U9l2EVGv1ViKQsh+JISBI+2GMoWHOkoIUdISdxw+2Tf
         WpT3hpFqC29KzgcMUN62ddIH2wWlPBh0RvhV4BGofaq1Fv2cxjo05sERt/5BNAEzfXOR
         VmVg==
X-Gm-Message-State: APjAAAU35r01yKCdM0bOE2bn8dwr5lFpPh8c3rHSzH6inQzQfTMBea07
        U/WJnvOBKajGWTzpg88xE9PYOA==
X-Google-Smtp-Source: APXvYqwv4FD7npjWh+xM8yEtWzQSvRX+xQWGcV0kVvGQhmKaR0MAmXhCirrzY7eQKyfmK8n6ahuV9g==
X-Received: by 2002:a63:364d:: with SMTP id d74mr1504299pga.408.1576031951864;
        Tue, 10 Dec 2019 18:39:11 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id 200sm398800pfz.121.2019.12.10.18.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 18:39:11 -0800 (PST)
Date:   Wed, 11 Dec 2019 08:09:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 13/15] cpufreq: scmi: Match scmi device by both name and
 protocol id
Message-ID: <20191211023909.7iun7kdk6pjkync6@vireshk-i7>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-14-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210145345.11616-14-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-19, 14:53, Sudeep Holla wrote:
> The scmi bus now has support to match the driver with devices not only
> based on their protocol id but also based on their device name if one is
> available. This was added to cater the need to support multiple devices
> and drivers for the same protocol.
> 
> Let us add the name "cpufreq" to scmi_device_id table in the driver so
> that in matches only with device with the same name and protocol id
> SCMI_PROTOCOL_PERF. This will help to add "devfreq" device/driver.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index e6182c89df79..61623e2ff149 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -261,7 +261,7 @@ static void scmi_cpufreq_remove(struct scmi_device *sdev)
>  }
> 
>  static const struct scmi_device_id scmi_id_table[] = {
> -	{ SCMI_PROTOCOL_PERF },
> +	{ SCMI_PROTOCOL_PERF, "cpufreq" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(scmi, scmi_id_table);

Applied. Thanks.

-- 
viresh
