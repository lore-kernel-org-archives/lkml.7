Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7CEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB93B206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RolS2lr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbfHAVDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:03:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34938 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbfHAVDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:03:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so75017766wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLAp7PJdRS5HSN4j0mwHufaobGvhbtIA9bU8A3WHPLo=;
        b=RolS2lr3PkK3ioYygZ6RAvR/+wgwGKJSavJz0miaeBJSbhRmMlMAdl57e9U0oQGZm8
         m6DpfJL9sM41OTeMaCEopQLTznhDvIVIxixStliH7FLbx5E/xNLrwsw8r0POwd6Syl3T
         sdcgoKwSITRwpXnvkTgLrsYkX859cZJTPFKdnmG0PkuNhsqbANsZ/8qnuY5npOrlJSlR
         4NveQHqVDwYaCaIh7I7LNzgBkQGNj8trMOTNKNod2ySL9Dpk0ojvLbzpcEbE1O49CJ4B
         +khEugo6YOLAcHuGYjfiOJxi4WqUTldQ7Ibyo4DaSInx3RTIYptXcnlcazgc7DjCk0zV
         3VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLAp7PJdRS5HSN4j0mwHufaobGvhbtIA9bU8A3WHPLo=;
        b=nSOTzjdW4jPwgWAjiQY0qE/38gjLjI6cYOlSFUZZG9G2HXxrqxeXf7yPNgiynC6Dxs
         WNR+daOqVd0lc9MLnMBu2UL/+EFfIvJMnyn6nlVCSK4Itd0RaU1l5vu7g7B/rf0hLWNk
         UkcO2lcdMbo7ofkrU4JJD1d9xwQSEEi5neUmHlBTbMhxs0VCLbWthTSad4b0pL3DSmXl
         HIGUYs2qsKApM9ZYQZXuINUvvffDw6Rlote2YeuF8MLEV39QNorW7W5ynXa7j3/J1MX6
         E78qrqHGStm5fEZboWKzjIG44cSpAIOZtytUDksfaTPtkp/3Fw9gi6Iv9O6AQBVmC4N7
         vJCw==
X-Gm-Message-State: APjAAAVPp0FjGvWONS9lpgQcFkD++miaEmgwla+CDh5nsaKWoJZr3kOC
        la+tSoFr15lF8TIHYgMrg/GH16CUhc+QYK3w3HmcqQ==
X-Google-Smtp-Source: APXvYqyOuP7Y4zLdInAoIDRzb9qiE++Hk/Q5EEXZ5lLSr/1vgAmYQouTEUdo8OiyzF/fY/yzzjeBljh7ioezpFA8IIc=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr5229138wrs.93.1564693409669;
 Thu, 01 Aug 2019 14:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111348.530242235@infradead.org> <20190801111541.685367413@infradead.org>
 <20190801174907.GA16554@cmpxchg.org> <CAJuCfpGQsfQ8QW7_LJzsGgTj6H9r6bV529Mzv-dXCWiv+qjOpw@mail.gmail.com>
In-Reply-To: <CAJuCfpGQsfQ8QW7_LJzsGgTj6H9r6bV529Mzv-dXCWiv+qjOpw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Aug 2019 14:03:18 -0700
Message-ID: <CAJuCfpHT9HVLfE8zgm6ZgBpX7ZsVOZeAkoyHO+koD0SYih3yfg@mail.gmail.com>
Subject: Re: [PATCH 1/5] sched/pci: Reduce psimon FIFO priority
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 11:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Aug 1, 2019 at 10:49 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Aug 01, 2019 at 01:13:49PM +0200, Peter Zijlstra wrote:
> > > PSI defaults to a FIFO-99 thread, reduce this to FIFO-1.

nit: above "PSI defaults" is more accurately "PSI polling defaults".
The core PSI thread that handles regular updates is a regular kthread.

> > >
> > > FIFO-99 is the very highest priority available to SCHED_FIFO and
> > > it not a suitable default; it would indicate the psi work is the
> > > most important work on the machine.
> > >
> > > Since Real-Time tasks will have pre-allocated memory and locked it in
> > > place, Real-Time tasks do not care about PSI. All it needs is to be
> > > above OTHER.
> > >
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Subject should be s/pci/psi/
>
> Thanks for the patch. Please give me a couple hours for testing to
> ensure no regressions before merging it.

Tested-by: Suren Baghdasaryan <surenb@google.com>
