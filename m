Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E025C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321C22071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dw4HY62q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfKZOGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:06:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43934 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfKZOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:06:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id l14so15925750oti.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPOiBiMl69XGQDBmycxuawKOxsJQrxoI/O+sj/Y0vXA=;
        b=Dw4HY62q40JV7BWYlZLIGz6S96Cm9bMj0Wo2km15nIQqLH4Zz1BRw3dQ/buGO6/QKT
         VAbL+EQPXdreE9r3cyH9Y7aYzcgZf8ZuiXYYqVpXYxvEyEh5NLsVoyP8FArwOm09+epk
         gbIh/Fl1NfFWge9SfqKz7ndd/sLU9KZJcMEDZBGdVCuoZ8nCvXWlEOrKEWAOYcYqri93
         wqwjrAwg+1XtW+uHIGzIdS77RKa+gCzdoD0D8cJRnlKqu+6hVW+bkhPk8k8nNsZhxRqs
         F1wa6fQYMHOJd5trEjadiYOAr2PEXZpG4NiGuCyL7x8vnRQYbV8O9/sUvVNCWtyunhXH
         BBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPOiBiMl69XGQDBmycxuawKOxsJQrxoI/O+sj/Y0vXA=;
        b=Cn/rSOEP7zHjZN6aPK6ohZM8UZQ9ju5ZxoglOa7JEsUEzKYQonxXft+teBZdpwBMsz
         g034feQqQ1RagxAG8H1ak05gOtke3C9slA4KQ+dh5gsEWuShvEgeV/bhEBHySNF6pyiW
         uI6jjvltziAFG0Yg81r7cC3xn6nir5PvBTPrDHe00R6cvKBFsQLhFPMgNdMclCTUQtVD
         psnnaoMgK6m2qVaTsOHB8EiPH2AEwy40iYQji4EyiJTTxDIiyvsTIiI/5zrqh6yIuZ6y
         WIdrnpi762ZJRVZWnulaQzRK3PEjJ9XOIan8lUgNX8wazI4Nisrmv1a3cdbcWMWmS8oU
         Astg==
X-Gm-Message-State: APjAAAUKyBq9luBTUWSP8i9y2dcdZ6SaAMImW1n6BWI5ApcXLoD5vIcg
        AXrUsVYwsPI5pQAywg3OInXmndSeZxt7h52cYxHYJQ==
X-Google-Smtp-Source: APXvYqxQUDki0G777xbpVnHTwhAQtWrn/BxMVnfhOt5W+/tfF//ioxeA1d3s8ro9+Sm8jQrl5lXWfhJFgjrYUCro9ZI=
X-Received: by 2002:a9d:8d2:: with SMTP id 76mr25447839otf.17.1574777192640;
 Tue, 26 Nov 2019 06:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20191126114121.85552-1-elver@google.com> <20191126122917.GA37833@lakrids.cambridge.arm.com>
In-Reply-To: <20191126122917.GA37833@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 26 Nov 2019 15:06:21 +0100
Message-ID: <CANpmjNNcWujm-Q8WD2Lgf2ww5aG-kfmFca7YC96BdcFOkwgxXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] asm-generic/atomic: Use __always_inline for pure wrappers
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 at 13:29, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Nov 26, 2019 at 12:41:19PM +0100, Marco Elver wrote:
> > Prefer __always_inline for atomic wrappers. When building for size
> > (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> > inline even relatively small static inline functions that are assumed to
> > be inlinable such as atomic ops. This can cause problems, for example in
> > UACCESS regions.
> >
> > By using __always_inline, we let the real implementation and not the
> > wrapper determine the final inlining preference.
> >
> > For x86 tinyconfig we observe:
> > - vmlinux baseline: 1316204
> > - vmlinux with patch: 1315988 (-216 bytes)
> >
> > This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
> > in the KCSAN runtime:
> > http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Add missing '#include <linux/compiler.h>'
> > * Add size diff to commit message.
> >
> > v1: http://lkml.kernel.org/r/20191122154221.247680-1-elver@google.com
> > ---
> >  include/asm-generic/atomic-instrumented.h | 335 +++++++++++-----------
> >  include/asm-generic/atomic-long.h         | 331 ++++++++++-----------
> >  scripts/atomic/gen-atomic-instrumented.sh |   7 +-
> >  scripts/atomic/gen-atomic-long.sh         |   3 +-
> >  4 files changed, 340 insertions(+), 336 deletions(-)
>
> > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > index 8b8b2a6f8d68..86d27252b988 100755
> > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > @@ -84,7 +84,7 @@ gen_proto_order_variant()
> >       [ ! -z "${guard}" ] && printf "#if ${guard}\n"
> >
> >  cat <<EOF
> > -static inline ${ret}
> > +static __always_inline ${ret}
> >  ${atomicname}(${params})
> >  {
> >  ${checks}
> > @@ -146,17 +146,18 @@ cat << EOF
> >  #ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
> >  #define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
> >
> > +#include <linux/compiler.h>
> >  #include <linux/build_bug.h>
>
> Sorry for the (super) trivial nit, but could you please re-order these
> two alphabetically, i.e.
>
> #include <linux/build_bug.h>
> #include <linux/compiler.h>
>
> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Done, thanks for the acks!

v3: http://lkml.kernel.org/r/20191126140406.164870-1-elver@google.com

> [...]
>
> > @@ -64,6 +64,7 @@ cat << EOF
> >  #ifndef _ASM_GENERIC_ATOMIC_LONG_H
> >  #define _ASM_GENERIC_ATOMIC_LONG_H
> >
> > +#include <linux/compiler.h>
> >  #include <asm/types.h>
>
> Unlike the above, this doesn't need to be re-ordered; for whatever
> reason, linux/* includes typically come before asm/* includes.
>
> Thanks,
> Mark.
