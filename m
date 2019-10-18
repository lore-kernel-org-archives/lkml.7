Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2CECA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB2221897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGjlwqaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443214AbfJRTAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:00:44 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35025 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443193AbfJRTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:00:43 -0400
Received: by mail-ua1-f68.google.com with SMTP id n41so2052582uae.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHnooVFY2SD/hhEM3K3r0PH8N73JFv2NbOv8bRM4m2E=;
        b=fGjlwqaPn26KxRb9o+F4zrhfo5SkElhAWo4zrZYkQX9pYzl+Gat5G9cEzwzzgLT0yN
         01vXJtveJQV2qNvuL3dsYa3uHnA44CbQiyZWnm0OfAnXngfbQBE6/GoC7xkKTjBJoQ1W
         I3TlO2mOikI6Kr/w+ct+2TTOTmiNs0XrL0v8Qsjwm5i6295ZB9suC9+VQPpZngTAqbXp
         lbTN8AhrIsPleMkGbxdHNZqq0UgR8TbuoHXfoDLAHfBp5Dt4CXqh/ghNRZE/atlkwC4C
         f/z8a9w78sIenvmPm6uGln+51flj9Z7ABSXfofYGZvMWcJmJ0vLmRcx9Etw4H3lXK2ux
         qiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHnooVFY2SD/hhEM3K3r0PH8N73JFv2NbOv8bRM4m2E=;
        b=F+Z1K9ZqJQ8jelnJh4CVmdY8ELCH1ko/RkJhz47SqmI0Gd5JXefqpZ64+yG+MSq9bU
         HUDSoi9GwnsZLtsuEjFffoLDj7PoS8ru7rasp5E/dJ53UwVUvXtqRwcL5L179ZGsFIoH
         GgEn4u8PyZbdLDhALSSgJtYSNbAkEOLp8vBmdOh4FTkofMvTmilbd1cN15gy2EvcNe6D
         wgZIFq+7PPb3yBlwen5A181oiivcxKfz3R2V0TFsZGX7Bty3BFxHA90iILdGoB0w+8zh
         JC/WF+TFLJh/ja1tg32oHlUsAcyOLuCcXaYk0cBKqTpSXQ4CV37Zt5roCL4snavikVUa
         hrRQ==
X-Gm-Message-State: APjAAAUC3rV669fdES40vIrOleVZijGsQ9xfvQxhBFZKNomBRlbh80Qq
        bD/7CkHeLJZnjRHLm7UsH7N+mg7W6IlKmiWkBX6oNw==
X-Google-Smtp-Source: APXvYqy+QiLkN9pfvjcYpnB+QYepyp79m5l6k8r6HsNNtj0nqOOoe5lpxNRIDuav5cK0cYo+BuFsIE1uUC/SJFG20xg=
X-Received: by 2002:a1f:b202:: with SMTP id b2mr6191356vkf.59.1571425241664;
 Fri, 18 Oct 2019 12:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-6-samitolvanen@google.com> <CAKwvOd=SZ+f6hiLb3_-jytcKMPDZ77otFzNDvbwpOSsNMnifSg@mail.gmail.com>
In-Reply-To: <CAKwvOd=SZ+f6hiLb3_-jytcKMPDZ77otFzNDvbwpOSsNMnifSg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 18 Oct 2019 12:00:30 -0700
Message-ID: <CABCJKuf1cTHqvAC2hyCWjQbNEdGjx8dtfHGWwEvrEWzv+f7vZg@mail.gmail.com>
Subject: Re: [PATCH 05/18] arm64: kbuild: reserve reg x18 from general
 allocation by the compiler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:32 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> > and remove the mention from
> > the LL/SC compiler flag override.
>
> was that cut/dropped from this patch?
>
> >
> > Link: https://patchwork.kernel.org/patch/9836881/
>
> ^ Looks like it. Maybe it doesn't matter, but if sending a V2, maybe
> the commit message to be updated?

True. The original patch is from 2017 and the relevant part of
arm64/lib/Makefile no longer exists. I'll update this accordingly.

> I like how this does not conditionally reserve it based on the CONFIG
> for SCS.  Hopefully later patches don't wrap it, but I haven't looked
> through all of them yet.

In a later patch x18 is only reserved with SCS. I'm fine with dropping
that patch and reserving it always, but wouldn't mind hearing thoughts
from the maintainers about this first.

Sami
