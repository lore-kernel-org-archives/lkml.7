Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7981EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB342173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576180903;
	bh=IfLvnnJKRvyI93u9CW8kz1PZkYj6AIw5gIzN3vvMkTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dihFppebUfEkoDFNISRPUpZaoil6yXmuqSM/BNZyBtycALj9h0VI0DF2Zn7yYTPL+
	 ktNDcuV7jbXFspPIdYB56gTp9S/Qogt/Y5kL1VsqGM7wo0SOn8cvgOliYSXeWINy5V
	 49eOiwk1efcRiniK93xdsA9ynwVq+FdZkx2Prr2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfLLUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfLLUBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:01:41 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931B82173E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576180900;
        bh=IfLvnnJKRvyI93u9CW8kz1PZkYj6AIw5gIzN3vvMkTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xwbKOE1nWQtY3afZU5JvRT9J9N9WaSnPhEuu7v8c/NjN62r/nSo6CjotAFT8dUA4L
         Uoy9cHFN0/AycUtv4Fz7ESc9pS1MBYwQA9frJgL8sMUrkArJJW+TiYBZPI/0cyUVTT
         dl7Am9I/04jqtl3e38Jr9VWVEPEZxfwRCpcMaACs=
Received: by mail-wm1-f41.google.com with SMTP id a5so3745739wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:01:40 -0800 (PST)
X-Gm-Message-State: APjAAAWLcFGGKWRPk2ClK1Cunh8gmK3qxRmaKRlst38DtHCgh9ruho5G
        xmkMsiGDzISnUtra4s/JaRYjxHg3NT2d4C+VvR5QFA==
X-Google-Smtp-Source: APXvYqyMBb6YoHl1pO6RZfHcWPfBbg8P61zxM3fQyQXFPkv+dnM6X8BqMRpNWeXsObtT9mdtUmm0SD8cBue2dH9KxPs=
X-Received: by 2002:a1c:2083:: with SMTP id g125mr8677354wmg.89.1576180899002;
 Thu, 12 Dec 2019 12:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20191121060444.GA55272@gmail.com> <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com> <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net> <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD20D@ORSMSX115.amr.corp.intel.com>
 <20191122202345.GC2844@hirez.programming.kicks-ass.net> <20191122204204.GA192370@romley-ivt3.sc.intel.com>
 <CALCETrUBomb2_2xyX-tZUD84smtDWH6e16zSN1qupkv-DWu5kw@mail.gmail.com>
 <20191212085755.GR2827@hirez.programming.kicks-ass.net> <3908561D78D1C84285E8C5FCA982C28F7F5011B2@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F5013AA@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5013AA@ORSMSX115.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 12 Dec 2019 12:01:27 -0800
X-Gmail-Original-Message-ID: <CALCETrX6Riy8vHkWcYOt-Vt0xD2JGgua4o-8F6KatUsXH9iEUQ@mail.gmail.com>
Message-ID: <CALCETrX6Riy8vHkWcYOt-Vt0xD2JGgua4o-8F6KatUsXH9iEUQ@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:46 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> >> If anything we could switch the entire bitmap interface to unsigned int,
> >> but I'm not sure that'd actually help much.
> >
> > As we've been looking for potential split lock issues in kernel code, most of
> > the ones we found relate to callers who have <=32 bits and thus stick:
> >
> >       u32 flags;
> >
> > in their structure.  So it would solve those places, and fix any future code
> > where someone does the same thing.
>
> If different architectures can do better with 8-bit/16-bit/32-bit/64-bit instructions
> to manipulate bitmaps, then perhaps this is justification to make all the
> functions operate on "bitmap_t" and have each architecture provide the
> typedef for their favorite width.
>

Hmm.  IMO there are really two different types of uses of the API.

1 There's a field somewhere and I want to atomically set a bit.  Something like:

struct whatever {
  ...
  whatever_t field;
 ...
};

struct whatever *w;
set_bit(3, &w->field);

If whatever_t is architecture-dependent, then it's really awkward to
use more than 32 bits, since some architectures won't have more than
32-bits.


2. DECLARE_BITMAP(), etc.  That is, someone wants a biggish bitmap
with a certain number of bits.

Here the type doesn't really matter.

On an architecture with genuinely atomic bit operations (i.e. no
hashed spinlocks involved), the width really shouldn't matter.
set_bit() should promise to be atomic on that bit, to be a full
barrier, and to not modify adjacent bits.  I don't see why the width
would matter for most use cases.  If we're concerned, the
implementation could actually use the largest atomic operation and
just suitably align it.  IOW, on x86, LOCK BTSQ *where we manually
align the pointer to 8 bytes and adjust the bit number accordingly*
should cover every possible case even of PeterZ's concerns are
correct.

For the "I have a field in a struct and I just want an atomic RMW that
changes one bit*, an API that matches the rest of the atomic API seems
nice: just act on atomic_t and atomic64_t.

The current "unsigned long" thing basically can't be used on a 64-bit
big-endian architecture with a 32-bit field without gross hackery.
And sometimes we actually want a 32-bit field.

Or am I missing some annoying subtlely here?
