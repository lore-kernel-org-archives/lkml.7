Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED3AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0D826EFD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfx+9Sw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfEaUiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:38:20 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38243 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfEaUiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:38:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id 18so7933110oij.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0cnPFzcn5QCXw5XUHbmYf8vbNrDRlFteoa91Du2Yekc=;
        b=pfx+9Sw5vtKckYQD1JLLmFYKgMjdOiE1GLfBnUxWZEpmur1iDTu4DP9DWuUAipq217
         Q3LeAPoajNvNIs5iTA+XK2O8+Zdk6myuHApD73+jMWVBarxreQidfdiVjJ0A64R7wo/J
         ichDQGx+ov4YWojqcLnhDA3L6TCmxGLrQmKwF41td/px9EAzYAWgOG+1We7LvoiS5T8a
         RiMzpXicxhbJg2AqlN05QzzHocm9C73o9iXs7GxqMx/Chgc/KrTvi5y5hKlgIoJQ6ALl
         n0BohlHKgpBeuUn5lAYB/KlAAFuWpYRlOdyBznykrSHDV2bjMn5JeNjrK0apRgURmXSu
         nR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0cnPFzcn5QCXw5XUHbmYf8vbNrDRlFteoa91Du2Yekc=;
        b=U3SAiayWjhz8jDlAcJEkWL/4bto9C5hLXnZ6pxpCupfowjjoO3g4ZdS7KccLtmTCyt
         i3931UCjOyhai0VkcJpPP3/oFE+z5hEGVjttllf+ZQY3Is2FNF6uRKgyzXEN4KyFgeCW
         jUJ4mJ6OYTfPxslF1Q9OFn5Kt05OwTvbxl1jpM21f0uiB7Mai9WZgMDKcF8LK/4dRCBw
         CJjwwfiTrbYGrhgH2ZGTx+KnYNEiuwTr91Mdyy5C6cI16XjPoAPmG8uz43LO8j1xMYbD
         Yatx9NZNhIBtph/XNGDigY5w5+zopdoSStTyJKu83BTZHFx9G2TkzEYxrpyi+NsvUQTZ
         qluA==
X-Gm-Message-State: APjAAAW4iECsaxXhMVQ46gZYm/6HVBa6RJM4IAxtWfQ5xVDmXeZ/A7jJ
        ynPR8bnJEjhUISn61v1Y8WLi5iUISDQUIWbb69KCsQ==
X-Google-Smtp-Source: APXvYqwLYNgPUHjHWRZ4nVrkwF25wQhKf65UEb5amUMC19vKmqRZwX5OZs7swgotUuD+8rKrLjpbw8D5YUVZgxIb/XI=
X-Received: by 2002:aca:f308:: with SMTP id r8mr437812oih.39.1559335098973;
 Fri, 31 May 2019 13:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190531063645.4697-1-namit@vmware.com> <20190531063645.4697-12-namit@vmware.com>
 <20190531105758.GO2623@hirez.programming.kicks-ass.net> <82791CFA-3748-4881-9F01-53F677108FC3@vmware.com>
 <CAG48ez1LxU_swf30Ndj=vjZLeSKg83Oi4f2Kd+wSUygPXA0cGg@mail.gmail.com> <6331796E-8925-4426-A0A6-5CB342178202@vmware.com>
In-Reply-To: <6331796E-8925-4426-A0A6-5CB342178202@vmware.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 May 2019 22:37:52 +0200
Message-ID: <CAG48ez0pEHOskDK53LMQa=gbUSoztWR3SuAeux-aVeh_896w5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:04 PM Nadav Amit <namit@vmware.com> wrote:
> > On May 31, 2019, at 12:20 PM, Jann Horn <jannh@google.com> wrote:
> > On Fri, May 31, 2019 at 8:29 PM Nadav Amit <namit@vmware.com> wrote:
> >> [ +Jann Horn ]
> >>
> >>> On May 31, 2019, at 3:57 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> >>>
> >>> On Thu, May 30, 2019 at 11:36:44PM -0700, Nadav Amit wrote:
> >>>> When we flush userspace mappings, we can defer the TLB flushes, as l=
ong
> >>>> the following conditions are met:
> >>>>
> >>>> 1. No tables are freed, since otherwise speculative page walks might
> >>>>  cause machine-checks.
> >>>>
> >>>> 2. No one would access userspace before flush takes place. Specifica=
lly,
> >>>>  NMI handlers and kprobes would avoid accessing userspace.
> > [...]
> >> A #MC might be caused. I tried to avoid it by not allowing freeing of
> >> page-tables in such way. Did I miss something else? Some interaction w=
ith
> >> MTRR changes? I=E2=80=99ll think about it some more, but I don=E2=80=
=99t see how.
> >
> > I don't really know much about this topic, but here's a random comment
> > since you cc'ed me: If the physical memory range was freed and
> > reallocated, could you end up with speculatively executed cached
> > memory reads from I/O memory? (And if so, would that be bad?)
>
> Thanks. I thought that your experience with TLB page-freeing bugs may
> be valuable, and you frequently find my mistakes. ;-)
>
> Yes, speculatively executed cached reads from the I/O memory are a concer=
n.
> IIRC they caused #MC on AMD. If page-tables are not changes, but only PTE=
s
> are changed, I don=E2=80=99t see how it can be a problem. I also looked a=
t the MTRR
> setting code, but I don=E2=80=99t see a concrete problem.

Can the *physical memory range* not be freed and assigned to another
device? Like, when you mess around with memory hotplug and PCI hotplug?
