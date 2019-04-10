Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85C2C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAB920850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKB2j3b5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDJEGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:06:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44802 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfDJEGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:06:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so673623pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZuWAIhjkWDyyN1kphT5RcL1YQnVirMG+cjxlhSmmsY=;
        b=UKB2j3b5pIE5mz8LGr04zNi0Q4PNWchOuE+rKYeyEs/P+fZycaEOxz6NqjxnJCX2GV
         2wvodQEhXUP9xzkktt6nGJjaTTjwJDqSkNtQvXpJZabiPb64fa2T7jG0jdQLAScxUAmC
         pdgBhx7Ag6GoclKHOhxh5X13apEPEvzmi4pITvYlbkR1ygZP499EmAKOY0X8MDt2D512
         onPH7w6EQ7xaWQT8HQQCg2xu9EoVVtVY3vOIlRfPIcy/g93CBSaf3Kva3/Xq7/rqRXAy
         ZrNRekyXx7vHKzI7w4+mDNqRK/TlkAT09K9cBE/EgQL3MzI5olNaxAZHwHi/pqDwyIv0
         j91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZuWAIhjkWDyyN1kphT5RcL1YQnVirMG+cjxlhSmmsY=;
        b=keRJhl33qDtS3sjwneJd5N1YhWAw7AnNiBMAzvnT7zAPa14IzruUBahDpmg58K+dx2
         jswX+yKyyeGP194HXWr4kHdlBKltqowkk4oDVAwP5pAYcNHlZkFfHoTQyHkqivHmRDzE
         UIBQXbrkDQGqAzBL17iffxryTyZuOpuJohq90a98IiuA0WcRz7dRrGfZVwJdM0ZVfU4k
         0ykpU14ouwRm1T7QmnGxFYuylmSBEynGIvQMT3r5RvZguaNeEyMGv7VvCvvXjmscVPYX
         gEK9msiBG2qdMHqJowVfZSFVndF0wjW+7WVFk1WnDtqCzQSPbkUjPruxVTmP1Hz9ZC2j
         d0gQ==
X-Gm-Message-State: APjAAAXCRsB+TjCS5X2gkRhsLjIWhg/eci4BDfU5Xl8jM3okQ+jlpUuT
        dfhdBfdqXmUWuIAaj4IRgmi3og==
X-Google-Smtp-Source: APXvYqxDakN2RJUuM3fwaOYCQy7rCeGo9lwmIyj5Vwvi1ldeVqwM37WmtPMbVUJMzZPHH9iizTRuFQ==
X-Received: by 2002:a63:87c1:: with SMTP id i184mr39074233pge.265.1554869160011;
        Tue, 09 Apr 2019 21:06:00 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id u20sm30785523pfh.112.2019.04.09.21.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 21:05:58 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:35:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
Message-ID: <20190410040556.uwnhmhajcasic7hb@vireshk-i7>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-2-georgi.djakov@linaro.org>
 <20190314062312.vwyu3ryeyc6iv55h@vireshk-i7>
 <e462c932-4789-4f59-ad58-98c62266d977@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e462c932-4789-4f59-ad58-98c62266d977@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04-19, 17:36, Georgi Djakov wrote:
