Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F3C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 10:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C034205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 10:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="TPI177wC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfGNK2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 06:28:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33418 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfGNK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 06:28:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so8576077qtt.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSj3Bmi/w/1zN06nJGZLq87D/4DT1P43eX8reckzzS4=;
        b=TPI177wCttmgzj2zjtm6ejQGE2hqJgzkft59BaitUc+pDhgLl67WUZ3HTPqkmBKwKT
         HaKtzy3kfBLudvUGEVZmYnRb0cWL1GbRhUjQxTI6D6iT5At1QV6mQFcObNzatYIH+Use
         z96hM91I6zGAWLSIN8jMnRSDFBNwP6B/jnZQmbpt3QHQpUuyxoiUCIFxL7pRlFFVITw1
         Z5qySYIEh3FOUnN7pZG3DSHDofgQbNi/OEOcWMLOsSpfRPWFZtMdw1814uKIt84sVjDR
         LWF6m7evbEOJJUKSKCINVv00WlKvcku43xeWmEBM8XJ/I9563k5bctS+Pm8Ddi6WzklS
         Axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSj3Bmi/w/1zN06nJGZLq87D/4DT1P43eX8reckzzS4=;
        b=BMIL8zd3CVMaSmFX8HT+Vw4ImKwz1WSlhrx7CnKysCp1jpbsXV89Ofs9u/3Q8bUXxc
         V+64+LbLiuAW3JVv4tPUp52eQjcmLuKC2becGyxk2KnQPGOEtTmexV6tQrrdIQBYhYme
         CPTRMj0/BLUOsXIMzP0ZDhaLIpbzBcQU0kWvGpGjXbV05R4yY0je1sdR5eORpY8dFbwB
         eqaYM1R0i2a1lGG8wO1CnFv5Gu8Q8DhlJxL6YnCzzVIOE2RKJaEe1G9Z2RLBV7mp2JAd
         v14XriKWlJIxdxQMR/NzbULBByVsHxXnyOr3vrL6cgXVmt70UeGu1iPb3nbnzHzbDNeX
         T+YQ==
X-Gm-Message-State: APjAAAW5C3/D/1RP1IvuCHUSC+2K3LxttRvK9e8p+qQ/tQsJ6qlKlxmx
        XRXt94dX4mPVf9yPqLNDkRLpqZxFdRTPIQfU1cI=
X-Google-Smtp-Source: APXvYqwW9r49ZNCDH5uR+fCTnodiMf8WsYqgNpD7aFNpy6/MLfLizZYiOESsdENMFNBbYJ51h6NGhEzzIqeVSJA7bnw=
X-Received: by 2002:a0c:b010:: with SMTP id k16mr14512300qvc.170.1563100083935;
 Sun, 14 Jul 2019 03:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com>
 <20190713145909.30749-1-mike@fireburn.co.uk> <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Sun, 14 Jul 2019 11:27:52 +0100
Message-ID: <CAHbf0-EPfgyKinFuOP7AtgTJWVSVqPmWwMSxzaH=Xg-xUUVWCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be reserved
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     thomas.lendacky@amd.com, bhe@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        luto@kernel.org, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will the fix be in the next RC?

On Sun, 14 Jul 2019 at 11:16, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 13 Jul 2019, Mike Lothian wrote:
>
> > This appears to be causing issues with gold again:
> >
> > axion /usr/src/linux # make
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> >   CHK     include/generated/compile.h
> >   VDSOCHK arch/x86/entry/vdso/vdso64.so.dbg
> >   VDSOCHK arch/x86/entry/vdso/vdso32.so.dbg
> >   CHK     kernel/kheaders_data.tar.xz
> >   CC      arch/x86/boot/compressed/misc.o
> >   RELOCS  arch/x86/boot/compressed/vmlinux.relocs
> > Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> > make[2]: *** [arch/x86/boot/compressed/Makefile:130: arch/x86/boot/compressed/vmlinux.relocs] Error 1
> > make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> > make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
> > make: *** [arch/x86/Makefile:316: bzImage] Error 2
>
> That's fixed upstream already.
>
> Thanks,
>
>         tglx
