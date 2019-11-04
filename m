Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E001CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA91218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Venzl/R8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfKDOvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:51:21 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45334 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDOvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:51:20 -0500
Received: by mail-yw1-f66.google.com with SMTP id j137so811709ywa.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7r5lBU/w2GioMOAscwus/pOsp6TqJGFS95RYlRLl5V8=;
        b=Venzl/R840Ayp+mx/PlwfO6Axz6jr9KMlduM9SwZzTH0OB0LSCWPAHDamRh2JWa5QE
         KBdL9KUnnhCmFx3Z+TMApBLGk+BsaJ7GZL1VMYvp9FVAQU59YxpLe1lXdW7R5ovZtzJN
         j6O8k9OeYyLaBJt7BaZkKKxB6pjnHzCWDX5ogyBKR4zzZv67cxH3Vm2I1M7ksbeqlJwF
         WZRhhTlbAekMTvxxxWtMSo7De6Vfr+ryAN7WbJdudze+VhZO0rpbCQcEO6mg1kEHH5aS
         9u2zWioBMTpNVBtx2dMRoEXEzGin1meDBK13RPw9YPxXYKsjo5EJdDgF+sDiPqFHdbRa
         Yl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7r5lBU/w2GioMOAscwus/pOsp6TqJGFS95RYlRLl5V8=;
        b=T1aH4D/75ZZmhLqVO87xX1PlGhsCvoH/x8s6zzRZ5OPVi39xBYm6J8klcmFUHf9mf7
         K+hJbqgfQLM1/VgHneeO5U5OxJ5hi+Z30XjxK4yT7ndSVHoST4cvKdGlRlkVQCWk7hxk
         WYH9Si1xjyg+CJd4e1XFKeKqpQmbxQ8cClRuGz2C67qUReUG0luPe7gSRZhXPtXWlN3C
         4tNoalbAEDiRi72JJ3N/Y132ZmxB9XwjSQpgMGyTQII57JNqnNdG5qbyB6N5jLqTUhV9
         R0ltYzRIebX/gAF1wu29NK+BOzHbGtXM/dlk8qE8REMc0z2uri9hZ5YhtEahiTN7y7Kb
         JUNQ==
X-Gm-Message-State: APjAAAXJokDGdEU0XYUDbjJ4EByMAsbOvKuRO32DGzehgAq1/NQo/lNn
        zmRBHM2tpTDqskQT2hpjLljXP0P1Q2t40h1JGTA=
X-Google-Smtp-Source: APXvYqxUd0xWCqIUtntR2MSva2pBZIV+Ro4QgagTcr5dCjl2LTVg3D7IcZWj5sEmy7mgGKbUBZPxM7ZolD8xbtB0rbs=
X-Received: by 2002:a81:3644:: with SMTP id d65mr4848747ywa.10.1572879079753;
 Mon, 04 Nov 2019 06:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de>
 <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
In-Reply-To: <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
From:   Charles Machalow <csm10495@gmail.com>
Date:   Mon, 4 Nov 2019 06:51:08 -0800
Message-ID: <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this one yes, UAPI size changes. Though I believe this IOCTL
hasn't been in a released Kernel yet (just RC). Technically it may be
changeable as a fix until the next Kernel is released. I do think its
a useful enough
change to warrant a late fix.

- Charlie Scott Machalow

On Mon, Nov 4, 2019 at 6:34 AM Marta Rybczynska <mrybczyn@kalray.eu> wrote:
>
>
>
> ----- On 31 Oct, 2019, at 14:39, Christoph Hellwig hch@lst.de wrote:
>
> > On Wed, Oct 30, 2019 at 10:03:38PM -0700, Charles Machalow wrote:
> >> Changing nvme_passthru_cmd64's result field to be backwards compatible
> >> with the nvme_passthru_cmd/nvme_admin_cmd struct in terms of the result
> >> field. With this change the first 32 bits of result in either case
> >> point to CQE DW0. This allows userspace tools to use the new structure
> >> when using the old ADMIN/IO_CMD ioctls or new ADMIN/IO_CMD64 ioctls.
> >
> > All that casting is a pretty bad idea.  please just add an explicit
> > reserved field before the result, and check that it always is zero
> > in the ioctl handler.
>
> That would change the size of a structure in UAPI, won't it?
> I wanted to avoid it when adding the *64 ioctls and that's why
> I added separate ones instead of extending the ones that exist.
>
> Marta
