Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5957520828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mAKFJFqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfCRUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:13:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34339 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfCRUNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:13:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id r19so15647612otn.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ley2nh3GFrfpOpGk4n030KPLgXgEmt/2h5lDf9s9dEA=;
        b=mAKFJFqiDQc+2hXNhQknOvDGq/lAvfTgO/Cv1Rcjlkeu0J4FjsyYMe8yHw8gA8NhTu
         5eqjN7en5Fbh7jAv0DM7ACjhxH3W+/VrJToVd9Vckyykk3SlvrpJbuomNKTnaXJjIY6e
         Z9r8nOwJ7xLWg90QT85pHCMBUXXs2jYMm727cfN+KV5YmMcK9l/v09GMO/z1Wg03B6Ve
         0E+vC+25J9IsXZmDu5izvIbfaUrU9+tf4dmBEBosVN32wdXzUmUQ0zZzk9nn0MWz45n2
         9IisliRQp8IOdwjcmdoBG9oGTPUHxj5tW9GIkGV5JCAEZ4c/+LIJR8DZ0FNenTDVGE5V
         wc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ley2nh3GFrfpOpGk4n030KPLgXgEmt/2h5lDf9s9dEA=;
        b=EshG1hZJ0QUD+7/yJY6rsNBy1mpSc2mj9aY4k4oDZPq35Ag7I2yYKpgpVsui8g6ssr
         g8cVVnaGEYc1eiqpbVA325FmISkY8L4UApLTmJux46i4dmJuFSMPMTzOq2uX6/mPio8S
         QLrPWWmfPxyy+iIotnmrbEjuz69sKD4KuHetYXEJWt8ug/SQme7A9B46gs8lut1I+SXk
         OUppSrzyFy/VCorEBdkCheEHnOs91W6dB5WMdly6SXPW/8lnNN+H5Ex7OVColTKqdMvc
         B3sADKINViVWtCXNXWKiyaOMsa8nP7Po2/sbgVOoq5fPJBETPB57UECpLh9Jyq+FuAJ+
         Hq3A==
X-Gm-Message-State: APjAAAV+bGat55I/rLr7k5O5id2SLa6HYarOVdnFIXQO7ujvJyw+ZN/4
        mz4YTKjkYwvGtvtGnbEEgq/iuVDfKib4dM7DGvw=
X-Google-Smtp-Source: APXvYqyIJ/fJ5Ryl95uXVYFDfnRiMR7/LOMVdYNZaZZYH6o5h3HY63Tkwz9uvRiWvUKtKlVKSQB0Iw3FmweksseRz+Q=
X-Received: by 2002:a9d:7441:: with SMTP id p1mr12227529otk.148.1552940031770;
 Mon, 18 Mar 2019 13:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100458.5619-1-narmstrong@baylibre.com> <20190318100458.5619-12-narmstrong@baylibre.com>
In-Reply-To: <20190318100458.5619-12-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 21:13:40 +0100
Message-ID: <CAFBinCC_+KWZW0p-HGRzjsYZGHN_FkU9DicR6Z4+J3KfzPKbUw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] arm64: dts: meson-g12a-x96-max: Enable USB
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:07 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Enable the USB2 and USB3 Host ports on the X96 Max Set-Top-Box.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
