Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59934C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2781E206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Zjen9v5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfFFTzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:55:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34324 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfFFTzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:55:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id u64so2513862oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgQ7oCfy0nLOIQgW+qtzhKYHnPLM4G90MVyLVLrcIT0=;
        b=Zjen9v5WFHbtRW9yJ9xzSZos5uoDp8qd/oX0HBoxrwOTZSvc4VZmgc6r2noG3x7nHE
         GqDhM0AJ8WWEqYi4+YsGbvEXk9rsDrlm1nFpi/5dtmjQftCIHMGlln8olOp6fZjM//ZV
         an7yxQekTRd6yAj6Ez1F/EGiVDP7VC9n9RGrN46EkzOwZp6ICzKezZKBD8jQzm8n3F7M
         NbhZt01pEmMALS+NywkfPdFVeo9GM0+54kEusBGQHzeB3FMMFokK8+zP/6xrL8OcoiR6
         n3/sBlG7Bz+hWOz8eTC09BdjkIkvI3glWcbnnOQKjIhQ7pFSyicNfUBoYd01zgvzEE7R
         +bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgQ7oCfy0nLOIQgW+qtzhKYHnPLM4G90MVyLVLrcIT0=;
        b=VnhPl0vF+hZHOBE4Le0Fwukh+vinmo++B3IK9ZWtQX6gbp3GQ7TpiC7YKlQ2VCIORs
         UD6M8OJnqpy2BsOGvcm+dVIfBmYvcZBooxFfTRzCxWWdPCXP4hbe55+0Hn9JzKjlkpdX
         sNXCHEpI7CNwZ0Lf8F6ASKF52J3TNZ1qcZ8pBF8U534L1KyMUsvMN1WEO9ldoLMUDjm8
         NTitGJOZoaBgZeJPCmo7jKALbSgqGW84WMzMjmcGjLRDBy4fOq3S/e5lneQ+nRYzTcI+
         7Gy8sGlnk0iUGbXTP7GkEUe+TnX8ZfEyec6NIzbWcx+i8ZmzGk/178anuedrFi+gkYSD
         2/tA==
X-Gm-Message-State: APjAAAVcC2mHfTaAz0Dqyyw69vDfDZ8A6hiU+HdHQ8okt9cNN9xXT4kP
        /rJ6kYnJ18ttoBRz3q9JBAWiyJWMaw9lznd5EyE=
X-Google-Smtp-Source: APXvYqxQZd19J2f5LW74+rVtS8VV6ptXZiXvMelvK9uglEv229O+9W6Z3u3WI/+oKete+6HD5UGS1SS/IP1ChQyS3F0=
X-Received: by 2002:aca:3545:: with SMTP id c66mr1303630oia.129.1559850900567;
 Thu, 06 Jun 2019 12:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190603094740.12255-1-narmstrong@baylibre.com> <20190603094740.12255-5-narmstrong@baylibre.com>
In-Reply-To: <20190603094740.12255-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:54:49 +0200
Message-ID: <CAFBinCBaXgi8dRH+3O4847f1CdjUwQ4hspZMc5LJbJrVX3d59Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: meson-g12a-x96-max: bump bluetooth bus
 speed to 2Mbaud/s
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 11:54 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Setting to 2Mbaud/s is the nominal bus speed for common usages.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I tested with this speed when I updated the meson_uart driver back
then to allow higher baud rates [0]
so I don't see a reason why this shouldn't work


[0] https://patchwork.kernel.org/patch/9517907/
