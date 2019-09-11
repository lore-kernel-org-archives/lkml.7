Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8801ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD0E20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axEEe+Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfIKI3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:29:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35486 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfIKI3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:29:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so13214175pfw.2;
        Wed, 11 Sep 2019 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cseoKH3oBWC+0X9v3aYbIoBEhdfQYccTgVaRfgik0vY=;
        b=axEEe+Hjd0qUgXBA1Q21wmIpdcJgt6M+zh4nEhFd4PLZ6yE800H0StSMvYyrLcj9FD
         xxTwdDrCrNN76gaUisORRQp/nUjrhoh6HuWA0YUQvY74dp/svbC3kDNNxrMO6nkB9u6r
         UFbWzG/lf91E+KrnCzPUXLVVtpuMLe9rwnz1tMQ4Rre/zPDllih8QlYuTwpf7eutTM5V
         f4kwhqb4hpFwQDX8++Vh65W2xsA1NbQjbE8Wft81gzoKK0rC3h/qYktUmByaedCQqctH
         OTrpBxs4s1cFJtXgYriQg+kd/6vKl4sLcsqJUxTyNlOVHq1LEtpmOGh+JvHsjjFyiko4
         8Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cseoKH3oBWC+0X9v3aYbIoBEhdfQYccTgVaRfgik0vY=;
        b=fcldAj6DqcO4PhRqyeb4vQh97F2ywxIO5Kft/Cnfen8J49/0aGQLGYjW5yNFlEfBCk
         +ivgYSAPgvrF7EwpDkdDtoihlBJoZLlCQdB39Emr+AxoNep6eoBC0YULmsgyqXlRV5yQ
         /X3oBWoyW9LaQ/5HR5BvGolu4E2gWblexrFv8T1M06akMnb3Pawtu8wLuYDI63F/73f/
         sBK/knNlQqlCAENa1sbLBlbFKhiU6/EVdTuJgOnfoFU1nn3t7qr2pHIuQcCmWtAsGmI1
         iqbcrGB0ihBe5Kr4G47vivXMpM1J3lnucRkePIPt1LgTOL4MNlrVkltSOjN5Xynu0nNl
         s3Tw==
X-Gm-Message-State: APjAAAX2gOI5P5nuKEqYaN03nOVIA1sM8gPuWZrd6MPm9lSPpLOX3DSp
        GZBQSPncPWwngHhi0Iw+SfEbOXcLP/Ppvb49Nqs=
X-Google-Smtp-Source: APXvYqy6XpTQ8EVzyGevKYt5w3jlnSBHVa6lohTLSVwPQuOiYvSW1aa0QNMhJpSwaRZWYGp4s1Cd9oXq+GMf5EoB61k=
X-Received: by 2002:a63:c842:: with SMTP id l2mr31756878pgi.4.1568190562807;
 Wed, 11 Sep 2019 01:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com> <20190911051231.148032-7-dmitry.torokhov@gmail.com>
In-Reply-To: <20190911051231.148032-7-dmitry.torokhov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Sep 2019 11:29:10 +0300
Message-ID: <CAHp75Ve5NvhzOQ96OgbPh1LdsAtvk+A=aVu-oXKdhnB4PpL_og@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] software node: get rid of property_set_pointer()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:15 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Instead of explicitly setting values of integer types when copying
> property entries lets just copy entire value union when processing
> non-array values.
>
> When handling array values assign the pointer there using the newly
> introduced "raw" pointer union member. This allows us to remove
> property_set_pointer().
>
> In property_get_pointer() we do not need to handle each data type
> separately, we can simply return either the raw pointer or pointer to
> values union.

Same as before, typechecking is good thing to have for my point of view.
Others may have different opinions.

-- 
With Best Regards,
Andy Shevchenko
