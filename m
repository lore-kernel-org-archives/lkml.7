Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5A0C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE977222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCSJSGbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfJDVuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:50:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42349 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfJDVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:50:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so5460773lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nCCZUN+AQi6f+HDFRHWw58C6Pgy++nWUft00Pny+CA=;
        b=KCSJSGbENpYq7XL5mKWZqt+1XepfFA+fhBaH5bjKTcle4rfGcm0wRn5t5k+9yOtwDd
         naFsp5svX6yrRDahA5xhDeUXzEzCtQ1Dy7gwyX9R3RRJHzHZvpQuk7C/Cm93o93f5VVh
         WiVgh6y8eSA/Klx7Ikn1hA/zh85qNU+X2qSjO8PV+QJFRzlg8E4e1TCLziZujO2QCiLy
         6uYBd3J5VyjD0m+YGYB0M+W7iusmnu2dzS6ipKYaoszu0tlyolWh7Qp1MW74E27ww1/v
         kWF1LYnV0rGo4W4vqS4BzRDYuWqYHeqxdXgNqp0cWRwbGNLcT6ElG611xES/B+SBxZ8f
         8soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nCCZUN+AQi6f+HDFRHWw58C6Pgy++nWUft00Pny+CA=;
        b=j+yI+G7qmiKr6Q4z08WAFWxMIUfJLEYOD4Rj68jqqpZrnFJdVisnDMfUsSBLIAoDO8
         WTZNeJL+m7EbIKAr2YacYLtZalWJHGJw60S4avvYpTcaVOnuew4Iho6tWWw9MHUGIj1p
         BzfgYX71paZm2kmfXtYNx9Xpz8+XAh2T1K7GRuEOMhARVS4eLSWu+VN2Fz4FLVzqMqw7
         lw1KxA4wBCkjAJgdOIRzNsxb+87aF5Ere6QrguMVRnPmbEaRMGhpAMLCplz0ypxI3Y4U
         fBfI35D8eb8t4w2G1iy/R+Ti4x9HBYzeSObuEl0ypTXmCr6Kg9F2tIiBvASsgwrWh+0z
         vLew==
X-Gm-Message-State: APjAAAWpGLTcNYM428ODabZD7N8+6emPYH80vVtltTeIJvF9V4lgvtlf
        XDrKBzDccUGsbNUCyfEYiT/m6VdH4fGwzpICVCkjLA==
X-Google-Smtp-Source: APXvYqw3KANjP6MBE6jdRbl/rKPm0g8YD9vV2HsqND/p96v/v8xXsNCPpUd92rrbMU93ToBovh+gecB1q607Gmc9d+w=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr10197791lfp.61.1570225817810;
 Fri, 04 Oct 2019 14:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191001145620.11123-1-dmurphy@ti.com> <20191001145620.11123-12-dmurphy@ti.com>
In-Reply-To: <20191001145620.11123-12-dmurphy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:50:06 +0200
Message-ID: <CACRpkdax7jn6UsJOHx2oHpKBpX-5QLMErdZfks-iwTtsYgOUbw@mail.gmail.com>
Subject: Re: [PATCH v10 11/16] ARM: dts: ste-href: Add reg property to the
 LP5521 channel nodes
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 4:56 PM Dan Murphy <dmurphy@ti.com> wrote:

> Add the reg property to each channel node.  This update is
> to accomodate the multicolor framework.  In addition to the
> accomodation this allows the LEDs to be placed on any channel
> and allow designs to skip channels as opposed to requiring
> sequential order.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Linus Walleij <linus.walleij@linaro.org>

OK I took out the old patch I applied.

Tell me when you feel I should apply this, or if you want
some ACK to take it through another tree.

Yours,
Linus Walleij
