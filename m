Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB65CC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C546620665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rUbw2h7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfFYHKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:10:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33825 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfFYHKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:10:37 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so1425038iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 00:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=de69OCjWLEoJOVupj+z2Vrj9cMrX8EO/TnQ/3IPkUjg=;
        b=rUbw2h7m31+afZF5Hr38OLSiDf3+gH/T9QJYuR6ow/SKpzay6u1adULGW2w8WI8swO
         6TmWtb1H2tnA2eRTp1XhJ6xFuV4KKqYxxLZpwjhmbpDtKoazMS1JkdiWshJKB9fi9y1C
         1jqjTA8vWAYQ0NXea3jrS/F0o9/oU5bt/JIJ9e4QCjjXBLjnQMqG/VhToI+VHR+Hww/F
         dh6G+zJ0dDyqFCGAEVZzU2trUTWDnuygPYSNubyDA4UaCzt64ekqZtQRAN7b7kJwJvLR
         Q4nxcNbstX9ZKADAEFWAVYHsfTVuuk+cJyHNV0276iR6KFhboN5emsKeB/TC9ePB5QM/
         K3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=de69OCjWLEoJOVupj+z2Vrj9cMrX8EO/TnQ/3IPkUjg=;
        b=brmV4p1v4C+cCGrWJFURN2tW6Gkrtna9nmve3eKndwIJa0TsT8hcLNw5WFv0c9Ph0t
         lpRo6JFVqihYYnj6g1ux8CX36bg2leCVEv5iw/j4OMa+1P1UqP76VudOfMQ4zQbMjzGH
         ht+bkCzCwjiwjj17G6bR2Y8yqhIdGZo8SWaQsdi/WiR0GVo8gzbiWfyAFYN/gFe9rwWr
         lJgc09EdH7UiAI9BbG+5vCnacH1KfLC2ig2s20tx3ssqRSlKMSEt4cx0CT+bbTRuta95
         eTBDLbuHXV8NnnL1Azop2vDgFZ/7PjyUr0GiPD6/pKIUd5jteSt7E47RgqC02OF0QNRw
         mC2A==
X-Gm-Message-State: APjAAAWUcSfOU2dTandH0vS+D24XtfH9KEDgnHTjz7JUB8+/kOzUYEmd
        5od010xZwiDANGUdw1TnNfqegS4SYz+m3a7FmK2L8g==
X-Google-Smtp-Source: APXvYqwt9FUPbNuPIYl40S3Z6LGQFhKnprVrc15JCgOBrx5+zp4ftaGlrybHhDlwTUDwZpPQdqmFp5GLjNd6LUptR+I=
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr2262547ioh.40.1561446636658;
 Tue, 25 Jun 2019 00:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl> <9efcbce2-4d49-7197-a3d8-0e83850892d5@web.de>
 <CAMpxmJX-wXQ-ff1RWkPmJBWSsP_v2MjZrA3fhj3HQX0_zM0eZA@mail.gmail.com>
 <39ae399a-c606-c6de-f84d-35e39d0410c0@metux.net> <CAMRc=McepqowJNi6ay6x9KKoHOC8aCxP_ob12SgbsnJU_sKQng@mail.gmail.com>
 <1dd52704-0e41-db31-33f4-c9f446a47344@metux.net>
In-Reply-To: <1dd52704-0e41-db31-33f4-c9f446a47344@metux.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Jun 2019 09:10:25 +0200
Message-ID: <CAMRc=Mfp85diy849r_8UHKS9eao26djrsMF0_iwE--d62mQ5jg@mail.gmail.com>
Subject: Re: [PATCH] drivers: Adjust scope for CONFIG_HAS_IOMEM before devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 24 cze 2019 o 20:22 Enrico Weigelt, metux IT consult
<lkml@metux.net> napisa=C5=82(a):
>
> On 24.06.19 12:46, Bartosz Golaszewski wrote:
>
> >> The patch seems pretty trivial and doesn't change any actual code, so
> >> I don't see hard resons for rejecting it.
> >>
> >
> > In its current form it makes the code even less readable. The #ifdef
> > should actually be one line lower and touch the comment instead of the
> > EXPORT_SYMBOL() related to a different function.
>
> Okay, that missing newline should be fixed (as well as the extra one
> after the #ifdef). Besides that, I don't see any further problems.
>

Are we sure this even changes something? Does kernel documentation get
generated according to current config options? I really think this
patch just pollutes the history for now apparent reason.

Greg, could you give your opinion on this?

Bart
