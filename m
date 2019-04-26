Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7876CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7A7208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLZzivqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfDZGsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:48:12 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:34378 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDZGsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:48:10 -0400
Received: by mail-qk1-f173.google.com with SMTP id n68so1304396qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhRY815R2AqhT7LmjxiwI3XYxdY7+txljuXoaHBSaFU=;
        b=mLZzivqchwXacrvgyyoyV8g3zI8nmBIvGvHyK5ZiWPn/muqwI51d+TjwfxThmP7xnL
         9ERluw8/lC8lUH2uJv2zMWjNfiIQIHpeQglGyD5oeJm2WilOvu4lIf49NDDoCUXy9+cX
         n/IKbUoNPYeJlHbgDcN5pu07HmAY7/234w5hZlM+IhOnhnUVW2H8rirRoHtA4OEE0L20
         7/YK7FXfwY4Q/IoUQK1l/Pj5IZ7TGxLRfzhYbJTlOYZQvU/DqBxfnaRoSlZwTsFUDhSr
         Fpkee+i1Vma3qJ042JURDNIgOIG26/r68Q3D6UJmcTdNcsm1wgFI/6Dck9CCMjD6Eb6Z
         wT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhRY815R2AqhT7LmjxiwI3XYxdY7+txljuXoaHBSaFU=;
        b=c82E2hZ5D/5FEIhJHegFP6PRsc+Vym6fxh86a0VT7hHm4NW+N6HHFo1kb2TuvGlR33
         ap+U48LL2Kp0oCzUkyQeEt0XZGBQmK754KC2QZbrD89ve+q31jvcnvKSDp8ITeQT1d3e
         bLH4dshzyqAScSMWiMnSENrbFNC8ldvz3O4+E0WBBmPkyEIwTu0/uEQCUsxYPsdI6f2E
         5sEfdz6e3NWdPZ7uHOi9jU2v4tt/83gK83BxFDRm28BA6ReDu3FWg98aeTqE7GrHoNSZ
         zN0ipTJMj+B1i3uTp9VO2fRgNOLirc6eE6hwJStBXWPJ8jkMS0YHZ5MhG592Z2d+Gx0W
         sULw==
X-Gm-Message-State: APjAAAWEMdReWW5a6rNlgO2/At0kzOrMrkcg9aH3HtIyYMY9r12JOzpH
        JRnQeJ/4PDL5rEgyd24+fQLU7b4adcggKfwgxvw=
X-Google-Smtp-Source: APXvYqxN4Q7Xv08AWyR6Swe1Lb/sWFMMr8JUTtmJ0M5M+qJoW4+GJxLU905ZeTORodL0VrBcV3RXWCrazOJHqI1s4WM=
X-Received: by 2002:a37:4f0d:: with SMTP id d13mr21283631qkb.159.1556261289274;
 Thu, 25 Apr 2019 23:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-23-duyuyang@gmail.com>
 <20190425195212.GW12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425195212.GW12232@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 26 Apr 2019 14:47:52 +0800
Message-ID: <CAHttsrYgxQ6zB+V2gVgPZT1y9n9X-cC+6HYrhyL++eaSknJoRg@mail.gmail.com>
Subject: Re: [PATCH 22/28] locking/lockdep: Adjust new bit cases in mark_lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Fri, 26 Apr 2019 at 03:52, Peter Zijlstra <peterz@infradead.org> wrote:
> > +     if (new_bit >= LOCK_USAGE_STATES) {
> > +             WARN_ON(1);
>
> Does that want to be DEBUG_LOCKS_WARN_ON() ?

Indeed, it was.
