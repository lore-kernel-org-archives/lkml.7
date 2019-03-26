Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328932064A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dlWjHUXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbfCZStF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:49:05 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39023 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbfCZStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:49:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so9483770lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtzN9uuKvwgRndtv0vOLne1QwtbZ6Hku5H3sjw5YEJA=;
        b=dlWjHUXV228mPKh9HrSrNE4Uf7hO/zOYy6X29KAne7+Jf+RT2rS97upskcjWK1Td9s
         uYf3JZjygel9u4Rs2HanylRlsZjYiOYwAnnJjGRzOKmcmg79641DBZxhu5lOPWzgFWCq
         6HY1M70AXIEWY2qQwqjYyxo1J0U/PotL0rV1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtzN9uuKvwgRndtv0vOLne1QwtbZ6Hku5H3sjw5YEJA=;
        b=cIIwyPUL83rCAiFOyhwF0QP4j+bN9PnW41A79Fv0VtW7OaH2vhJ3tm5advGU8nBY7V
         7gxoxFE6Vom4kZAAmzCmQ7kb7wX0nA3P0WT6aAVJli7lOHfmCTKMs9d4xL6IYID155bP
         lCLuvZrTyG7pYmYeG24soofU+TTHOICgwTPyuWoB3EjJm67p9F467VEF3D37A/K05mKW
         z2Mpfj6nYYUaT7Ms7P4oW4uH1Jgaz/mJ6cojcFHiGWlgooSHC2nuRyGH3/fS/uMfhpBD
         vIrjl3m0bjmjADKashogjm8DuZHWUpQyvH5hm3cLh5BlCCZn+nOgIpUsBMSUjOzKVMUJ
         uSXA==
X-Gm-Message-State: APjAAAUw3SCIyr50+jXAzkYmkHG98KLIUqsn2yLzWNDuqcWtG8VkDPvM
        bIzUzlrs84P7mou5icfulNv3TM2IQxk=
X-Google-Smtp-Source: APXvYqzG0KwXiEXHYlDDOORMkX9DBEof8TZpMN6dsWAX63qanO6ErPKDrIsC2cpkt8PgQfhQKXbIZQ==
X-Received: by 2002:a19:7608:: with SMTP id c8mr17098342lff.157.1553626141930;
        Tue, 26 Mar 2019 11:49:01 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id l16sm4255760ljb.24.2019.03.26.11.48.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:49:00 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 10so9480943lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:48:59 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr17034550lfn.139.1553626139438;
 Tue, 26 Mar 2019 11:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190222003051.127006-1-briannorris@chromium.org>
In-Reply-To: <20190222003051.127006-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Mar 2019 11:48:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNYZhOeef_7nhZf1GYhdxubE7v+ustG8zDigGHVOYWRFg@mail.gmail.com>
Message-ID: <CA+ASDXNYZhOeef_7nhZf1GYhdxubE7v+ustG8zDigGHVOYWRFg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 4:30 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Badly-designed systems might have (for example) active-high wake pins
> that default to high (e.g., because of external pull ups) until they
> have an active firmware which starts driving it low. This can cause an
> interrupt storm in the time between request_irq() and disable_irq().
>
> We don't support shared interrupts here, so let's just pre-configure the
> interrupt to avoid auto-enabling it.
>
> Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Ping! v5.1 is enabling wake support on Scarlet, and without this
patch, that causes interrupt storms at boot. Please apply this patch
for v5.1-rc!

See also:
https://lkml.kernel.org/lkml/CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com

Brian
