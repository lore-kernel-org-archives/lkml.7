Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1876B21530
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="roT870VF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfE1P6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:58:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40042 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1P6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:58:02 -0400
Received: by mail-it1-f196.google.com with SMTP id h11so4704347itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g3S8V898KrtaLMYYer30d+6LM21W+xCw3zo/Db9YNw4=;
        b=roT870VFUPQ0MNzilTwWdOiUBmWnMAZbgQJRtn8kcd8z75FP+0T8PW0FZFjEFqJHuG
         5cSnKsgdL0p30g9WudUhWBtnkLkreenvPUIgHLqL/0hqfp2CeVfL+mbEKzw2jqxbgCO8
         1YSdhMUjhWcOS20bd6/9nSMYpDy31XBjWJRYfIIw7bCyxrO6tjXwuGZk9fxnpfM7ea0f
         wGuB5dNj97tR0j8XxpERzD9dWwkaGPus0TO8b8kuRG+gR0eRCiwwxhCtPoJRsDXCswQo
         fcqKAdIKfD/JQV/PIdRSIj2SChv9pRQMbh4i27q7JhXjIliKYeURlC2sEnIU8DoWb9lB
         cX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g3S8V898KrtaLMYYer30d+6LM21W+xCw3zo/Db9YNw4=;
        b=lEf+POJ1FFt+nAK8ffoPHo951tz3TcsHyobrSgOsbTLobIxyZmhDGV89kOp61JD5Vf
         kR5gLNJmy05Pt6CV/jBHvj2MP2yqIufRukLRldumUmVokhI9Gt/B54cUpGHe4jOQr8k9
         oI0BbbPsQF4n76113bIXYUn/WuIAEH4OzFlADSi2+DEDiGvpbhvEAXotbUV7FF1EGrm8
         exMSip9HhuIA0wbH7dYpjLaGVOgcQdHxM+WtsyCYCI7ArIfA3maVCMMC7QUwJdpEfoiU
         x6eLJCgw7Oa9rIrVwGdmcoaYYBi0BL8gmY0tuexlMp7jDiVCxw0uScMnqiLdFcUUVAnU
         17Vw==
X-Gm-Message-State: APjAAAV951SjtAs72tMdXRY7Te6FKqKNFhOn3hgYRwJHK0tQrYQ26Z55
        MluEnkyZ9GMMCLitUeAH3t/bGmZcxvnLSOLTMe1Q2PRz
X-Google-Smtp-Source: APXvYqyiignG339gUzN02NFeFY66ElaccoOh5CWmax+f/WhuJDVJM0kEGWSiDE+SCy+BkUpUsrYkAERmmg6qFpXCca0=
X-Received: by 2002:a05:660c:917:: with SMTP id s23mr3632489itj.166.1559059081244;
 Tue, 28 May 2019 08:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190520071042.21072-1-brgl@bgdev.pl> <20190520071042.21072-2-brgl@bgdev.pl>
 <20190520130837.iglqohsyi5kyj55y@katana>
In-Reply-To: <20190520130837.iglqohsyi5kyj55y@katana>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 28 May 2019 17:57:50 +0200
Message-ID: <CAMRc=MdcY0Qx2ZDM7ogwc8BH-cT61ovukg=U6G8k9ZDgR488UQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] eeprom: at24: use devm_i2c_new_dummy_device()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 20 maj 2019 o 15:08 Wolfram Sang <wsa@the-dreams.de> napisa=C5=82(a):
>
> On Mon, May 20, 2019 at 09:10:41AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Now that it's upstream, use the resource managed version
> > of i2c_new_dummy_device().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Looks good now (not tested, though):
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Thanks!
>

Applied.

Bart
