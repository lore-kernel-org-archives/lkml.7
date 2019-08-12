Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011A4206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KW8ONCOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfHLH2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:28:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55060 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfHLH2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:28:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so11189629wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dS8QjiscgaenCkX5JpNWRJCTZErDhfBTzMdSan5Q/2g=;
        b=KW8ONCOZFv2djZGwrwT3qFe9ApIehPYn2Uf0giY7150c3caCteu8Cj7AsgSam2n6Ta
         TCGeOGtuI++u8PLcpXGEBsyt2zZ1oS0ZWiJtmWkLDuf26+5M2HrZBiCXlUKy4/rL0ikH
         L0XxnengMtzn09Oh7H+gbjc7mYvuMPODpnk9il6MWnupOqmbBNACFqe4kJmGyCrUvibJ
         lszwFwrd8Z7xfrNHUFDTQcK7q6oE/FoCoOAHHA7EhfKFOoYWSmKVOve3KQ//MZuZ0Qn3
         Bef6qPshoB2TfheVc+nukT6OO4h+yJ2AhBxO0qYkHhdv63ZYG/8tTBWSqPUTh9WqBHoH
         rBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dS8QjiscgaenCkX5JpNWRJCTZErDhfBTzMdSan5Q/2g=;
        b=laG+9mrTxPwPCjCKq2LTkBFQJR5KSXcDYhOpGXgYYpfrs5b5O9KcqerMWcvL7hthsQ
         Hk4sgiyWW7HYe+EKkc7tchiThW2LvWuETqOixDhrupieX8dVLaK+y7MbcppCoos8luqw
         uSWVRtqfwxaAGxzVNey/A0JSVWosX1vwMqAjyntGECX+HyqtaR6qQ/7wpHh7CJI5weTO
         Q+iWMn9U9w+JT13YekziuuBlxYSVoxgJrq+DozxR7HkykWgNl5LHJ1jy5vr8p1MFhatn
         AHrly5sH30jDZWVvuIsyzxWRt9EyJbiVhbBbvHrto9PF2XOzaEQiM13jtIeZd7u/Dwf+
         D6lw==
X-Gm-Message-State: APjAAAWf8IzVfEip3XnFutWZviky+gVaNs4HOWYir1G8ZO9Y1zDdCDeQ
        RJCA1qoWpMwllsomWLuRMAG5eg==
X-Google-Smtp-Source: APXvYqxEBuBXC8JaygGjqRf0m/wRzcZ68vXKYlYTLwKkrehnik6eC5wLYBmkVZsSVd9C1fCP3ZZr4w==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr25867646wmb.171.1565594914227;
        Mon, 12 Aug 2019 00:28:34 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id z2sm15398999wmi.2.2019.08.12.00.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:28:33 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:28:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH] mfd: cros_ec: Update cros_ec_commands.h
Message-ID: <20190812072832.GO4594@dell>
References: <20190708181536.2125-1-yichengli@chromium.org>
 <CAPUE2uvnPfA8y1bqppC3-vZyRKRwdF4evGY8X4c-xP=YZi4HRw@mail.gmail.com>
 <e241dc48-5cb0-3b60-9b84-cad8e80eb617@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e241dc48-5cb0-3b60-9b84-cad8e80eb617@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> Hi Lee,
> 
> On 11/7/19 19:17, Gwendal Grignou wrote:
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > 
> > Note there is a patch series that move cros_ec_commands.h from
> > nclude/linux/mfd/ to include/linux/platform_data.
> > 
> 
> I just sent a new version of the patches mentioned above now that rc1 is out [1]
> 
> As Gwendal said this patch will conflict with them, so we have two options.
> 
> 1. If Lee picks that patch I can rebase again my series on top of it.

Yes please.

> 2. If not, we can wait for Lee reviewing my patch series and then I don't mind
> to rebase that patch on top of my series and carry the patch through
> chrome-platform. Anyway I'll need an immutable branch from Lee.

I just reviewed your series.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
