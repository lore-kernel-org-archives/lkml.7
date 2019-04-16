Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F34DC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BD720821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsPDXNF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfDPLuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:50:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46110 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfDPLuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:50:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so18773101ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDEUUJoJSi6YoYZnXF5gY1Gw6oRcZMS/KEqiS2IofEw=;
        b=rsPDXNF9+dl3oAKvj65WtlpVCuxrIRVUMzeWCW4rQ9psniXY0agR7uWZ5X97MiZb9g
         5mX0FokaIVnOlrBYcEU33PN5y1KAKJeoC6GtA09jPcl2nriWpXCJjwh9MBiAdfWR1y1+
         2VaZlIWuFx5cCWdpKl2w4Qw7exA3RALxHWtlfV9+NWL1ueM72Db8686gSU4h6l8x2sB2
         CBlAHO5FDMghLTIpi1C/fWkNk+OoseKrKasC8kHc6xEUmgz+pX7bvojN4tQgNYOZnmOZ
         Ch3rZUQ+gDZUzseSTn++30M1liZx3hFgalWVxeJ3V1TiaUV+GNbawVu2741rRCHUXzKS
         3vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDEUUJoJSi6YoYZnXF5gY1Gw6oRcZMS/KEqiS2IofEw=;
        b=S64WZk8xx/9T87El25gH3w87jCMHiAfgqqsNK/81WNDpY+nFk/9Nae9kjdZVyHfvoa
         ETk/ji+qcSS8+TWtiyGnEbMUY94sjxh3wh188sXLeGIJy/DkYpMadDJPpatlf6dUSofM
         fS4IYhcsnlt/L5exiqUm4Ir1/v2InrsbsJFsrGoYHjlP5bhCQ5Zg6aIDD5zcBnULepzI
         72yGRtqgJa53GWR0GQWkTopmAJzkVh5vIsXrDttffnDDmWUnkDXFt/POg7zMTmyrywnm
         tw2bWGK9oeNINdVOJX380r/zQkZBHdICxGS7XbGrwycmvIDVGlxFGXSkJvi3nwQAQXH1
         Zdpw==
X-Gm-Message-State: APjAAAVhTUZFHpqYsfvalxEzJEdTuG1lxeFuXKrf6OikH1eRmZXkQQ5T
        2m+N2t7sQFau7hVE9sdK6RjdGZi5pgdkgox017UR1w==
X-Google-Smtp-Source: APXvYqzvLM2iOlhUPlFbXzBTzgB6hvGmlBsofIrhBUB/mzmiP5PZfWnXeTzIL/nFkAY+oDiKxJDWdnDygL3sklKEDlI=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr42249075ljz.25.1555415430079;
 Tue, 16 Apr 2019 04:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <1555257218-3830-1-git-send-email-mohankumar718@gmail.com>
In-Reply-To: <1555257218-3830-1-git-send-email-mohankumar718@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Apr 2019 13:50:18 +0200
Message-ID: <CACRpkdY5cX=aP9nNwWeUd0Nx33MS0QJDnLKzbajADRsKCUVbOA@mail.gmail.com>
Subject: Re: [RESEND PATCH] drivers/iio/gyro/mpu3050-core.c: This patch fix
 the following checkpatch warning.
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 5:53 PM Mohan Kumar <mohankumar718@gmail.com> wrote:

> As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
> up to 20ms. so use usleep_range.
>
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>

All right, should work as fine.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
