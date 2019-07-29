Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13058C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF779206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psnZBQy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfG2Jfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:35:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33966 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbfG2Jfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:35:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so21736691pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9x4q40YNu8PZPNIMOeH6iHYV/NmKq4shqC8DBZn6n2U=;
        b=psnZBQy5CgQsotR4fjYCVbWm7lutJhGnn3FiudticeJjy8OTsBbRe5kJQF/0SLksPF
         +DCS0kbRS1PtOXIM06h4Zun8Hs0X42Sa4GCi7iNowPoK5X4BtcDqMC/JjTmrCvt+/d8v
         5kS9pj9ElrVzNRiPBNUeML71Zhfp9QytXreocsBrrUfMNMhfR6KdH33Jm6eLW8O+8o3m
         4Ic1xMZw30pKqBBm9StqhcPddXoBnkvCXoIJ9FnqFWYJdnKQ7BKVoXrj1R9erq/zualR
         S5U1dBfR4Ylz10h8cUeXHA23eZ3zRCpfPly0Ii96aXm58AFxqsU4gJhLVDpnm2TceAMx
         R6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9x4q40YNu8PZPNIMOeH6iHYV/NmKq4shqC8DBZn6n2U=;
        b=c1gIiVtTJRtSpsBAE3R8O/5y5DbNs3TRZrDyNVKNF9xtaFitpV2KwcjngcVh1V5EUw
         ZT8FqEe3xBY4iCduiT57L0bCntpyH7mcdgH2AkZPVC5/WFZH2M0611cVkCzYyUVyx0A3
         uc9kUeCYV3lBjmZoC0XjtLQwEyCOtBXbXwI9vJVHjaC/908EXQS3UY8tI14MEgiosIGx
         PR2mMTtRBlakPoGQIqt9GUJI+vTi6ZHsEdilZSSOYAhrOFSadeikKYOWukKtAY3vGE/R
         ejK2IlepO/wKm/RqbtJ2jgOCF++1+ynMbeTOSCXeQnT0ACuQ3YqTWnVBTwQrTJ61Y/iy
         pEwg==
X-Gm-Message-State: APjAAAVwbLSYKgzKQHuvoY/j8mFNSQjdE70MhCA92a2XgbiPvMMyzzfp
        5nFqd0RmEOqvevfudDvoY4IzWA==
X-Google-Smtp-Source: APXvYqwqE1NvATylQ7IseTvLry6NpXjoeNxFl451clxTeXz3oSDy1YnxOVHkLgnx4/YzllHFERrdoQ==
X-Received: by 2002:aa7:8b10:: with SMTP id f16mr36090070pfd.44.1564392948016;
        Mon, 29 Jul 2019 02:35:48 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c70sm6172721pfb.36.2019.07.29.02.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:35:47 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:05:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
Message-ID: <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
References: <20190726231558.175130-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726231558.175130-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-19, 16:15, Saravana Kannan wrote:
> Interconnects and interconnect paths quantify their performance levels in
> terms of bandwidth and not in terms of frequency. So similar to how we have
> frequency based OPP tables in DT and in the OPP framework, we need
> bandwidth OPP table support in DT and in the OPP framework.
> 
> So with the DT bindings added in this patch series, the DT for a GPU
> that does bandwidth voting from GPU to Cache and GPU to DDR would look
> something like this:
> 
> gpu_cache_opp_table: gpu_cache_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_cache_3000: opp-3000 {
> 		opp-peak-KBps = <3000000>;
> 		opp-avg-KBps = <1000000>;
> 	};
> 	gpu_cache_6000: opp-6000 {
> 		opp-peak-KBps = <6000000>;
> 		opp-avg-KBps = <2000000>;
> 	};
> 	gpu_cache_9000: opp-9000 {
> 		opp-peak-KBps = <9000000>;
> 		opp-avg-KBps = <9000000>;
> 	};
> };
> 
> gpu_ddr_opp_table: gpu_ddr_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_ddr_1525: opp-1525 {
> 		opp-peak-KBps = <1525000>;
> 		opp-avg-KBps = <452000>;
> 	};
> 	gpu_ddr_3051: opp-3051 {
> 		opp-peak-KBps = <3051000>;
> 		opp-avg-KBps = <915000>;
> 	};
> 	gpu_ddr_7500: opp-7500 {
> 		opp-peak-KBps = <7500000>;
> 		opp-avg-KBps = <3000000>;
> 	};
> };
> 
> gpu_opp_table: gpu_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 	};
> 	opp-400000000 {
> 		opp-hz = /bits/ 64 <400000000>;
> 	};
> };
> 
> gpu@7864000 {
> 	...
> 	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> 	...
> };

One feedback I missed giving earlier. Will it be possible to get some
user code merged along with this ? I want to make sure anything we add
ends up getting used.

That also helps understanding the problems you are facing in a better
way, i.e. with real examples.

-- 
viresh
