Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA26CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B8A21855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572620924;
	bh=9ZozyuUmqGAt4fIzfc2WuteRl9FmXNAfuDCCnSzQ+wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AhRiyO6q8XIeYz+x8l9z6tWbDso6uLiHQYwJ5iWqWeoOrpWha5IDDkomrPr/zqdxt
	 bRUp+GI3khyNWFche7qqzYQuKcz9qlLU8pFLF268CIqVpTbrCZU+10MfrYm51PjQjF
	 Io4iLg7sMBXahKhEwpiMaa9t9byG8pb1l7mJbwUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfKAPIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:08:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36497 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfKAPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:08:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id f7so4681694edq.3;
        Fri, 01 Nov 2019 08:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NCA9Ywds0P5FtYhKbL0ZOhacAW+Sgbwam/HrJvvslJY=;
        b=j64H2Aidw+d4TISmlyGQWUqPzze572o6HMXzvGHjJ1QLKJPrl8E2oQZS1jRsh4mtIf
         7GCz4N6IRB9D4r3GzDnZrHcBRWicKDWLBl8D+L5AGGIa5ySjqhJup1ErUSDuXQHiXgeZ
         hCVZm67A+NWI1lE4kPA6mBsQIAQeFpkJWFqKxccrYG0hH4/p0bcyjEUGO07Oj6aDr0Im
         z5cBiqzwbfSeiHNBp6mIqxmK4f4FXyEAHrHdpO7V1tmFCizC6RVw4bGFMu0pvBLh/jZG
         yya2MMqjzaelLQPGzTL+4WD4z/vb500NPxJkrWjsxmX7JSAA1nuhnFIGmXVTJ5fRdlP8
         6PTw==
X-Gm-Message-State: APjAAAWfpnUK0F7uDbBr5A0JExHKKDj+ywLQzYuR2rm7ekgXtBtyypO2
        JoGxFV+J96Qlt4vYrPv6tRsxkP3t
X-Google-Smtp-Source: APXvYqz1oXEM1R4/Fw/Zy1uABO2AhD8TJPWcq1yuq6FLsl4iDg7WIaPr5LUB9vpgSRK/B8wheOa5qA==
X-Received: by 2002:aa7:d4d8:: with SMTP id t24mr3231114edr.40.1572620920724;
        Fri, 01 Nov 2019 08:08:40 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id j17sm156379edr.94.2019.11.01.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 08:08:39 -0700 (PDT)
Date:   Fri, 1 Nov 2019 16:08:37 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] power: supply: max17040: Add IRQ handler for low
 SOC alert
Message-ID: <20191101150837.GA28931@pi3>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
 <20191031184134.30621-2-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031184134.30621-2-matheus@castello.eng.br>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 03:41:31PM -0300, Matheus Castello wrote:
> According datasheet max17040 has a pin for alert host for low SOC.
> This pin can be used as external interrupt, so we need to check for
> interrupts assigned for device and handle it.
> 
> In handler we are checking and storing fuel gauge registers values
> and send an uevent to notificate user space, so user space can decide
> save work or turn off since the alert demonstrate that the battery may
> no have the power to keep the system turned on for much longer.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 65 +++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 5 deletions(-)

This was already reviewed by me. Where's my tag?

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

