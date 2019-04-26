Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F15C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379022084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsho9+eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfDZGf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:35:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35942 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZGf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:35:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id m137so1285823qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0CCcvrQKNvZdOBlguNuEQf2fS1NfZTk1cAx7BGAUbs=;
        b=rsho9+eYlPseO7/CGG1SFD4EoFm92Su3T5N6sNPsTBsYzPiAjBd3dZUpWvFxqqcrR6
         zRf2nDRJcZWyq7jzjYKPvhiQT4MNNbuSmvyKDHYVU4co+e4mVlmLNLv2ywAZU0qT+RUd
         S9c/WrvNnXx0I1iJUIH4QbOxzMh6r4rXr3WVhkowaZOB+m5vDAz7miRqbYMoRhXSQJc5
         POgr0HoK5sLtd+fnCWiPWAe0N4FaJBxcXg9KSVzMXMb6+1IQ3U89xnC64Mgh3N7fl0wQ
         V3Hd8CtBvT2S2B5O5CUr8sy4anROl3LY6JOfY1xGpFoU67Dbk8prr8HzcfXeEaaQLWfs
         01mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0CCcvrQKNvZdOBlguNuEQf2fS1NfZTk1cAx7BGAUbs=;
        b=ucqp0W331m3bisEOS8YZXveACr/mjoyM4FMf8s6Sfxme893S1J/Lk9bURVOsRxthwd
         JwL9pjmlTPC13oMsA4b2MoTYOP4qaKINrWUGu/lrFj3b/wzCZOgmeuBe8yf2w8AW/6to
         72TFWDH+7mYm1rpZHYZ7M8t01pqZ7zyNXkAqmYzNT6Qt8Zs/r0Bt/uZXxV8WsAKpVLnl
         ht+p7CK6OcUApP+GYubCjpiCByqRPhK3DH3cORChHvVOqJ6UNoJ6ddFjzbwHMVqR79+Z
         9z/x1fBZOvYlh8SrvjU71VmEMOPENcEISNxXoNgKcEGum9wOZVsG+OA6z2r0SdLZJ2s/
         YXjw==
X-Gm-Message-State: APjAAAVb1VUAVVgLRLm7S0a+6Y11qNNoNG8MIKJcWjVmz8lBWUIDtj0T
        vH/bENQlIFwvUafnVm175indhADOCJKohHds29PbdZard3Tm2g==
X-Google-Smtp-Source: APXvYqyGb9GJfWR0IZHtvu+w8D2JU8B0UKfHXVnu+tGOc3gvSH8iI2R+voU4Uyr/ih2+904Qg61QN5N1i56Wq66NqyA=
X-Received: by 2002:a05:620a:1088:: with SMTP id g8mr9634469qkk.173.1556260557642;
 Thu, 25 Apr 2019 23:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-27-duyuyang@gmail.com>
 <20190425200658.GZ12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425200658.GZ12232@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 26 Apr 2019 14:35:46 +0800
Message-ID: <CAHttsrZhswsrNywoC0gQk4n+VTPPM=xvSPeJy_Tp92pEojzVQA@mail.gmail.com>
Subject: Re: [PATCH 26/28] locking/lockdep: Remove __bfs
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

On Fri, 26 Apr 2019 at 04:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 06:19:32PM +0800, Yuyang Du wrote:
> > Since there is no need for backward dependecy searching, remove this
> > extra function layer.
>
> OK, so $subject confused the heck out of me, I thought you were going to
> remove the whole bfs machinery. May I suggest retaining
> __bfs_backwards() in the previous patch (which I'm _waay_ to tired for
> to look at now) and calling this patch: "Remove __bfs_backwards()".

Sure thing.
