Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A420C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13A32184D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pc8kLgoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfHSJJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:09:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34877 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfHSJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:09:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so677229plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NbQHubvtE7M8Mm9C2LyqFuVWNwA8k3gi8WsBVYz2BKg=;
        b=pc8kLgoVhNLslClp12JPBSjxR0z3JujowkefS6jDPR1UHNdaucastVWa59gQ8D8lbt
         0MGRCHg9mrrnVUEfo2wUi3Iuo4Wu/u4lTKjXKpkr+Tlfx/BRr9ewsDbvTa439fOCKAWy
         gTNy7KwC7wgAB85feFTYk/OxyRVTcFs813go5F4A5aBrEQw9RGPiNr2rZIGcrlgWyz5N
         6pgP0WkpVzuKxOY1AQNKLZxQAzOGxLLYsNoE6uTn4EPuyi7iNjn+PiZk2iz7xo/9yaMa
         nFp2BO9hS20XmNof1YVo4GXNSbggWhClhVXVv57TZFoKGOoMpANkEOqkT11+rV6L9FFv
         LnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NbQHubvtE7M8Mm9C2LyqFuVWNwA8k3gi8WsBVYz2BKg=;
        b=ciIc0g5GfE6vJylLG7DAgVhZQNk85ZwGZQuWwSOTwQi4Uoi6DFIjokPfjc8OSqyaRQ
         Jc+oum2NhmxjZKwYU97incO2p8gxQLOsmp1CW4OezBBAgbrJIXPi9QBL1o37SwsGeSGQ
         0/BfojKjGWPLGhrakC7gRzeqst0qcQG9RnaP9SxMjv/38Co7rKg3t5EG+nqGZObyYLhr
         TnsH1NjJRjg75EsYcgzfIVLxUHAfuPicH6rkcbDZuckWdx1hA9B45ZM1kHyK7PHr3g7j
         UKd1yFTMNdQdWnnogtQQMR/crbZfyrMTl08RntGPBa9VzE/qEYVyHOf5FnGWLYLUFvG+
         1jDA==
X-Gm-Message-State: APjAAAU4nKO3d6QWFkJOsi5VLwRhsklf0M1Or9uLV8++iEDmKUCy50xO
        Cp5HYXDOL5JJlwiABUCXg8awtg==
X-Google-Smtp-Source: APXvYqwkWKQ15NL5sU2NfelXo3wfOTdqz6Icamd3E43Zqn+osblR5WcJ5sPyUi8DObCUnMzd+CCJow==
X-Received: by 2002:a17:902:a8:: with SMTP id a37mr6159528pla.316.1566205772237;
        Mon, 19 Aug 2019 02:09:32 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id z19sm13413609pgv.35.2019.08.19.02.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:09:31 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:39:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Message-ID: <20190819090928.pke6cov52n4exlbp@vireshk-i7>
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com>
 <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
 <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
 <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
 <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-19, 17:58, Sylwester Nawrocki wrote:
> Thank you for your suggestions.
> 
> For some Exynos SoC variants the algorithm of selecting CPU voltage supply
> is a bit more complex than just selecting a column in the frequency/voltage 
> matrix, i.e. selecting a set of voltage values for whole frequency range.
> 
> Frequency range could be divided into sub-ranges and to each such a sub-range 
> part of different column could be assigned, depending on data fused in 
> the CHIPID block registers.
> 
> We could create OPP node for each frequency and specify all needed voltages 
> as a list of "opp-microvolt-<name>" properties but apart from the fact that 
> it would have been quite many properties, e.g. 42 (3 tables * 14 columns), 
> only for some SoC types the dev_pm_opp_set_prop_name() approach could be 
> used. We would need to be able to set opp-microvolt-* property name 
> separately for each frequency (OPP).
> 
> Probably most future proof would be a DT binding where we could still 
> re-create those Exynos-specific ASV tables from DT. For example add named 
> opp-microvolt-* properties or something similar to hold rows of each ASV 
> table. But that conflicts with "operating-points-v2" binding, where 
> multiple OPP voltage values are described by just named properties and 
> multiple entries correspond to min/target/max.
> 
> opp_table0 {
> 	compatible = "...", "operating-points-v2";
> 	opp-shared;
> 	opp-2100000000 {
> 		opp-hz = /bits/ 64 <1800000000>;
> 		opp-microvolt = <...>;
> 		opp-microvolt-t1 = <1362500>, <1350000>, ....;
> 		opp-microvolt-t2 = <1362500>, <1360000>, ....;
> 		opp-microvolt-t3 = <1362500>, <1340000>, ....;
> 	};
> 	...
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 		opp-microvolt = <...>;
> 		opp-microvolt-t1 = <900000>, <900000>, ....;
> 		opp-microvolt-t2 = <900000>, <900000>, ....;
> 		opp-microvolt-t3 = <900000>, <900000>, ....;
> 	};
> };
> 
> I might be missing some information now on how those Exynos ASV tables 
> are used on other SoCs that would need to be supported.
> 
> There will be even more data to include when adding support for the Body
> Bias voltage, for each CPU supply voltage we could possibly have 
> corresponding Body Bias voltage.

Will something like this help ?

https://lore.kernel.org/lkml/1442623929-4507-3-git-send-email-sboyd@codeaurora.org/

This never got merged but the idea was AVS only.

-- 
viresh
