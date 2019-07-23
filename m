Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F03DC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0542022296
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoYY1RAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfGWB4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:56:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38776 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732131AbfGWB4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:56:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so19917767plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CzAyOVJiJ+crp0dyJDyW4Uoxcw0DAIBLgfBcpgWpRTE=;
        b=LoYY1RAS2JNfm6BNv0oVp61iAaOaXZRwIMWDs+xz1wuORHIMPs5XMsgo95ZYK10qMV
         Sk8m8TY1R2ZEqd17Nm1wVugMbXJkHIEEIPNvVfi+Mqxr/GdOGGVc2BqchZ5ie/vCOBX/
         UZ1tOlpvGrLeUX+dNfUg6B9F2yTh3l78AwMin1IYI/NG1jC60eEFYPs3Mi95oggZZcbX
         th9DY8cA3D4A8jbnTAdUPddIEaHBFJV5G+gW7dyTOw+rYf7ex45hyEbRBFGZaZKx6YCW
         VNDP2zsaJJkyLJBw9HRjoLnkoIrkthWLHEx27PGfLqZI8JsgoxOZZMfKTyjVEt2ItovN
         BmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CzAyOVJiJ+crp0dyJDyW4Uoxcw0DAIBLgfBcpgWpRTE=;
        b=c6qlm9+Itkw4xgpMbhCDZ5vn00gajo7vI1dTgAqXAeg4ks7XgEwt2mpj2SaJYvncdK
         c0shz9SWRzbDFITlRa2MmZ3e5EQq9UJoxAgkNM71WOplIibwguE43lX4xtGEAq9SmFK1
         jh/H406hCrCPAGM06yyUomAvec4bESry6xmkYo1ARvKTJHCUJc7472M/9CJkYMcqRaF3
         D/cs6qvCd00hT2h20QwwZEnRAOLz6xYhe64h6PqjSAfi8o4cRIrunpxSdJUZIvOQjqx8
         vvZNuKS1YZ895MszmL3V3PfJzu9f+/VGSXvPwRJPcpTnDJsr4cLYj/0/I5nJMnw2eRs0
         PBng==
X-Gm-Message-State: APjAAAUBDgN7HsPqE2WIiD3KEB4i//QBpCHWsA0+KqHEreN7FXnqw303
        36SvU3tEXJi0Ot+kbqWnTrEDdQ==
X-Google-Smtp-Source: APXvYqwr3DtyxnI94tRYYNP8pfrGZYXogprcPFn8oIrkLVKv0frSc1VdTB+BJi+vXTMqvBSZJHv/5w==
X-Received: by 2002:a17:902:24e:: with SMTP id 72mr36026735plc.65.1563846999629;
        Mon, 22 Jul 2019 18:56:39 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o24sm77193811pfp.135.2019.07.22.18.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 18:56:38 -0700 (PDT)
Date:   Tue, 23 Jul 2019 07:26:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] arm64: dts: qcom: qcs404: Add CPR and populate OPP
 table
Message-ID: <20190723015635.rl5a2isjnjn23fzh@vireshk-i7>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-12-niklas.cassel@linaro.org>
 <20190710090303.tb5ue3wq6r7ofyev@vireshk-i7>
 <20190715132405.GA5040@centauri>
 <20190716103436.az5rdk6f3yoa3apz@vireshk-i7>
 <20190716105318.GA26592@centauri>
 <20190717044923.ccmebeewbinlslkm@vireshk-i7>
 <20190719154558.GA32518@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719154558.GA32518@centauri>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-19, 17:45, Niklas Cassel wrote:
> Hello Viresh,
> 
> Could you please have a look at the last two patches here:
> https://git.linaro.org/people/niklas.cassel/kernel.git/log/?h=cpr-opp-hz

There is no sane way of providing review comments with a link to the
git tree :)

I still had a look and I see that you don't search for max frequency
but just any OPP that has required-opps set to the level u want. Also,
can't there be multiple phandles in required-opps in your case ?

> If you like my proposal then I could send out the first patch (the one to
> OPP core) as a real patch (with an improved commit message), and
> incorporate the second patch into my CPR patch series when I send out a V2.

Send them both in your series only, otherwise the first one is useless
anyway.

-- 
viresh
