Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D55C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B192F20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XlJSSg0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgABRzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:55:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33841 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgABRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:55:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so32340967qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VvBGSQnAvkp/z9KIA70+zCZk+7dfOwKatcr0yFpfC/A=;
        b=XlJSSg0PEd9Gwmxem87SMKsdC8/nyuwJgJetjj+6wVGVCnKrWFyeFioR7mYgpQavrM
         e0QUGQOff54lsBTdbtLjAY0Zmbt5jVxbxXT1vFtQuK5lNshrEwoMZs03ZLhXY1uDYCS3
         pdTIs+x8Y//CNgCZvlQgQYKsUP2clxzBxg17R4GBbXXWM9etsIyhUePTVXUtcIVGnyL0
         dciGDiEHy+22i0FIpVLIyx2U0ga23gxv+VDL0hPYu5Laf2hseSFlRhnV6jwnFVWLgvgN
         3+JU/Cplv3wj4GGb1yOf+AwzY2bj+sBw3BmodXdGCcX/kP7XlX6jAE0apst0m0N6Sn2n
         kRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VvBGSQnAvkp/z9KIA70+zCZk+7dfOwKatcr0yFpfC/A=;
        b=QQs0oyFRN53o0i8SPlhz9rP/gxJYbOhEFGE677tVhU+EmK0S2WkE9XadtHOOIC6kT8
         rueJL2dW900oM5yJDKnRCJtGSLY9zDkfozMFSSmeagHoow2odp3xmDQPmN5ywtiFM7IN
         zrCC1vwCizNzSq59qzfLfxaN/f7mEqIHvEn6OsN3/RXYO//X8z1cXj43MSjRvWnOfRYn
         D/tCH7VR1PvZpdT8htwiNEHddBZ89JdAhK95doaJ8HX4qJpEDwp89JCR5aoBlfWbmvNV
         b7ZdHUJwKz2oVjuYFGzq6X3eTBnYE7otRiopW0Bso1B3c/IiNAH9zlX3dJuYb3MTawO4
         jSvA==
X-Gm-Message-State: APjAAAUsC9xtHmm0/EEy8jeLq7ecHtM4BX7E4XE2hDlrhuFjBCBWlKH+
        8K1wXiADyeOMV9t0I4WCsq60Te9s+n6iX4mfxfWjp+Et
X-Google-Smtp-Source: APXvYqwIJ8jhqb3Pxo1nnqStMC/FyAlTk/mLSjRyqYHHLaEk1gII8LrtnY8U8YO2gxgz8yVgYmIVIJ8eoCcUZqkXdhg=
X-Received: by 2002:a37:6255:: with SMTP id w82mr68484592qkb.330.1577987752601;
 Thu, 02 Jan 2020 09:55:52 -0800 (PST)
MIME-Version: 1.0
References: <1577362338-28744-1-git-send-email-srinivas.neeli@xilinx.com> <1577362338-28744-8-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1577362338-28744-8-git-send-email-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 2 Jan 2020 18:55:41 +0100
Message-ID: <CAMpxmJUgALt6K2m2iAtR9xhkFaDDyESpjqu11EivK-ottVuZLQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] gpio: zynq: Add pmc gpio support
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@xilinx.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 26 gru 2019 o 13:12 Srinivas Neeli <srinivas.neeli@xilinx.com> napisa=
=C5=82(a):
>
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>
> Add PMC gpio support.

Again: please provide some background on what PMC is.

Bart

> Only bank 0,1, 3 and 4 are connected to the multiplexed Input output
> pins. Bank 0 and 1 to mio and bank 3 and 4 to extended multiplexed input
> output pins.
>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
