Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C67CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8984D21D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCo2LsiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfKDO6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:58:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41627 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDO6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:58:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id m9so17931734ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQT3fS5S41/nDc9PxWx6AfzSE0EBcmwMovDDeO7/F0o=;
        b=qCo2LsiFG4nolA/iR7fmRONVtZ56CRD0DEtH4z3fn3kFPR54PXNXhdNtoSpdtI/BC3
         Pxnf3UnZm6bAhBy5937xGDhmpVia5IMJnzyuiIqlA9iWIqhUUGQpOiK6qAXWtoNvXsKu
         CFw5vciS3yqoxC5XbBHlzIYv2dypYYKD5PF0HIZAYeslHRDyICRooHTY87mxRE/rQ1oR
         kTpFGFVW6Ec+guHV8sudEaMF2iqMviMGBwEmrWmGGlRjthRP3Lt3zFZ4ZMWfqaeaWhkY
         RgIash3fp6ZWU0z1tzcxbJdZ7KRweEIJT5AyvVEcXf98ZYOukhveYalznLsBqjD0uCoI
         qLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQT3fS5S41/nDc9PxWx6AfzSE0EBcmwMovDDeO7/F0o=;
        b=kJ1pxmV5h0xnr/lHlSMkjzbwOTVFSfLUKRcHM2CbuIysaOhgvzi+MdHxzjYGizMvhL
         sJXYIiJajqHvr8memu4zcInX/0sT4Juz01qRgmsP7rZHVfndnOUYO045Nff8Tow+pfZ2
         umdU4Y0IxzI5CUzA/Pp5EKYbtkKeE9i3JWRTcXBTrAdcG25qnG/keZH7n0hRp2V0RyS1
         HabjEsOWrnwJW+pCpsHKlgZPthbC0ut3RvtXiBOG0jABptvj+2fomXpXTRV2nWdsQVde
         ALMgyiBdVwnsic8JTrSmJQcjvqQ4w8hHoS4Y9Eh9dgKQ0geRpBE0DiuruDcF13yS+N2a
         bCqQ==
X-Gm-Message-State: APjAAAX/Pj7UhjmnQRM7jMbnWkZqKx873KdhfLradveRaGITnBTMT2s0
        1YKkeN4ybK2cXH5mp3uYpUEFuGILkrhwRXeIrIUdPiP/ZFg=
X-Google-Smtp-Source: APXvYqwqzFe/WynJv7uysnlQKS5aaNgXiv3b6dRiA+EEVT7ttVdXg9c0o8gOsCY+vJ9sFd16TD8qcWvJsKTk5BCaIUQ=
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr19180665lja.218.1572879482204;
 Mon, 04 Nov 2019 06:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20191018163047.1284736-1-arnd@arndb.de>
In-Reply-To: <20191018163047.1284736-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 15:57:50 +0100
Message-ID: <CACRpkdbb=kazUgwx5nJyv7rOvtuDXQ_1mpz=U8tio8Om4j5pHg@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: versatile: move integrator/realview/vexpress to versatile
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:30 PM Arnd Bergmann <arnd@arndb.de> wrote:

> These are all fairly small platforms by now, and they are
> closely related. Just move them all into a single directory.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd, it looks OK but is this one of those patches that are
only formatted for review because I just can't seem to apply it :(

Do you have it on some branch I can pull in?

Yours,
Linus Walleij
