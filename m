Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A9C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE7D20673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="3eWauR/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfFSUHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:07:07 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:53215 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfFSUHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:07:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 9eb80254
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jun 2019 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=D9OSfcTgB30HuyBuA4T2ujgIyPY=; b=3eWauR
        /ukRwGBUGUylWauukNImoc1wFnaQBXpKnY0H8akF2hWbfb+jhLrDxaGA8GlwcGpg
        zziXR7QnQfwLi6S4fZ2SR8dbXvYTUhVS9r9p+ya2EgGQPq2Q5bexk6bo3qPeRsR3
        uIYsEWmly7pjZMFMG9EicS/Vc+DLnDlNcXf/ezwTKRrsaX0ILyFXnGMnM8xuTz4r
        iZu1GwoRt9iEZ/tMTBe8quklbC4yXQ9jNzMJplw3f9TdspXWYddQeMajxEWLLh/l
        WX80FDDvtrdUv07g0xBgkm4NCkfBNYDs+3ss0APGKix6KBNH+KUVkGl2Z6InSD//
        oFX6S1LmfghoMm6g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5d201ed7 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jun 2019 19:33:54 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id i4so363125otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:07:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWahU6QMyy2FT3Uoal0ppqPjNmv0oyxw7cBOqeD/3MjBTXqSEOv
        EeXk4LZhI/nBbnJS9Y51nD48iSsdPDmok4Lw7uc=
X-Google-Smtp-Source: APXvYqyTziWTodddpkG33XXMSBxIGRP7FJWi9q7S0Kzeef85WjeD/b8FjcjZbPxN1b4ObuU3h8sIk+X6tDc2n0vkwZU=
X-Received: by 2002:a05:6830:2148:: with SMTP id r8mr20851774otd.179.1560974823800;
 Wed, 19 Jun 2019 13:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142350.1985-1-Jason@zx2c4.com> <CAK8P3a10PfTOhLA9d3vMTV_YXqymKLNeqCg6r7dLiNA1BwJbmA@mail.gmail.com>
 <CAHmME9rYgKxNyLH4MFJwaj4188O5N6vjseQRHwF0n5pZhU8kuw@mail.gmail.com> <CAK8P3a1Wirao3s4Xz4Rgkc1FkpT4isMNuuPv7X7orwX4fcotXg@mail.gmail.com>
In-Reply-To: <CAK8P3a1Wirao3s4Xz4Rgkc1FkpT4isMNuuPv7X7orwX4fcotXg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jun 2019 22:06:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9pk7zXMSGiofPMppzA=dy__qttg00LtwqU7oSz032jtWQ@mail.gmail.com>
Message-ID: <CAHmME9pk7zXMSGiofPMppzA=dy__qttg00LtwqU7oSz032jtWQ@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: get_jiffies_boot_64() for jiffies that
 include sleep time
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > get_jiffies_boot_64 26
> > ktime_get_coarse_boottime 26
> > ktime_get_boot_fast_ns with tsc 70
> > ktime_get_boot_fast_ns with hpet 4922
> > ktime_get_boot_fast_ns with acpi_pm 1884
> >
> > As expected, hpet is really quite painful.
>
> I would prefer not to add the new interface then. We might in
> fact move users of get_jiffies_64() to ktime_get_coarse() for
> consistency given the small overhead of that function.

In light of the measurements, that seems like a good plan to me.

One thing to consider with moving jiffies users over that way is
ktime_t. Do you want to introduce helpers like
ktime_get_boot_coarse_ns(), just like there is already with the other
various functions like ktime_get_boot_ns(), ktime_get_boot_fast_ns(),
etc? (I'd personally prefer using the _ns variants, at least.) I can
send a patch for this.

Jason
