Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A269C48BDA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C520843
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMLJmYNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGFSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:33:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33295 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGFSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 14:33:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so12157677otl.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8R4z3fd/pNkVMb+89dxA4ui8k10ocj37Bt7whLaC1Q=;
        b=rMLJmYNuSevuKWuCiVdI43bNmxi2G3pHLMt7d6UgYRzPT5IXjgo/GT6keDasRoZK4g
         /OBhvjWjUYS2v0qo9lkIJjfjkWE4kQLRuB6HOjB54kxbMOj7Ibd3pgQiMMTDL/I/5iCg
         2BeOM0HRHns6OEvAIi7NDoj2y/dlF3VxnijP9I+3HzHbLr7M1LTr+5Cg10Syh3dz5oTS
         pBae4r8DF086crOJ38wMkDHMpLDL60ovH7rl6Se08aUjhSzMzcn0vQpNsNrr1cgMoU/P
         YlfFMVxPhwry/SRvgTR1K80hTe9zWiuHkC34F1tIefAjUxRB4y7wu0+32btM3e8V9hGs
         3xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8R4z3fd/pNkVMb+89dxA4ui8k10ocj37Bt7whLaC1Q=;
        b=G0E1LwzfT07wW/jdRNqEGfK5H6fpzEQh7RugKA25ci/TONODiU0f8CMoJVKjAy+aNr
         5S91Mqi22AbQ5ZU3BxfHxk6/iABJofw7Blmbegz9ipdECNfmJ4sbPf2VoFyU8qjrj+Nr
         uHU/rkSkz0A+cOsEodfib6Dbw40qZy8nMw6IlNf0tEtYbNJKth+WEkSyoCZvrEA5TygV
         OG0Vj+gSk8xxaxCeifxIT/QLk372NhuC4Sywa/5yOsb7Aa7V+Q4dPLqTLwiIIsqFNrov
         tTTFZQkOo1iL4aUao3EwnO2Ox3sBrp1NhomG29B/jLT/E8uNlpTIslB/B/iQ6bjjCssQ
         YIsQ==
X-Gm-Message-State: APjAAAWR/5R/Jry2SdXSjwh2d5aAttmXawyb2BCdNeXyATPO3oi1BALw
        IRgXsLx2ZfRm5O6eUsOHK4M+GGGIvuK38HPge6LWCe4hvLv2jQ==
X-Google-Smtp-Source: APXvYqyBcck06VlUCnJhTINmdA4ZJqB4oH2g6lhQMqchyhM/oF3KhFa6xeVxaox70u4OowtbK7dZn6ufESL4f0s1zvE=
X-Received: by 2002:a9d:774a:: with SMTP id t10mr7301075otl.228.1562437994877;
 Sat, 06 Jul 2019 11:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com> <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com>
In-Reply-To: <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 6 Jul 2019 20:32:48 +0200
Message-ID: <CAG48ez35oJhey5WNzMQR14ko6RPJUJp+nCuAHVUJqX7EPPPokA@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] S.A.R.A.: generic DFA for string matching
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 12:55 PM Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> Creation of a generic Discrete Finite Automata implementation
> for string matching. The transition tables have to be produced
> in user-space.
> This allows us to possibly support advanced string matching
> patterns like regular expressions, but they need to be supported
> by user-space tools.

AppArmor already has a DFA implementation that takes a DFA machine
from userspace and runs it against file paths; see e.g.
aa_dfa_match(). Did you look into whether you could move their DFA to
some place like lib/ and reuse it instead of adding yet another
generic rule interface to the kernel?

[...]
> +++ b/security/sara/dfa.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * S.A.R.A. Linux Security Module
> + *
> + * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.

Throughout the series, you are adding files that both add an SPDX
identifier and have a description of the license in the comment block
at the top. The SPDX identifier already identifies the license.
