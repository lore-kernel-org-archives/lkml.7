Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B90C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628D920873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucyWSYoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfJHWS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:18:57 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45409 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfJHWSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:18:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id d204so168747vsc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qBbOQHMEGbIi6Q8TmHGDl9gpWTvaemlinsXz3g2z2g=;
        b=ucyWSYoYA12iEZoC/jmhn0gx9UeO6YTpJIhPL5ASqtkeMRBmalnv79A57nfiKdMDvH
         d+/U6QsjQODu6OueuddkHxvnd4tBDc8GEtdiGVo05end60mJeAk3Pknxd9Jf7FUSvNqc
         Fs6gKTEFMcTzhPFsvZwtlglbNVykTFtbEPYuo6lyJWOYKP01UAhYq9IDmq9grSsUI00h
         vwHpCGN2Z0S+lZeVZWHMD8yCuZhnKuqHOM3oqIYAaUuhrA7u+LUkShByy9qbdx/ztgBs
         xSEprjAb2LaO56Nd/tSvvrg9xpIt4LAuS4SKASc8Dqw5xgYGSPvSM+EIs6ow9naVB65R
         bJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qBbOQHMEGbIi6Q8TmHGDl9gpWTvaemlinsXz3g2z2g=;
        b=Gl7YB7lF6SvAoZtdjOumZ0mxnZEbm5vsRyv96TEsCQpg5vcV33lDYiF4ZzXZx+Lr29
         aVsU90Fp0LH9d98cQj2OTo/atEsV7CF2Da2sur36pobTy2V0uk2Sf8UA1HepEMsMjZaX
         RQg1IQVObcfnROKWRfGd6Ex4AlwN1T+ipm7FgMLLIjkJTGxO53P68NQ1sX9FuooUAb+w
         EPFtrw0ASf4f/sS/PNjtxlfoyMgE0/YQnFIalEG9wRj1+NQmr92rloYFXxl974DMUfB5
         3pC8pBPX13HQn17KTUnr5zSs5+M2WMUOIcpsMyF8YW7anUH1Ews+hdwB+j0xYr2vCkFt
         q5YQ==
X-Gm-Message-State: APjAAAVLeLxbFADXa6swoLT5cg4X+04petz9sVoIbtJAtJemXn9rFeeI
        dzvdDlpZQGsY/1SqRXJmSocUoAtIIiJ8Typ354mnYQ==
X-Google-Smtp-Source: APXvYqxMQK7/AOsW+Xue+pf0X2/MOkBpQY9PoEzc7LsIoEIsIagWdCJpyGdoMXNJ3oK11ksvAi7z30I/sV4YTJO+FYg=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr67518vsp.104.1570573133773;
 Tue, 08 Oct 2019 15:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190913211402.193018-1-samitolvanen@google.com>
 <201909231626.A912664DA1@keescook> <CABCJKudtyL4UO+45GMLNT6vZK-FEB-Nvry=aPEnWDY3v0goOew@mail.gmail.com>
In-Reply-To: <CABCJKudtyL4UO+45GMLNT6vZK-FEB-Nvry=aPEnWDY3v0goOew@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 8 Oct 2019 15:18:42 -0700
Message-ID: <CABCJKudjboSdZAqS0DViAi0=Y+R63CZbbO-L3Gm=MCoOKjYK0w@mail.gmail.com>
Subject: Re: [PATCH] x86: use the correct function type for native_set_fixmap
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:51 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> Someone else probably knows better, but yes, we could also fix this by
> changing set_fixmap to accept enum fixed_addresses as the first
> parameter, and changing the type of xen_set_fixmap instead.

This approach is actually more problematic since we cannot forward
declare an enum in C and including <asm/fixmap.h> here results in a
ton of other missing dependencies. I assume this is why the callback
function accepts unsigned in the first place.

Sami
