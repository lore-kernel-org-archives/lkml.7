Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0805FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3AD2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzrat69q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfHSQr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:47:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34603 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfHSQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:47:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so1903647lfq.1;
        Mon, 19 Aug 2019 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ew3DQY1/Dy+Vj1B+2EqwrXO/bgBLBuE1m+WOVlZNw9k=;
        b=Zzrat69qNDkyOx6bUdjul9/0REh8MBL9UAfX0aHLTfPO4Yj7u1jxyx6SYwrJdLj8fo
         ucIFzCZgUVUpIFcZAW7T0tWl540lK7SKozSZn3bjuUdC8tGXH/VIeZtcUkFYUaXLBSGI
         fPTywm4DUPlheCPBkNQ9zdIfjghGMGueSZ6lyvfUDEWgm+6++aS8Hcbr5F2vxTBll9h0
         TJT0trrOtUy0/DPtiDODK9ZKAAQh5RkJZuNdnerkLAtvf4RBBlLOcs2KzDtMbttTJOMl
         DfRWNEmeK7Da6+ru63FNSm0V9BMRRmQwnA53fZPitY9O6THMt3vPoyBLuDpEmH095hlB
         ICPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ew3DQY1/Dy+Vj1B+2EqwrXO/bgBLBuE1m+WOVlZNw9k=;
        b=gDFbwyrPTkF0+mLsHsmhg9DJzPUJ4R1vkEafUrzb+j9Y0XAjyuxPfzpiJbDBND6el6
         DJfpe31hwM5fW62xZLwVKhuWZ581b4BWR/cCy/pGS4Fq/jSCTqxQrXl0ASNBwk/2UnwU
         5eXXpvNAUP6Rt+q2Er2cpmZENMOHGiRgRs5RxyHmIWZqzpcVnYk3CRHlsixZFHdkDVAL
         JKYDDqqDUxRlN/5Jlrzbwlh+H2q4qzqvl0K7ZW+hJXoVkWVe+01nqiIQYjNrPpYM9aMN
         eTJBBLCzrqbIkzXMYyvjttZ3VKfhAjIwYL7MVe0myTUTxiEFPgy8kbMM0gLSZS5jd9jb
         vKPg==
X-Gm-Message-State: APjAAAUYA9xyR7X/FaCcqOj4VlcU4MHkBrjiJ3kubMQ8wAce9Rts/hE7
        9AE45wOVFd1zJAp9gEKvaJ3+ggFE
X-Google-Smtp-Source: APXvYqylRRIWkhGbH3c9BVxzslGqbyBV8LGTEodnMmUBoTGC/IS6qv/jaXeotyUzTfjx+hA9HVysqg==
X-Received: by 2002:a19:7:: with SMTP id 7mr11557327lfa.45.1566233274484;
        Mon, 19 Aug 2019 09:47:54 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id b9sm1248849ljd.52.2019.08.19.09.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:47:53 -0700 (PDT)
Subject: Re: [PATCH v9 15/22] clk: tegra210: Add suspend and resume support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-16-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <85b970d7-1a4d-1db4-8d9d-177a7cd4a7c3@gmail.com>
Date:   Mon, 19 Aug 2019 19:47:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565984527-5272-16-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.08.2019 22:42, Sowjanya Komatineni пишет:
> This patch adds support for clk: tegra210: suspend-resume.
> 
> All the CAR controller settings are lost on suspend when core
> power goes off.
> 
> This patch has implementation for saving and restoring all PLLs
> and clocks context during system suspend and resume to have the
> clocks back to same state for normal operation.
> 
> Clock driver suspend and resume are registered as syscore_ops as clocks
> restore need to happen before the other drivers resume to have all their
> clocks back to the same state as before suspend.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Looks good, thanks!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
