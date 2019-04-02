Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF69C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672D7206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5sOoGGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfDBDww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:52:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42090 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfDBDww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:52:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so5533620plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YvAKlCDUtqs5douNrNhpOUClKLL51IqifIliYlE8BB8=;
        b=Q5sOoGGO+64+707vRMFTb/RcZVhJcALQgpAsIfqHVOvNrs6eQAZ6rJPJH+REf8u63b
         /klfTWe2oDlPof3+YYZqgFpintnBlERyxBusdQ1XAQGXVJHMuObe/yQBUo4ISPA/PS5T
         sqPZknuqMEphj7W5DGz2NEB2jBp157fXr/blCmOLDN0CEvR1/4NJ/B05bv4TgNJAHn21
         zaSWQQWu3Gt3hi7dvYWvgsK8oASF+e/0PUS+Z7N9YkmTb3Zre96PmnSAY/p9g1PAdo4G
         wySpO6vW972uQ7bmY5DtuEBgmkDhqyEUTK3pllLo31UAYT8E+xsGUJ47PxoyK12hidpT
         JLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YvAKlCDUtqs5douNrNhpOUClKLL51IqifIliYlE8BB8=;
        b=KGnXoXpspvzml7V51TAgdqOAB2+3m6ZSeMRdfDTEJZyIyDTwRACoMQ62pjSetzP/QD
         4YCzfQCyYMIfzvrLR/qMcgDjhIF0rlezm7Svu26nUPG/qQ4CoN9scUtHgwTiLFDxqTNg
         ucORbkkgUIAHUOt22rUoTI7GDA2pXZNyhsucNy5y9dKpZkM0iPuhM5JE0Hp+8LWRzRA2
         rx4IY0e+mgVBmHwd2t5HtWTP7u93QJvtbVuWcvus2ox09DUhJvw39SZ38MYlOxYGwuyn
         M6g4eV5nqJL5lzemwljNjA58hmNRXU0uStsAyeSR9bTHrqhuaCkt/kUGV9rHu96Z/4bT
         vuVA==
X-Gm-Message-State: APjAAAWpSJYjnD9R1826Zoc1wM36Xp5RYHxEja5s5TM75rrZI5d09zBq
        ar0PtxB5BP/5g4Kq0qeKgSJS2Q==
X-Google-Smtp-Source: APXvYqzzCULT1DkgzeFC+mNfYQiKqhDdfBW/G9Y8Hym/ZS9A4zx+ULRiBhZdS4BzCyZPWmhwVdm53g==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr31507756plb.24.1554177171166;
        Mon, 01 Apr 2019 20:52:51 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u26sm15294128pfh.42.2019.04.01.20.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 20:52:50 -0700 (PDT)
Date:   Tue, 2 Apr 2019 04:52:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] mfd: twl-core: disable irq while suspended
Message-ID: <20190402035244.GI4187@dell>
References: <20190223114754.16286-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223114754.16286-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2019, Andreas Kemnade wrote:

> Since commit
> 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device for suspend")
> on gta04 we have handle_twl4030_pih() called in situations where pm_runtime_get()
> in i2c-omap.c returns -EACCES.
> [   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [   86.485473] printk: Suspending console(s) (use no_console_suspend to debug)
> [   86.555572] Disabling non-boot CPUs ...
> [   86.555664] Successfully put all powerdomains to target state
> [   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563751] twl4030: I2C error -13 reading PIH ISR
> [   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563812] twl4030: I2C error -13 reading PIH ISR
> [   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563903] twl4030: I2C error -13 reading PIH ISR
> 
> This happens when we wakeup via something behing twl4030
> (powerbutton or rtc alarm).
> This goes on for minutes until the system is finally resumed.
> Disable the irq on suspend and enable it on resume to avoid
> having i2c access problems when the irq registers are checked.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/twl-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
