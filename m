Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E96BC04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D0E214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYSr9QJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfEHNrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:47:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36541 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfEHNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:47:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so10536322pfa.3;
        Wed, 08 May 2019 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abi/LI33UU4FZpJKirTDuSSuM40WUXND0+Sz3pImfKQ=;
        b=BYSr9QJBgm7KUapEFWgZ7nMiKGvAkTkqxZn9XIpxgb8UvL7NFcdo6abyQ9Kuxt4PCe
         W3yZ3hJ9gUxjsStaJFKk405qEyL6Jsd9FsB4L8UY6jGRhROGHqZxun2LMfbC0/dVJGtD
         BG9aNP/ns2ip/hNwM/pHFpbTns1/GQQ0xt7qfqkSW3fygkxQgl+/tNWr1A/YqJTkJJ76
         cNX7TGEaqV0niPiGONQAsZXwtILcRMGFJHIy+0BgGi8vo+Fy9coxEB8yMio4gTKNdw+h
         CQY/RQEvsxQpDD/VTs4Inb83uZKJ8pcM1JL1KQeixR5VGNCjKg7etitFgT0QpegvWEga
         neiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abi/LI33UU4FZpJKirTDuSSuM40WUXND0+Sz3pImfKQ=;
        b=cbJNbVg6JfFHIT07lEanmaRly6YRk2OEI91Z8F/MzzzS2EHtVsTC1+ARJ1qw5NiheJ
         vUdAXAdnazXF+4vomG8Wp40hTlu0jIh4n2u+bg4vOhQLjMgLzQWEB7akK+0BKTVNBf8g
         vvF65P4jfW7K2HqkFwTNdOYTgWySe3BJcPWamXvPbVVoGD9RLeF6JO2Ts/n17/LUQAgV
         ywEWafMrePg8FoeUKakMZ8GnE2F23Regrj8bq2OxNxP40ky518k1Ak780v6O3sIfkS5Y
         79QqMxftH5fY/AyQZ9tGLnwg+FvsxNgYWSiNfQ1e+CTUNYUP8jPFAllKrPhduX8KJ3kw
         SM0A==
X-Gm-Message-State: APjAAAV4qGjxJ0RLtixW9QtV+F1OxMZRfZbm81I0MvwmrZLooG0KFbdp
        mqAnIPgFhN6jfFXY/LIHnWOSdjrswr2a++FYrhWx+vNFpms=
X-Google-Smtp-Source: APXvYqwAjqe8DlKr8PYF3Wq1QLB26wR638W0k/14Roh/WmKpc6J0IPA9+etVcXxIkQltySTgjbC61AwQrpZBMEYDsHU=
X-Received: by 2002:a62:4183:: with SMTP id g3mr49898949pfd.229.1557323243023;
 Wed, 08 May 2019 06:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com> <22dc9bfe-af2f-7ea9-e5bc-95647d5411a8@gmail.com>
In-Reply-To: <22dc9bfe-af2f-7ea9-e5bc-95647d5411a8@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 16:47:12 +0300
Message-ID: <CAHp75VdRE8C=ZODLuKC0JktKv4rbw_Y4fOA4J5wBYKPU+URK+A@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] platform/x86: asus-wmi: Support WMI event queue
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 1:10 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> Event codes are expected to be retrieved from a queue on at least some
> models. Specifically, very likely the ACPI WMI devices with _UID ATK are
> queued whereas those with ASUSWMI are not [1].
>
> The WMI event codes are pushed into a circular buffer queue. After the INIT
> method is called, ACPI code is allowed to push events into this buffer.
> The INIT method cannot be reverted. If the module is unloaded and an event
> (such as hotkey press) gets emitted before inserting it back the events get
> processed delayed by one or if the queue overflows, additionally delayed by
> about 3 seconds.
>
> It might be considered a minor issue and no normal user would likely
> observe this (there is little reason unloading the driver), but it does
> significantly frustrate a developer who is unlucky enough to encounter
> this. Therefore, the fallback to unqueued behavior occurs whenever
> something unexpected happens.
>
> The fix flushes the old key codes out of the queue on load. After receiving
> event the queue is read until either ..FFFF or 1 is encountered. Also as
> noted in [1] it is checked whether notify code is equal to 0xFF before
> enabling queue processing in WMI notify handler.

It's rather a big change. Can it be split to smaller pieces?

-- 
With Best Regards,
Andy Shevchenko
