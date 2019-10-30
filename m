Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F9CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0962087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bf2xTGjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJ3OXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:23:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37793 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3OXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:23:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so2908419qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Iieil+MuDaNJ5lIJEOFs9h7jIoiG48MeHaP0+PASXlo=;
        b=bf2xTGjUYAa3MySkebfnobaQ/S7IFbvS3B8bSmpGJw21kTSBXvaEKLTGw+yavb0Dgz
         Dw/dnD8CYZHxAuOvQrPSFUCZ/ggeRfDkgx444Sojdaa90kTduIlrOB9d69bpjAFWkAgO
         iFKxRGN/WlM09anCsNQxhTKqBBTNObXzGqksZXZh1y5Xyh6UO+8EEv//zy84HhvzsJuH
         iFKxK5PG0h0u0HO4h2JNTDGyeCbdkQ8QXHSdoDGDWM/zmThHe8lsMzrqI0qeHYlwKq7s
         FFlVfJs/amMOXNIROl2Hq0GlFPvtATS00Dv6LBb+lrMpb0tttEUpSE03ufeyFMA9BRDT
         7r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Iieil+MuDaNJ5lIJEOFs9h7jIoiG48MeHaP0+PASXlo=;
        b=RlwAYgfKZVIrlkQX30w6eTbbhy+3/SAuZBaN4bOvS8+iDvX7TKhrz2lqNUvEoVWRAf
         5TlRcztdQcvzuayk7S7Dnjr5frCoNp3Zeq8BYvCb8Gheu2vxv86Hf4St4FI7lf53HHkg
         3PVcpknyv4cYon6HMRJ3fZRyf0W5ucUvncmahkU3cMXvSoPpOPGsTaX8RxL77/rtPWN6
         AxbqRHC6iDYf+6toPCLBkY1tDbqwWRB3Agw4BVr2fhskPAxKkZuYSzUZYlFFlG0JIeIX
         tSJlSD/N/ofvHZADb1Vf2XChYKatkTTbv5c1YBCFrFhxOKAxfvfLTB470/sYAdTncPNu
         F2kA==
X-Gm-Message-State: APjAAAUC+qjrZT4g47NnR5bbQbYc6mLC2o+SfsUqUeyvY4yeg4y0Mo3g
        A4rLoXRhGe2ttm9B4PGvTczMbVFwMzY=
X-Google-Smtp-Source: APXvYqzmbqgk6/kz7QU3nlWaRgKvHPWEG3ZIdKB73xjHpjGorCH8t3zSH+3B/Dh6UH8mTXW9UuCW5g==
X-Received: by 2002:ae9:e713:: with SMTP id m19mr127213qka.338.1572445418273;
        Wed, 30 Oct 2019 07:23:38 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id q4sm219231qtj.41.2019.10.30.07.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 07:23:37 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: Add mx power domain as thermal
 warming device.
To:     Rob Herring <robh@kernel.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-8-git-send-email-thara.gopinath@linaro.org>
 <20191029013111.GA27045@bogus>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DB99CE8.1050506@linaro.org>
Date:   Wed, 30 Oct 2019 10:23:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191029013111.GA27045@bogus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2019 09:31 PM, Rob Herring wrote:
> On Wed, Oct 16, 2019 at 03:37:21PM -0400, Thara Gopinath wrote:
>> RPMh hosts mx power domain that can be used to warm up the SoC.
>> Add sub-node to rpmhpd node for mx to be recognized
>> as thermal warming device on sdm845.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 0222f48..0671c8a 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -3788,6 +3788,11 @@
>>  						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>>  					};
>>  				};
>> +
>> +				mx_cdev: mx {
>> +					#cooling-cells = <2>;
>> +					.name = "mx";
> 
> Copy this from C code?
Hi Rob,

What do you mean ?

> 
>> +				};
>>  			};
>>  
>>  			rsc_hlos: interconnect {
>> -- 
>> 2.1.4
>>


-- 
Warm Regards
Thara
