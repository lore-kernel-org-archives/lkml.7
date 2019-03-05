Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4186FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6041F20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aY4qhXai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfCEWnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:43:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39925 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbfCEWnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:43:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id x6so5721556qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NMUt1dRLJH21nUMASB+wdgU+JMHg4C2dAkKgGkR9gSM=;
        b=aY4qhXai8dAvdNAC2QL+ZG/f9n8XDEEoGe+AJDOLCsQlsoeBSpEyX2dnbSrhvr6klM
         QBwAghLjoQm+ZODAu4fLUbkFDblD9X/hWJLYKCfhl8p/vpsMTcrGCmg622tSd6yAgSFl
         kw4Okhrd01DRTwjX+GBfjJBMJCT3rWoVFzot+vi/aNXKXD79A6sIsCmz9MrKcFDD2cb8
         N/YoeuKvRGZacJDSPTnQgaMKypMtmI7xFvR2y9rDu3mWTpfrKwSaZZ4wgZVhQ8cNLmhd
         UbsJD41TvCQULX8JJtWwm/LqMGVWbajD1XbjhxYBcnoNY9rW0K0whJJ4nQGH8Ehys4wW
         TT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NMUt1dRLJH21nUMASB+wdgU+JMHg4C2dAkKgGkR9gSM=;
        b=lu8Q+ybypFwqgvKt+zfwJezu4N32ISm569H4N6NyWiN+4tIjqFAFSma/o1iwOBsstq
         8x4Ih9RSEs/6rC0viXlzMApHJ4wWmv7VtTtF3OTPeqNUyl0UP8eQgw60CWYNBHotwbSl
         tR4KdwEs/9UPHGyWDpW/lnyK+Ul8kiUgxev4GuEilvQkEHR7xGQDbtS86c9iWJNv8fbS
         shytRJyocARWMOnPPPauffkgkvVoPdf5dhagGInCbhxLFFibHVDwwcvDJ43dBsEBI2AS
         jbWaaqiVetbJULOGET7zvnntYsn0R7plVkeiNId8BegSB/6ffF18qXwHKrMwvEvu2ekZ
         wnEg==
X-Gm-Message-State: APjAAAX/l6Z0F5r1l8cqbZ8KG37EJ42dzuFLurwlsZug25Y0xYl1Yaak
        afGS8b8gbkdKYJ/5KGdO0pMYyHsz6OZYmdd0Q/rLvQ==
X-Google-Smtp-Source: APXvYqwrBuTWNCpbTf2PO0zqJjEP2fpqIj7cov3BuYrwhG/md5G39tUlr68nWrCHnL16rvoJmAQK46xkqWtdtVp7UuY=
X-Received: by 2002:a37:d649:: with SMTP id t70mr3568281qki.44.1551825811704;
 Tue, 05 Mar 2019 14:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20181124200628.24393-1-masneyb@onstation.org> <20181124200628.24393-2-masneyb@onstation.org>
In-Reply-To: <20181124200628.24393-2-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Mar 2019 23:43:19 +0100
Message-ID: <CACRpkdaQvaJHJa-Q_gZZRzPtDr+Mgs2pgcAvirQeXQ2E0Xh-hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: simple: add lg,acx467akm-7 panel
To:     Brian Masney <masneyb@onstation.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 9:06 PM Brian Masney <masneyb@onstation.org> wrote:

> From: Jonathan Marek <jonathan@marek.ca>
>
> Add ACX467AKM-7 4.95" 1080=C3=971920 LCD panel that is found on the LG Ne=
xus
> 5 (hammerhead) phone.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> [masneyb@onstation.org: checkpatch fixes; rename jdi,1080p-hammerhead
> binding to lg,acx467akm-7.]
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Tell me if you need me to merge this to the DRI misc tree.

Yours,
Linus Walleij
