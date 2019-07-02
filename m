Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C536C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EEA218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dQE6ToJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfGCAtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:49:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40410 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfGCAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:49:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id w196so578786oie.7;
        Tue, 02 Jul 2019 17:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmEB/x0Lo8kjE6XO29I6yQcxMJdkJpBobZcgW1H9skM=;
        b=dQE6ToJhgtp1wCfPTOfOeyy3Wlzl33q0h9WcnIJA48XtbfKqzHONGYC3W61NGQfNim
         wJaXkOCEQLLrI2TSIZQwvLCc1Rqhy7tkKbFJItgpBZmmCqqY0TzvUJ2rx0vWwv7zrFmZ
         kZ5OII7eqEx3/ovCXbefJGBE8F7LYBJp3Eh1m81WkMA/alEl+TNmkxdUWAI5Udj6A0C+
         vsbKbIDFDrMiyP7vv46AElwnFPDzMcamevSZp3I5khh3FwrFUuoHiTauuxpXCu4bPH8a
         8Vi37k2YDn8vy9Meo0Fcg75al7N0hdAtajz3wPYu473GTV9bU6aDJ8XppI7nkwKlrfGl
         vp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmEB/x0Lo8kjE6XO29I6yQcxMJdkJpBobZcgW1H9skM=;
        b=Nkge5JFPMbBhxkKLnomdjb0OuYJasblpM6mVT3pkNPasJZwukEVqumayLJE+9MKRlm
         IWLgGQloBjmF5O55JR8BH+mxSXvNiV+rz3tKOI3eQ2SyJ31Z2O9trS4YwB9IUiD/DAVM
         m8uPLVBb7du/jTeBy3mfc8Ifq5Pg1Q+Fcz3O7VTYoE8GRTufM00muyYnkGrhPChek8RH
         yL5bVy/wpaq/yMwAQn/3ohwh55iikhcM7l6MUI7JF0FMujwkkrhI3oUXVVaj2DUst5lp
         rdi5Vq2RUdMJ4R70UVQCp6LfdgRsK3YrPG+jKDiSBzWtNPIg3KSg3PfmHRYDLs4iC67t
         Eo0A==
X-Gm-Message-State: APjAAAW9bSRK9yobiTm9ANnrAmvLtSpLv7K4bEpIJ4eMaU4kY2TtH0CO
        yLsPsALcKtgTJXy7Pg7IyxP3wesklckhrsu626LwR8jD
X-Google-Smtp-Source: APXvYqwGO400fcqFqegu43ZWYESJ1x0EcFHLkunurhz/yLrGFeET/1sUvrRHA32DeHN9rz4+lxZGWrgg9XsKuY7U36c=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr1514748oib.15.1562111016670;
 Tue, 02 Jul 2019 16:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-13-narmstrong@baylibre.com>
In-Reply-To: <20190701091258.3870-13-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 01:43:25 +0200
Message-ID: <CAFBinCByCn1NMz4ATnR66114jYj8=KG-tY5S4iRfoPEw3uLF8g@mail.gmail.com>
Subject: Re: [RFC/RFT v3 12/14] arm64: dts: meson-g12a: enable DVFS on G12A boards
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 11:13 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Enable DVFS for the U200, SEI520 and X96-Max Amlogic G12A based board
> by setting the clock, OPP and supply for each CPU cores.
>
> The CPU cluster power supply can achieve 0.73V to 1.01V using a PWM
> output clocked at 800KHz with an inverse duty-cycle.
>
> DVFS has been tested by running the arm64 cpuburn at [1] and cycling
> between all the possible cpufreq translations and checking the final
> frequency using the clock-measurer, script at [2].
>
> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> [2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
