Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE331CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A3920679
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVHz9MPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfKAWj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:39:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43821 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfKAWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:39:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so814994ljh.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW5P3msthAEYEpcJCwNLHJI0AHwjUK9+moq8nW+j+gI=;
        b=NVHz9MPNmEYvoVVSDtGjE9sibi06/7R6dS/cupiorDXcYX1YBdHDJxjGZJE1Z8YBGF
         xaZ6cY1OaC1bPjLiMmOwxMYyBjHvN1ezYW//Li/vpFZj1WsudhzRIEwPg9Q7BtQlLGJq
         kvIrnlIoDFwLct+Jfz2NH5yNULCDgumxeM2EJnZl8B6Ol032JhSvcKOQCqGdJxrmFwEB
         lirUhn1uHUXLUedG4fBainYrPQegJ5PpUnIDNOdAWgm5uY73MBZo0nhME/1Mz35+nJxH
         D8pe3bu5bGs1MxhWgbS9kbH+oH3v/jZgdS43b+qqWofE7h+wwKo3+BuHQevE/3WjO8oG
         Q9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW5P3msthAEYEpcJCwNLHJI0AHwjUK9+moq8nW+j+gI=;
        b=a41m3dbYfNpLjr/dHwMZNXBUR5032TZ8sVFowvMk6w5NVX9018Hrzchya2s6Nfe1TV
         zG6Ma48EdK0Jod0C7HnAUMMBgBqh4vDC8Rgg2aKwjYR0AXANCy71+k0tCj4LRgVTENjj
         JvG2Q035kQWEAZk9bcCbr+1GFTKaCXR07+dm65iNxCACn6zfv2VQ/RZ2zvYkwoAFX09v
         s2zb+OKGyihPTENMR6dB9TXFJzG4GDj3yA3vvJOkgeKrguq9zyolcli6pS0gMlg50mWM
         aHso8ff/iuOQeFbBX+ny1cQ8jw7TS4hQJVbiY1nEWoZ0C4c9lyGGayU3UtPjVzySWMm4
         bv9Q==
X-Gm-Message-State: APjAAAUcmx4cUaJKodBMw9S/C3IuCAnqXmpWBI1ydiU8EFGIRxRGCPho
        cRGNdWVF6ZrwXgDO7MMAqOpj7uqxnONmFdwTdmc=
X-Google-Smtp-Source: APXvYqxG0qIa3i3IeHZD+usZTQwBJ9x/ZbDOyT8J6TjeiFMt1c0/iXrqEg49ZypCqzYjMFCjECboyjVqrYbYlG+xdxc=
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr9721034ljd.1.1572647994910;
 Fri, 01 Nov 2019 15:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
In-Reply-To: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 1 Nov 2019 23:39:43 +0100
Message-ID: <CANiq72kpbgkjLqTP_uRNGN0Qh6xx_EBxy5AB+Y_1FNhi-Q9+xg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 10:25 PM Anchal Agarwal <anchalag@amazon.com> wrote:
>
> Currently we do not see sleep_enable bit set after guest resumes
> from hibernation. Hibernation is triggered in guest on receiving
> a sleep trigger from the hypervisor(S4 state). We see that power
> button is enabled on wake up from S4 state however sleep button
> isn't. This causes subsequent invocation of sleep state to fail
> in the guest. Any environment  going through acpi_hw_legacy_wake()
> won't have sleep button enabled.
>
> Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
> Reviewed-by: Balbir Singh <sblbir@amazon.com>
> Reviewed-by: Frank van der Linden <fllinden@amazon.com>

Somehow this does not have recipients listed, CC'ing lkml.

Cheers,
Miguel
