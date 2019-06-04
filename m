Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE2AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9302490C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfFDLrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:47:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46666 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFDLrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:47:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so2546723qkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHJKK/e2WXQfGPq6JPvdmsZx/GKDlBLCBewwqbRa8t0=;
        b=mRTXNZDrg0ccXje7rLOf/v1JwqliCqZyexwqSesoU6lBE38JNDicI89K581EVjleqf
         3TimPptz33rqSWsBDiRYehbZUgrU++ZaNLJfrxkAN4I7nSm7C/Dg4gS1/D4icSLdeKW4
         pe5nfpZ4u9y/FqkJjdVp3YrbAaUUbl1M2Nhwxqrz/afXK0kQUPXpDzXs8h1xsqP6TA2P
         dLyA7zQjCrb2+o6FE6dsDTmzhb7LJtVXjTwaUMj7N757HbuuU6z58FF+bGhN7zh1acxg
         qpLQ87saJi72ZdiuHHrruxud+Tc4rEG7Z8fHnhIlaX6gI4ils0ThCbJr0dI7y40pZQSb
         kLaw==
X-Gm-Message-State: APjAAAXC/k2iE20jn0uL0yItjdYryyLXAYrUJmBrhAdbGVZrj0SjkNc1
        IM+UisndEZXsfsETLlsRCA8BNNIgReK6ixCcec+moFA31+g=
X-Google-Smtp-Source: APXvYqz26FtG/SH7XiAsK7EtNGdeNSlNJbMOl+fdyYLLgTPiH1vCfPqC9Be/usikzvB6Rd8DYozJAXMz99g2s4ugwpI=
X-Received: by 2002:a05:620a:16c1:: with SMTP id a1mr26496328qkn.269.1559648855749;
 Tue, 04 Jun 2019 04:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-48-git-send-email-suzuki.poulose@arm.com> <CAK8P3a22Uo9mLh7cLpZQQpxRFd=XJ1uKu66eu1c6_AMNzW8etg@mail.gmail.com>
 <ae7c07c5-f223-dec4-b8e4-c49d08a76fd7@arm.com>
In-Reply-To: <ae7c07c5-f223-dec4-b8e4-c49d08a76fd7@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Jun 2019 13:47:19 +0200
Message-ID: <CAK8P3a3Wc44JtMhrMSqFy3d5CiESm6iO64kGDdhGygXN9AvowQ@mail.gmail.com>
Subject: Re: [RFC PATCH 47/57] drivers: mfd: Use driver_find_device_by_name helper
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 1:42 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> On 04/06/2019 10:45, Arnd Bergmann wrote:
> > On Mon, Jun 3, 2019 at 5:52 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> Use the new driver_find_device_by_name() helper.
> >>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> > I see that there are currently no callers of this function, and I never
> > liked the interface anyway, so how about just removing
> > syscon_regmap_lookup_by_pdevname instead?
>
> If that works for you, sure. I can send in a patch separately
> and hopefully I can remove this patch depending when the said
> change lands.

Sounds good, thanks.

      Arnd
