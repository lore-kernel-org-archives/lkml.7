Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F8C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345DC214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3QBL6ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfJKGxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:53:41 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37992 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfJKGxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:53:40 -0400
Received: by mail-yb1-f195.google.com with SMTP id r68so2781020ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JnKueGQUcLxomX1ONLEZ0vUK161ExmGVyqV9RjauPMk=;
        b=D3QBL6aea5owB2yfoACjbaMKm3p4q64hMgKkPADtf3SEraDaGiWZkWJ0U+CW0swyxZ
         rA6AFv1+nR5UxHodgZbJhwrgPFQgTebb15x7F0wMM11CifCBCKVHCi6tdByxJlKhx9ve
         KnbTTCGzuIhxP6tvQQm5ZwBmXgzLehtE1LUSroEPTUwxbh4E68CGrd3t8cuZcohHAAS8
         /dt/VOVXmwiCZ7GzxjFiaj51De5WesLvzYSbuLSA55dfyAmeY0PJJ5px/+khciqQo4w4
         p40xvhrCKDudDvnrsi1/7kLJz70WJd6oiowD1NSvKWzNCMYuObuRlfb4Lhjzzf6i2fyF
         IHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JnKueGQUcLxomX1ONLEZ0vUK161ExmGVyqV9RjauPMk=;
        b=naICUDOddiIY2sT8RjHNL34soe4su5nsvTKtdH3IeV1zmb0FVkdBVOlSi3C5XQVzFm
         hJTSrf4OJ9D3sjDngvTSbvTbAMWyBBElqff044EIzmeWJKgiFujhhP/bItfBIt4BsH3X
         XUARaOaxFq6gsgy4luHqQ3kvhf9etT6f0tssCrQXBFF5b5R7G4l3TjYRaC4z6pS5AUuv
         /WsZ4vWv8QR76z8U9KwjSE/VucT9JsCBMPX3a63aapOEKMHpVdvdqjybPCOI7QRdgnPD
         OLgrTvsu78iurl0sAIbYwf7PvXwf2hQ+9wmeIFKpdmGe5o/RjxQ5lW7dBb/Sd78uOxtU
         O4Qg==
X-Gm-Message-State: APjAAAXhG8q+DAHsG29u69E0bPef7uu9rY9npRZf8gkX/SK2MNmDXWag
        kb1xDYQgOyyTaOwNVqg1w9gpnhjCcGXd8xmRjBI=
X-Google-Smtp-Source: APXvYqzUjPoPLsL1G3m5vLe5OCMdaqaPVsJQGhbz8o6lpCZy/pbAjb9LOI48JnxWjoG0KWCdl6w0CRszGY+9Bkg+I4k=
X-Received: by 2002:a25:5386:: with SMTP id h128mr8487389ybb.362.1570776819887;
 Thu, 10 Oct 2019 23:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <1569483508-18768-1-git-send-email-candlesea@gmail.com> <20191011055951.wpngo7wyfssrczof@pengutronix.de>
In-Reply-To: <20191011055951.wpngo7wyfssrczof@pengutronix.de>
From:   Candle Sun <candlesea@gmail.com>
Date:   Fri, 11 Oct 2019 14:53:28 +0800
Message-ID: <CAPnx3XPDROKLErhMc16-+_7beCvXw9NZ1UL+1yb8SokLjOej4A@mail.gmail.com>
Subject: Re: [RESEND PATCH] ARM/hw_breakpoint: add ARMv8.1/ARMv8.2 debug
 architecutre versions support in enable_monitor_mode()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        linux@armlinux.org.uk, Nianfu Bai <nianfu.bai@unisoc.com>,
        Candle Sun <candle.sun@unisoc.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Uwe for pointing out my typing error.

Will,
Is the patch ok? Do I need to send another version?

Candle


Candle

On Fri, Oct 11, 2019 at 2:00 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> just noticed a typo in the subject line while going through my lakml
> mailbox:
>
>         s/architecutre/architecture/
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
