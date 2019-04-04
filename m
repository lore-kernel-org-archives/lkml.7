Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D24BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FBF20645
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMh8zSet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfDDPjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:39:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34314 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:38:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so2536237ljb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fdPQ/COXOFDgaHILjHxj4hoJZJg9QfhmE6Shb3yiqo=;
        b=qMh8zSetyu1VMTZBXA3TLuGukIIWTkaJm0X9gluiHmYSBAkwQm6xV38V5TVOFrA9/l
         EZTLVKTKzYH4MaRX7kt0QD1z2TSY1UNunqytYPqmTA1qC6eHh9a2NJTcqJiXHN5WdiPd
         a7R3g2/97/pVHvDV2PThxmhyj2qPHrjjE3aBMmvi4IrOq2terIZxs/VkuQQ2Ma3RCXLH
         7CpqIVymXlHHP5kDi8WUzqt5Ygv0W8enEtZKxWossvTUH16weXukWSjuiX61brWefe49
         7sIZWaz/bNLLY/Gy8r4iJepsjZK+0ouyznVYtehrtyTTy1CTVcw/h+TDlB6JX+skSkF0
         c8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fdPQ/COXOFDgaHILjHxj4hoJZJg9QfhmE6Shb3yiqo=;
        b=EuZT5orTwUZGZXbXd+eHsiqguSYET0sQzNYs1ALZRa3hiSJbwuaY4YZ26BrzZrKIVF
         WmfuQBfB7QetOLK8A8CmG4bWELUal3ssO2cYR5s/xQArI1fyRiLi3Dn2lqOz10K6T3ql
         z46Lo+UTw/jmoLxbpHkn0wLNte7Ii9qxfV8bmqeBCmsFQDgG6ZhvMQh5+srbPvomOwVY
         0Bm/E0JUrrvSKXqisUQoDf23h4nF39QxJPi/7s0AiQVaPQPRcI+HSUoE8LH3PsgyRRRw
         KLoA7zurF3MhNtoIryAXAuQ2wvcxVHkErgWPQOhFOoBgQeCVMXcEJouUIpRGi1MGpfcb
         dBCg==
X-Gm-Message-State: APjAAAXP5fI3ayPzNK9Fy9BOLrEpMaiZkkdlWQHpwOl06ARkgCBTRUkz
        jxiKylmxlo/0ScpNszifdaoCRIX/80GVXwUHgv/9Rg==
X-Google-Smtp-Source: APXvYqzTD1ZOG5UlWynnlODB8x3xxch1LutzmqRufAuT173oALBbpiLbCA5yILNE7sIjOLdcIRpiYHbhLuRp4ihu9l0=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr4087348ljg.103.1554392337308;
 Thu, 04 Apr 2019 08:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-11-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190403124019.8947-11-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 22:38:45 +0700
Message-ID: <CACRpkdanoV-cx8sy5=imdznud3Q_=6N+QnROoqWg9OtPqgbwmw@mail.gmail.com>
Subject: Re: [PATCH 10/12] i2c: stu300: use xfer_atomic callback to bail out early
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 7:40 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> Use the new callback to reject atomic transfers.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

OK that is a reasonable placeholder.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
