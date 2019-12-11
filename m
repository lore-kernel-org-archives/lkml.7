Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78611C2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F11F214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S60wH1RH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfLKJIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:08:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33697 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfLKJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:07:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so11067601qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+1+2OzonF8JaI5zb2TCQGTWjY1hWFqWalCfMdztL7bw=;
        b=S60wH1RHuXQ8mOnPL0RhPKzQIGXltV0Cv9h00AH+VYro56n5frUBSr4jG3994daVvT
         V+vThx0M+M5TKEPRP7rKgYkWR9SLOxLfctebgbS4/teJyPdNqlqYK9Sqae4OYe3pOZfj
         RbOKuXYBl+rwcuW9scJiI3DZUILjSRdRChb2cUjEMEG/J6gALdSSdCrSN73Zs+Oaq7Ld
         ncsVZLJRCCbXDi37Bkc0aQABg2eiqLVtoela5xrLAMI6eSLhlktSHK/xO5UF2xLQLYer
         yMxhiSsTvhVSoG04ZT4mwPZHx/2a+Y7mdi6v2EwwgKDOC/A2904us+0B2fJX/ZY9l4Bm
         hO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+1+2OzonF8JaI5zb2TCQGTWjY1hWFqWalCfMdztL7bw=;
        b=WbDUtU6ErNzjUKVaZIGCw0XoIXg3UmiMSGI5Hil9Qq6iWL4i4UNui/9Ch444mR0Tm7
         GAjIlEg4DUNjNhIrX5quX+3E2Ht3tmvZMFQHJJDx5ppd4ZzJurDDBQxTzhLvgOPlT1H8
         pKr3pxR302WRsc32o+fkN43HkqImpV6DQ6VmkyTZRChLCrICISj+E0zPFI3N8gG94fbN
         h6XYQWCSNwf/0VQsp2RnEF3YuKo8folBm5/CatlEMXV0LpFTx2pl2vDb5Ufog+r8Uhf2
         Z0KKqBOgtOpHM1OJnBmqJqQROuV+sr//QX0ruQeIYdb6ElxHRh7eJrCznFZed6ybnBqk
         N9MA==
X-Gm-Message-State: APjAAAV2TzF2PrL1kGDNV00712YkhKTA7ixUktqGSYl6H4e3bprdHgJv
        hLZAB3cV7t1jvRRcqIRPxz/RqMTexsykW5uA+QTAGQ==
X-Google-Smtp-Source: APXvYqxo51nvYaIkggIMq8ITtXp9gbKNulM8Wmtc5DRGjuFLLqvLJhg/1ssY8su+0/x7Vipo/ClbnBGeVsB5uoQ3mKs=
X-Received: by 2002:a37:6255:: with SMTP id w82mr1919216qkb.330.1576055278589;
 Wed, 11 Dec 2019 01:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20191210202842.2546758-1-arnd@arndb.de> <f6a514d1-44cb-4577-af07-fd2f3fefc974@www.fastmail.com>
In-Reply-To: <f6a514d1-44cb-4577-af07-fd2f3fefc974@www.fastmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Dec 2019 10:07:47 +0100
Message-ID: <CAMpxmJUD8A1qtmZmOxAq3XojFG5LHu_DS94LC7orinz_O9zY=A@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: avoid return type warning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Hongwei Zhang <hongweiz@ami.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 23:10 Andrew Jeffery <andrew@aj.id.au> napisa=C5=82(a):
>
>
>
> On Wed, 11 Dec 2019, at 06:58, Arnd Bergmann wrote:
> > gcc has a hard time tracking whether BUG_ON(1) ends
> > execution or not:
> >
> > drivers/gpio/gpio-aspeed-sgpio.c: In function 'bank_reg':
> > drivers/gpio/gpio-aspeed-sgpio.c:112:1: error: control reaches end of
> > non-void function [-Werror=3Dreturn-type]
> >
> > Use the simpler BUG() that gcc knows cannot continue.
> >
> > Fixes: f8b410e3695a ("gpio: aspeed-sgpio: Rename and add Kconfig/Makefi=
le")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Applied for fixes.

Bartosz
