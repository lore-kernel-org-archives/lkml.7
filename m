Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF0C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDB021A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khVLBRWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfKEWFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:05:53 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36607 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfKEWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:05:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id q21so14567472vsg.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNIM3D66/Azg3YbAGxb2zW1QAG5fW9Q4vvlsSYbe2Go=;
        b=khVLBRWVxusf3aE0M5MrKx62Oe++CuRS+KMSKCuHE7JSxqPvv2VfNvIiZ4cxk9GprW
         abw7Gs5M44bJuTVgw8PeUbndm2GiKrPoGbtyG/1HyRFaCzIOPEvYaVpS47QGYbLxkN1k
         EhThQrckqd60eakMb3jq5ZvCpR+VWe7Rej+ktXn0G3ta4gTbl/rrlXA8Y/44FW6JNSva
         pXUTC0+JvRcq9/KOBxri17FvlBBWvc82WQme0i84hDJ6MCbHKa3Oj1yxPUj03p0Jrm+P
         ZOG1XOCcRDguAkyTbMvWk3Kc/XSmYgXExORncmzkrxKjVxBgHL6PNlkGOiIRVmIy3BXP
         G/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNIM3D66/Azg3YbAGxb2zW1QAG5fW9Q4vvlsSYbe2Go=;
        b=UyiVt3k8Hr9diSRaxOs0YYCtcQwr59cnwv6RHrN3iizGY3OwREpJhmPWzgsc6rkBFL
         go7lNf9221rVgjm3pX+Quss4owiQr5IhmyexJ/huG+Yw9lHeamTAyReifyAOQ7Wx45ts
         Y7JOTpMkRiRaupYtw7Eu51wxS7x2YfAk16mzy02ClCn4gaVBiur/VwGk7Om21/e2cNKT
         +22P0Tg9Xp1tMbXKCJzhoBs9A+qe+e2aJawCJjiu8rxFhjcSjy7zE86CT0NW874EmOhz
         nbyYkKKi1/UlHya06V7S2Rp04jUiWma1as1PAIH6Sq8EURZJ1Hthd2FArZ4pAHCHSUGM
         vx1A==
X-Gm-Message-State: APjAAAU9k+fD9T73w286FBSxYffRIWtoKdJ41Lqvl4mZip8D7oLvtl6x
        WYAZ2r/SpnA5rgnIhSafvpfMr/qtaDvxbsZo2nsNOg==
X-Google-Smtp-Source: APXvYqwEQ6fUE/r/RBzQgo3NUh3rdxSMFsh6pO692U/wnlkZClRp5BWs9eC7JOzQ6JAatKP0Y4DV4dBp0zEFlBlcc28=
X-Received: by 2002:a05:6102:36a:: with SMTP id f10mr116554vsa.44.1572991551050;
 Tue, 05 Nov 2019 14:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-12-samitolvanen@google.com>
 <20191104171132.GB2024@lakrids.cambridge.arm.com> <CABCJKufDnLjP9vA-wSW0gSY05Cbr=NOpJ-WCh-bdj2ZNq7VNXw@mail.gmail.com>
 <20191105091301.GB4743@lakrids.cambridge.arm.com>
In-Reply-To: <20191105091301.GB4743@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 5 Nov 2019 14:05:39 -0800
Message-ID: <CABCJKufpgoqo84GvV42bO-LVPZ4morV=OhscTNwaBpv-RSwXUw@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] arm64: disable function graph tracing with SCS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 11:55 AM Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Nov 04, 2019 at 03:44:39PM -0800, Sami Tolvanen wrote:
> > Sure, I'll add a better description in v5. In this case, the return
> > address is modified in the kernel stack, which means the changes are
> > ignored with SCS.
>
> Ok, that makes sense to me. I'd suggest something like:
>
> | The graph tracer hooks returns by modifying frame records on the
> | (regular) stack, but with SCS the return address is taken from the
> | shadow stack, and the value in the frame record has no effect. As we
> | don't currently have a mechanism to determine the corresponding slot
> | on the shadow stack (and to pass this through the ftrace
> | infrastructure), for now let's disable the graph tracer when SCS is
> | enabled.
>
> ... as I suspect with some rework of the trampoline and common ftrace
> code we'd be able to correctly manipulate the shadow stack for this.
> Similarly, if clang gained -fpatchable-funciton-etnry, we'd get that for
> free.

That sounds good to me. Thanks, Mark.

Sami
