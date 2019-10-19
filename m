Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9BCA9EA9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 00:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D093A222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 00:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJhBGhz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391179AbfJSAV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 20:21:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39262 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfJSAV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 20:21:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id 195so5927646lfj.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqICylESWKf0IpOr+KHkluRNlL0wf5TguV6mXdP4QGA=;
        b=SJhBGhz9kYlPN0TADnvJp8G2Y17kwQLx8bFgEQxXC4oPBXVPQajIkOkF46KrnCk3Y+
         SIhUxsEMZpo0mO71reWB5iYnGBSvSPpnlhJ7SOGmsAzO1r/eCW2htdVksbO0SI9DIYUV
         omVMOJI5aJQYPBTuWOcF+vN49kJ/Z38IZ5w69/IWpI0dZkus3V70HRJmjzixpNFSsrH7
         zFdeP18no8PweXdELrMKy1nvLYeUemGKl7HG8j1bU8GRNXdqGvneSPtLFgWbG2ZCxBd6
         JFKB+kpkVv5yQiadF2KjhDCmed79/Dn/ssCkl2cq1nYz+heSuFAzelrZNVV5W1OmMhq6
         qcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqICylESWKf0IpOr+KHkluRNlL0wf5TguV6mXdP4QGA=;
        b=hyBcVplsw+betlEz7hcXS3YcNuP1/FAFrqZPSqfLijkvqcXQ5SQ+P1J/L0WOWdm+gD
         jaCM9MhHV+XdSB7HjuXa/8k0cTMda11pktbUOjsSDnUg2yqm6CvyV2m+1MsONYae+6qp
         8Sxqxcs35mZmbYAzfstyndpXWzL71i02O2MJpaa5MjloC18AUMnkrZ0ZVbHMAShApxPN
         EyQ+aghXUu1va3n0/gGXuiUu3dVpG7TQDL+H8QGyJVqAjoXsWkMki4fv2fXNS0uSpH7U
         oUSvJ1FYZkTyllry6kdkpAvskoNLQLtKKGHXuho3EdcrUnOdbsNppWdFfnUzRHNEmPAY
         Y5CA==
X-Gm-Message-State: APjAAAUbe6JZlAojD62y8xf7GGarNv5vBHFecETrhqyqDYaOJ8NzvWBz
        unRkFC4vJ4uK1Wtf53v44rOvEvLGv6E8rcIb7sM=
X-Google-Smtp-Source: APXvYqxT5yYNPjiMSlzwumlj8UjSOAfCmDmgAcpOZOM10R//Skv4aoDktplFaX7g2Ws72X/gbHtxdVXSSeajbRTRouQ=
X-Received: by 2002:ac2:55b4:: with SMTP id y20mr7590271lfg.173.1571444515448;
 Fri, 18 Oct 2019 17:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <CAKwvOd=z3RxvJeNV1sBE=Y1b6HgXdnT4M9bwMrUNZcvcSOqwTw@mail.gmail.com>
 <CABCJKud6+F=yhTo6xTXkHhtLWcSE99K=NcfKW_5E4swS4seKMw@mail.gmail.com>
 <CANiq72=PSzufQkW+2fikdDfZ5ZR1sw2epvxv--mytWZkTZQ9sg@mail.gmail.com> <CAKwvOdkqfbXVQ8dwoT5RVza6bZw3cBQUEGcuRHu0-LhObkg--w@mail.gmail.com>
In-Reply-To: <CAKwvOdkqfbXVQ8dwoT5RVza6bZw3cBQUEGcuRHu0-LhObkg--w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Oct 2019 02:21:44 +0200
Message-ID: <CANiq72m_+YLLWuRGi=yZBAUj2WHSbw9E+jQ02LbXyq3b12Vb6g@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
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

On Fri, Oct 18, 2019 at 10:33 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Sami pointed out to me off thread that __has_attribute would only
> check `no_sanitize`, not `shadow-call-stack`.  So maybe best to keep
> the definition here (include/linux/compiler-clang.h), but wrapped in a
> `__has_feature` check so that Clang 6.0 doesn't start complaining.

Ah, good point -- agreed!

Cheers,
Miguel
