Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B09C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9655D218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RK2oq/2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCOVwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:52:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44948 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCOVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:52:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id g1so9646169otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WmB2OkuQotcGSTkifMaHZvWiPCi6moalFzp/XsjASE=;
        b=RK2oq/2mRorl3FIXezSTAvF8jdyRjJqKwA86Cm+hlZ4wW7+Kpum8YuJZ3GwjUj0wAs
         XhzD6BzEj66h5v5x8JZbFFDEB/d3ZMzFIG9nPpXMRnCVjSYuhUG5c0xfMYz3BlGGxoJm
         jAdTad8jUq2CSVWMuTmrGe5viNYsBs9nGdO0b4dgudXmpGH1nxKs7XvOn89tTxjTPMiD
         yvjGNC23piTrR8p8F2XkHVzI7cXz0lxUeZ/+JYY5RgDEknThfN+w7Le9y4BF74nesWr5
         1Wb+X9rZUmG/cMU6T51kZa4L6P/0JyHtIyBqcmfS2nGvbkSxLmyAa4k0VwjU2NJHwHCy
         jUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WmB2OkuQotcGSTkifMaHZvWiPCi6moalFzp/XsjASE=;
        b=ZCxkiRLVsqeCge2fBbsozZ8Oven/j7ntZlJN3PV0AUJlOQ6FGH95q3IBJrYmWh203E
         oJnu9NPLHeSDaTydOwfqKhEtlwnr0lJDbVzFnqKxjFtxcFZ293ZVASDKXRtmgMkY/+cM
         Lcn8FFVKca/sgyA2FWesl8KhJm9OsJtbkRDMiQJTwpm2NbKhF6f/b1VbxLqiZTUbaWi3
         ntHaG1//NPgbwqUWZQL3UWcUinitOe4Eumtufod2TOBB0lBHM5FsD9GLsiD5vETI5kcN
         Sv3mosftct+aSXIsF34SuEtjx9wYJlzdaQr39Day+jnFTDzEK59Nm35lBGC0AiyXhGH5
         XgJw==
X-Gm-Message-State: APjAAAUqhiLBzU43rbAQLNyHeDNOF+v2SE6dBAUHepL1c0SzfB1ytnRx
        lzrhy63nwcWX1Zswb4VfU1/ajd2NU8WAKG9bn8lT1FDH
X-Google-Smtp-Source: APXvYqwbfSSdK/faD3hkOPxJ1zB+wXSq0fDj/DeIUWHqMBCq6n6xA2Enfr48FpZ6KC/Kr0hhwgiUP/ah9DYOnPNh4UY=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr3457660otk.86.1552686768062;
 Fri, 15 Mar 2019 14:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-11-narmstrong@baylibre.com>
In-Reply-To: <20190311095613.11371-11-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:52:37 +0100
Message-ID: <CAFBinCCRWV425Uon7BnR8+cFLO4T=bGXvSvkrnBWKvLYco6nwA@mail.gmail.com>
Subject: Re: [PATCH 10/11] arm64: dts: meson-g12a-u200: Enable USB
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:58 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Enable the USB2 OTG and USB3 Host ports on the S905D2 Reference Design.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I have no details on the U200 board (whether it has a micro USB OTG
port, etc.) but this looks sane so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
