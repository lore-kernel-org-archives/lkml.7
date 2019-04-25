Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704F8C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383CE217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkGh3k76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfDYEYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 00:24:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44817 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDYEYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 00:24:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id y12so7823958plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 21:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MZ0ZquoXjXt5YQFZ1wMrrbk19uCV0UUA3XVrwhRs4M8=;
        b=XkGh3k76hbcbOi/MX/s5uM85MbIjTe3GUxlo97a63B6spbtzwdVlSgqGQXtjd+FQ4Z
         O2e0Hmuq0LfxKhMmVzxHgOO4xZMCCPu/vn9jVrRMN5/GktnGisXEKCThoq7xuEM/wXfd
         6aU2FluO5NEww6Z7vACix3Mn9QlFWYRlnUHMwHM9n1Hn3BxkB6Yn4/P8xnFaRxAlbHFa
         mp693inIHUcCexOMa50f1BzGR/XXpajPkRwLS5uVeZTwse31B/M/0J4lvP+FiuPt22br
         fqzkpQ59MSaLPPNw4dZjjgngY7g2dHBpgOIC6QS3/Yfpd/NnjKRoBeJQ8hPuBmVLH7HI
         a/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MZ0ZquoXjXt5YQFZ1wMrrbk19uCV0UUA3XVrwhRs4M8=;
        b=ZOZfUbkpMhs/lUrVQA/e8YvvbgvP8Mh1NUasTO3yLA1yV50YHgYg5R9mxaXMWMEraW
         UMEvAablNIfBbnbtJSx5B8qKyJ5x3q2iIiqvTtwVTw973rmaFxhI/1aKp2XWyjTu7Rs1
         pDR6y6coMX5REcKl0K67x8Nja7ozOwUwunaAQgSI7MxVMGraH2deHntaKQ4gLO1X4wca
         mHirAAGd2n9LPVXpF7u1fuu1fwsdY7FcT5CbQb9nS7zOqzEispzfN70mn0VlUHWQcnsk
         scXI8UOiRIZNdE/Dl2MJOPrn8f8Tr+E8YGlro7NLGiMc/zsrTmAV3L0qulVHmRAWf6cO
         +uKw==
X-Gm-Message-State: APjAAAWRj+BDWgv5+8noAc1cjNOmO5mtAgwDvSo/ATL9r87Xv/OIylV4
        ul21y9/Ul3WNJ2YBL4Y0FxR4jQ==
X-Google-Smtp-Source: APXvYqwVyaHQRyRc/H1q1tzitljEXvhQueIXGZNsgusbQEPPcU4cH+xz6ecZzeYFl2Ach6N34UnmOA==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10mr11040129plu.272.1556166293565;
        Wed, 24 Apr 2019 21:24:53 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m23sm28564839pfa.117.2019.04.24.21.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 21:24:52 -0700 (PDT)
Date:   Wed, 24 Apr 2019 21:24:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps
 bindings
Message-ID: <20190425042450.GB2867@tuxbook-pro>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-2-georgi.djakov@linaro.org>
 <e35223d0-80ac-5236-2b8d-7f46cd3a1581@codeaurora.org>
 <20190424064942.v5g6jr5l3xy5z3xv@vireshk-i7>
 <dd6f055c-e7df-13e8-72aa-2973d3c664d0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6f055c-e7df-13e8-72aa-2973d3c664d0@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24 Apr 02:00 PDT 2019, Sibi Sankar wrote:
> On 4/24/19 12:19 PM, Viresh Kumar wrote:
> > On 24-04-19, 12:16, Rajendra Nayak wrote:
> > > On 4/23/2019 6:58 PM, Georgi Djakov wrote:
[..]
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
> 

If this is a pair in the middle of the list, we would either have to
define how non-specified values are inherited from neighbouring nodes or
you will get different behavior if you're coming from a lower or a
higher opp.

I think it looks clearer to just be explicit and repeat the values.

Regards,
Bjorn

> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			bandwidth-MBps = <457 1525>, <914 3050>;
> +		};
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			bandwidth-MBps = <457 1525>, <1828 6102>;
> +		};
