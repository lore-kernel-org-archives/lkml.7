Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2212133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeJ7+BIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfDJDvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:51:15 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41203 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDJDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 23:51:15 -0400
Received: by mail-pg1-f170.google.com with SMTP id f6so661739pgs.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 20:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aSMT1m7f0apIK0kK/rQKyjCoBDQkWkakkLdNZuhWhG8=;
        b=QeJ7+BILYlzYsGFq5x0Qe/Uqwm+vDDFTlfP7VHyfMLRvaUXvBNMjJ4Y5QKxFyFK99a
         rr3gYFBsgozJlUwipx1ZnlxBAhDr1epdExLJMODJE4AvlpXxB09CfDHGQSelVbTRHIrb
         YHkDDSvGcv6Ym5bX/I3UmHRGTa3Zrw5rTjoSQDUGQkNzNnGieYBFr8pF7Nbi1Rf/n1y3
         08I3tTSWkvqgRlxZqbBZR7g+CCTh2TA8dTumQhXNXHmF2oJbHEyPd1ZhTmQu/ZZ+G3dV
         l5Asev4IglslJnc4NfQ9rk7WGQVDtAkApJPoAB08RL+7ay8lZX+Ja3M5idYDcLfjdu6c
         PLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aSMT1m7f0apIK0kK/rQKyjCoBDQkWkakkLdNZuhWhG8=;
        b=IgHiIYKiDjIRwpkHRTsTRuh+OZcb/GjW+WDcL8YHyVW/lVtlhy2FLB3ZsvBAAoH6RJ
         yO0fo8rqnqi6Q518u4gK/TQP0GVttoRQa0cLNim8DQlCZd63mAcqSvuQRnudG5SeI3La
         K+dnkXzaN2Y/tosCHYHADfjY2n5SJ+ScZwlXr6hbJdZCd9ElnIH5MuFHfMnb69l5gdFQ
         BaLst85TeyFqYN2xRReRIOSr7tQ9Pt2mh28L4eYa2YWsVgqqy3nG90wtrSst72Xhp2hC
         ahkFWaCd3tfqCNvP/XeT0vONLlAf36mAY2eGTl9Mcs9XIyojrd8FACfozfKc5pgDPZfF
         9BZg==
X-Gm-Message-State: APjAAAUFCqF2ItZ8AmxgV6s+e7iUwKMYCyP/Qsw53fQRKZ9h0TRmPsVn
        5gOBJTgm1C0ayoBpHc1Ac7Hg1g==
X-Google-Smtp-Source: APXvYqxv/3wgOqtpi0oLdefsQJ8pLl+JW5GWXiWY3HLAJhm0MD6Y/Sg4kG/BNLBFN1QGb5Ae1LhxEQ==
X-Received: by 2002:a63:530e:: with SMTP id h14mr3132702pgb.136.1554868274137;
        Tue, 09 Apr 2019 20:51:14 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id s5sm39295259pgv.8.2019.04.09.20.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:51:13 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:21:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, swboyd@chromium.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 00/11] DVFS in the OPP core
Message-ID: <20190410035111.po3dgi5qiu67i652@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-19, 15:19, Rajendra Nayak wrote:
> This is a v2 of the RFC posted earlier by Stephen Boyd [1]
> 
> As part of v2 I still follow the same approach of dev_pm_opp_set_rate()
> API using clk framework to round the frequency passed and making it
> accept 0 as a valid frequency indicating the frequency isn't required
> anymore. It just has a few more drivers converted to use this approach
> like dsi/dpu and ufs.
> ufs demonstrates the case of having to handle multiple power domains, one
> of which is scalable.

I though we discussed about enabling/disabling clk as well from OPP core to
simply driver ? I was expecting that to be part of this version :(

-- 
viresh
