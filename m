Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DF1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaRrDiXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfDXJFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:05:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40289 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDXJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:05:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so8964338pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9aCcMuBCvx5cbhKsdvZqDdwab4T/UsiSsBYHhigk3jc=;
        b=iaRrDiXxRYp9/8pk3OQn4t2BCDrBfoCA4yMYTpniNB4GRPLZTPEROk3fpmsu8Pg1es
         d9vqTg+tFMJqO+HXGTSe8Bc+nTwZPqflZciMdfAKJR6FyvYt/7IVAZ6/grIEgkcA1zbY
         a95Br9JxKIVeTXaR7LG+qJFHuoZsFXbfmhJ7DFkgmHBT+iUMSsduvhWEUOVOxiaq8ts3
         r/fmLwvJLsa0frY4Wd8k3AkQ6jw7pv9Q6zDSNouKSCzR4fLuO8BtU7cQA3cQHkzfSy7V
         s+Ef2fodGIrHLe4TMQOR8hPk8I83dTvJNt/TbN1vjpQCxDy03BuYrFlg+MIj5Fl2lAIn
         3fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9aCcMuBCvx5cbhKsdvZqDdwab4T/UsiSsBYHhigk3jc=;
        b=ZVHRvOPn5DAYem8F0mYvFCe2ZZEAiTOnQBzEfO1r6zkUZUVKX6sK7Fcs/YgBzA6GXU
         sHcjiYm3vwatSr1qtufXqeENJBq/S0UnDWPFaY9l4zFHDfaVc/UISmKX60YAVUxmrcIA
         TElgKtIeGrBJ0QtOL9Sfv6JOoe8u2xYA5vXarW7akn3EA9L/7xMNzL/5xpKIZ8wSGhM2
         muJcE7Kmv+qfZkosucbv0IX8LFk6h3ecaswoJyTiYDXzvI3CTmRzDzHOT8D9XUv9Oxf4
         YH4NptKFSiymryliCSI6jDmBL+z2tY30WgJlZb8tXWR1b21OHR0qy05miHikEqB8mddt
         vfKw==
X-Gm-Message-State: APjAAAW/ppzzSW5I5TmUdv7HQzWSbE95xtAtIZzCNnJx801uHHB0lgpT
        aau2vqdRx/HsodrQCMveikb5Kw==
X-Google-Smtp-Source: APXvYqxDFvaWvd7wZDk4qHnBtvRFlzutSEQMpa1AjGpKYqYEqhIlaT3t8HkLkmQMJbT6G2ve3PRchQ==
X-Received: by 2002:a63:cd50:: with SMTP id a16mr10816882pgj.394.1556096709712;
        Wed, 24 Apr 2019 02:05:09 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id x9sm25834360pfn.60.2019.04.24.02.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 02:05:08 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:35:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps
 bindings
Message-ID: <20190424090506.jdwhf4ndzr2m5ea7@vireshk-i7>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-2-georgi.djakov@linaro.org>
 <e35223d0-80ac-5236-2b8d-7f46cd3a1581@codeaurora.org>
 <20190424064942.v5g6jr5l3xy5z3xv@vireshk-i7>
 <dd6f055c-e7df-13e8-72aa-2973d3c664d0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6f055c-e7df-13e8-72aa-2973d3c664d0@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-19, 14:30, Sibi Sankar wrote:
> Hey Viresh,
> 
> On 4/24/19 12:19 PM, Viresh Kumar wrote:
> > On 24-04-19, 12:16, Rajendra Nayak wrote:
> > > 
> > > 
> > > On 4/23/2019 6:58 PM, Georgi Djakov wrote:
> > > > In addition to frequency and voltage, some devices may have bandwidth
> > > > requirements for their interconnect throughput - for example a CPU
> > > > or GPU may also need to increase or decrease their bandwidth to DDR
> > > > memory based on the current operating performance point.
> > > > 
> > > > Extend the OPP tables with additional property to describe the bandwidth
> > > > needs of a device. The average and peak bandwidth values depend on the
> > > > hardware and its properties.
> > > > 
> > > > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > > > ---
> > > >    Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++++++++
> > > >    .../devicetree/bindings/property-units.txt    |  4 ++
> > > >    2 files changed, 42 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > > index 76b6c79604a5..830f0206aea7 100644
> > > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > > @@ -132,6 +132,9 @@ Optional properties:
> > > >    - opp-level: A value representing the performance level of the device,
> > > >      expressed as a 32-bit integer.
> > > > +- bandwidth-MBps: The interconnect bandwidth is specified with an array containing
> > > > +  the two integer values for average and peak bandwidth in megabytes per second.
> > > > +
> > > >    - clock-latency-ns: Specifies the maximum possible transition latency (in
> > > >      nanoseconds) for switching to this OPP from any other OPP.
> > > > @@ -546,3 +549,38 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
> > > >    		};
> > > >    	};
> > > >    };
> > > > +
> > > > +Example 7: bandwidth-MBps:
> > > > +Average and peak bandwidth values for the interconnects between CPU and DDR
> > > > +memory and also between CPU and L3 are defined per each OPP. Bandwidth of both
> > > > +interconnects is scaled together with CPU frequency.
> > > > +
> > > > +/ {
> > > > +	cpus {
> > > > +		CPU0: cpu@0 {
> > > > +			compatible = "arm,cortex-a53", "arm,armv8";
> > > > +			...
> > > > +			operating-points-v2 = <&cpu_opp_table>;
> > > > +			/* path between CPU and DDR memory and CPU and L3 */
> > > > +			interconnects = <&noc MASTER_CPU &noc SLAVE_DDR>,
> > > > +					<&noc MASTER_CPU &noc SLAVE_L3>;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	cpu_opp_table: cpu_opp_table {
> > > > +		compatible = "operating-points-v2";
> > > > +		opp-shared;
> > > > +
> > > > +		opp-200000000 {
> > > > +			opp-hz = /bits/ 64 <200000000>;
> > > > +			/* CPU<->DDR bandwidth: 457 MB/s average, 1525 MB/s peak */
> > > > +			 * CPU<->L3 bandwidth: 914 MB/s average, 3050 MB/s peak */
> > > > +			bandwidth-MBps = <457 1525>, <914 3050>;
> > > 
> > > Should this also have a bandwidth-MBps-name perhaps? Without that I guess we assume
> > > the order in which we specify the interconnects is the same as the order here?
> > 
> > Right, so I suggested not to add the -name property and to rely on the
> > order. Though I missed that he hasn't mentioned the order thing here.
> 
> by skipping names, aren't we forced to specify all the specified paths
> bandwidths for each opp even if it is redundant? i.e if the first/second
> icc path doesn't have to change across a few opps but if the other path
> does need to change this scheme would force it to be included and will
> try to set the first/second path again.
> 
> 
> e.g: Here the first path does not have to change across these two opps
> but have to specified nonetheless since we omit names.

The code should be efficient enough to return early in this case, but
these value must always be present. We can get some sort of
relationship between multiple paths that are part of same OPP, but not
between different OPPs.

> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			bandwidth-MBps = <457 1525>, <914 3050>;
> +		};
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			bandwidth-MBps = <457 1525>, <1828 6102>;
> +		};
> 

-- 
viresh
