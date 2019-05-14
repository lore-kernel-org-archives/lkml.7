Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6484CC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371B72085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw1d42kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfENBcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 21:32:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39856 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENBcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 21:32:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id z128so9318402qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 18:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uzZggL7uaEuD2m83sZrmm7ypbTjMCDPij4bD1U6Km4=;
        b=Yw1d42kccOcuD4dM7cuNCekEKABH6dROBIov4bmT2B0NlJosxDADNL374BYkyGsZ7O
         ppkbJsz1p/rLMWbj8auOxxtk+8yqcSVbCoKC3YmaK9JE3B6evqoamQkrRFqjadnAyCoR
         abQt5RWrmkyS2RlmAjn7P6A7+Nexr115z6KlwjkXPlL1+mrLF02nx2ttKQu8FuNe2k5D
         lUqYCYrfjBVM6U76AjqglaQ84i30xx8uGOOlmkzeQVG/y1TF/x5iEES+FS1sXg0Ey3Va
         tmXPF0hNu9BRqJyECy9WqYXeGo4wmXax8N99ysoCdAF4HUCFAlvwBQQgRnRyaVSOONUZ
         YckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uzZggL7uaEuD2m83sZrmm7ypbTjMCDPij4bD1U6Km4=;
        b=E77v3PmR/zVi3RnybfonoxCjCxGCdaLUJVL2RNIHqyOYnf+yA6QIixR1jNpCRT8QJx
         d0rIfHdbNxNmqNQu0jxv29GBoZUJA5/YlY2Bdi2j7bO/2Eue/v82I3+qAOTQHsVjQO+6
         Eu1cj72R25HH9bBOKmk3hoUvXPgEeCNqjb2QDgFFb56TV8mTOJ+a/DwU0vjiwsmESb6b
         UeYkBMT6RH1EGT6Mcv7Y00pfwncN/wQ1IXQCieJAMiom+zuXUaE6Hyeg8lhJx7IPwi5c
         t/uwtJF/iO6IFw1CkXgY+vv0r8njjWsk8GeheLfNfYunZbZyJ4ujyLfzMyo+7etS0+eL
         ABiA==
X-Gm-Message-State: APjAAAV2lvcFAXR1FA9szy0fHxnqU9E6pTjhsDjKBJ2L9i56DhSGFl9/
        LcPrTqfN/Qyx/1qs8rFmFvaT7lEoyXQPLOyMmoo=
X-Google-Smtp-Source: APXvYqy/UbH57XPp7HBsnus1TpIDc2fA2wo4mOYna++4MNCuKEsNZ1V6zXq/ozfWjCcKNJGhnN16p/2G15fLpC4tX40=
X-Received: by 2002:a37:b4c6:: with SMTP id d189mr25209054qkf.173.1557797524504;
 Mon, 13 May 2019 18:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190513091203.7299-1-duyuyang@gmail.com> <20190513091203.7299-2-duyuyang@gmail.com>
 <20190513114504.GR2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190513114504.GR2623@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Tue, 14 May 2019 09:31:48 +0800
Message-ID: <CAHttsrYf_SSEHwPZRqs2KGznPgC9Je3dPOft1bwZ5pYC5R0xUg@mail.gmail.com>
Subject: Re: [PATCH 01/17] locking/lockdep: Add lock type enum to explicitly
 specify read or write locks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Mon, 13 May 2019 at 19:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 13, 2019 at 05:11:47PM +0800, Yuyang Du wrote:
> > + * Note that we have an assumption that a lock class cannot ever be both
> > + * read and recursive-read.
>
> We have such locks in the kernel... see:
>
>   kernel/qrwlock.c:queued_read_lock_slowpath()
>
> And yes, that is somewhat unfortunate, but hard to get rid of due to
> hysterical raisins.

That is ok, then LOCK_TYPE_RECURSIVE has to be 3 such that
LOCK_TYPE_RECURSIVE & LOCK_TYPE_READ != 0. I thought to do this in the
first place without assuming. Anyway, it is better to know.

And I guess in a task:

(1) read(X);
    recursive_read(x);      /* this is ok ? */

(2) recursive_read(x);
    read(x)      /* not ok ? */

Either way, very small change may need to be made.
