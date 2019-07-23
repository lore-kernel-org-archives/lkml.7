Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93201C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666ED2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563910263;
	bh=mbTmS1LZImw57qCGpPA/d2LPrQGTEffRKbLn+C2T+8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uSVkuRSGPYMyH4iwkJQ1vp0Lc171npmoheg6nVcWjL7Gfv4W5petnrkoK/u3eQVvN
	 K0N8yFKIhSY9jYdEusRhpfRfcG/yPTfO7sivlgNlsvCe6XlHGqrD0SDRTA/9vGrrMM
	 z21D4GconwLDy1g6jf/VqRTru/1dUEeADJNWOCe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfGWTbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 15:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfGWTbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 15:31:01 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99A0229F4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 19:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563910261;
        bh=mbTmS1LZImw57qCGpPA/d2LPrQGTEffRKbLn+C2T+8M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1SKAdmGIP5V9n4U3iDtQgoUB4KJNKHm8vWv83J5jUAGHPq2I+9IegTZY0Reev5bGy
         h+bTqfnNy06sW3hBXcbfXbrziQqYMLnZ4LMzIF4jlaXA9DYm6C23J9oKJjdwHT4o6p
         sBh0foHkyMaToOgevEUwzxRYpjVKkYd1NKT24zIk=
Received: by mail-qt1-f169.google.com with SMTP id x22so38102648qtp.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:31:00 -0700 (PDT)
X-Gm-Message-State: APjAAAWAobG+FFLpvV5i7WxcoXaJnyh0V6UVnlJHr4wKOezr7p9vBaNO
        2FSr43o2TaYCahBAHHjdc9N7MEMS6FB9f5YE3w==
X-Google-Smtp-Source: APXvYqzkONB94qiS0aaPqoXHPWiUsz2yZHq4eyfhIpE5HUHXaIbrO3XgPshMXsWt7ElpDdO9ORrX5rUbMT89+jDiA6w=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr55983683qve.148.1563910260061;
 Tue, 23 Jul 2019 12:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190723181624.203864-1-swboyd@chromium.org> <20190723181624.203864-3-swboyd@chromium.org>
In-Reply-To: <20190723181624.203864-3-swboyd@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 23 Jul 2019 13:30:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMmQdvQmybXbGf_CZkvd1TTeMBPyk3uEUOK9Vz1+9PNg@mail.gmail.com>
Message-ID: <CAL_JsqKMmQdvQmybXbGf_CZkvd1TTeMBPyk3uEUOK9Vz1+9PNg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 12:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.

Nice. Would be nice to see this for other commonly called functions in
probe though we have deal with cases of failure being okay.

>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);

What about cases of pr_err, pr_warn, etc.? And the subsystem specific
prints like edac_printk and DRM_ERROR/DRM_DEV_ERROR.

There's also some cases that the irq seems to be optional. They use
dev_info, but will now have an error level print. That's fine with me,
but some may complain...

> )
> ...
> }
> // </smpl>
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
