Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B92C73C75
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2412054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPeyxrl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfGJGSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:18:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36812 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJGSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:18:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so701572pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zQmbfW7TpvOqpgoqLNKl5KITK0HJvFLYAFP6k0WADm0=;
        b=BPeyxrl2nhtQapBE3Ixs8+wTLMwneCzfGrY52ENFdNdmkguUxQe9NLuRWf2W3TBnpc
         XUAPc4pCM/0hZ1+yZDtt/2NXgtQmROyJUueCIZpD+22kmivN/DPnkmM+rY8itm+zMKCj
         6LHW8GrR2jAu+jB8xPzy4bXDiilrFshcP/vsKrueClwd12mmOl6QkGAkqP6m0fB9oBSL
         P2WMeATveZT4Sr45viuB9ffRKdD46DzjJX4cT1WXr4H6cR0ALuYjDWY42wUHx3jJQoau
         65Zrl6Dy1hC2+q/G/BKiLvQ+8RLdBfL4noVTLy/uJuFTPg7SYs6u0OkaaE8YC3qNQTuV
         0dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zQmbfW7TpvOqpgoqLNKl5KITK0HJvFLYAFP6k0WADm0=;
        b=G7vs2WxMGAjx1sd0/3nD8aX9ad3Kdvho6R2ZuyjAP+rMBlu9YZ06vzqhmLPOupO4G6
         teYH26Nph5REjOhfbOI9APBCVsLwVJDVDN2j0QG21WRKlSjUS312uDtWLhlGsPAiMSB0
         QtSTge5I9lwaBYr3hcIfv2Uaf08yeg9fD1FWoRCTFDYcYeU/WKvxFc3a/7gGMe4vhEQW
         tFDJYfDrxEsDV3JA1yhsJa7VImPh2KZOsNpniwkRTpi7UE/n1hnjVUTs0GhnmC5JDIYg
         of/33AMJTnkbAeEp+3Kv7iFC235mZqwNew6uzgYn92zltFimEoJ22nQdMyZco0EcLVQd
         wt8A==
X-Gm-Message-State: APjAAAU1FobDAHIsCUslbuYfuJp+nrIdWBoLR+upNaVcwanyq7wEGcp+
        zisCGLYtzMfFkMH+HE4xqyOz7LKezhs=
X-Google-Smtp-Source: APXvYqxPlwIKEjAa48FkzZFM3Z9mpZvQFB9aOFeYE12DE4SzOUbA5VaSqOEwM7Qx/fcwutb9oGWaHA==
X-Received: by 2002:a63:6986:: with SMTP id e128mr36569826pgc.220.1562739523074;
        Tue, 09 Jul 2019 23:18:43 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id p7sm938764pfp.131.2019.07.09.23.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 23:18:41 -0700 (PDT)
Date:   Wed, 10 Jul 2019 11:48:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Sricharan R <sricharan@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/13] cpufreq: qcom: Re-organise kryo cpufreq to use it
 for other nvmem based qcom socs
Message-ID: <20190710061839.quncnis6pjyjntip@vireshk-i7>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-3-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095726.21433-3-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-19, 11:57, Niklas Cassel wrote:
> -static struct platform_driver qcom_cpufreq_kryo_driver = {
> -	.probe = qcom_cpufreq_kryo_probe,
> -	.remove = qcom_cpufreq_kryo_remove,
> +static struct platform_driver qcom_cpufreq_driver = {
> +	.probe = qcom_cpufreq_probe,
> +	.remove = qcom_cpufreq_remove,
>  	.driver = {
> -		.name = "qcom-cpufreq-kryo",
> +		.name = "qcom-cpufreq",

Should we still name it "qcom-cpufreq-nvmem" here ? Only the string
here.

>  	},
>  };

-- 
viresh
