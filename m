Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FBDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1532071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="u8FT0UY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKVQNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:13:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34522 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfKVQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:13:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id w11so6659624ote.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGAkIY/malVfTkqNJbPQAJQlDy7Ez63qwq+JecsGmso=;
        b=u8FT0UY5EsTVWPrYHEXwEq/awgVnTMghppZ1AeqecEiteiyKKqKKc5MoolkdXaws2t
         SmJr8j/kAOZH32nqX4kc97Hc+b2Xi0RZ+UwTC3UmkWsDiNSRL0IUXu1iPz472CIrBxyA
         2asrCnwmK9ReGLWKVOTiYpdemWfkj60RYDmHcr5xwGgq//CV13eZreLbWWIn7aFiFVsp
         AdFUs+Gcc30RSVGqYr8nEmr1skeEL7/65+4VpXgVfjWZDfA6hZXhhcWBXvn8yYPXs7V2
         hSuoxj+uV9FUfKLmbTfISVzWcEclMbxPDvr3QJRJTVjI6insjBR9IqjtpDDorDVF/j0H
         /AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGAkIY/malVfTkqNJbPQAJQlDy7Ez63qwq+JecsGmso=;
        b=jEoescQEklyI65sesU8GOc8trHLyckZS5RKT/7pWjxHWcgub8r0yBCpoUuaMZvNIeT
         pf5ydXY9zIOHxELnqFP3wBgCDbb+m6dVNHwAxqG30qUcIZVIp88O2piC0wawUX4wG31l
         chJ+nA+myQ3DaVuQS67W4zd7MREBKiiH571wK/IylJ7Ei20ELZVSTZq/d+Is+jHrRVLV
         d++/DCCCxxZksuMEp+IrjHKaX5rCnXfo0l21ZeCqDRWZjbOUHZIRdJyuLg934AWK1GQb
         GrtQXnZcS92syKHr4hSU5fZX07Yq2CVFiP/IT7gjRVsM1zFIXFS/cqwecy7QFirH5e7r
         uIOg==
X-Gm-Message-State: APjAAAUjB+OBdnboLiXoKKCsxDFcmdYbYMySxSZwTtSiqawqu6bT0WZa
        aX5T9qcQNrbW99366wRRKLBRhp3x4Zk0krMj+sGJiQ==
X-Google-Smtp-Source: APXvYqxvAz/mVNKR9y0aIXP20GgQ5CMbb7RZ/EpsgTrCK2HXJUipf6SbaAdIrz0b9RTHNlsVyHExbcwWaUgQ7UotvQM=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr11028481otb.126.1574439196834;
 Fri, 22 Nov 2019 08:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com> <x49h82vevw1.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49h82vevw1.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Nov 2019 08:13:05 -0800
Message-ID: <CAPcyv4idC=LgkwP+A1GKJ1CWkzUZ_RVBDCVfA3yAL9TNw1zZmw@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 8:09 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >>
> >> Pankaj Gupta <pagupta@redhat.com> writes:
> >>
> >> >  Remove logic to create child bio in the async flush function which
> >> >  causes child bio to get executed after parent bio 'pmem_make_request'
> >> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> >> >  data write request.
> >> >
> >> >  Instead we are performing flush from the parent bio to maintain the
> >> >  correct order. Also, returning from function 'pmem_make_request' if
> >> >  REQ_PREFLUSH returns an error.
> >> >
> >> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> >> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> >>
> >> There's a slight change in behavior for the error path in the
> >> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> >> converted to -EIO.  Now, they are reported as-is.  I think this is
> >> actually an improvement.
> >>
> >> I'll also note that the current behavior can result in data corruption,
> >> so this should be tagged for stable.
> >
> > I added that and was about to push this out, but what about the fact
> > that now the guest will synchronously wait for flushing to occur. The
> > goal of the child bio was to allow that to be an I/O wait with
> > overlapping I/O, or at least not blocking the submission thread. Does
> > the block layer synchronously wait for PREFLUSH requests?
>
> You *have* to wait for the preflush to complete before issuing the data
> write.  See the "Explicit cache flushes" section in
> Documentation/block/writeback_cache_control.rst.

I'm not debating the ordering, or that the current implementation is
obviously broken. I'm questioning whether the bio tagged with PREFLUSH
is a barrier for future I/Os. My reading is that it is only a gate for
past writes, and it can be queued. I.e. along the lines of
md_flush_request().
