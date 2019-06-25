Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE3C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CF52133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4iqcuL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfFYNr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:47:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36479 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfFYNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:47:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so16346736ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqj9RJTLU6a7u47c/a2XupnA9jHEjvrlPTNwz8/pAYI=;
        b=e4iqcuL7UrUFxNJnOOaBzdgx3YrvjL/tcddqVNmyBvq77sJiTTcqtICftMEIq6Xz50
         dXwomMLX65/Vcbqhe+UrqDl1OYzzMfRzHrK/9BGOuPWRfhesBx7TwiuvaRiL1jPsswCT
         pZqJKU3UDGIuh44/ThJik0yQIp+yEn+CvGEnXci1tOkWH0x5QUktV+j73tF9g6CetwYi
         eNeGjmOp4S3GlttW7lbz/+sE5QsyOTFPZkrPWe7h8bSOyc9c7m/jclIe3UI+33lc5a8p
         nyRlgT4zSZUYc8IlfMvS+IMXIBLVBJ3D1ZnAJqMTgLr28tG/uS2yfKvqximd2wbSaYth
         jumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqj9RJTLU6a7u47c/a2XupnA9jHEjvrlPTNwz8/pAYI=;
        b=Tu7pz9DsZPd467nuaxd8ER5jOw4X1bN5iE9My1FS8PNUZgqC6OyXRmSF2HltSz1hRM
         yP4rn5PaILgIxFdmQj7lgQO98bvSZ8kSpDc54bhDP9Qo3rnNT3EeE6mX/bOat8qaZ8Rp
         P2yQkntQ5ApTk3JWNiPuTUnmBE+aDxy4ohgiULoD+7zEzGWQHaKqpSNRvwc/+kjIc58z
         8Ms4n+hNDdXD3s3UDHWD4S2SfQGu46O7tornzuEfW/JX+WZOgLGcmzHcUhj71pUX78yC
         wIbPHc4eCcbY27DbzpjOXW8vofUc3+MXkhxLCBYB5YRQ4+nsWjVBTDz8PeKaXffLgtiQ
         rkPw==
X-Gm-Message-State: APjAAAW3lxm5GM3OArefq1/cjDezSc6Ml3FmOl3jsTmwRAX25mZw2OwV
        cwjd6TidbVB7Ig1nczxmwJent3H8zYisK1RoFJkWdA==
X-Google-Smtp-Source: APXvYqxcWfEyG7sNk/JkRaYtPGwrWAkli7OwDCO7bqYoL3jX7uJ8UgDBQAE4GreAMx83t0VEuJIiv4peaDl4sX/yZ64=
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr52570827ljm.69.1561470476420;
 Tue, 25 Jun 2019 06:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <1560938081892.33415@sensor-technik.de> <CAJKOXPej57MJKe6ShinG+VJdG+XM4qhpeD3rQ2ZHzRTmO43+GA@mail.gmail.com>
 <1561066629320.13520@sensor-technik.de>
In-Reply-To: <1561066629320.13520@sensor-technik.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 15:47:44 +0200
Message-ID: <CACRpkdbPxHgyTAnE12PrMRu9XQqdoXmS+SWXYrSKXgL_SWOzcw@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: Fix return value mismatch of function gpiod_get_from_of_node()
To:     Waibel Georg <Georg.Waibel@sensor-technik.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georg,

first: good catch! Sorry for breaking this, and kudos for fixing it!

On Thu, Jun 20, 2019 at 11:37 PM Waibel Georg
<Georg.Waibel@sensor-technik.de> wrote:

> In case the requested gpio property is not found in the device tree, some
> callers of gpiod_get_from_of_node() expect a return value of NULL, others
> expect -ENOENT.
> In particular devm_fwnode_get_index_gpiod_from_child() expects -ENOENT.
> Currently it gets a NULL, which breaks the loop that tries all
> gpio_suffixes. The result is that a gpio property is not found, even
> though it is there.
>
> This patch changes gpiod_get_from_of_node() to return -ENOENT instead
> of NULL when the requested gpio property is not found in the device
> tree. Additionally it modifies all calling functions to properly
> evaluate the return value.
>
> Another approach would be to leave the return value of
> gpiod_get_from_of_node() as is and fix the bug in
> devm_fwnode_get_index_gpiod_from_child(). Other callers would still need
> to be reworked. The effort would be the same as with the chosen solution.
>
> Signed-off-by: Georg Waibel <georg.waibel@sensor-technik.de>
> ---
>
> V2: Rebased on top of [PATCH] regulator: s2mps11: Fix ERR_PTR dereference on GPIO lookup failure

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Mark: as most of the changed lines are in the regulator tree,
would you please pick this patch up?

(Else tell me and I will take care of it.)

Yours,
Linus Walleij
