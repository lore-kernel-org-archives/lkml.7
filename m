Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7EEC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE8D21537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 14:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9izCbEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfFHOL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 10:11:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42951 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfFHOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 10:11:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so3652585lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/Lc3GoSd97S4UlXfUe20NKseC9kq0KZ3QtIbR+UKdU=;
        b=C9izCbEPkC0U7LlS2yX/MM37xekbGe4fM1HSimFKsiQDuTQR76cxqqyyXa/43/3uxD
         Wwmi9TRwY/+y++1xaw+DeUEvIDIttHGs+5Kg1sohN8+qo6PQfzd/3RWfWxoa6q1UVkIO
         v+mSG1VT1hY5A0BC5Ua48+aRW9vBgCUQ5GeqD+w1/tnOnuXupWcvR8PNo9dX+hvfXfZt
         D03Q0KEn0MOg6ak2mUG2jzQCpWmKQZ5mcZDMtQnuxpKgfM7JG1bKfhq52rNzx3QPFPE0
         6L2SJ7wbE00qzSmSF3Gg5R/jdOcK/pMJabDUWqEdLyHcUM/79Iirvbn4n4mRn5c1Iqq1
         FqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/Lc3GoSd97S4UlXfUe20NKseC9kq0KZ3QtIbR+UKdU=;
        b=V+XYv8ez59smFO0p4njKSQrQVbrA8xufdWwv/+LFRqrikPZ5WGCs8XqFevkI06tpnp
         32KpTNxxtvNsRgcPUG477mCaOcdtKBHJCoKiajomEvuct+a0QfxeqiWvjEutGzDQbuga
         Gyrfk0Sevv38nxecOwAxic2HEGQbnnQ2mV+X21R+mMZb9K5yZKI/pFUwDmhJiTiarR8Q
         1st1urufCQ3ejN/XA8BxzkKm3mKxXYHYz60JemzSg9SyjKjuWbyHmffNohDI+vlouJk5
         nHYp6wlM9JyrcnG1OS05GfaLuoFBDyq+itDO8sh1kTCZsJ3xg6dRA/HMtCmzBaOi9PYy
         8YEA==
X-Gm-Message-State: APjAAAVkepc0A+bQLY2gB50RmDrY7NbDDxqyL7e2YFrOcbXFQBZtQDnU
        kzwemVhqIXbD5AEEG1VEAGG0ZUX5TVxvMhnMRBZt6A==
X-Google-Smtp-Source: APXvYqx2u6ua04Y2DWZCjnRk0Yb4gA36ghvH787XRHzsYhxv4xxKaUG/0dYaDFteZbFlqHDjqvzEIMOYdrLEHwKPayg=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr17680496lfc.60.1560003117100;
 Sat, 08 Jun 2019 07:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190607110612.12625-1-geert+renesas@glider.be>
In-Reply-To: <20190607110612.12625-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 16:11:49 +0200
Message-ID: <CACRpkdZp+dxGOKBm-puvuqC2kjhw8Oy0-8jjkBBU4EkRTDUkkg@mail.gmail.com>
Subject: Re: [PATCH trivial] dt-bindings: pinctrl: pic32: Spelling s/configuraion/configuration/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 1:06 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
