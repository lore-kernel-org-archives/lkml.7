Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E384C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7CC217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="WkfMoLBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391761AbfEXT6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:58:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37956 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391612AbfEXT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:58:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id p26so6721341qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfJ7Wmu+isnYJEI0NneC1wcTrVYA9eunxNNo2wKm6wc=;
        b=WkfMoLBXlXaD8fN+Z7zVQLMt0cNkLBAr6nPCu0BzVrAL6KLcuTRZxhzhj3Rw0r9aPe
         6scipkf0Hh2C0ICehiVOm5O1NExP1/GNZCJjUMAhD3eAsBxl0MoohZ+wTpPxYPng6VkU
         9ZgOLZbTGSv4gT320oeYwbGJP6w1WPYs8PE4Kqv1dnlB/yf3UtAVXSHn7OAYsVx7cmxp
         rT6io7BGKgFgGtZIR+pKfJuQ2/N7hmMBqFHYLwxTK+ZK0mIRk4YrctauDi2RFZXIvRls
         mV6lR+WDOOGQ9LDe+vr2xq4ONJ7TgNRpzvJS2+7+x+H8XUpN11C7rzzK4ElDPHM5V2tX
         hPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfJ7Wmu+isnYJEI0NneC1wcTrVYA9eunxNNo2wKm6wc=;
        b=Yju9i+hm/UyU4U9mFNbTjuJqe2j/WpH1eJiu+ZGIufptvjxAk/W4nNoEqigfaQXkGL
         UFndDINZRbUUb3YPOui+eJDXq1ZSaGyhd4nkFnLTEV8Ku5b92s0Mm5gqIlL1yrVS+Ima
         OjF6N++wRlrSJRyEyh3hBnllaX4qcAiQtwyOBLu9bBmBdgTnXWltJwM4pbAPs7LA7Ag1
         37s7Fski+6bq69Kxy8UlMg+A0kKHa7kRr4s1P5axQJCo3EU/+5WxycE6BptcD3JAy2ou
         HS89IQB5qDFZAcEoODEKJdauJkMam8ig02Mn0EowHDpyySz2UxfmWLhGWP1+9mR8e/0r
         ZxHQ==
X-Gm-Message-State: APjAAAUql74q69JQHMdpXI/DmREpKyXEerpZcYBgqsC2ZB152Sa6tyrt
        DXK/DtxyJVs6uzIahvkpEqjnCWDAINQ7m1AxhqAERQ==
X-Google-Smtp-Source: APXvYqxQyrFf0F8YAYWWEOD6q14fdkQ741Geyi3ajDMrBap8GX4q0wCbDoN3ZSd/Pt5Qh3urWtsKZNrUeN8cveM5JYw=
X-Received: by 2002:a37:9ac7:: with SMTP id c190mr70006657qke.300.1558727881655;
 Fri, 24 May 2019 12:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com> <40403d07-293a-62a1-e0e9-ad6a2ba84844@gmail.com>
In-Reply-To: <40403d07-293a-62a1-e0e9-ad6a2ba84844@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 24 May 2019 13:57:50 -0600
Message-ID: <CAD8Lp44PeLhTb=g3zz9mfOZpco8ybDqcKDVD6ZmJZL+D_+3X7Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] platform/x86: asus-wmi: Fix preserving keyboard
 backlight intensity on load
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:51 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The error code and return value are mixed up. The intensity is always set
> to 0 on load as kbd_led_read returns either 0 or negative value. To
> reproduce set backlight to maximum, reload driver and try to increase it
> using keyboard hotkey, the intensity will drop as a result. Correct the
> implementation.
>
> Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>

Reviewed-by: Daniel Drake <drake@endlessm.com>
