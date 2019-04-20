Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054CC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2BB20859
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XT+otKh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDTBSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 21:18:17 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46403 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfDTBSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 21:18:16 -0400
Received: by mail-yb1-f194.google.com with SMTP id m5so2552072ybk.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 18:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzbY/Yv1Au74aAJ4RNinQbr52uik+Q8k68V9wr+IZQo=;
        b=XT+otKh2aq2TMCq7OpJpGzZjiSnQm2ev7mGIQbPalQaycMJ9olqY13HAfo7rC1xeJ2
         1ScUY8U2LnmpUBAA/Q42axKAIBNIBaa/Xs/jRofRVxypx16TWvV+6I28NlFGmNW/I+Q+
         LRnPIe5Wbp3EuAbw73V+30q6eiEws6vAbLWYnbxqpe3EME/sHHkwerzuESkOUoym8/JB
         nHiUPhtljlnP/GHjkBvMIbrJ/EVOYy4J9QEIqrTZz/bObfxUMTPD05qPlOzi8zl3Eiqq
         KIWy0MxHNjEw6l+FXJG45z249Qo+V0AgQotcRjlnCUuVMDOijWVT6Mv7Yhl9C7M8L6iM
         dr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzbY/Yv1Au74aAJ4RNinQbr52uik+Q8k68V9wr+IZQo=;
        b=T/P71IfEZ0Iu75Fk/tyHNVB8DY8stVsVH1CW+tMX+QrzM1nEYy1TBOmrFLi5IG3Bgb
         rVWzT2eXplyo1dTgIX28QCa6tUXQS8pRoHeM07TalKlqvDvzSQZ3SUqkCr1nk387oa3d
         6fltw5OXXvLuAD/iqkM7vSBz4Ro1AIEZ4dZ2ARTRa/oemb41niyLMFGaLxf/Q89NMK7a
         P4ej+4v6JFd/Lsri+jLNkfj3ML7J/GL6/zHgePS5DesidZa/yhjSFfhlbf1xw6nJ2JOE
         tkOztQRRmteu18mB9/Cuk6plhEpaGR4R6KdasO4zg651WNDYUOmcyx3vGH6+dEAKgWiX
         Cr0A==
X-Gm-Message-State: APjAAAXEHoPxL23I44IkfE29RTgNnDO35lPVPy7/PHgUgKziafTmJzoJ
        24jAVLyOW4hKmg2fMrBJn0o0Tg==
X-Google-Smtp-Source: APXvYqywpLuB9cPOPhBt4vZEAu3fSMKmOl2SFtJbV94NWtA8VKZn310GxRdP/GUdaa7D9pBZcVxgVw==
X-Received: by 2002:a5b:d0e:: with SMTP id y14mr6053164ybp.103.1555723095719;
        Fri, 19 Apr 2019 18:18:15 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id b205sm1211752ywa.82.2019.04.19.18.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 18:18:14 -0700 (PDT)
Date:   Sat, 20 Apr 2019 09:18:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2] clk: hi3660: Mark clk_gate_ufs_subsys as critical
Message-ID: <20190420011803.GA3759@leoy-ThinkPad-X240s>
References: <20190320100508.6950-1-leo.yan@linaro.org>
 <155571244214.15276.7318614591453533548@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155571244214.15276.7318614591453533548@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 03:20:42PM -0700, Stephen Boyd wrote:
> Quoting Leo Yan (2019-03-20 03:05:08)
> > clk_gate_ufs_subsys is a system bus clock, turning off it will
> > introduce lockup issue during system suspend flow.  Let's mark
> > clk_gate_ufs_subsys as critical clock, thus keeps it on during
> > system suspend and resume.
> > 
> > Fixes: d374e6fd5088 ("clk: hisilicon: Add clock driver for hi3660 SoC")
> > Cc: stable@vger.kernel.org
> > Cc: Zhong Kaihua <zhongkaihua@huawei.com>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Suggested-by: Dong Zhang <zhangdong46@hisilicon.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> 
> Applied to clk-next

Thanks!
