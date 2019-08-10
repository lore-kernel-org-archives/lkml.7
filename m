Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67C6C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839F5218A4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyRgTEG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfHJIUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:20:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38813 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfHJIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:20:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id h28so71098272lfj.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vQnFwQNyVp0MJ6ZA472G3A4Wc8Umh59hbB35xxA2KY=;
        b=xyRgTEG01oxAM6kN3jiwijjpejYs6si4w5U6ne3GUJERc2vRfDRBTIkQDJjJqxDolK
         0bLfKfPb3JCYWf66fSjaqCWEhYLa9ycbxRMraqUJswxo9XOPg2BIpaClQ0f73JcLyEel
         wEnlWiq7C+xmB+M/WcGbHGjA8kxNsahgwIdQW7GjRBhTFb7aTceZi8h2lgO57lgqCa8d
         LLRBFebUb2L3VvHb4mCQFOjF8j0sxr/z+Astq+efuh3CLGgNJRcXqdJjUeS1veFlDXrA
         /VoCRELA/ui1hkqfMSw/IObCC0GWhKbL193R8e8nS43qChlzbYB/dfC9rOinU1R9gHyZ
         QEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vQnFwQNyVp0MJ6ZA472G3A4Wc8Umh59hbB35xxA2KY=;
        b=DbDmBZvQI875BLnBHFpiqjiqL80of6Dhe3OXSFy/C59zihh4jOVP7kIAzYU46ytLlM
         h0zl/wIPAGlcJDsUGDe5N4XQTgRFA5gf7Uf3TdgFdazEXJl7Ox7wuBbssMj3/eA8ebqb
         dPA/1oIUksCC4OcnfOfxeqBk5YvmxuAXMRmLKXtT5MjhdS1ciRzaORlKzNkhgqT4dNxo
         ZBSzgq6AQjycEC9Ts29bfPQsb32b6fkBBojhwomcgXGbQaNivxJAC7vSSQ0Dc3O+KfMy
         6IGprwhP7TXgDMYTTeKk9orCXuPQSCU9/aOg8R9NHvCcNSRhspl/TlD97sczVfGmkmLZ
         +CoQ==
X-Gm-Message-State: APjAAAWh2kXSV/29Lho9wTje7HXx7gjfwBR271JS41zyA4d5658+zXxH
        2Md1Rl2cq8Xp+e/m5hpMJrr3kXiLK5KN1E522aLQ9g==
X-Google-Smtp-Source: APXvYqzE1mTpjud1QXbttRnYvBm9iSV2zfdjY1xkGmTm69zvHpAT1DCI81jjIuPyyV8Cd8bHwU5cUrdUSfa0v+ozqu4=
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr14657379lfq.92.1565425216308;
 Sat, 10 Aug 2019 01:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-32-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-32-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 10 Aug 2019 10:20:05 +0200
Message-ID: <CACRpkdZhdp7_ou9XiiAq7OAuXDxE6zr-rHuhEZPi+ErSiLKdLA@mail.gmail.com>
Subject: Re: [PATCH v6 31/57] pci: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 8:19 PM Stephen Boyd <swboyd@chromium.org> wrote:

> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
(...)
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
