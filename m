Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E626C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3FE20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUd7YMW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfCROpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:45:05 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:32983 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfCROpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:45:05 -0400
Received: by mail-yw1-f67.google.com with SMTP id a199so13110622ywa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+Gencg0JswbAigLpd/T2ItS1NnphPhR+c6rD3BwH/4=;
        b=eUd7YMW/iwbeqVYkUaaw/cUWk71SOkrkn+hXu01mjWUDyol7Y3918h8Me2N/Lmwg82
         BACBnVwkosRYGgNkB+MEv3CCkEWOrHu3xf7N5dwYHmmMELnYsQNqsOaeyK88/Ckff/ef
         kh+B6RhAXAgdrluebHSVHeJbDqxICihTurm6Izpbs8uJk/KpMx9fOP+CQm89PWz1so10
         k5Hy+rI3GiWNLVnAFbpLH1eywVv8873JwRYu/a9tdS5LPAoqYign21IdkWCo14GRLZpi
         +1s6lB6RpgPoZI0uN8BuvtNMRbB8sYv/Hh/TeFFlme7Oddb+rSFYGGHMaF7cYJURP6Fs
         tbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+Gencg0JswbAigLpd/T2ItS1NnphPhR+c6rD3BwH/4=;
        b=ZqjoZQWLQIluUoqHwnF3Etj8/8SVg8pyTrjyUvDMwhXAwwiIH3aB1PXD8/2QAFI2Za
         fEZkmBMZq4qu5jcfgkLvGQlSPK06XLpEpmDTxx1qx0VC0XHK5IyQ6/RB4MS9AP/RhH8m
         lLrgO2JWrTtWJPeXiXc7wivheLuXE6SLUAhbZh1WXvyFuFtxQpSMabHDV0loy/b2r3X7
         Jl1YnktQb+bzKhA3T3lqjZ42iSp5AeBzDUvcYkN2lUiq6oaVCgUCKZovtZ1+gr0otAsF
         yDhQbJdmGv2wFxbFxxyCNQ3tQgerzHTpbIo0C1D9bzcdr1ZeXZQILtcP1ezPtn6gWsUF
         Sl5Q==
X-Gm-Message-State: APjAAAVkkM3vF9/PdNgyc28dHIQXUXLam+PMznQhFS+13JRvhvIPOvAt
        zVNqdmfyffW5IHL04M6BlOE66uzIENiHoWM8Ei6ToQ==
X-Google-Smtp-Source: APXvYqy/LrBuUxgMYxjRei67FuMQP0H17hpJ7z4CK4VwoXLf7Je3qt70qo9gwTM2VSIhDx1PncSnTBxTzploGurMk0s=
X-Received: by 2002:a81:2843:: with SMTP id o64mr13821364ywo.441.1552920303807;
 Mon, 18 Mar 2019 07:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com> <56d3373c1c5007d776fcd5de4523f4b9da341fb6.1552679409.git.andreyknvl@google.com>
 <04c5b2de-7fde-7625-9d42-228160879ea0@gmail.com> <CAAeHK+xXLypBpF1EE73KuzQAo0E6Y=apS46wo+swo2AB6cy3YA@mail.gmail.com>
 <CAAeHK+yxcG=KBjG0A5BicBA7Zwu6LR6t=g5b-9EAPXA8_Dfm2g@mail.gmail.com>
In-Reply-To: <CAAeHK+yxcG=KBjG0A5BicBA7Zwu6LR6t=g5b-9EAPXA8_Dfm2g@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 18 Mar 2019 07:44:52 -0700
Message-ID: <CANn89iJfjhNcDS_eHg-OUiGui-hyRL5iWQuu_U+BW_N9iSNbeA@mail.gmail.com>
Subject: Re: [PATCH v11 08/14] net, arm64: untag user pointers in tcp_zerocopy_receive
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 6:17 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>

> Looking at the code, what's the point of this address != zc->address
> check? Should I just remove it?

No you must not remove it.

The test detects if a u64 ->unsigned long  conversion might have truncated bits.

Quite surprisingly some people still use 32bit kernels.

The ABI is 64bit only, because we did not want to have yet another compat layer.

struct tcp_zerocopy_receive {
    __u64 address; /* in: address of mapping */
    __u32 length; /* in/out: number of bytes to map/mapped */
    __u32 recv_skip_hint; /* out: amount of bytes to skip */
};
