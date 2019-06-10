Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B5C28EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3D420820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVZygW2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfFJCwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 22:52:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43063 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387490AbfFJCwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 22:52:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id i8so6944079oth.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 19:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/MfzJg7c9DX2ZNb9NjuMd10Rr7cerwvLZmvt7k7/+w=;
        b=rVZygW2PoODN+f8HdixyM+h03uiMRuiSR5mD4dSAgGV2NTHG1J/ywPnV41ybe4rEoo
         ITBwsxDeUNl8BG+5hOjA7njHpV0+kDgr9jmsDmJsA/WuICKLQSz/f2wvUApuEqx7vNWA
         iKYWp3VOVBtVEgrDWrjYU8tnxEH3I3eCOXk5LVK1Sx2cI1ICX82X1F6sQ5TP31H/4se4
         HTmWvQpNwAFfNKazu1DQ8I5VRYOiLclpaPT/DVzWCxRvYHo+MjZzODMxtvpzj6EKnlpq
         RVC/JSTqv0kX1sHW60YRJtjrxC/QBzVi9Uy80+0PQNLHIkeF2D/7vv4w+v/VQY+I5ft+
         8ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/MfzJg7c9DX2ZNb9NjuMd10Rr7cerwvLZmvt7k7/+w=;
        b=Wfjj9VBZHKfu7iK4NWQiKAAYp2/GMk7lluzAYUpgTnufLXktJYHnkz3yUc1Wjz/X+W
         S+x4SBbjC46I9Dd5lb31kj4sEdsDYJHBHJL2+nvTaUY2iVeJDMKOLH+1/6ZXXIsVI7jm
         zOPrWFpNgVeetWaW45rY73FnkdSbVMbQ0I/Rm+p1X4MyDerF1g+wlZfoEpF/0znua5lE
         G1vJLjAhXsbTM32XjXLf4NsU8dDqEULxBDOAix0+QTlPGBPKCcXwrgVt/UFrH6LJXmK1
         ytdq9Ryy0FYnXYyee+fwsQMNqGBaFDMLhBfKYkg6LaAbDpWvUjqWByfyfTrf528vDtpx
         b+7g==
X-Gm-Message-State: APjAAAUgVQx7PYxyjBjp6FcPGRGa6GFMcNpfK4NTcqr1GErvTTw0haZ+
        Iq4GDTGdUWf9asebXrq3ebJcXDLiPdNZ/aPPe1LQyA==
X-Google-Smtp-Source: APXvYqxAimTcIhB0rhj7ECSrbtfm8vcFVwPFdfOqnhswkGX/W/CpCR7lAQcIg5CMKXUq/12QVu54SGP+weUrHpQLtLc=
X-Received: by 2002:a9d:10c:: with SMTP id 12mr28837859otu.123.1560135143789;
 Sun, 09 Jun 2019 19:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190609190803.14815-1-jacek.anaszewski@gmail.com> <20190609190803.14815-8-jacek.anaszewski@gmail.com>
In-Reply-To: <20190609190803.14815-8-jacek.anaszewski@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 10 Jun 2019 10:52:12 +0800
Message-ID: <CAMz4kuLHxxDB2SrYZp5TWSk8ZFjiCWPaRX-r_=zpFy+-YM3WEQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/26] leds: sc27xx-blt: Use generic support for
 composing LED names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>, dtor@google.com,
        Guenter Roeck <linux@roeck-us.net>, Dan Murphy <dmurphy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On Mon, 10 Jun 2019 at 03:08, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> Switch to using generic LED support for composing LED class
> device name.
>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

-- 
Baolin Wang
Best Regards
