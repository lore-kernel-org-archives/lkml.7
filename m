Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37AFC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ADE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dfb6+7G1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKKJZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:25:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46314 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKKJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:25:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so13724195wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QGA/xqmQWev+0NFe4O1TN1YKQ6mW88MJOuhnNp+1ZuI=;
        b=Dfb6+7G14s79tYoH7BzweIeHFTtFG/h2mFENKgZ0C0904ffsK6FkL59yC85qrY1nR5
         q+uIXQu2za9et+lvd+dfO/dSzilQY7Iit+HH4PRs+fPNg5lruFzEJ1m2cjQHE1gvtLV3
         HigANxoBR/CSRpKK2yMZfdhcM2YUBY11kovpoubO7X5Cu5uVVkGWuWzlQjiii04p+91T
         NbfSb1MFU8zaLi1WFs5y9QM4YIoT7bbAPhzLzmez+UNK1vAbSgIgILevTFRAggx9goFM
         qwon6dX5/ysVYJmJZUP0943hXU4mNrBYplzITJSJRO2e/RvC+5X8WVXsidjpxUXLFR2t
         adbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QGA/xqmQWev+0NFe4O1TN1YKQ6mW88MJOuhnNp+1ZuI=;
        b=goBn8a00MfGcmYmSaMh25l1hj2H+X04mETGoqlShNlxTWhXnoAok7jk9IMpsl3j+yy
         2poK44/dkyguWj7gdbum37E8TG7NS1Cdw0EELg/DO5lZMnFG2ZSiUcamu1vbFwI4itZ7
         4pbv/4WUjLNiqF/NE2mPRV54vriViIBBHI7lWk3ejgUMmyClP3wDzh983qAXvwbsiSH9
         9ZtxUIlgc9vnCYcsHzL4QDztwsxO22dO98feoxHem3tZp5ubxaPBT+wZquA/CW6ByPgK
         bGWzPvEaW+NOg+N8R3CVIbm1MEzVQFUXZexf0Vg9oXyJ3/rPhzmaMABeblYBPLsZ5+ND
         Xl8g==
X-Gm-Message-State: APjAAAWI1gbrjyI7Zi1hj+RvjkEs5ERJInkYvqgbpKSDI2MHyUJRUhKW
        Mm0PYbgoZu+/ZiSYSpP4bfa9sg==
X-Google-Smtp-Source: APXvYqx6jDtFgEhErFSeyKkbV8ZV9CUx1Pyx244vdqrZIIvJ1ES7y4XaSdZ6WWpMzxcI9s4XD6bHhA==
X-Received: by 2002:adf:ef0e:: with SMTP id e14mr4205640wro.204.1573464344370;
        Mon, 11 Nov 2019 01:25:44 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id x6sm13916940wrw.34.2019.11.11.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:25:43 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:25:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH V10 7/8] backlight: qcom-wled: add support for short
 circuit handling.
Message-ID: <20191111092536.GU18902@dell>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
 <1572589624-6095-8-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572589624-6095-8-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Nov 2019, Kiran Gunda wrote:

> Handle the short circuit interrupt and check if the short circuit
> interrupt is valid. Re-enable the module to check if it goes
> away. Disable the module altogether if the short circuit event
> persists.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 144 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 140 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
