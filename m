Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB07C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5792F2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9uL31Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfHSGyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:54:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38714 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfHSGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:54:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id o70so604943pfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWJlQTSBEOMCh5nB5DH6siEGtKeSyl6ScBGH9ifHyOQ=;
        b=b9uL31NcY/WwfuxOp5cPuq95N14dbd6KNGhcRQNo2BqseqQDuhhLTS571/TXal5NaB
         xcOaeMCtVeOj/u8L7L+NZsxgVrdJ5eJYzHN8KJla1coSoyV8sf87/OTYZHrK9vbw3pbs
         XcebGCvoaXgFduNAwQjASZC5BOB/HWQrCmXlJuK6aMRFtyGHTcypNsGLnmwjFq1v21I1
         VbcM9t0s5cZdQrYwdZbwsuzdURpOYBs9cbs62dJVSete1KAD/KXv8nVB5LimiECaHoPb
         LRbeaQRi/nZvRoVkJ/kEozuG4urdVr/ZKbI4UfeUmf22492iszcEfbytVCcWZaqdMFrs
         Ng9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWJlQTSBEOMCh5nB5DH6siEGtKeSyl6ScBGH9ifHyOQ=;
        b=L7Dk12OSnDsLj2u7S3jDtQBqlU1H6x8TYtGPsFDcGQD7n4y/9Cw20mH9G0oCfN784u
         RBP7KmBSg5RHdb5UVgQEZQB/vbz6XFknpM7liE479DQP9F3pDO/cZ68w7eOaCbNYotQA
         WeaHgN5OSjwTGZvQ6eof7uZftmXL6IWVvdyRPHKLz/ginaVPj1FQbBICo0+E9mBNCuw7
         2YlW9QUhp0CldtCxPcEjbpQUps1racZilslyz4G6DuZH/xTr0/hQ2n143B5wDNelW/Ie
         EpCNeemEvBRt1ir3rr/WZJHKk6C7o+zVwjH9d9Lwucd4zfjoxGUqedD8pKV6epOCvnO0
         /9XA==
X-Gm-Message-State: APjAAAXCv6vti/cjCBXubDflHPTG9nILu7ZDXgrTKqz2OaJnmpoIXCuc
        JRkwVGOKj9M2k2DEOQWTFtbK7A==
X-Google-Smtp-Source: APXvYqyn6XNQMkA+NZOqYySmlT0/AvqE7dviESCrNc+0i71jmW58wFNIu2D2DzIxJxzZuwGu7xo6jg==
X-Received: by 2002:a17:90a:358a:: with SMTP id r10mr19651582pjb.30.1566197662461;
        Sun, 18 Aug 2019 23:54:22 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id m9sm14943320pfh.84.2019.08.18.23.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 23:54:21 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:24:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     tdas@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, rjw@rjwysocki.net, agross@kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: Update logic to detect turbo frequency
Message-ID: <20190819065420.3ch4cbfdsbbs67rz@vireshk-i7>
References: <20190807114543.7187-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807114543.7187-1-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-08-19, 17:15, Sibi Sankar wrote:
> The core count read back from the each domain's look up table serves
> as an indicator for the onset of the turbo frequency and not accurate
> representation of number of cores in a paticular domain. Update turbo
> detection logic accordingly to add support for SM8150 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Applied. Thanks.

-- 
viresh
