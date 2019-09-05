Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7054FC3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4747B20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQNQsZxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfIEFB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:01:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36959 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731163AbfIEFB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:01:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id b10so694408plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 22:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SUBeohh+HfbbNLC2vNWJGf1wy1Gdj58+BXfyMUrKjoc=;
        b=lQNQsZxYsESZuNfE0/YmQ6QEjfkBMP2b5Cq9hW5SSuH4ZmInwZ+bEdgwHTQBKexs0l
         mm0PIiuvSihKeJKrtU55xFyIXXKbfpkaUUHA6LciwO+kh3SqCIR9dRisUpjIKrdmLCH/
         aEU5hKRqdQraaaOa2/U1+8xQssGgrCYcV84OknuhvYOam+Zusks1aoH2zBwhNfOdrPqw
         WPpvMOU8e5zTBL/stzc3L/IDjgE+sj3e8ePSTkncNQklhRJacblNFNi5XBs2m3VZpkLp
         PzcLlF6mvd+UN7b3K2oVTrAaCu+B9Jc1ZCiBw1+rbT9eITC/YqJtkEA2jAMHxi6euTGE
         tnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SUBeohh+HfbbNLC2vNWJGf1wy1Gdj58+BXfyMUrKjoc=;
        b=sZznDlapGtvo/LYFHjabtMpTrkkjjF7pVQvn9OQpoPwCMwGZe9Ch3BaIZh9m1sgGF3
         VgbADJm14Ueb6YunKH4dychZj2Rnf3rPVrhoVZuLorD3bjcOzV697t0TSRjyBCJuKELv
         PikxSiurfqGWFt5bBD70xtxmRV86pUsXzyMWjp4FL2l2KI+Qdn6VPMs21OjzU+SBXR5Y
         ujVpPBieQyCRiZdmxYrR7FbvVVMGtku5M+WCmBuLsC3o5GZ1eg3XcZpJiyDQtIGf/DJj
         10MYWUOZldKbpVDTLyu9TXK70bF5fEM9f4VJT+bJGjklaIRQT9u2/LrVv0/9exHb2Xz8
         2r+g==
X-Gm-Message-State: APjAAAUNDFHaOIhQdlzd82Kw+yfy8qzg/wpYOwuNbbOSvCeuOUSynEga
        2yfqheNFL4H3NhYMBeZeaf/Szg==
X-Google-Smtp-Source: APXvYqxLKp/hQTBJFZg4bq2XsgfOo5v+1kCisfZEZTN8ZhsozLd3tLyYaMrWDgM/E+T8p4eXRva++Q==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12mr1410313plb.129.1567659688106;
        Wed, 04 Sep 2019 22:01:28 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id p189sm1181543pfp.163.2019.09.04.22.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 22:01:26 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:31:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Message-ID: <20190905050124.kopzxxouuuta37n6@vireshk-i7>
References: <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
 <20190819090928.pke6cov52n4exlbp@vireshk-i7>
 <b831d7c5-c830-fd65-20cf-02e209889c28@samsung.com>
 <20190819112533.bvfyinw7fsebkufr@vireshk-i7>
 <b7093aaf-ea56-c390-781f-6f9d0780bd8e@samsung.com>
 <20190820030114.6flnn2omeys3lih3@vireshk-i7>
 <06ccff05-2152-4bcc-7537-8f24da75f163@samsung.com>
 <CGME20190820092123epcas2p2170ae19467a5fb19fcfc1acdbecf9381@epcas2p2.samsung.com>
 <20190820092113.gojhe3romdnvm7eu@vireshk-i7>
 <4e6379a7-0d4b-8e0d-c225-49976b2587e0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e6379a7-0d4b-8e0d-c225-49976b2587e0@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 14:37, Sylwester Nawrocki wrote:
> I have changed the code to use dev_pm_opp_adjust_voltage(). I was wondering 
> though, what did you mean by "triplet" when commenting on this patch
> https://patchwork.kernel.org/patch/11092245 ?

The voltage value in the OPP core is stored as a triplet,
min/max/target kind of stuff. You can check DT binding for OPPs and
see the details. That's called as triplet.

-- 
viresh
