Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFDBC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5931220C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8guUWxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389367AbfG2V6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44466 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389282AbfG2V6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so28916867pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGX4E0zL337coMpGxL1XEgxTmtLdDc56kYr2P6tXetM=;
        b=L8guUWxOYjK6XiCshtZZcKoxR/54Vz5NjX2WheEEHk63qf19d87Faxvv5kgSZfMxFc
         jOOMWrMPyinWN0CrAYeiKy7ktsraRmF80lRehlRtDEXhOcO+YWw4WpvZEy7Trgi8ed4N
         V7yHbdKDGfCFZArRwTdbTz0F4d5ZRgndfjc97JKYE6PwuAaKIWQz1nK23nmf2W6ULnbv
         +maT59ZjSl9MxEFz2OHzVE1tO+deOpoiRFovw3VweVn2WCrEZGNn5AItcw4DxmxTkO7u
         Pb1ZjgHR0yzNeEKO8oIdWV7X3V5GUvCj2Y+JIDNnOStLn0aG5+rdCdB5SgbETi4nL91W
         KoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGX4E0zL337coMpGxL1XEgxTmtLdDc56kYr2P6tXetM=;
        b=e7bdTmwA3m3PCJt1H09VQnp7NXK//14HWw3KWXtK1tLcmS5leFt9FEKbQcEkI2hTbt
         u+yUUjd6AmCtcrZuqKn7A/kP4dVVDmE84jouVLDGldiAhZ67MF43s2s0GfTO3mm7esVw
         AiV1f0iFv+QRWpkFQMHK9UZzYLv8NvmzA/begiUA/ssVZu20bGJ/ku7AdRYyvIemxhMg
         P69jt6qwQ1QtFAbHKPx+nlBoyQrXMkTvRk2O/oc12gbOIkpih2Im+n/hnqk9dn75J5B3
         hMtV1wRAmvQZhZhm3zW/+yjjMPaS2z3+aIviSZ7avy9JAa8Up8CGRTtFiXX6JW3HTj+V
         1xXA==
X-Gm-Message-State: APjAAAWqJ6KfVjXUMofmYV+JZMM1o9uBBNABcC/BrdHt1JfSSw1tFWGT
        glGs5wPc2DaUr5LR5AX7zL/N8eLJ0tSr3WOf+WP02LmQOcSZDQ==
X-Google-Smtp-Source: APXvYqwkmUwldi+ySYyBzJGzi0pYkpahJyKEqbVx57yA9DvkEPW3DJukefD/8uJY2Yiev/nqvJakt6MjXBFzNaT83og=
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr101643560pgs.10.1564437527160;
 Mon, 29 Jul 2019 14:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <201907291442.B9953EBED@keescook> <3e515b31-0779-4f65-debf-49e462f9cd25@kernel.dk>
In-Reply-To: <3e515b31-0779-4f65-debf-49e462f9cd25@kernel.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jul 2019 14:58:35 -0700
Message-ID: <CAKwvOdkRxJ6Vtm8CX1ZgDgzzAywSyx7Y-nNFn+tVPf35YQc2YQ@mail.gmail.com>
Subject: Re: [PATCH v2] libata: zpodd: Fix small read overflow in zpodd_get_mech_type()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 2:55 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/29/19 3:47 PM, Kees Cook wrote:
> > Jeffrin reported a KASAN issue:
> >
> >    BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
> >    Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
> >    ...
> >    The buggy address belongs to the variable:
> >      cdb.48319+0x0/0x40
> >
> > Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
> > eject_tray()"), this fixes a cdb[] buffer length, this time in
> > zpodd_get_mech_type():
> >
> > We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
> > ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.
>
> Applied, thanks.

Dropped my reviewed by tag. :(
https://lkml.org/lkml/2019/7/22/865
-- 
Thanks,
~Nick Desaulniers
