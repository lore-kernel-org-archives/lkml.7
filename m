Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABADC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AAB2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCxXHuzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfHSIhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:37:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39337 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfHSIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:37:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id z3so634129pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MLF4tD6+FJYl38ePAWlkoj5Z15+ny3oYCgbHrSJNz8A=;
        b=LCxXHuzlxnVHVppnji+DvHkFP/SZLymrp5bS89fSrkUX9wmkOXSaBohOb7SboQaqF4
         lfmi3bvVVib3WfL4+7WDoC8xYs+s06jY207Ob2AfP/3njR2W7SomPIqQ9waB9mwUn0YN
         c05eHQ8l8d9OizbMy/elctv0YCkurzezb34QQ710k/u2H/d4cQy/6Ws1kxU3yIiSnxvv
         EIhQPimc5Zx+TnB2PZgZihS+V/hUdmY6H/AmZzhTg7XiFMYt6HB/JqGoTvjQ3h+b4FTl
         cHD7uh1oD0VMfE203q/6vB2yuwb0rctRYFg/fFid3KKinDq1ArBn34NHt/+21a37+Al3
         W3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLF4tD6+FJYl38ePAWlkoj5Z15+ny3oYCgbHrSJNz8A=;
        b=QWnrI9EKwBxRRccwg/GFlF6g+8gFQr6M5mtjSaRU5QCYkdJBgOXUYGGOveFBCbUvax
         w3yX+sfYNt5jME3BDo1aNsvtCiUKln994OTqqqtOKfF3sXhGVAqPjFyGr30VqSykw9Sj
         RjenrYnR/vJyS7wdRf97eHOrABlWbMMCgzNXDAKnYmNlGxqEcgSpJBmYt0nPNIDImF3D
         VE+5S82oQ+q+xei7gifGp+K+ZW6yrgPl7c9uw7eRfyPWBz1HNWbN92CAFsZyS3fA3nI5
         R28d4yhVaCtf0pYFoTrS4i9bzL3hWsLB9fUlAJbcGlW+oLLsX+Zcp0mXS/9/7mDu7ycJ
         /GLg==
X-Gm-Message-State: APjAAAXh9Ta/kMr9Jw9bfR89/2ySbvNTHij3sg2ce2Ci6IZFx1my0/ED
        Ir1Tz3b4yszLG8KM4QAuDEZP1Q==
X-Google-Smtp-Source: APXvYqz9ND/C3CgHtCCh37J8vJRsiNrGnMOQWJPmZy8F/EO5ELC+GGDRZy6iFapGHd4fJ+RtC7S0RQ==
X-Received: by 2002:a17:902:5a04:: with SMTP id q4mr21659669pli.280.1566203843709;
        Mon, 19 Aug 2019 01:37:23 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id z24sm20403594pfr.51.2019.08.19.01.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 01:37:23 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:07:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND V2 4/7] cpufreq: imx-cpufreq-dt: Add i.MX8MN
 support
Message-ID: <20190819083721.w75clbpu2vtoeocx@vireshk-i7>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
 <1566109945-11149-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566109945-11149-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-19, 02:32, Anson Huang wrote:
> i.MX8MN has different speed grading definition as below, it has 4 bits
> to define speed grading, add support for it.
> 
>  SPEED_GRADE[3:0]    MHz
>     0000            2300
>     0001            2200
>     0010            2100
>     0011            2000
>     0100            1900
>     0101            1800
>     0110            1700
>     0111            1600
>     1000            1500
>     1001            1400
>     1010            1300
>     1011            1200
>     1100            1100
>     1101            1000
>     1110             900
>     1111             800
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> No changes.
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
