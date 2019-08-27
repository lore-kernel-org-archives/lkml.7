Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA4320828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTT/5oNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfH0PAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:00:11 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36712 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfH0PAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:00:10 -0400
Received: by mail-lf1-f41.google.com with SMTP id r5so9943862lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iOYKeAHnO6YhcVLdQL8x4DyiBV3mpW9kN7yXNwN8m8=;
        b=HTT/5oNNXiH13XF6Y04PxDC2zkVP8YATjvAp87HIKBTi8wenS16vATKuN0lgh8T0mg
         0O3rMEHTcB6rZS/ww7lidGc3DXCWgOahpYm5jZ2YXd9ONJMEPlVXfz8P0qE6gGQBveJJ
         HDFPqutLvDkVAYa5Cp3VctAzepjx5XZ++pgpfyBvhz9rvJ6XKDGg3twXeWRSm1oWwiJE
         eDfHurU36QTQoE9dI2xidsyKDSYPvC7C3llTQfrxYU+hcklHUB57rOD3ulvx359fkZtC
         xlozlzpMGmeoiVryTvOdasX6EA7ruCmvjw3treLEytseu/XZb1R5wF7kdVGziXLoD2II
         +0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iOYKeAHnO6YhcVLdQL8x4DyiBV3mpW9kN7yXNwN8m8=;
        b=IiEx4T6mscoTqAYRtYfwKGhopsVY56gqj8x+dSC3TTm8mqDbLoGTh5MJ184DdJ+H5X
         bYVdYIgGSGTcnlfnIRMqLhM/4CmOKLgoaepKvwDTdcfaJwaADJeKUgM8L173Tl7YrAuy
         Zc3BqvuY1LtYJlQVp4emmc1amCEqEreZKMJ335xCjDuTB+437EluI4dZF0ATMElhLkkd
         r5v6y27TUc2AYcQs9lwd0TpSleJ36ew7EuIxR12HnBGdVq1toBDpRobiUp6/Juhkm+xn
         wo4xmOy5o0Y845KVmUx2/X9LLNUi26utG9KB32O/E9tq9jNW6VSPOWbFvOMEpfxPxFDl
         x4HA==
X-Gm-Message-State: APjAAAU0kOw/0MomGSEHq4pHg6ltQDbWKtSsRsLkl7BowO8Prkt5MsMa
        5DYmOm1dC5mCfCsUVAKFqogLgkmBHPyM6LMIPuaD5FmE
X-Google-Smtp-Source: APXvYqwI8TRK5NNuSGfKteU0DZ+XYqkikMcc/cio9z9PbWTXO9EsMQnlu9b7YkhU3gIt2Xr0NuvOnNyKCmuPqiGlK9o=
X-Received: by 2002:ac2:5206:: with SMTP id a6mr13649527lfl.96.1566918008817;
 Tue, 27 Aug 2019 08:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble>
In-Reply-To: <20190827145102.p7lmkpytf3mngxbj@treble>
From:   Ilie Halip <ilie.halip@gmail.com>
Date:   Tue, 27 Aug 2019 17:59:57 +0300
Message-ID: <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > $ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
> > crc32.o: warning: objtool: fn1 uses BP as a scratch register

Yes, I see it too. https://godbolt.org/z/N56HW1

> Do you still see this warning with -fno-omit-frame-pointer (assuming
> clang has that option)?

Using this makes the warning go away. Running objtool with --no-fp
also gets rid of it.

I.H.
