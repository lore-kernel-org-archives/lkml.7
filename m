Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793FC21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwSBWS1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfCVHnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:43:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38316 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:43:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so1192542wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=VvhmhUaJBmKBUIKN16Nd55bRItuZiV9os2uR8iZYzf8=;
        b=EwSBWS1ErC4Tyg+4EfcEXpNZTPgVpWMVCXDN90wxFIcYUUsCYbPztpTTPUQehT4i9W
         oMh5Hoez9oA/47jxFTjSwB40M3i/D0B+3H/uhDEjJD1l02BpxpLDP+LzJfWcRUOjh78w
         KpuNbOXdtYc3PqxK95IgEZSBsnbM2yoPWoJZSuztSLpD6K74Kju7diqVZMIlIPGyIHBT
         kjXOg2ti3OpJr8EdVmqLv1tgpZnP9hGH6kRmjU08t0YFR3w8fTsrUeZqlR1maYhWHwBf
         lgXDZ0nVRMh+8K+KCnFEQcvcES9e+QCdRnc9gQEhFxQqJidY8lN2VCrxWhlGKq70Qj1h
         0svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=VvhmhUaJBmKBUIKN16Nd55bRItuZiV9os2uR8iZYzf8=;
        b=mTFmFWiA9kPoC3LK/heNyVB8FjLV8CnGb0NgIn2m1Tqbs3d4qf3zf4MelYpv+Zeu4+
         fh6p0OZHQfU4iL85FyUME5OuG0PtC+cRZoIMqZ9FDdxbCUIcI9B3zIzu0Jv8omsp0hzN
         g7y2eh+TOjB7xS7Bpx4uFa5LQZxRIud9BYBGqBlkwMFAlPDZjc5YJ/6pLn/W67E8i73O
         HvkdYvwfkZVmDRM3rVDJBxdHYb6elJSjdv0lUPHhce9bGbLmqurT2vPm55ge6M3DAr4K
         L02afOPYlEULsi0xp/ge1E85SpLCIu3eDs7tZrWEaok+GMxLo0H4cRJKpnOKy5QWMC9N
         zsDg==
X-Gm-Message-State: APjAAAUQIi7vMO75X3N58JslkdLaGpa07RIMuHxYlmAsTDrv9ZW8WLkb
        t0eWaPZhB1BzmVpmcjQcLnrHc9j7JvuiSEfjzmo=
X-Google-Smtp-Source: APXvYqyl8Tx0BOLMocCe316eDsLgKYTExCQVCQE6/evO9LFHree9SfE7koN1N8dQRubjK7FirzWm5Sm8HcZ5pEDj6dc=
X-Received: by 2002:a5d:48ca:: with SMTP id p10mr5651263wrs.141.1553240623508;
 Fri, 22 Mar 2019 00:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
 <20190313211335.165605-1-ndesaulniers@google.com> <20190320191135.e49e976a8258c8ac0bb428c9@linux-foundation.org>
 <CAKwvOdn84HNEB3u4XO-V_+c=txmDd1061G_7K0zZVS4MfF--Lg@mail.gmail.com> <e0b18c66-677c-7418-875d-f3d8c2f01913@rasmusvillemoes.dk>
In-Reply-To: <e0b18c66-677c-7418-875d-f3d8c2f01913@rasmusvillemoes.dk>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 22 Mar 2019 08:43:29 +0100
Message-ID: <CA+icZUWiiAjwQm3ajHyYpX5z6pUU7V8TrF=f_9G_EPN75iM_fw@mail.gmail.com>
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 8:17 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 21/03/2019 18.02, Nick Desaulniers wrote:
> > On Wed, Mar 20, 2019 at 7:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >
> > Further, I can drop some of the __GNUC__ < 4 code in
> > arch/x86/include/asm/string_32.h.
>
> Already on its way to Linus:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=88ca66d8540ca26119b1428cddb96b37925bdf01
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=2e905c7abdcd5ff09b9df33d25eb7148c85bed2a
>

Upstream:

"x86/asm: Remove dead __GNUC__ conditionals"
https://git.kernel.org/linus/88ca66d8540ca26119b1428cddb96b37925bdf01

"x86/asm: Remove unused __constant_c_x_memset() macro and inlines"
https://git.kernel.org/linus/2e905c7abdcd5ff09b9df33d25eb7148c85bed2a

- Sedat -
