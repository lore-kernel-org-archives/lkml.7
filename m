Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC16C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B018C214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMSBagKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDWKia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:38:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45669 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWKia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:38:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so13000386ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiY8KxmNolvoyI+2Mm54SFRyzCdd7JND1qQzIZ56ER0=;
        b=oMSBagKv6c30FIWAGhhH8Q2PK2y0XSqApwwJFEW6v5xWwclKPT/VcPnKHUzgs2Wwl1
         3ATrZIxZkQ+gUmIScv5u2TUoGyFr/f3jH082o5d9UhqaOqP2YLARj2nG/XYNav4DYEdq
         3n7gDUO67QQTNhzSuxLb6/2QJLLjWEZ/wefET93r1H3GGFfdA1hEd9mK9jNOerF+XUfU
         /KYG4VHAfUM3fOJaj5FtSAJD8Om3urVtT9vW92IR3IN4v66JG5uBpnDsxLZ0pfCqQb8j
         CIvDP0GAiSPUzxeCZNXhGWwDuAtk9fhuuqJHWVp2da1O9l2jnTxXc+fQ4dT10N06Lwor
         0D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiY8KxmNolvoyI+2Mm54SFRyzCdd7JND1qQzIZ56ER0=;
        b=C9IFEKA81BY03lZqDjb74BO7qU/wELbPLxFS5lQVdPrNIxsh7Toxf9G+6y5GfYXjcF
         d2NJWaoj5MqeI5/gEDu+pMSByDGO4oOf68JFetsTuq7c3wm487+Ky2Vd9MnjaE0ygCGI
         4bx283QboV5X05FyQZ3PYTpXypjxR/1kMLkWEhfrOyqGiKEe4vgjQFgt2HTyOwOVk0au
         pJ3WJbRGyuuxbqsKOy/i5gNFyZ8UY/qIjFOv00nkX9G8d3E0d+XchDYDt/xrtFTq6osF
         LlS1fttmckWK52DfSHyicd4/Fm2wFqVKCKXxbJJxJv7WXbHq87o7tCnEVQBJ53HctLAA
         5KBg==
X-Gm-Message-State: APjAAAUAJGR+xhcBGcToFD/4CMHxEkI8T+YzXn3pEZsUivwvFmD25btt
        cnohlXEmi5iCZ2DoSnTXFqNZQt9fBTwL7zqV8WgS1gHl
X-Google-Smtp-Source: APXvYqwFf2IQnsYtuxGjDbR/fLNI7+KB/VvxjEVtvpME4bV+r1EOxbYtGbBPmz+dDlKeUPoydFJA7N6s5VVg1Mvq2hw=
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr1634324ljj.159.1556015908559;
 Tue, 23 Apr 2019 03:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190415055358.9269-1-chiu@endlessm.com>
In-Reply-To: <20190415055358.9269-1-chiu@endlessm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:38:17 +0200
Message-ID: <CACRpkdanhW206AEj7m+2FQBhJ5epUzw60Y6v+k-eoJLLW_-SSQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl:intel: Retain HOSTSW_OWN for requested gpio pin
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 7:54 AM Chris Chiu <chiu@endlessm.com> wrote:

> The touchpad of the ASUS laptops E403NA, X540NA, X541NA are not
> responsive after suspend/resume. The following error message
> shows after resume.
>  i2c_hid i2c-ELAN1200:00: failed to reset device.
>
> On these laptops, the touchpad interrupt is connected via a GPIO
> pin which is controlled by Intel pinctrl. After system resumes,
> the GPIO is in ACPI mode and no longer works as an IRQ.
>
> This commit saves the HOSTSW_OWN value during suspend, make sure
> the HOSTSW_OWN mode remains the same after resume.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>

This v3 patch applied with Mika's ACK.

Yours,
Linus Walleij
