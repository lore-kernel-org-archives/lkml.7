Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72A2C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB813217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUcztouo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfEUNAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:00:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35387 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:00:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so2816848wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t8CMJUes+vVZ4X5QvlMrA/4L+K5ilL7nWY+67+tl4nY=;
        b=KUcztouoXRXuFSOG+87SvGvhobOj2HEmDL48edoIPMKJ+FBXyC6sEN+hlbi7GIjKlG
         spSC81snnP4dUzrU5iccrCYkMgayLg6NRxzxSAqycTTbvpmMAd6a8kbY1wAJz2xdeWHl
         E0VGLBgFgl6CxtMJgnLSsCDqtL8YLmsr1BC91qVt2uoMaaK9dcY7v52CGhYZimpqjOZs
         JZbI9//pjONDZorY4AV7M/2xtYdMcXzz6lIY+M4iYemohoYZlcwzVDq4/OtwJVhb5ryA
         fjlvqf8CIVqysmutmIL93UeVunphypyXPAKWjUfw26KJ4R3/RR12Px2Eeai9TV0Jxaae
         8mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t8CMJUes+vVZ4X5QvlMrA/4L+K5ilL7nWY+67+tl4nY=;
        b=fB2gQaAR0E2ZewkAI6QOsE8uhoL3Y//pdR9h1PQXWglMKmx7NWNzPmQHq9ANolNCHf
         W2srdTPHN4WUK6NMv+9zlK10bCPCDP6yGTFC3w0t00bjsu3YMowsnxxmQOh8zWkQrOVS
         c8/6bVA8HumQ6erPLUDCFACzNuNP+rhrYkkoUjfAfsYPVNZ312/Xu39i1pH8+h/b6+G6
         5DckmpBXlufG0/JMB4xJUs0mJ/E1zSuDnUGlgK6DQpv9BIKf39ue1K4BycTU7sVp966N
         bPeUox8TEdQoJYtomJ6EbiSJALD437LgoYctVPTk7o2wUgcXfav1r+K4ZEYsDkEFE4G1
         wFEA==
X-Gm-Message-State: APjAAAXzH7T8znFVKVSTeMD8r/DE6pJ3cGZCFOoIcx/vZAMWQWfJ3u3+
        MGU2lV8kAnAZyIqPY5rbvDSShvvwcNjk/w==
X-Google-Smtp-Source: APXvYqyJYrr/jqA+f39gyEZBL5tG6/F+Xe5A0vgniLDLyfy2q6DbqmnYgxYrHbNW/CtaEzZwlcCZ/Q==
X-Received: by 2002:a1c:c016:: with SMTP id q22mr3167203wmf.6.1558443636007;
        Tue, 21 May 2019 06:00:36 -0700 (PDT)
Received: from [10.1.203.87] (nat-wifi.sssup.it. [193.205.81.22])
        by smtp.googlemail.com with ESMTPSA id b2sm19942725wrt.20.2019.05.21.06.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 06:00:35 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Change to new style
 declaration
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" 
        <linux-kernel@vger.kernel.org>
References: <VI1PR07MB44327103DA9EAE93D5417B3EFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d9ae7069-99e3-75f4-24e2-bd151c0a3d9e@linaro.org>
Date:   Tue, 21 May 2019 15:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR07MB44327103DA9EAE93D5417B3EFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 14:26, Philippe Mazenauer wrote:
> Variable 'dmtimer_ops' was declared const static instead of static const.
> 
> ../drivers/clocksource/timer-ti-dm.c:899:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>  const static struct omap_dm_timer_ops dmtimer_ops = {
>  ^~~~~
> 
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> ---

Applied as fix, thanks!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

