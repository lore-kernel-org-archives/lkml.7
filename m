Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5AEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76AB2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOCxhZ0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfH1OWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:22:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53017 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfH1OWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:22:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id t17so270598wmi.2;
        Wed, 28 Aug 2019 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=D4lwdLEb4QQKbZ9weOV4KhRYID3FQMV0ZKC/KJGyR5E=;
        b=DOCxhZ0q5T2JQYg2s16hNNsaXELwXQE9uLBO4MCD4nqEzNQp6RFzjOV8sxkEei1gZ7
         YphdelfVMwbNGQ7/HQgoPKGwdCOXbjzhtoEzqf5sS7mF5bzLU1flnPGWkre81cwDcCky
         ZZ1BCEl47CtNdQbjA57jzTqRvaL3QGqLdqC9rZ8tPmFRyJXH7gd45UgY/GI6VKwWTYIK
         Dj6oUl2aTmZUahvxrB6i3Dawr8JIsJcipgMkGOtfydBCL9Dfm0cPKflgxNO0rlBwpswZ
         B9OAGr/2vtfYtYZ2tPmTEUbPYK3CZlxh4Ia7UFk9QiRM4GqydGAACs6qnSA4UhcDGvcx
         WFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=D4lwdLEb4QQKbZ9weOV4KhRYID3FQMV0ZKC/KJGyR5E=;
        b=r0bIobuS5oTiTcbL0F0o/keOGEDWJG8GiyPQ9+Nt/PlTtdB51S2Pk3pEoyl0B7nxxG
         pdCJnEhP+z4du1LegScWour6yrLPMuxewVKBCm0APuRWy8I9i0AAUUZ30EgnMDX10kOC
         q/kDdMHxaGEZTNqWPbSGRMFqvq8SNkCR9pDk45wSq/koNWAz3gTSBe6FBSQa0XNFWRL0
         ICoJV6m1p0qecIDRwldpCraG6OTzM3RCqw9fahNP61k16tbetXoCkqVm15LqGMHGVo9o
         mLyIpcEfp79CLKcpLV+C/lty6JYHyriXhE6mAoE92Hs0N2JZYUJ0sZG1I0rR1rqJAwDH
         wVNg==
X-Gm-Message-State: APjAAAWhXVBgiBKRN+bbLpTdEeeXnlkTOzDBSan+lwdFA8FJyX/FUzS6
        OhAhdCMpNAESKIoyr4kx7x/pz/zop+uo+Loj7g8=
X-Google-Smtp-Source: APXvYqxCAlRy8ROXK9G2GnuDBTqcHC3Ggaq+VaNUfdOmWaUyVB1CNvvLV7q/83lqVw2NDK+hphCfpobr/nq5ilnbKME=
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr5533245wmg.150.1567002129167;
 Wed, 28 Aug 2019 07:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190828055425.24765-1-yamada.masahiro@socionext.com>
 <CA+icZUWigJkh-VtJc4=xE06oMgE=ci2Mfdo2JaDv0fth8PKH+A@mail.gmail.com> <CA+icZUUhhOLfOgwoKP4nKOdPakNJF7XafJ09ERP6r7dOUduMsg@mail.gmail.com>
In-Reply-To: <CA+icZUUhhOLfOgwoKP4nKOdPakNJF7XafJ09ERP6r7dOUduMsg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 28 Aug 2019 16:21:58 +0200
Message-ID: <CA+icZUUSVRURu-jQAnVnZwPp0qiWpostDz+WkTjxx8zunVKBgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: refactor scripts/Makefile.extrawarn
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> build-time checking. For more details see <Documentation/kbuild/kbuild.rst>.

Grrr.

s/ Documentation/kbuild/kbuild.rst / scripts/Makefile.extrawarn

- Sedat -
