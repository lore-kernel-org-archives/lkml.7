Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3057BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A6822363
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B557JxbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfKSQPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:15:39 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39270 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfKSQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:15:39 -0500
Received: by mail-io1-f65.google.com with SMTP id k1so23857769ioj.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QzBsf1/Q8hKzbeSju/cjkym48KF1RXo6Ozgcc+ilbY=;
        b=B557JxbRmG6bGxoMH25hjkkFa/8uMFElraHUqwVWyBdVL88O6yOK24tlKofwQfELla
         kmgnZl6NqlnvT6F9knFUlLByW1Zg0wY/TW/qEZThA5fDnn23pf/AEWg1Jf/VK1UrnZ2U
         oPdawl1BJ8P9/x7dPwEqvvP/zs4Mh4g6P1ZwKfLK36mmAp/5JlJoZpR+zEKSNM7SgdGF
         Z4XqXq5jvbIdTomXYzj0YUVs4ONUOs97XMsDZpsbtnwj5Rntr0Q4oekV0hBAQRlnvZ+G
         etTsVpGZ/+y5WR9tDtcuJWDITRco+L9s1OAZeDEXCMKe/TOtqEdmS8L98pBTwJ2S0t9s
         XjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QzBsf1/Q8hKzbeSju/cjkym48KF1RXo6Ozgcc+ilbY=;
        b=QxIcfv7uIHcwsIFxpK1IFsXXcccDwv4LUFxBHl6j2dORtOEvYP4wxuGG4ZfjjDnwHO
         wKdW8P4lEp0JnNZvKEAoH6DGSfGI1SI9O3nz/of5jjnnbLFF+AelECx2jwEi0hyPpe7J
         xlz36f20cxIn3ukl+OimhLsABM2SFDisbytoGKyNqn22yOYZt/4WRfPw9ndtm1QGvlsY
         DuIPIT3lHauJJt+LEH6cW0uJOB76OVygtAiE1gZXFUi+vkxfWJZMWXQXZFsopSI+U+Ar
         yYNqsgnpSCUvistLhDU28hu8poBnnuKzgAMNh1aiMGN8Mr5pqB1McFGuJq5JLOHTuB3K
         Qkow==
X-Gm-Message-State: APjAAAWRHDEN5hAGyr1KhLHsjeMo5lLTA9i1D2Mvik7qCLc++als0A2k
        4MdDl2R6T5uYK4icez9sDNVGN8DbN3uhMxsOBtPr+KySIdg=
X-Google-Smtp-Source: APXvYqw503RqDWWROFTPpdWnnJSfJY3YAq7SFnY1QjLQaYOndzuBk+hWJoZO8CCxZ/+343iUr17+gMnAVu7eO4Quu/g=
X-Received: by 2002:a6b:2c95:: with SMTP id s143mr5938031ios.57.1574180138026;
 Tue, 19 Nov 2019 08:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20191118185207.30441-1-mathieu.poirier@linaro.org>
 <20191118185207.30441-2-mathieu.poirier@linaro.org> <20191119043044.GB1446085@kroah.com>
In-Reply-To: <20191119043044.GB1446085@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 19 Nov 2019 09:15:27 -0700
Message-ID: <CANLsYkwaYZbQPoqr1D2jB+OKirR-2F1m1cqdAcHHwqvu27HxQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] coresight: funnel: Fix missing spin_lock_init()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 at 21:30, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 18, 2019 at 11:52:06AM -0700, Mathieu Poirier wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > The driver allocates the spinlock but not initialize it.
> > Use spin_lock_init() on it to initialize it correctly.
> >
> > This is detected by Coccinelle semantic patch.
> >
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > Tested-by: Yabin Cui <yabinc@google.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-funnel.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Is this, and the 2/2 patch here, needed for stable releases?

No as the code they fix is new to this cycle[1].

Thanks for being inquisitive,
Mathieu

[1]. https://lkml.org/lkml/2019/11/4/726

>
> thanks,
>
> greg k-h
