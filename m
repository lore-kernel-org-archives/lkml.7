Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92131C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DEB20656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJ948rqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfDXGts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:49:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36135 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbfDXGtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:49:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so8898654pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GPwJ+Dv6Yye/GYCQu2DK/IFt2gkz+D0Qa9x7sKSg3nI=;
        b=dJ948rqBPaZUvCFKrcFhohdvlVX+94B52yZpDc1e32ZAQF/qVhzuZZ4jPUd8xVAgai
         8tuQb8/MbuZzo+qVuDRVQBNbmriA7n+3nYm42BEyxr+JhfubavBmV5YVS1w6zOd29Do/
         B2e3QKb1dRAEUfk6fq0lkaY37McCPfFS9K7WivszZl37/A1ZPl3NbbONHppdWXIevzfQ
         o0a72GLVsFV3QycR8O338TBhGnEauxITlydfPW9unppA6Mhn/e057kyBQZyrnXMypzcx
         ipknOmaPzQJUzz1a6jzbkNsSgumZwYIY5im6HLJGwQDNilkSSaOwvvSaPCgaZKA5Ov4u
         Dmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GPwJ+Dv6Yye/GYCQu2DK/IFt2gkz+D0Qa9x7sKSg3nI=;
        b=qkLB4rAf2A+Cimo1s2Q26ka/fBAkwU6rkzmjK7wu6//DOwrAx9FdyPhJkIzNuSUnlK
         aHIIon/4P3SdiIixyGDPXYGFkX7DNs41QpZeCI3VeiPVWxupVYC/netiVdAU3QYTXTz8
         zCcDkW5joHqlYDfszgw3pxIkjYlwNILVsULbLF2ZB2ETTcW1MqKTTSBeJHm080etsDQL
         ijHVssCQuXiVsMqEqbqH7A7PdJ9vvgFsQmn7y3aEeffN+WFK/DubE2gGYGvEg2n9JQGK
         uCgG2COz/9hpNP4O1K5kMHwLwO3hdd9P1Ec6+kBQl41K0c4plls0LDegb6Ju60KFTcXO
         DNUg==
X-Gm-Message-State: APjAAAUGfNlaZDwhFAUIbY5W+Yp9MSjpQlt5dlKw432a7uS2iMzvtLzI
        hcIZPNBYgoCLktZ3sp/OWScGtg==
X-Google-Smtp-Source: APXvYqw+WSq9sgNEIwrX+TiZ8BQ9M/YjqXdpRJROPCJOsnNN9blig2LfSbou3/Jv+yLLJeNyFCzz2w==
X-Received: by 2002:a62:4554:: with SMTP id s81mr32218642pfa.66.1556088585455;
        Tue, 23 Apr 2019 23:49:45 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id b13sm24443639pfd.12.2019.04.23.23.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 23:49:44 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:19:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps
 bindings
Message-ID: <20190424064942.v5g6jr5l3xy5z3xv@vireshk-i7>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-2-georgi.djakov@linaro.org>
 <e35223d0-80ac-5236-2b8d-7f46cd3a1581@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35223d0-80ac-5236-2b8d-7f46cd3a1581@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-19, 12:16, Rajendra Nayak wrote:
> 
> 
> On 4/23/2019 6:58 PM, Georgi Djakov wrote:
> > In addition to frequency and voltage, some devices may have bandwidth
> > requirements for their interconnect throughput - for example a CPU
> > or GPU may also need to increase or decrease their bandwidth to DDR
> > memory based on the current operating performance point.
> > 
> > Extend the OPP tables with additional property to describe the bandwidth
> > needs of a device. The average and peak bandwidth values depend on the
> > hardware and its properties.
> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> >   Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++++++++
> >   .../devicetree/bindings/property-units.txt    |  4 ++
> >   2 files changed, 42 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 76b6c79604a5..830f0206aea7 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -132,6 +132,9 @@ Optional properties:
> >   - opp-level: A value representing the performance level of the device,
> >     expressed as a 32-bit integer.
> > +- bandwidth-MBps: The interconnect bandwidth is specified with an array containing
> > +  the two integer values for average and peak bandwidth in megabytes per second.
> > +
> >   - clock-latency-ns: Specifies the maximum possible transition latency (in
> >     nanoseconds) for switching to this OPP from any other OPP.
> > @@ -546,3 +549,38 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
> >   		};
> >   	};
> >   };
> > +
> > +Example 7: bandwidth-MBps:
> > +Average and peak bandwidth values for the interconnects between CPU and DDR
> > +memory and also between CPU and L3 are defined per each OPP. Bandwidth of both
> > +interconnects is scaled together with CPU frequency.
> > +
> > +/ {
> > +	cpus {
> > +		CPU0: cpu@0 {
> > +			compatible = "arm,cortex-a53", "arm,armv8";
> > +			...
> > +			operating-points-v2 = <&cpu_opp_table>;
> > +			/* path between CPU and DDR memory and CPU and L3 */
> > +			interconnects = <&noc MASTER_CPU &noc SLAVE_DDR>,
> > +					<&noc MASTER_CPU &noc SLAVE_L3>;
> > +		};
> > +	};
> > +
> > +	cpu_opp_table: cpu_opp_table {
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +
> > +		opp-200000000 {
> > +			opp-hz = /bits/ 64 <200000000>;
> > +			/* CPU<->DDR bandwidth: 457 MB/s average, 1525 MB/s peak */
> > +			 * CPU<->L3 bandwidth: 914 MB/s average, 3050 MB/s peak */
> > +			bandwidth-MBps = <457 1525>, <914 3050>;
> 
> Should this also have a bandwidth-MBps-name perhaps? Without that I guess we assume
> the order in which we specify the interconnects is the same as the order here?

Right, so I suggested not to add the -name property and to rely on the
order. Though I missed that he hasn't mentioned the order thing here.

@Georgi: Please mention above in the binding that the order is same as
interconnects binding.

-- 
viresh
