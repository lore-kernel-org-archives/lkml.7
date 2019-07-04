Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF721C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EA6218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTuDj32P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGDHoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:44:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfGDHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:44:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so5147889ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpdCeLUoBh4DNHtAtSr77HOQTlACCI/6Pjsw5SZSdjg=;
        b=wTuDj32P4i6zb27aRMtS65T3OIeBp5OCqxQ8bqEVrOCKQBzq0qeh0SPeMIohcNOSne
         jfSd2pab1IdXLS2D1kjdAHRX/Gkn8tbC/b00lt2SJ/9bt4SmyV3jeJVysFrLJ3tLIxtB
         WzRmxJ2z3oH98kCCcQNjQVn+bWP1onMMBzybF9yezab+Xqhzy2fIV/p9hTzraljDjp8W
         rdD0FMiTt7dAaI5T0rZmdEjff/601jcVwFlcMu5N2mCMroPlOQfS5rzSxEejlIGVYGvT
         DuvQLUWj/7zRJ99j2kUfyfX8NCUwv79jQ8HveklU4RT7vxzocCCRdWrZkeLQUs5saT7Z
         h/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpdCeLUoBh4DNHtAtSr77HOQTlACCI/6Pjsw5SZSdjg=;
        b=ii1f0e1EG5LiLFTJYUPGesYurkD/N28G1dod0rNeKa7h2BNS9Dx+x+yd3E3yH3NIbU
         bXKdVt8TZGI4Rh4ymG89o7CJpJpGN1acEplMo4Z9nX7z819bI9qKCYd//NHM5M2i0ghr
         tkf84h5o33j8d0N+zTCUXC5q/qiwlbUTu8wkzySM+9mKDm2HUsX6UG8DIMHro2ts6YtB
         VoLj5nuYYXSOKSOpnD1RqDPLIVEMWQn5K9NWon2exMA1oKlcm/0caPH2MJczyrlDSAaN
         Q55uC18VZ2hcpZsZPC+ypu/Z5GPpoIVw2ixIk+JTQJ1TUGcCuSDfWedBYAIL81TA/vH2
         /kYQ==
X-Gm-Message-State: APjAAAWt3iwhKqRUDYRF3sR6+aPvrlnRQ488oSHpcZNnca6dq3bUbv+C
        +rxRmO3QGLDEknfn6Dn5bnjqg1BOB7O8eVSt2G3oZkkx
X-Google-Smtp-Source: APXvYqwXEkssJqbTmDrqvNywyodc/3AMhglFknj69Veuy+PImsyE8rqZmPtOkLWguna6Qh+Z4KDTdg2glDqKSmMUx6Y=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr24023400ljm.180.1562226255809;
 Thu, 04 Jul 2019 00:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190702223248.31934-1-martin.blumenstingl@googlemail.com> <20190702223248.31934-5-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190702223248.31934-5-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:44:03 +0200
Message-ID: <CACRpkda+f2o+S25dHFLV+1Mui0-=ShiBSp_8J0W-ptNxTRLW+Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpio: stp-xway: allow compile-testing
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        dev@kresin.me,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:33 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> Enable compile-testing of the stp-xway GPIO driver now that it does not
> depend on any architecture specific includes anymore.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied.

Yours,
Linus Walleij
