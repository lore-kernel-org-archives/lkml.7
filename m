Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA446C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E19214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rUgI7/cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfETSIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:08:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44153 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfETSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:08:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id g18so13827883otj.11;
        Mon, 20 May 2019 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7G1MGSx6nHwpQNyADoCOs+yAwPJeVT4zKxuY01zrPw=;
        b=rUgI7/cyozVGEI1WAULyI8FAByxK8naBaSx0t8U2HtADFx5+PhMerjbmLI1lCJD+TF
         DWMKQ5MDTPYcUaWAHhBS4Vle2kj1/Cx5mhku2J/Fg1dkoulRXCTqdxCGSUM2Nn9cJrTj
         TpnZQBA2TUUOk5m8jyGwZsrnxmCmXOwsGiB4xvQ80NO49sh/NFKkr8HSviLYPdX394fd
         er5Rf944R5jciEy94lciqJELseu/5s2Kh0FDiwnhztL+Bew6IjgrO3IljmPckNik3OfH
         O71aAdk0jpPZwNlowDIzDMuOmLf+cnOOIgLAFV4pAZf1scPHRV5F0BNcPGcPXZ2SPdbV
         u5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7G1MGSx6nHwpQNyADoCOs+yAwPJeVT4zKxuY01zrPw=;
        b=RH20D5VDqKWHRBwp+IxCl6deHRJ3NLal2V3lbAniIfPRh2XGa6kucNa8mwCfiZmYjY
         u0y0mHfXXVRK73+UdB3spN392x9yPVbcjTvmxhMKFSkL9h4trZ83TId0yPou4R1tLMcB
         1q4rFr3/mINw8BZgvWIYW1360UJjPKcwE4FkVDZCjKb8EMHcWuVAUUxLQchlWAxaxAd/
         cPrWGqG2UEH9KNMmfKoDFiC9c9fp5s1UBRhxqYqJfANzfqaj8V3alpSa2TQAqvGkx1xF
         1hGR9MPKTPUGnsd7yZrmd+0oi+NML71UvxLVBcFmEg1eF2wqUPN1YFsjeMQIY4mi7THz
         VtpQ==
X-Gm-Message-State: APjAAAWwYohHBcJbLzWvk8GN4fPYf+YSjklaZ9mK6CFTUtXavsIM8Vfg
        ItGCh+WC4fdI2mJaAVvy9YuUkBOrXiCEvlzFQ9Y=
X-Google-Smtp-Source: APXvYqyXTaYQ+NOHsY6Q4lnQpI7e2SZVcHg565RFV+td7ZiqkS8L3mkm0fonYHSX6TA19ts6wUj++pgx5JEScfV10/0=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr45286331otb.42.1558375690288;
 Mon, 20 May 2019 11:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190520144108.3787-1-narmstrong@baylibre.com> <20190520144108.3787-3-narmstrong@baylibre.com>
In-Reply-To: <20190520144108.3787-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 20:07:59 +0200
Message-ID: <CAFBinCBNKOPfnE9dXLwGv=bgv3piCyecrnoCvvvwaZ63fTRX1g@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: gpio: meson-gxbb-gpio: update with SPDX
 Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:42 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
