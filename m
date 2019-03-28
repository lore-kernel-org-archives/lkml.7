Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B955C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865920823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASMgJ4Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfC1QLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:11:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39103 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1QLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:11:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so14416756lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOIV0KoBawmrEkIAXQxxh3jnfhN2tAdwGVoANxi2pGU=;
        b=ASMgJ4YjO9nItuveaSms48kXfi5LGfsNRNadpzjscmOizJLjFoXItMn7uxBSN6Mplw
         pyMcepN8cTCLA+0vL1K9E6rtOjo9G1n4Nz/ziMBqhX2TMSn1KtuW+Pt5Xta+4Yh+ske7
         YNClxl4DpYFeZAcaM3FVXsetAwbRTnvl+Ji3033PujcR/mztrMOT/6iZBZnk5gfjTZq9
         QjlLRmBL9oEgRjpERxO9CfMiQXvP+PatyHDxYdVtSPB7+5PM2BIqjDDcO6Gx8h4LFcaT
         bTIx+4yaJYKr2VfGIxGZv+dvcr/DIufmr/4tqoCeJuX3dcOeJKxaVKv/8bokXChGsAKB
         3NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOIV0KoBawmrEkIAXQxxh3jnfhN2tAdwGVoANxi2pGU=;
        b=VywU29wr4isTup0EgFRj1a2KzNRwWE8r3QGAclnBK8xqHx0aiXJ6IB57mA68dXsqiU
         Ho/TJxx241GtWKMK/uplJC5IZRj62SA5/byzWJeXr10bZGT6zPnqnzYK/LzJrcxIwTCk
         UE1ehk5+0dGiwgyblSHfL66em/vHTWOwtFbaRWAyR16zB+o/atjTMjZuWpqaZ28qRwXF
         uDt71u0sGqtHqT5lYb4toe9USSj1TkAdn+W0GnlGBS2LpKOSpytdIX/0w4o6+KibWJi4
         UjJMVKIBvT95fRhX8793FESICJD8j6KqFy04z3C4TykEp3I1VyQR3IbgmdSajZEDp+sd
         7lhQ==
X-Gm-Message-State: APjAAAWq1ZUAP3AkRL6O3na+wlvbaTHMxRxHWo16/DQCdZlbfUbwtn6A
        C6BdYNaEY4qZ4iTjFIffEbYeUZv9PK9OSQGf3EUKtQ==
X-Google-Smtp-Source: APXvYqzJxdnDBxNfu4DFkwLcLJqgDQaRD4f5A29x+CTpXMt2V7zft7tIMVPHK4p5P6lQdvBoDbYynaC3yl2fjVeL1ho=
X-Received: by 2002:a19:5789:: with SMTP id l131mr21961570lfb.8.1553789507174;
 Thu, 28 Mar 2019 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190326063209.6421-1-andrew.smirnov@gmail.com> <20190326063209.6421-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190326063209.6421-2-andrew.smirnov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 17:11:34 +0100
Message-ID: <CACRpkda3f=7t+qnNrvDchaQUM+1g+gCcM83eD8vy0Ja73DEL7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: of: Check for "spi-cs-high" in child instead of
 parent node
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 7:32 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> "spi-cs-high" is going to be specified in child node of an SPI
> controller's representing attached SPI device, so change the code to
> look for it there, instead of checking parent node.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Patch applied for fixes.

I could bet I exercised these code paths just the other
week, but I don't know how it all ended up like this... :/

Thanks for fixing it up!!

Yours,
Linus Walleij
