Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD50C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A11C22CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U75GJORV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfH2UBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:01:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33303 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfH2UBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:01:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id l26so4768755edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYf/lCZC1gwMIR9/lhwT5M/JPgKzeUqjFNgwUcFRWFg=;
        b=U75GJORVMHIr0iUVnntJaP5CkG0L6J04X+1V/ZPN5uW3dQqnBj8pdaROlXs8b4Z1SG
         DR1yBHet2NvJnJhuzP0i5c/qQ5sBWpaG0KlB9URDDEL2UqurL8fMaEild5hR6irruZ3I
         WwlNUWnUuDyL8bRkDmAo8qYqSmnG/ayXfekSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYf/lCZC1gwMIR9/lhwT5M/JPgKzeUqjFNgwUcFRWFg=;
        b=nKOWf4xA4rLNcJ1IasjUSTSTaJOXWhXBoQgwRaMJflIaHPHWgijM/eyMmXffdNyNTJ
         9c+IIoSF1xZXK42Sp+9d7vBdc5RSJiht50MLeTUOEdU4SgKjOW0xNKZ5b4X6WolKuc78
         zdUpU5RN+2fH9C+ulM5GmsA2xWjk28JOWzWr1oGHUkL9mxKemLs8+rn+m+Jv08OrKBFu
         TWzHUV1dnDtDtcZVBr9B0LI7z+Y0b7eDhY4arwdu9YwxaTWmtO0Dba+hPZ2e3dPDt/PP
         8hFhNRwwAhxdImgUQkqGZ4kU8aJel2cD2h+CcMgeOlbryAthq5Acl5krf737orFA9Ji8
         ozJA==
X-Gm-Message-State: APjAAAVvKGPZcNeMEsN9HNHjlIC2fRXVR0JmcCPuMtn3VvENEejTGfkk
        quKazs+GubQI4vdASyHWKkFgsn74uOc=
X-Google-Smtp-Source: APXvYqyZ5IVTcYYxurSb7YO5OyoqWD8iqL1THpWc7J6e9gaRjQAWEaYJzGxUrzpvqQNKJ6K7AmjRZg==
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr9842509ejp.262.1567108893616;
        Thu, 29 Aug 2019 13:01:33 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id g17sm613013edy.26.2019.08.29.13.01.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 13:01:33 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id s18so4710013wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:01:33 -0700 (PDT)
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr13235010wrs.200.1567108513590;
 Thu, 29 Aug 2019 12:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190806154347.GD25897@zn.tnic> <20190806155034.GP2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190806155034.GP2349@hirez.programming.kicks-ass.net>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Thu, 29 Aug 2019 12:55:00 -0700
X-Gmail-Original-Message-ID: <CAJcbSZETvvQYmh6U_Oauptdsrp-emmSG_QsAZzKLv+0-b2Yxig@mail.gmail.com>
Message-ID: <CAJcbSZETvvQYmh6U_Oauptdsrp-emmSG_QsAZzKLv+0-b2Yxig@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] x86: PIE support to extend KASLR randomization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 8:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 06, 2019 at 05:43:47PM +0200, Borislav Petkov wrote:
> > On Tue, Jul 30, 2019 at 12:12:44PM -0700, Thomas Garnier wrote:
> > > These patches make some of the changes necessary to build the kernel as
> > > Position Independent Executable (PIE) on x86_64. Another patchset will
> > > add the PIE option and larger architecture changes.
> >
> > Yeah, about this: do we have a longer writeup about the actual benefits
> > of all this and why we should take this all? After all, after looking
> > at the first couple of asm patches, it is posing restrictions to how
> > we deal with virtual addresses in asm (only RIP-relative addressing in
> > 64-bit mode, MOVs with 64-bit immediates, etc, for example) and I'm
> > willing to bet money that some future unrelated change will break PIE
> > sooner or later.

The goal is being able to extend the range of addresses where the
kernel can be placed with KASLR. I will look at clarifying that in the
future.

>
> Possibly objtool can help here; it should be possible to teach it about
> these rules, and then it will yell when violated. That should avoid
> regressions.
>

I will look into that as well.
