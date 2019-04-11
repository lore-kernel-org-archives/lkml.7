Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E0C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75405217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cq25d18D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDKNjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:39:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45647 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:39:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so5534267ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4n970sNmM78f9cVQpUJA48QdfoCTSqP3bdkBrlTp+go=;
        b=Cq25d18Dp8VNkOW/Ns791+NCirCzCDyU7jLJwG3fhqoimX9vzje3tZEpKlNh78vtvW
         g1VGeW6unprMDB0MpDuu8OyafiVueWhTCcW13KNERl1r+B5rEGrR4sKoqVqbDS/a3Nmq
         KBeOMcNcuNT4lopsHjXZ48VnQm2YYdf3QH0I9D7dvSXlVIs8vmNsT4K4WaSfZ+vqE2xp
         LoSh8HbbFy2So5NBd0djuxk4sAb/sk0x09QCUCJoL6HS2cP5VTdsWzb1aAuiuoFGJZLE
         JTN4rbwFiWxjh0Nkk6GwbT9rTf0/CuhqGumpO8ruI+L8uOu/qLIDGuXLVi+Mj2M218cz
         jHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4n970sNmM78f9cVQpUJA48QdfoCTSqP3bdkBrlTp+go=;
        b=ARs/4yBBc9OaAH7bWQgfpHSGKO2rXigRxjghW70PXxokiooNK0fXeO3TN+3zBwsapd
         XFtdPyJDNk6dpfIleTwnG8AhHfL6z9exvMqRU1ZLIvnY/UVaWJFh6mfNO7QZf7dhhTuo
         78fq98wZHTocTwROqHfmsfa718k5qjaHQ8b5sdnJ/qyKltVPPvSFcZybh4Q5FaiIhNQk
         MIVUA473QKD3lQ8eX/+n/uSMthT6btHlbKQPcMhZwQOCpf4Qg/gyHxx1Du6dBLji4MtO
         FxnMNgsIBBOuAVCpUftkk4lKCxVs2FeOfmrKigHKh8dTFgdul/+tkx8CaS77aoH+meoD
         9kiA==
X-Gm-Message-State: APjAAAXykHL/opAGuvMjWjoMo9uL+9T0yC/T4PTUAIS7Jt0l+MtFp3H9
        i3NQZ5PV2BOvUrnHyM766u69+6zg85tRumImJ/s9cQ==
X-Google-Smtp-Source: APXvYqwE6U6rQsN6xUJKLSqrSmzIraPuNPOZy0/6YUIwnC3oNILXbO/9Xe8VbJsLu5IQ7uaOi4jKNwsNF01+dCvxhQI=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr25969221ljz.25.1554989951785;
 Thu, 11 Apr 2019 06:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190409195945.20725-1-alexandre.belloni@bootlin.com> <20190409195945.20725-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20190409195945.20725-3-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:38:59 +0200
Message-ID: <CACRpkdYum4vpTYDaME2tAd492Rbni7OBuF6LCD+C4+rk7Ye32Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: ab3100: convert to SPDX identifier
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 10:00 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use SPDX-License-Identifier instead of the custom license line.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
