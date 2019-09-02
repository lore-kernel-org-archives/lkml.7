Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A85C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF6320644
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4t36eTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfIBJGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:06:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36499 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfIBJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:06:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so13184926wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0GID28MOVw3IqgOtjsXJT38X0mktzIfxk7qKPFjEw8Y=;
        b=B4t36eTzRUg10X2oYdNxqdht2V8mmilid7efZANO7l/f0AtKhN/HTTcWldm5et9WB/
         D8zgaoG3x9ANGJmSrXDSeKvaanVJl5cIdOJK7Mmk0Luvj35cpHGC5V5EjWHwfStmeMea
         yl2kob86RjHU0biSFMF/44xWdj07sODUCQygtk4Rb6fff9NaNPfs27G1QGJcCYTaGF3c
         uw74a3Ro9TE0GVaEjpfh4jgmUZPWIK+RBo4/r5OwH477Z3OWl7dj4KxLtm4qrfAwgzew
         65ia/DVRC1GBFpzPQTH0iMAuFW8lrYm66R2B1LtFF96qrkoPG1dgNXVg+6mZhjv29f8f
         99bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0GID28MOVw3IqgOtjsXJT38X0mktzIfxk7qKPFjEw8Y=;
        b=qRzt8oFbdr6xqdYtRL7iYkiSgP1JScAjbZwpX9c5AZ6OUHr5PR+PtZ3/lY3BrgUbje
         L2TLYZTPpnm+GJVpOJTF02721zDaM/Fty6FNvAZB4p/43NhBCVyABgeOtb7ocKOAtBke
         ow2g8Qcw1Q7ksFiF4f8ii4AOv1GCBIG0epf6iEkKHIbpa9GrdG9B5VQgLqs1RW/s0WIn
         GG1rF6TJpG26NjzhFhGoldNjUXqs0vDTkwyXvXdPXAIqlTtGjinMyCHXHASaWA0VQSvf
         oAfvSAm8tCcKFKgqI2eOTZBe2WPChjXfgp0pmmVTRumHzp4s2XnKfTJ0TO8K7qTD/Cy5
         y//Q==
X-Gm-Message-State: APjAAAXQLDuN3YM9C/msZIVJN+6NBLOc0AlSyF3AHkuwpKqRA0FImMWS
        bIyWeeC4wKrguJKQ2ORZPqGnmA==
X-Google-Smtp-Source: APXvYqyGchDBpbIV0gXn9irGSUfGOAygOBZe+P22P17+hvKlBQgWDe2vziKLR0WrBSi+Ty7HtNTYKA==
X-Received: by 2002:adf:d1a4:: with SMTP id w4mr36364617wrc.331.1567415208695;
        Mon, 02 Sep 2019 02:06:48 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id n14sm49290434wra.75.2019.09.02.02.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:06:48 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:06:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: backlight: tosa_lcd: drop check because
 i2c_unregister_device() is NULL safe
Message-ID: <20190902090646.GE32232@dell>
References: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019, Wolfram Sang wrote:

> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 
>  drivers/video/backlight/tosa_lcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
