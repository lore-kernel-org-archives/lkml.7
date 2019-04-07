Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C28C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A132720B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 12:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="FiGmM0Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDGM7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 08:59:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53156 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfDGM7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 08:59:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so11250660wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMoq4qWh/WrIZpuJeJZ6gjv2TsstGKsOQOalG0lD0NU=;
        b=FiGmM0WkJB8s5lyCoGLQ9RvFzGpQ9dPFBksELjPlRGXOWGu9VZnPqRIvp/48CkCKPg
         wUiiRr3N6RtX71haeLgQSKsV36enw0YUuL+pnkuktFNZObfLsqySLkumb7nKu7sUbKTd
         z4g/vgeDSQ0iRp63mkQbiv01RTHqElyjRkxC3gB8iSxT1LKmIkbsxP5H9sIbeh7xXqIV
         VvVKMZ7liQoRFU9ccpKzGyx33+YaZwr8JQmKiVXadPfu9F7j757MAGtyxWaU9AoiuTHa
         dWHJYkRWUDtSpZWTOzRJz7ljEK24h6hh2I872WGWPgFIa9nI99oO+KeKlGGHLgvTv0oy
         SouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMoq4qWh/WrIZpuJeJZ6gjv2TsstGKsOQOalG0lD0NU=;
        b=lUqMs4jKalk4iMLd1Pp2eZb65G4IOSrjHTWdst0YSzIwxd10vytTob/Y2x1UyCqnam
         y4rIB3BsKE6KV/3kJi/iGXJstLsJG63RkdKlhOoyCzVeV6LFJZApj4+Qa7hbkd/pAFQs
         OAAgMtY4x2NN6ELl9TNRQ1SiTEnw5YOIk3vKnsbTKRB/0QQ8jvV+SY9XN5Z5m0awXtja
         XvvdZYGuYTeZ406lxbL8qjWdPUQ5GVBLTtwf4I9rdHzJJvDB2ZCdd5h3J7Uq16a869Pc
         bhPDLo7h/s3ena4xcQb1+opgmqR3dIfa+M0jnrExYllJSLswK+2R2CqrVaqt1/uSakrx
         KRyQ==
X-Gm-Message-State: APjAAAWHuk6iNVbrDtZMOLZGYugGUeo6Udoa7I8VfDI7+GPPIKe6YNlK
        1OytbO9MqfJcPGDwB6u+NFr6uGnY5JbmGZzrlxj83g==
X-Google-Smtp-Source: APXvYqzn8yAbbsm5PAMd9u3DQu/7uYZTipbyo4jF/J90tRTmlAyT6TlEoHenuT1lWEI3s4nunuRECnqh8rGIY1T9BOM=
X-Received: by 2002:a1c:544f:: with SMTP id p15mr13814879wmi.65.1554641951971;
 Sun, 07 Apr 2019 05:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy0k0gSipzne1=agZzTWa0URoq3OH7vefJsr2=SEMyJ1tg@mail.gmail.com>
 <mhng-6bd91073-ecae-4da5-8332-0e6c9f8aaac1@palmer-si-x1c4>
In-Reply-To: <mhng-6bd91073-ecae-4da5-8332-0e6c9f8aaac1@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 7 Apr 2019 18:29:00 +0530
Message-ID: <CAAhSdy2+-TCv9i+R7ZUzJaSt_NFNbY+v6EUhkynFtD=FD7reFw@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Fix Maximum Physical Memory 2GiB option for
 64bit systems
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 2:47 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 04 Apr 2019 23:01:11 PDT (-0700), anup@brainfault.org wrote:
> > On Fri, Apr 5, 2019 at 11:24 AM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Fri, Apr 05, 2019 at 05:49:34AM +0000, Anup Patel wrote:
> >> > The Maximum Physical Memory 2GiB option for 64bit systems is currently
> >> > broken because kernel hangs at boot-time when this option is enabled
> >> > and the underlying system has more than 2GiB memory.
> >> >
> >> > This issue can be easily reproduced on SiFive Unleashed board where
> >> > we have 8GiB of memory.
> >> >
> >> > This patch fixes above issue by removing unusable memory region in
> >> > setup_bootmem().
> >> >
> >> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>
> >> Btw, what is the rationale behind even offering the 2GiB option and
> >> the medlow model on 64-bit?  Do we reall have use cases where the
> >> slightly more effient generated code matters so much to keep up
> >> the support burden of this mostly unused and unusual configuration?
>
> I'd be OK dropping medlow on rv64.  The performance impact of medany is pretty minor
> these days, and even back when we added the option it was mostly paranoia about
> the linker being correct.  medany has been solid on rv64 for a while, but we
> did recently find a pretty major toolchain bug in medany/rv32 so if we were to
> drop that we'd need to enforce a pretty recent binutils version (the latest
> release is OK, I'd have to check on the previous one).  I'd prefer to avoid
> that, and since medany doesn't really buy us anything on rv32 it seems fine to
> leave it that way.
>
> Given how many issues we've found here recently I doubt anyone is flipping this
> option away from the default for their base ISA.

Actually, this issue was reported by someone trying out Maximum Physical
Memory 2GiB option.

I agree that "Maximum Physical Memory 2GiB option" is not that useful and
does not provide much gain over cmodel medany but I would suggest that we
take this patch as a RC fix and remove "Maximum Physical Memory 2GiB
option" as separate patch because:

1. This option has been part of few kernel releases. Even if don't
recommend someone might flip it and report an issue.

2. This fix also takes care of the situation where we are using "Maximum
Physical Memory 128GiB" option (default) and underlying host has more
than 128 GiB memory (assuming a server-class RISC-V system).

>
> > Yes, if we want to use medlow with 64bit then max physical memory
> > can be 2GiB. Otherwise, I don't any practical use of restricting max
> > physical memory to 2GiB on 64bit systems.
> >
> > BTW, as-per latest revision of RISC-V priviledge spece the MMU SV32
> > mode will be able to access 34bit physical memory (i.e. 16GiB) so
> > max physical memory 2GiB will also be required for 32bit system for
> > medlow.
>
> It's a bit more complicated that than.  The 34-bit physical addresses have been
> in the spec for a long time, but we've never bothered supporting them in Linux.
> Right now we assume we can map all physical memory into a contiguous region,
> which is why we tie PAGE_OFFSET to the maximum physical memory.  It's
> impossible to map all physical memory with 34-bit physical addresses on a
> 32-bit system, so we'll need to break that assumption to move forward with
> 34-bit physical addresses anyway.
>
> Additionally: medlow can map everything on 32-bit systems anyway, so moving to
> medany doesn't buy you anything.

Currently, QEMU emulates the legacy SV32 with 32-bit physical address so
first QEMU has to be updated.

Further, I think we will need a kconfig option for new SV32 with 34bit physical
address to support existing RV32 hardware which implements SV32 with
32bit physical address.

Regards,
Anup
