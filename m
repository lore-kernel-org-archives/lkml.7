Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FFFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80D82064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FN6Gp6Ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfHMHUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:20:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37968 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:20:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so100592866ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzvQR20lPoeZjhurVT6RSVppuCsYxsd66Yq17XgsMlQ=;
        b=FN6Gp6LngiMd8Ivm0OmPalHTogtRAH5WDU0i4gzDyH2/pA7v/HGPMI9xSigL6xOC3V
         7SJ8SsB5pAocpjRBt3NywRc2gIuZ/apy2oMMrRpbMc15jy4hvtmUROE+IKpS16/EhQSw
         FPdAZ8VvR3g/ON21wN9r4295rqlExYuhztI/awfbIQvyKeyta0Kb3ES/s5ypZV+5AuDK
         Dd6kVZJiis4RyeRYDSHQSfmQ8MzomMb8tIXCIOBw8GQV/egYZUzFaGuSh6SRdhnZVBs8
         CyIVpwY5rEDu8+j2idiXG/GjVar4sqgxTxgpn7BULkfQVlOmvrHbb5dtGiQ9qLl+GHTn
         q4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzvQR20lPoeZjhurVT6RSVppuCsYxsd66Yq17XgsMlQ=;
        b=QyRPH8punnkbxmFJ7kv3ZTCR2GwZtJVsIQ8VsgOj908hTY1M6iDytZe0XeD5ZFLkCd
         EqFe1G5f3J17gd/qy0BYhYx9uG+YfbDjGdAG66gKbj3ioYx169Itee0r47L+hVpGNQiy
         gTCYL4OrdX9YyRRqSVMDCxddI5teF0TanHpYuZPhU04wHg+tpRTlpI/WM5ZH9OAq7hbB
         I8DP/ResDv1KCKo433EpNR/Dcv1toFzbfkXY22hT2dlYTYWDuaVIU2smffOZfVtFp8PJ
         LS9ZIsY5LuxuLGYtB9rYWJR9TTL+XtYia4K5zmCSAQbt0nU1ChwoNJi+/UvTmL25bHno
         +E6g==
X-Gm-Message-State: APjAAAVGU7XcmSxt9PNWBLzAHroSNCWPA5CeRT8GOH63noB0yU1MUhFC
        9HQZHtBiWV0HvHrnMx+3iS6vqBz3r2h1Dg+6Uh6j4NssVrk=
X-Google-Smtp-Source: APXvYqyNLDWKtInyLdMbW6jcx0sLa6zFjReLxUWdmVjMxzkJyd2bv8KdS95o0lBKkrmBODn2zhHKJct1YL8t4+Zp5LQ=
X-Received: by 2002:a2e:9f0f:: with SMTP id u15mr11580891ljk.54.1565680839664;
 Tue, 13 Aug 2019 00:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190813061024.15428-1-efremov@linux.com> <20190813063251.21842-1-efremov@linux.com>
In-Reply-To: <20190813063251.21842-1-efremov@linux.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Aug 2019 09:20:27 +0200
Message-ID: <CACRpkdZRW1fpjf=vQbuDdSC1ZU9o2tq2C2bL0GonQbnPWc06-A@mail.gmail.com>
Subject: Re: [RESEND PATCH] MAINTAINERS: Update path to physmap-versatile.c
To:     Denis Efremov <efremov@linux.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 8:33 AM Denis Efremov <efremov@linux.com> wrote:

> Update MAINTAINERS record to reflect the filename change
> from physmap_of_versatile.c to physmap-versatile.c
>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Fixes: 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini} into physmap-{versatile, gemini}")
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
