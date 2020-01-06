Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A5C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACDA2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MA1lw0M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgAFOBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:01:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40542 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgAFOBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:01:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so15360135wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 06:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lz7ikis0geWQiGTegeuXGmTWQm7+VDbN7NPm2DYVWb8=;
        b=MA1lw0M114PfeJblTQ7enuGZIR3qzoZFsrCNUeTMdJ7eUnf+1/2XYPUMQT93mBU6As
         dd6kNjDGv/ol7YKtE//7NFnauJnLq49UiuJYxzUiJZyLTw/8L/sY4tNR3v/3Qm+eNmwh
         r4MYamBx1J2KgQeTIrX3EuOfz9gLiplZPzw0WdioOLeLhO2IbE2W4IbdMS15ujXfv+Ie
         x6KlXPSHVOt/Ma99I7mZgMUbB0GpBvs/lYsL1yP2hYlJR41K8h4SFyaTEmPW6LPFD+V2
         JhYceIC+sevCdYnTpdmDDw6AkwppQuyNFDp27LbS17FN+GzkICIJmvK2ZK2HfkZfSikG
         gWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lz7ikis0geWQiGTegeuXGmTWQm7+VDbN7NPm2DYVWb8=;
        b=mC6Jl6BeoC2YaObjdDg+U+/Xc6niA60wNjHE15dG+/aP0QDFqpACaoW37xBL38ha0g
         h3cgRZEyZKnredxfaELuBWWlpNkd+uCZZDg6TkggxCEtRA4vw0RUQYoRqtSgaSjCPGr2
         9KcbirIpXN2TJc4nBTcn32i0LIyQz138JkM7rCTZCKjVwxrRodsG9NGSHHqSx8ew2one
         3LlrY0QXvlBNgJedn4iaYb0zOMmR/KqP5HM2RP5Vfew3EdZuVOJMC4t+uvXSdwVBMBQf
         nDqC95vaVtv3fR39yF5pe4s5DKE7t3XkTa5PB5KIRnN3+pQZybsxv6t+wOqGv3HRCud+
         U21A==
X-Gm-Message-State: APjAAAXYtrc0j7s2bOvm6mVSTsbr+jaZwfQZshPlvhbnCGDyN8efRcSj
        H/zkZF2mib7xauByUbpiqc/1uytITjU=
X-Google-Smtp-Source: APXvYqzM2jmyz/J2syp2KInXPWWwzhzK4IPDbTGtsIuU/hKoh62sCmhnmHrHpKTCTeKwraFV03oM5A==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr34354871wmj.117.1578319276916;
        Mon, 06 Jan 2020 06:01:16 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c9sm22385471wmc.47.2020.01.06.06.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 06:01:16 -0800 (PST)
Subject: Re: [PATCH] slimbus: Use the correct style for SPDX License
 Identifier
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200104141433.GA3684@nishad>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d0ede580-5abc-b2a5-52a2-bc8ea41a369b@linaro.org>
Date:   Mon, 6 Jan 2020 14:01:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200104141433.GA3684@nishad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/01/2020 14:14, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style in
> header file related to SLIMbus driver.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>   drivers/slimbus/slimbus.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied thanks,

--srini
