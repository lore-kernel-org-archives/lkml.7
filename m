Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F2CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671232080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+DJg0TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfKAJBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:01:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35789 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfKAJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:01:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 8so1392822wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 02:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w9H6C5mwxHUabRjZS5CCH7OW180B81Cniy6znfZhWb0=;
        b=K+DJg0TPN7ZlAVDrEeZ6Mbx2/BdPDoauyLwl22EktSDllRb4tWTW2ESgXL0M/JXwSw
         aKWW2wWcISV8jqMsZQt1vLmTnYa+4nVgu30MEPJQulNNe6Ee8HNHhOwtjWSYb1Ns8MiY
         rG+TiIC1/daHDyXz1Y9GohussoQU9YfZPOYVW2+ms7ay5wPR0LMWA78waoo2+8WOD41Z
         PwkFG0ZGYj25Giz245Kz7ssc9KjaXiOLlwfqBDCB4XKGO0Vcl+IOsWZfX/d7q/l65/8o
         qGZn80j/Zl+Tf1z8RskUejPv8bZltylGYan6rb8x4qLpokgXY+2JEkr9D2OChmS87M6k
         QcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w9H6C5mwxHUabRjZS5CCH7OW180B81Cniy6znfZhWb0=;
        b=QGVJb/Lrpy+tVzsV/85f/ShU26kDdsW9jyH4CWVS4hbAVN2pS7yirkDF2Q0rlzsPeb
         9MJexJer3u7tZoyZ1lAGcq0BeGu/FvJ4SBMMo5KrzoRDeMvWMmUObZ+G23uRPwM++K+2
         ij4P4fbPTEhPGW1Jmu0Xm0SHL9pm8nuN9lmTvX8kxJl0sXyx+ATb46cX6PnRpeWdNZ6/
         Dyp9ZwStk0GIFbJeuODgIYAMrhRepUywQzt5cdJNj7gr1fc34rs088XqCNRQigCpbBdj
         UI2Z10hksDiZC4kwSqyGeyxG9E8S9DNwjnHCk0rHpxIkZ/gAw0nwP64b3wWGGIvT5efv
         hU8Q==
X-Gm-Message-State: APjAAAX71Zu/3TPR4xJS55CsUkY+Fsez+5FrfIObYunZrtOyFoppU3bs
        YT0Vgce3qz10Ahn5ynFJWVW/9A==
X-Google-Smtp-Source: APXvYqybMcloyFbmbF1Y/Sk/rON3MWYd0PnCqOjPSeSEVDaPAub+pipFgNF+3lxxBvkZdcx3cVeVKg==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr9378244wmg.166.1572598873687;
        Fri, 01 Nov 2019 02:01:13 -0700 (PDT)
Received: from dell ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id i71sm8776266wri.68.2019.11.01.02.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 02:01:13 -0700 (PDT)
Date:   Fri, 1 Nov 2019 09:01:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: intel_soc_pmic_crc: Add "cht_crystal_cove_pmic"
 cell to CHT cells
Message-ID: <20191101090111.GG5700@dell>
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024213827.144974-5-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, Hans de Goede wrote:

> Add a "cht_crystal_cove_pmic" cell to the cells for the Cherry Trail
> variant of the Crystal Cove PMIC. Adding this cell enables / hooks-up
> the new Cherry Trail Crystal Cove PMIC OpRegion driver.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