> Hi Viresh,
> 
> On 3/14/19 08:23, Viresh Kumar wrote:
> > On 13-03-19, 11:00, Georgi Djakov wrote:
> >> In addition to frequency and voltage, some devices may have bandwidth
> >> requirements for their interconnect throughput - for example a CPU
> >> or GPU may also need to increase or decrease their bandwidth to DDR
> >> memory based on the current operating performance point.
> >>
> >> Extend the OPP tables with additional property to describe the bandwidth
> >> needs of a device. The average and peak bandwidth values depend on the
> >> hardware and its properties.
> >>
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
> >>  1 file changed, 45 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> >> index 76b6c79604a5..fa598264615f 100644
> >> --- a/Documentation/devicetree/bindings/opp/opp.txt
> >> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> >> @@ -129,6 +129,9 @@ Optional properties:
> >>  - opp-microamp-<name>: Named opp-microamp property. Similar to
> >>    opp-microvolt-<name> property, but for microamp instead.
> >>  
> >> +- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
> >> +  the two integer values for average and peak bandwidth in megabytes per second.
> >> +
> >>  - opp-level: A value representing the performance level of the device,
> >>    expressed as a 32-bit integer.
> >>  
> >> @@ -546,3 +549,45 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
> >>  		};
> >>  	};
> >>  };
> >> +
> >> +Example 7: opp-bw-MBs:
> >> +(example: average and peak bandwidth values are defined for each OPP and the
> >> +interconnect between CPU and DDR memory is scaled together with CPU frequency)
> >> +
> >> +/ {
> >> +	cpus {
> >> +		CPU0: cpu@0 {
> >> +			compatible = "arm,cortex-a53", "arm,armv8";
> >> +			...
> >> +			operating-points-v2 = <&cpu_opp_table>;
> >> +			/* path between the CPU and DDR memory */
> >> +			interconnects = <&rpm_bimc MASTER_AMPSS_M0
> >> +					&rpm_bimc SLAVE_EBI_CH0>;
> > 
> > Can we have multiple paths for a device ?
> 
> I suppose that this is also a possible scenario. Will propose something
> to handle multiple paths too.
> 
> >> +		};
> >> +	};
> >> +
> >> +	cpu_opp_table: cpu_opp_table {
> >> +		compatible = "operating-points-v2";
> >> +		opp-shared;
> >> +
> >> +		opp-200000000 {
> >> +			opp-hz = /bits/ 64 <200000000>;
> >> +			/* 457 MB/s average and 1525 MB/s peak bandwidth */
> >> +			opp-bw-MBs = <457 1525>;
> > 
> > In that case fixing this to just 2 entries in the array is incorrect
> > and we should take care of that in the bindings here.
> 
> We can encode the path name into the property (when there are multiple
> paths). We already have opp-microamp-<name> and opp-microamp-<name>, so
> we can follow the same practice.
> 
> For example:
> 
> CPU0: cpu@0 {
> 	compatible = "arm,cortex-a53", "arm,armv8";
> 	...
> 	operating-points-v2 = <&cpu_opp_table>;
> 	/* path between the CPU and DDR and path between CPU and L3 */
> 	interconnects = <&bimc MASTER_AMPSS_M0 &bimc SLAVE_EBI_CH0>,
> 			<&bimc MASTER_AMPSS_M0 &bimc SLAVE_L3>;
> 	interconnect-names "cpu-mem", "cpu-l3";
> };
> 
> cpu_opp_table: cpu_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 		/* 457 MB/s average, 1525 MB/s peak bandwidth to DDR */
> 		opp-bw-MBps-cpu-mem = <457 1525>;
> 		/* 914 MB/s average, 3050 MB/s peak bandwidth to L3 */
> 		opp-bw-MBps-cpu-l3 = <914 3050>;
> 	};
> };

The -<name> property is different as only one of the value is ever used, i.e. we
can have opp-microvolt-speed0/1/2/3 (4 different values/properties) and only
opp-microvolt-speed1 will be used eventually and all others are discarded.

Also I am not sure if this will be actually required. We already have a list of
interconnects above and the order of that can be taken as reference here. i.e.

CPU0: cpu@0 {
	compatible = "arm,cortex-a53", "arm,armv8";
	...
	operating-points-v2 = <&cpu_opp_table>;
	/* path between the CPU and DDR and path between CPU and L3 */
	interconnects = <&bimc MASTER_AMPSS_M0 &bimc SLAVE_EBI_CH0>,
			<&bimc MASTER_AMPSS_M0 &bimc SLAVE_L3>;
};

cpu_opp_table: cpu_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	opp-200000000 {
		opp-hz = /bits/ 64 <200000000>;
		/* 457 MB/s average, 1525 MB/s peak bandwidth to DDR */
		/* 914 MB/s average, 3050 MB/s peak bandwidth to L3 */
		opp-bw-MBps = <457 1525>, <914 3050>;
	};
};

I also strongly believe that "opp-bw-MBps" should be renamed in a way to make it
independent of the OPPs. For example, we may have devices which also need to add
their vote for the bandwidth but don't have an OPP table as they don't do DVFS.
And the same property should be used by them directly as what we will have in
the individual OPPs in the above example case.

So maybe something like bw-MBps or something else.

-- 
viresh
