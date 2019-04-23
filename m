Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B6C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD7E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MS7hMqRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDWTCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:02:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34215 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:02:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id h2so3373783otm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfXy8+0qHmN8/L3YDNa3xi4FBFvK73vT67UVRpGiWKU=;
        b=MS7hMqREmsPGWn+aQRIoeY+ZNGYMaYZB3oJTqkWWEbPmNRQeG3IafiO/lXspsz+Tkc
         EofF7uWJtjsh7pyQYUzRlLA+UZqLqz+JeuDd4zhT49oLgGg3u3MjV4+FydVZ5SZHUosq
         BQFfZln0Dcb5YbdTEhj79sCXGgG/bwpVZVfjifTMC+06pOoQFMGZ31zUHVRz3xW3iKEe
         x59YG4yBcSSHaLyyExiNeb3l/4b9mPibBwHQfvMyoUiJXYLa+k4wI2c3mtpATO8eLeiK
         alpbb89bkvI49Q1wTc5Ah+QOKXJuV4mLkseSS2iYbqp8VEj8fvekfYnnpzZzZDmNyFr8
         AbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfXy8+0qHmN8/L3YDNa3xi4FBFvK73vT67UVRpGiWKU=;
        b=h5xQUO6DqFphcOvgkEut1wJ5ByPJwImzEAfhjednecrTFBp0++1emUMpt4ks6lK4LZ
         HcLEfXktUtE75PDozV/WLBGWtaxFM//MrDEu93s1tgfT4S2Mw6l6AhRzZzC4evS599Ta
         KO98nIRfIf/s9ytDGxJnnatmeR+iWkGHy8vmnSJzP9+PPz7djzkP60RnysL17VnVDyqi
         AKkcnrlTtlRyHEdrg8L0jqb5DkvigmFnYLZ8uuYvVURjK8S6kTPs1cKYB7RFrh95AFuy
         4zOYZM1AwK2nK0XRL9NP2WVc+no4X+PeDP3VbLRm7oYTQ7sZUMfs57SvaxVpCr4H39z6
         +zog==
X-Gm-Message-State: APjAAAWfkd5jusUdEjpdSPlxUqZ8sUYlfoKriwoWWhfZohRZcpOAfWjF
        bXc44EzCYoLhSZsGH2+6N/g9WKry1mlZLtu6KgHvQg==
X-Google-Smtp-Source: APXvYqwfg9D7z6JAQBkyN6V+Yar0VijRuJYnnbXb4+qkhQVzYVNF5hpQoifTSTdaNz/jyym7Cf+tHqrhPBjEL5mJVaM=
X-Received: by 2002:a9d:694c:: with SMTP id p12mr16793422oto.242.1556046149596;
 Tue, 23 Apr 2019 12:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190423181210.GA2443@beast>
In-Reply-To: <20190423181210.GA2443@beast>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 23 Apr 2019 21:02:03 +0200
Message-ID: <CAG48ez0CeTEGDuwr+qAGBwsqm+Drj0dkFfr6_UDc+g-xM4BpiA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern CPUs
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, musl@lists.openwall.com,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+linux-api, +musl

On Tue, Apr 23, 2019 at 8:12 PM Kees Cook <keescook@chromium.org> wrote:
> The READ_IMPLIES_EXEC work-around was designed for old CPUs lacking NX
> (to have the visible permission flags on memory regions reflect reality:
> they are all executable), and for old toolchains that lacked the ELF
> PT_GNU_STACK marking (under the assumption than toolchains that couldn't
> even specify memory protection flags may have it wrong for all memory
> regions).
>
> This logic is sensible, but was implemented in a way that equated having
> a PT_GNU_STACK marked executable as being as "broken" as lacking the
> PT_GNU_STACK marking entirely. This is not a reasonable assumption
> for CPUs that have had NX support from the start (or very close to
> the start). This confusion has led to situations where modern 64-bit
> programs with explicitly marked executable stack are forced into the
> READ_IMPLIES_EXEC state when no such thing is needed. (And leads to
> unexpected failures when mmap()ing regions of device driver memory that
> wish to disallow VM_EXEC[1].)
>
> To fix this, elf_read_implies_exec() is adjusted on arm64 (where NX has
> always existed and all toolchains include PT_GNU_STACK), and x86 is
> adjusted to handle this combination of possible outcomes:
>
>               CPU: | lacks NX  | has NX, ia32     | has NX, x86_64   |
>  ELF:              |           |                  |                  |
>  ------------------------------|------------------|------------------|
>  missing GNU_STACK | needs RIE | needs RIE        | no RIE           |
>  GNU_STACK == RWX  | needs RIE | no RIE: stack X  | no RIE: stack X  |
>  GNU_STACK == RW   | needs RIE | no RIE: stack NX | no RIE: stack NX |
>
> This has the effect of making binfmt_elf's EXSTACK_DEFAULT actually take
> on the correct architecture default of being non-executable on arm64 and
> x86_64, and being executable on ia32.

It's probably worth going a bit more into detail in this description
on how libraries typically allocate thread stacks.

It looks like glibc will be fine; before commit 54ee14b3882
(https://sourceware.org/git/?p=glibc.git;a=blobdiff;f=nptl/allocatestack.c;h=dc501650b8629eda4502f2016016f09106cfb526;hp=6ada1fe1381de104153c0627e27f09fe5ad02caa;hb=54ee14b3882;hpb=16a76cd23ce9d3924fa192395e730423e3dc8b36),
thread stacks were always RWX, and since then, from what I can tell,
thread stacks were executable depending on the executable's ELF
headers (as parsed by glibc).

But e.g. musl's __pthread_create() seems to hardcode
PROT_READ|PROT_WRITE, which I think would mean that if someone built a
multithreaded program with nested functions and linked with musl, that
program would stop working? Or maybe I'm just reading the code wrong.

Then again, I'm not sure whether anyone actually uses nested functions...
