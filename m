Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297EAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A2F224F3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URTIsW6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfKTNXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:23:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40980 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbfKTNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:23:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id 94so21143929oty.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzMXI8CiEmUCb1T/mIucbXJe4tU8bP4I9jjwwuAfDKQ=;
        b=URTIsW6tZP01wQOhlnFPO0YcR2fJrVif20Z60qoXjMZfBUIFjhFdnIttZLJoRt+uuB
         3TxwmUzCRKtxTIw0FgqbzlDHVQQkUHUVdz8NI5aJliRIL1yH/PdDEX9kOpfb/6EycAuB
         O1LdwC4IOSbuZEO6F4tkTXlU/50ypy+deG5SBD2P/29ADBG9JfjiJRSnSWHOy7VQpL14
         WXZQL4aqd9lPoacYF0jYEu44WV7NfUGqR2y3I8O/1Jm9qTUpaBgXQfY/2euYSseUh9Zb
         4TrBQ9TrATgntDENO+UrbQYxv3D/XBY8stKQ/gFDs/Tx+ETUb3u6h06bWtKIdfrYx+9T
         6yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzMXI8CiEmUCb1T/mIucbXJe4tU8bP4I9jjwwuAfDKQ=;
        b=uObhiQTLOGHpTKQCPi7rmFbwwkYNBbk1NjkniSOofwRuEGNiQefV9RraTnfYjhv9zL
         7nFbQtGEcTSMe0OgaR9wZ2F8A+VlfzzC7JWvAC2NYLSvw33MPb2mABjzSPzSLZ7n7E8A
         iODD20Kqo1H5NepCVDoKez6czNqXwzrxOh+9u2HQnWUiydRDAlOppJ/OMgMzNhDxNTpf
         9vWusG6HJJgtEtnWQvhiSdlkp7QPSxHp6r/E7JQHQLQYdIzxG1/1/rdxiEm59YDVdtb2
         m6Q6Of3x6183xvGT/pub+LyWgMqs527uQW+99XbIwwnM85ARX9YsAqdXnc8NI/2uaeD6
         BefQ==
X-Gm-Message-State: APjAAAXWa9CvqzvU0qO3mO2/PsVYAH5iw40/e9UQTbI+kx7VsOL5OpET
        dvIdoJYa8+l4s3dtLskbKO5x4Qw7d2BCYzFm98f67Q==
X-Google-Smtp-Source: APXvYqwb9n5MQCN2w1O8tVaiPI3U9z029YRp54J2viOtXwX8ggK0Rw/OJtbItqTD6XRZ/nOBs03tr5yQb3F9wAkYh2E=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr2092594otq.110.1574256215221;
 Wed, 20 Nov 2019 05:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20191120103613.63563-1-jannh@google.com> <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com> <20191120112408.GC2634@zn.tnic>
 <CAG48ez26RGztX7O9Ej5rbz2in0KBAEnj1ic5C-8ie7=hzc+d=w@mail.gmail.com> <20191120131627.GA54414@gmail.com>
In-Reply-To: <20191120131627.GA54414@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Nov 2019 14:23:09 +0100
Message-ID: <CAG48ez0KscmTLf2_-tYPuoAxRjJtzUO8kmAPQ_SZTP1zvqvTtA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 2:16 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Jann Horn <jannh@google.com> wrote:
>
> > On Wed, Nov 20, 2019 at 12:24 PM Borislav Petkov <bp@alien8.de> wrote:
> > > On Wed, Nov 20, 2019 at 12:18:59PM +0100, Ingo Molnar wrote:
> > > > How was this maximum string length of '90' derived? In what way will
> > > > that have to change if someone changes the message?
> > >
> > > That was me counting the string length in a dirty patch in a previous
> > > thread. We probably should say why we decided for a certain length and
> > > maybe have a define for it.
> >
> > Do you think something like this would be better?
> >
> > char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
>
> I'd much prefer this for, because it's a big honking warning for people
> to not just assume things but double check the limits.

Sorry, I can't parse the start of this sentence. I _think_ you're
saying you want me to make the change to "char desc[sizeof(GPFSTR) +
50 + 2*sizeof(unsigned long) + 1]"?

> I.e. this mild obfuscation of the array size *helps* code quality in the
> long run :-)
