Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC1C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DB7208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9RSlkf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFGDWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 23:22:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33569 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFGDWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 23:22:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id 14so750729qtf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 20:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDxKlx26C6I58M71iZg55l9IUELd+cCI69BULnCFGCU=;
        b=R9RSlkf8+7etHBjAktMnCFls3HmJAeag61qEvUcSUdU9xFUNsgeiUVZ5f7YgxyNcBi
         N27IoHFfbFQ2M6bz3/i7+VeU0s1eHY44W7olFyIoK1/bW/EixiJNzF2G66ZceV/HtamH
         NkMizrSlre/hZSzJudvOsHmBsyAh5hglTFcDwwDDYefZ2rPCUZZEjRNXni1OuBmdb8Sz
         NynK6du+kAFUdJgkqrCYO/hseSdxRbQVGDv5umg8hWiQg9pyxQx771QiVbhIRxavAnTW
         5xaaEOY5DXpBtk0Wk30V7N/EeMfYwcR9CtfuuO3L6X7cxJxIClpI+pvYUVVgKwfU/rty
         QI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDxKlx26C6I58M71iZg55l9IUELd+cCI69BULnCFGCU=;
        b=ElNhBTd1r98KbJS2LN2gINdzMzqPsbeziAis8zsvDf/y/bTnZJ5LHiNJs9Nx+j8UT6
         P1amTz5rf5sKFgpVezgHj9bxJndKX7V4I8JD0ncC8QA7Pke5yyO8LHe0blasyaUP6urr
         WGfW1vuxjC8ehwX7djgZ3M02XeEHGx3+6GUfNQgke7o8SYbSx0T7SHTb5IQtVdC8yDdL
         x5nOoYUHGL4nRruVqAgFccSARtH0GNYWr+v2dXDBNwCBLdtH5zL28MaNJeUG+Udgc2uJ
         Ony0/JXjVlhRT3NPg7J3bZtLxDXBwV4b1S2R6liZvBrIHKfGKV8SAgJGB/alh+fxVgtc
         PbWA==
X-Gm-Message-State: APjAAAWRPHA0haVHS+7kWACm0HKuvE7xRQv0GzAWDDx4rsVWnefciJ0B
        G3qBvfbHnl/1ds9PYXV4wJy8KAkgKzjf2UQehU2gHSd+aK0BIA==
X-Google-Smtp-Source: APXvYqwkb6t25wXyMzSzcciF75z4Yv0RMfPMvzsQaB38bQ/c+7VkK/VWzC8hiAymuBHnKBGjofSqcJ93hKHsr+hzIOg=
X-Received: by 2002:a0c:88fc:: with SMTP id 57mr28115751qvo.178.1559877730487;
 Thu, 06 Jun 2019 20:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <1559855690.6132.50.camel@lca.pw>
In-Reply-To: <1559855690.6132.50.camel@lca.pw>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 7 Jun 2019 11:21:58 +0800
Message-ID: <CAHttsrYCD1xvL6hf6dXZ_6rB2pEra0HDZ+m5n8EMQr3+5AShnQ@mail.gmail.com>
Subject: Re: "locking/lockdep: Consolidate lock usage bit initialization" is buggy
To:     Qian Cai <cai@lca.pw>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report, but

On Fri, 7 Jun 2019 at 05:14, Qian Cai <cai@lca.pw> wrote:
>
> The linux-next commit "locking/lockdep: Consolidate lock usage bit
> initialization" [1] will always generate a warning below.

I never had such warning.

> Looking through the
> commit that when mark_irqflags() returns 1 and check = 1, it will do one less
> mark_lock() call than it used to.

The four cases:

1. When check == 1 and mark_irqflags() returns 1;
2. When check == 1 and mark_irqflags() returns 0;
3. When check == 0 and mark_irqflags() returns 1;
4. When check == 0 and mark_irqflags() returns 0;

Before and after have exactly the same code to do.
