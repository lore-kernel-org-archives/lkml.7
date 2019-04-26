Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87704C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521D6206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feBq2Lk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfDZHAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:00:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45535 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfDZHAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:00:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id b3so2943122qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWWiy6HsjxsTUoo2P8LqlCvN+4wOu2xo/zLBn5M2klI=;
        b=feBq2Lk1ARm/qsqxxZhRnmuYFTRmBz8mnxKRa9gj+R07PekBu6B6KgQwAJXs6yfu1w
         DYxVTTfyO4IWCWGhU9dbTC7+NJDKyxXy1kiZg2djscgSmr3VLwVIPEilGT1GUES9/aQ9
         m7UKTHutH5aQ0qBZAcJm3XraogE6UF7UF7GlLK+yzVodJ64hdeifCSsizMvi0Qjd2cUa
         95ZcNzXGDDXxmA+9+cnMTD/gZxJnNARAepc/M6CyPNTMOB/8NT0lBosmwRIqWFqgwx+Z
         954tN5H5dPMTCAiUmmsM8+1GrdCz1OMeRnJJy74NUOdmgOG/39+hBhiQbvDnVe08OA1A
         Gy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWWiy6HsjxsTUoo2P8LqlCvN+4wOu2xo/zLBn5M2klI=;
        b=AyKJtaCN1YFOO+pzpH4wQDWVkGsj4GizDg0kj9bzSPkcrVUsm3KC/LmEHSuUMKg5ij
         N0z910H8awREbiFYKDnNjk+Hy8SCLA4sTKHevAQzIFXNzMdAlgWA0ITOoosJkaKw+kk8
         ss80VTKEKOoMEMGku7Hkm9WouTTeYmoXFn0GzUJBGGYncqC0Ae+0X31g/HpefuF+Mcdz
         ce/oDCo6yFr+WtrsEcTyzLUxc56o2N013aehwfDclw3gwnezVEPt84j1zMOdBkG1L+hC
         tKORr2/8jTx7uqT/nBV8ms5M6iSP0JHAW+pjGC9adDBuTJ7PY6lKnzLqRiGjuAqjiJVO
         ec/g==
X-Gm-Message-State: APjAAAWQdoFuEFFMvtCIXXIWYdDDr3xOTlnChUmL96vLL6IVRaUsQwPi
        Mlv4EWxVIOzRFxo/ShYQ6gXIwUsJ4zkcAu2Er2k=
X-Google-Smtp-Source: APXvYqyyexDfJe4Ff8qTZ4ncpFs9qKJISd12X9yQNxBW8OlD1alEo/6iTZ9e5RSY3eTg2QOhada0sHLYMpOqYwdUYoM=
X-Received: by 2002:ac8:26e1:: with SMTP id 30mr454596qtp.305.1556262005116;
 Fri, 26 Apr 2019 00:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190425185641.GT12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425185641.GT12232@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 26 Apr 2019 14:59:31 +0800
Message-ID: <CAHttsrarkCz7a6rn-Zd2zfzENAPTkPMJNABkRw-LAHo1hCXKNQ@mail.gmail.com>
Subject: Re: [PATCH 00/28] Optimize IRQ usage checks and other small bits
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

On Fri, 26 Apr 2019 at 02:56, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 06:19:06PM +0800, Yuyang Du wrote:
> > Yuyang Du (28):
> >   locking/lockdep: Change all print_*() return type to void
> >   locking/lockdep: Add description and explanation in lockdep design doc
> >   locking/lockdep: Adjust lock usage bit character checks
> >   locking/lockdep: Remove useless conditional macro
> >   locking/lockdep: Print the right depth for chain key colission
> >   locking/lockdep: Update obsolete struct field description
> >   locking/lockdep: Use lockdep_init_task for task initiation
> >     consistently
> >   locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
> >   locking/lockdep: Change the range of class_idx in held_lock struct
> >   locking/lockdep: Remove unused argument in validate_chain() and
> >     check_deadlock()
> >   locking/lockdep: Update comment
> >   locking/lockdep: Change type of the element field in circular_queue
> >   locking/lockdep: Change the return type of __cq_dequeue()
> >   locking/lockdep: Avoid constant checks in __bfs by using offset
> >     reference
> >   locking/lockdep: Update comments on dependency search
> >   locking/lockdep: Add explanation to lock usage rules in lockdep design
> >     doc
> >   locking/lockdep: Remove redundant argument in check_deadlock
> >   locking/lockdep: Remove unused argument in __lock_release
>
> Those look really good (but don't readily apply to tip/locking/core) now
> let me try and look at the real changes..

Swell.
