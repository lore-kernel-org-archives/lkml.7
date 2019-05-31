Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B26C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D222326E3E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stM7yT+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfEaTUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:20:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39167 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfEaTUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:20:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id v2so8553655oie.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GTX5Cgdck8YyB6MHi5KkfMWFB3KE2P2EVJB/MkSYzRc=;
        b=stM7yT+/Mh1mRi0NzQUr3s1Y1nNgecbCv440WRhAFcd/gPsu76bApuH7dxU+uoTOAg
         q/Oh3LCRItAgarMUU4qsqfHs4W424oGdtbCtnGL+KNwyyios3qtE0O90XAHM8CMM5fx9
         GqCHFduaKx4ulL4x5XZvwWsq+S6Jca8v+8jp22+oY/JHXkJslGCPJ2OnJjESi1rxC8+O
         Ovg6jJaW4Ce4dIj4mPHTgHi/RAMSpA8Nyii7tPEVm9gzAIxQ+FfgIXPAAc8gmxLL4PF5
         U011AEywn6Cp7UYj+RoP3WM/cMhR2c4yCKSsH5n0fMfcI0DSkK0atBgUdxKbwcAWiu5C
         +I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GTX5Cgdck8YyB6MHi5KkfMWFB3KE2P2EVJB/MkSYzRc=;
        b=XVvia15jYktV67635MfHy2XiEGcto3ZLx9vzDIR4XNOkWV4UHFg04qAZsr9mVraY0E
         v8rRagss43q7EPJ/CUzh98UHMTa1xZ+tgEpfpw55PtAkgxsSbnza43XfuEI5mi3KDrRY
         UG213uO6j8J+mw6NXs0xpJpeo46ZVVUdyjABLbVcsA6yA2cRMgDOXlcFtLa7a+14kaJ1
         WV4CF2SwBIpRNEWvYfs7RofHvezR1oNdSIWHZIPDxNjRMTUqlof+oa7hO9TkbutIM+c4
         OFeuvjaHgqL52ZMCvpSxPbu41SRQq3Ifp6aBSoM85qp7jSDHqLoI6NwXVWhm9lE2UuuX
         yD7g==
X-Gm-Message-State: APjAAAXviJ5U3U3l9TgSw/YEbxkYltam3h+XgzatYvU3FoNfxbjWjC5k
        50S8qiEPbaUWGdMBTdO7uDwp/YAmFAt+k1umEB83JQ==
X-Google-Smtp-Source: APXvYqxYaf/p6HU3oJAMhRuIUUDaR+Bg/cFfJEsDf+zGjzfM0iPxluV0fkzJB9Jf9ImRAi+m8j4i2A77AVLu23Xf1q8=
X-Received: by 2002:aca:e0d6:: with SMTP id x205mr190997oig.47.1559330447322;
 Fri, 31 May 2019 12:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190531063645.4697-1-namit@vmware.com> <20190531063645.4697-12-namit@vmware.com>
 <20190531105758.GO2623@hirez.programming.kicks-ass.net> <82791CFA-3748-4881-9F01-53F677108FC3@vmware.com>
In-Reply-To: <82791CFA-3748-4881-9F01-53F677108FC3@vmware.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 May 2019 21:20:21 +0200
Message-ID: <CAG48ez1LxU_swf30Ndj=vjZLeSKg83Oi4f2Kd+wSUygPXA0cGg@mail.gmail.com>
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

On Fri, May 31, 2019 at 8:29 PM Nadav Amit <namit@vmware.com> wrote:
>
> [ +Jann Horn ]
>
> > On May 31, 2019, at 3:57 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
> >
> > On Thu, May 30, 2019 at 11:36:44PM -0700, Nadav Amit wrote:
> >> When we flush userspace mappings, we can defer the TLB flushes, as lon=
g
> >> the following conditions are met:
> >>
> >> 1. No tables are freed, since otherwise speculative page walks might
> >>   cause machine-checks.
> >>
> >> 2. No one would access userspace before flush takes place. Specificall=
y,
> >>   NMI handlers and kprobes would avoid accessing userspace.
[...]
> A #MC might be caused. I tried to avoid it by not allowing freeing of
> page-tables in such way. Did I miss something else? Some interaction with
> MTRR changes? I=E2=80=99ll think about it some more, but I don=E2=80=99t =
see how.

I don't really know much about this topic, but here's a random comment
since you cc'ed me: If the physical memory range was freed and
reallocated, could you end up with speculatively executed cached
memory reads from I/O memory? (And if so, would that be bad?)
