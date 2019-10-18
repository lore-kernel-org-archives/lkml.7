Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E279CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4396621835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeC1eSsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442925AbfJRRFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:05:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37313 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505215AbfJRRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:05:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so4258722pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3AWhLBU87R+tIjbOIzrOp4O2c50HJ77phRCMMuhDr1M=;
        b=XeC1eSsupnxZ2cZz0V/Tb10DmQP8FRk85GjE//57o3i9hmb/DJCAK42pb5JgfbUo08
         xi3/szTMch6NOOcybQHJD08mJdjKhQHWCLatwJkQVwtJx/JKQOO80zRPK3MR67P0Rw6x
         j8E/DnUOqTD//H2VsFjdRQCnNReZ9usDZVBUPiL+kXiPRV05qSvrF0m+KjEdN9FJnWAt
         p9BlwjAxmXMmWU1LVHKdUjCc5Ny3J1W+8U8g/FD95Z6s03ZiBYO3epkhdsuEzrfI4RfC
         S7/l9ansDJJnZYGJAZm7BddnoEQhm/P619/PSz7bGfdkw9oDiwzmyB7Q98pg2kUaxQQI
         xlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3AWhLBU87R+tIjbOIzrOp4O2c50HJ77phRCMMuhDr1M=;
        b=WJjD0yXhimfIw3EkhtYXXHcSK5wAnOebDwot1wfO8ZoUL5yBk7oQ/0OojJ0emgpGwH
         /zIYkPttwd27EK6vDJqMsW+8unhWy/QrfhPycBQt88LV+WXQk82s008qkZqlCpUNbWGO
         ZhMOrG0fCx1B1EigOs3Oy5AUrGAivJzDaVaMCJLKr9DcwqcJX/5BpuZ1i4lWyXgEOh6n
         KMhfpyaGKsYEoJd+7iPvlE04a9E1NyEjGRd9kFLDzygl7YQQFwFq8yLW423fxDUo9q+l
         lPyYhX8YiJII5+x1+m8CLnx9yJ8fTDvU4Md7H28CPklv+khkc6jh1As1FsTHNYaXi4sr
         YUQQ==
X-Gm-Message-State: APjAAAWUxgmnN9/zYK97kIkiflS08PvaQoexYbb7C7armgUFCBOFZo06
        kWOmd+tmkPb2hNsY0q6noA9otA==
X-Google-Smtp-Source: APXvYqz7a3/zrYpGmxBc3pou+oeyNDpKOmnUhi9w1oWvzYGHinizbWe7tR4ZySKQpst4zwh7RFddmA==
X-Received: by 2002:a63:f418:: with SMTP id g24mr11352479pgi.15.1571418334884;
        Fri, 18 Oct 2019 10:05:34 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 2sm8872881pfa.43.2019.10.18.10.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:05:34 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:05:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Enable msm8998 bluetooth
Message-ID: <20191018170532.GC4500@tuxbook-pro>
References: <20191017221843.8130-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017221843.8130-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Oct 15:18 PDT 2019, Jeffrey Hugo wrote:

> This series enables bluetooth on the msm8998 platforms.  However,
> without fixes under discussion [1] and [2], the init process will fail,
> leaving bluetooth non-functional.  Perhaps it is best to wait until the
> dependencies meet acceptance before taking this series.
> 
> [1] - https://lkml.org/lkml/2019/10/17/599
> [2] - https://lkml.org/lkml/2019/10/17/975 

Since the two patches has been applied, by respective maintainer, I've
applied the series.

Thanks,
Bjorn

> 
> Jeffrey Hugo (4):
>   arm64: dts: qcom: msm8998: Add blsp1 BAM
>   arm64: dts: qcom: msm8998: Add blsp1_uart3
>   arm64: dts: qcom: msm8998-mtp: Enable bluetooth
>   arm64: dts: qcom: msm8998-clamshell: Enable bluetooth
> 
>  .../boot/dts/qcom/msm8998-clamshell.dtsi      | 17 ++++++++++++
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 14 ++++++++++
>  arch/arm64/boot/dts/qcom/msm8998-pins.dtsi    | 13 +++++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         | 27 +++++++++++++++++++
>  4 files changed, 71 insertions(+)
> 
> -- 
> 2.17.1
> 
