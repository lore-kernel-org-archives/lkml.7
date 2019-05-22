Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08209C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC0821473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5c1PJ8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfEVP5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:57:47 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50349 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfEVP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:57:47 -0400
Received: by mail-it1-f193.google.com with SMTP id i10so4421570ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csIO6/r6boDgls5PxYVv4WnR4nG5C2hWLcsvu4wXyRE=;
        b=I5c1PJ8QlNgcKHXLHGh8brj9dKeIc23jMxGlGishmc7jg0dw/3WNuuAICPR4vHase6
         PXKRpc3p3PBlZCgxRTvLDlTyAmIMxmJ7uAylqP0Oum+ZxW7HPwc5ZhsSqR+PuIQLF2kn
         rmWAp7Sa8igzbVYZCptsBDsyBpbNGWwDEp1Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csIO6/r6boDgls5PxYVv4WnR4nG5C2hWLcsvu4wXyRE=;
        b=FmDzewqRanIk3X92mubZpBx2v4+Ax+jbC3vfKrxemRvbeNX5d/7zG/9TioTDIoOm3t
         XoOteBBT/XpYYVb0BqzWjpmy5JTi1wT2bph65uXZGFP/+dx6witdD9V9Q+fLAyMOj7Qq
         StnkHF5J3l11z+G8t/6Px6MFItgxsVqRIHJZYyFxeLY/KRQbbvZ7CMHXkWr3BXWCsJ0o
         ScHWm+djS7UlDeBhTxVwRPhu0woF8yjLBsCmJl8ac2A71slky2X8SuTm15KErIc+iAa7
         E3nhmMspeXxjx3KDCBWjCm+y3UIy7QYeB0v1A2UCCy3yk2ZeUKskEmYvQVPtlj6euOSB
         ox8g==
X-Gm-Message-State: APjAAAVPPE0JZJuaghGN9hWMMS/6aUg0d8PGHg9j9OBvihtEY3TY3HHS
        AxO3s9PgXl1RyVGBjP/ySlV9APmg0PU=
X-Google-Smtp-Source: APXvYqxzVxH0CGHOtbPPacUQzmlmSwvyuXkojrpeof//twviKDIiGLRVgwgyr0yAPizziW7zjRQi9Q==
X-Received: by 2002:a24:d43:: with SMTP id 64mr2092582itx.114.1558540666497;
        Wed, 22 May 2019 08:57:46 -0700 (PDT)
Received: from mail-it1-f179.google.com (mail-it1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id i25sm7730903ioi.42.2019.05.22.08.57.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:57:45 -0700 (PDT)
Received: by mail-it1-f179.google.com with SMTP id m141so4385352ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:57:44 -0700 (PDT)
X-Received: by 2002:a02:5143:: with SMTP id s64mr8139039jaa.54.1558540664324;
 Wed, 22 May 2019 08:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231948.49693-1-thgarnie@chromium.org> <20190520231948.49693-4-thgarnie@chromium.org>
 <FF111368-9173-4AC2-9A79-E79A52B104DD@zytor.com>
In-Reply-To: <FF111368-9173-4AC2-9A79-E79A52B104DD@zytor.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Wed, 22 May 2019 08:57:33 -0700
X-Gmail-Original-Message-ID: <CAJcbSZEYZLj_UQCQZzqxiOJEoWb2EzuUgaaFCkUBBFuKepHh8w@mail.gmail.com>
Message-ID: <CAJcbSZEYZLj_UQCQZzqxiOJEoWb2EzuUgaaFCkUBBFuKepHh8w@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] x86: Add macro to get symbol address for PIE support
To:     "H . Peter Anvin" <hpa@zytor.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 8:13 PM <hpa@zytor.com> wrote:
>
> On May 20, 2019 4:19:28 PM PDT, Thomas Garnier <thgarnie@chromium.org> wrote:
> >From: Thomas Garnier <thgarnie@google.com>
> >
> >Add a new _ASM_MOVABS macro to fetch a symbol address. It will be used
> >to replace "_ASM_MOV $<symbol>, %dst" code construct that are not
> >compatible with PIE.
> >
> >Signed-off-by: Thomas Garnier <thgarnie@google.com>
> >---
> > arch/x86/include/asm/asm.h | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> >index 3ff577c0b102..3a686057e882 100644
> >--- a/arch/x86/include/asm/asm.h
> >+++ b/arch/x86/include/asm/asm.h
> >@@ -30,6 +30,7 @@
> > #define _ASM_ALIGN    __ASM_SEL(.balign 4, .balign 8)
> >
> > #define _ASM_MOV      __ASM_SIZE(mov)
> >+#define _ASM_MOVABS   __ASM_SEL(movl, movabsq)
> > #define _ASM_INC      __ASM_SIZE(inc)
> > #define _ASM_DEC      __ASM_SIZE(dec)
> > #define _ASM_ADD      __ASM_SIZE(add)
>
> This is just about *always* wrong on x86-86. We should be using leaq sym(%rip),%reg. If it isn't reachable by leaq, then it is a non-PIE symbol like percpu. You do have to keep those distinct!

Yes, I agree. This patch is just having a shortcut when it is a
non-PIE symbol. The other patches try to separate the use cases where
a leaq sym(%rip) would work versus the need for a movabsq. There are
multiple cases where relative references are not possible because the
memory layout is different (hibernation, early boot or others).

> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
