Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C7C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888ED217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hc2QTCLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbfIWQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:15:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46629 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfIWQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:15:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so8234308pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kz4IZ3oYWoBFhxhQ1CwFfvKKIiAwRsecxuF5VRYqIaE=;
        b=Hc2QTCLztR11uKBEn4r3OeZlsjRsvjzNu21ne0wmU0VOOTo152UCGybydjOiGNjZlz
         j7IfsgojsLc4eMoSQwFFn4soOZ24XNfqmhPHMnqnNiqsN2FozknKM4/tVfzD5vDBxJoU
         q0YQJHX8dqf0Prjk9UUZ6vEFWg6HiqLytwnTF8LmSJEQjEvcs2c7uTBxvz86qZxr+2i0
         qCtke6eTkqrVRE8YERskj75XSNDncixv5eJRKSuP8meltK3d1x/N6VqEJDoJLbRjorZT
         GjQn6+tcxEsiJlyrn8JKgzXHSperhPLnSB82tbpyWV48/QeVyWHku2BIaIh5SMv3zn2T
         yG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kz4IZ3oYWoBFhxhQ1CwFfvKKIiAwRsecxuF5VRYqIaE=;
        b=dqQLlKtkYJk4mJc21BzeNbwbxYEcn7nOMqU/N8101pBAxIKddXUVOr30MBgiswjTwy
         VMW5lShX+m20/jQDHhqlfBQQhwlVAzsBPKRSLmmm8oVep6VHkRyitCtwGRPf1bww+RWC
         0JD2Vpzb9tkrEIbJ/3Y6Bz8EMGVNWd1Or+hqeD2ROG9bwZWdVapGs16OXJcRPlcv4ro2
         m5VVEu7LwJaUPVYvZv3G5UmU1eseEa5nL2Wgyrv/istqQmzjU3/BgKgE0v3bYel/miaR
         rhhsL7x2VIUNfltwk3lkLgCcH0wb+Phn+SKySOOVPV5Fm0iGV2pgS3XX1ql4R8DRi0I/
         q4JA==
X-Gm-Message-State: APjAAAVe3N23iD33hkD24paNtR+p3rU/A3Y89UJk0+ehaqCjcUWcjdRF
        +8eEUVKBj3ufV1q1iQR3rNtHdJ30uzxYwjX5iDM3+ot2
X-Google-Smtp-Source: APXvYqyDIh4CsO16l85GdeANdq5KUxecpO9ngbGQXUFdqwYTSH4EkpKP0y3y0UAhvQLMULqZcP7mndQc25/vgTQdX6k=
X-Received: by 2002:a62:258:: with SMTP id 85mr346108pfc.165.1569255327727;
 Mon, 23 Sep 2019 09:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190922173241.GA44503@rani.riverdale.lan>
In-Reply-To: <20190922173241.GA44503@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Sep 2019 09:15:16 -0700
Message-ID: <CAKwvOd=X9+uxQSzKad8B-Lw=ZarBT+SfNpBm_TE0k+DeJZmrsw@mail.gmail.com>
Subject: Re: kexec broken with STACKLEAK enabled
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 10:32 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Hi, since commit b059f801a937 (x86/purgatory: Use CFLAGS_REMOVE rather
> than reset KBUILD_CFLAGS) kexec is broken if GCC_PLUGIN_STACKLEAK is
> enabled, as the purgatory contains undefined references to
> stackleak_track_stack.
>
> Attempting to load a kexec kernel results in an error:
>
>         kexec: Undefined symbol: stackleak_track_stack
>         kexec-bzImage64: Loading purgatory failed
>
> Adding $(DISABLE_STACKLEAK_PLUGIN) to PURGATORY_CFLAGS in
> arch/x86/purgatory/Makefile fixes this.

Hi Arvind,
Thanks for the report.  That sounds like a straightforward fix.  Would
you like to send a patch for that?  I'd be happy to help review it.

>
> Not sure if that's the best fix or if other architectures also require a
> similar one.

The commit you reference should be x86 only.
-- 
Thanks,
~Nick Desaulniers
