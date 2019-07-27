Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F038EC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41E9214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P118mdqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbfG0RiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 13:38:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44184 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbfG0RiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 13:38:15 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so111253653iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxuNjFEA7s07C73APXQQNAta426oIXYom1FUbQczxhw=;
        b=P118mdqtL3CISSKDME3yit/FU9M8ypTF8xHVnp2a9Yup3YhcYXMS74ai0jUKBP3yIN
         GiUzFZoan4DR4QjDabidqUZnhIGnlj68IN+bCTQHVANJlKtwprPgM3f8DGezqFyUm97k
         Mh+PJLGZhGI+2gCBl6sFKQeXoWbs2M7VW+F90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxuNjFEA7s07C73APXQQNAta426oIXYom1FUbQczxhw=;
        b=TbLr/sIhPuHV1FRF4TrrtMyrYF45KdMih0bYynP5CYMwe5t4N1rMo1mvs9xWgrxF2Y
         Atx0wvaUff2D5LlxrSCijNl3bdxmlz6v2HJ9vGfSnGzvWj960WlbfMGMHQmTCxnU69fb
         D8Vl7J7b2CimiWVVjfCyRu1CEbg1ltyK1otofVjsW2zuGpyeve21eY0xG/DgPP2AJUDa
         kXhVKBzqQobXvFP+VRR+sKXKk3dTJe6575w9OZnRLv/QVw2dKYyttHkawTgZIM8RaoCu
         1TLNpaNqCkrS0wMVkJ9drAaUJ3AH2fWHymOyvY8ybQHnM3eKrP2BvEP4FJyqAL3VJ48K
         5E+Q==
X-Gm-Message-State: APjAAAVdr9sSgt+gZaODEplzEAURzLrUdDQ/ubVsto+zVDz/ciWMmSng
        D57BJ27ysslbaqWuhMV/29aUzHw0Nms=
X-Google-Smtp-Source: APXvYqxCSBxbfPJFmS8uL8TSOWISlSwXosx1Tli+1giWY2iZjyFNYurU8BX83sqdS84HQmqLz7q1sw==
X-Received: by 2002:a5d:94d0:: with SMTP id y16mr55669628ior.123.1564249094029;
        Sat, 27 Jul 2019 10:38:14 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id e84sm67659990iof.39.2019.07.27.10.38.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 10:38:12 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id q22so1688695iog.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 10:38:12 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr88917182iob.142.1564249092231;
 Sat, 27 Jul 2019 10:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190625051249.39265-1-paolo.valente@linaro.org> <20190625051249.39265-6-paolo.valente@linaro.org>
In-Reply-To: <20190625051249.39265-6-paolo.valente@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 27 Jul 2019 10:38:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W23cFq_MxbhZJ9tC9y0y9VqQ-mm8biOOMG_6Enbvb+3A@mail.gmail.com>
Message-ID: <CAD=FV=W23cFq_MxbhZJ9tC9y0y9VqQ-mm8biOOMG_6Enbvb+3A@mail.gmail.com>
Subject: Re: [PATCH BUGFIX IMPROVEMENT V2 5/7] block, bfq: detect wakers and
 unconditionally inject their I/O
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LinusW <linus.walleij@linaro.org>, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, bottura.nicola95@gmail.com,
        srivatsa@csail.mit.edu, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 24, 2019 at 10:13 PM Paolo Valente <paolo.valente@linaro.org> wrote:
>
> A bfq_queue Q may happen to be synchronized with another
> bfq_queue Q2, i.e., the I/O of Q2 may need to be completed for Q to
> receive new I/O. We call Q2 "waker queue".
>
> If I/O plugging is being performed for Q, and Q is not receiving any
> more I/O because of the above synchronization, then, thanks to BFQ's
> injection mechanism, the waker queue is likely to get served before
> the I/O-plugging timeout fires.
>
> Unfortunately, this fact may not be sufficient to guarantee a high
> throughput during the I/O plugging, because the inject limit for Q may
> be too low to guarantee a lot of injected I/O. In addition, the
> duration of the plugging, i.e., the time before Q finally receives new
> I/O, may not be minimized, because the waker queue may happen to be
> served only after other queues.
>
> To address these issues, this commit introduces the explicit detection
> of the waker queue, and the unconditional injection of a pending I/O
> request of the waker queue on each invocation of
> bfq_dispatch_request().
>
> One may be concerned that this systematic injection of I/O from the
> waker queue delays the service of Q's I/O. Fortunately, it doesn't. On
> the contrary, next Q's I/O is brought forward dramatically, for it is
> not blocked for milliseconds.
>
> Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 270 ++++++++++++++++++++++++++++++++++++++------
>  block/bfq-iosched.h |  25 +++-
>  2 files changed, 261 insertions(+), 34 deletions(-)

FYI that there is some evidence that this commit, which landed as
commit 13a857a4c4e8 ("block, bfq: detect wakers and unconditionally
inject their I/O"), is causing use-after-frees, as identified by using
slub_debug and/or KASAN.

If folks are willing to follow a link to the Chrome OS bug tracker,
you can find more details starting at:

https://bugs.chromium.org/p/chromium/issues/detail?id=931295#c46


The most relevant part from that discussion so far is that one crash
can be seen in bfq_exit_icq_bfqq():

/* reset waker for all queues in woken list */
hlist_for_each_entry_safe(item, n, &bfqq->woken_list, woken_list_node) {
    item->waker_bfqq = NULL;
    bfq_clear_bfqq_has_waker(item);
==> hlist_del_init(&item->woken_list_node);
}

...where "item" has already been freed.  Hopefully Paolo has some
ideas here since I'm not sure I'll be able to do any more detailed
debugging in the short term.  Happy to throw on a test patch and
re-start tests though.

-Doug
