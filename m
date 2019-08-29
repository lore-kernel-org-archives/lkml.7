Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B4BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDB92339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf6IKzbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfH2JF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:05:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38251 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfH2JF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:05:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so2974060wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PH15CXoUWSHFT2n3BVwBS++iyb/uJ0CNVO0a7Vt6EJk=;
        b=Nf6IKzbNFfLXSEl/tiNF5obxBP9ujEtEybCr3jFDgm06sAMM3xqk+0xOok8J6mzm95
         5Vnl+64oKpSqZkYhz3wWHcAL8wRgZ2AYkmzfxqf6RlQhXuHY9VPyl30dRW9PVgsrenzc
         sFGdyNREDXGpFoJnym3iusCi3bxeTUK//O8FZDYd8OQkLvdYAY/BMTmnTN4kgUuKNK2F
         wU3akyBO78XXG1FVQw4DxrbydI+ADlDEScSnMCqtgWQCh/bWzH7nPdcvW0YhHCWJSy5m
         NWrl3InNEu6cRadJSu9UjoPT0Zv1no5HQmEDQBYACLX3R3TQ7I75adhF85HxIWDZkgIs
         olxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PH15CXoUWSHFT2n3BVwBS++iyb/uJ0CNVO0a7Vt6EJk=;
        b=Z2+T0TNT5DjAo5E6DXKLfYfvOUffd+rmWOkgEWIbMbhqlaE93aAKf+HLnYvVwRz2t4
         tODS8MTb96KxJknhk+L+aBbRC2dIWNy5F7balyZB8CRUNVAcPVUGFsyYROw1/yI6inUE
         Fgsp9Nnq2UdU0NcGZdsiJ0aTfdD4uU4RetT7qfDYNMJT3d8e5i2eteatpK8uNBrhLMf5
         LBvqTH7FN1OwBMSvm+NAFq5glyiKg6vA/61tSKtA3kkYrbsru5Vut8oFqfRuUfPdN8c9
         aHhe7esPZze6EpNKgfgPT5/iJIfxWJHZoOFgUyf3ZMYl750TQwHp31wD///svyBYrEtP
         nH0A==
X-Gm-Message-State: APjAAAWxMz6X0WFk9PBYBQguIx9ZmFcYnxOXsgruZ3g5OtMc8f7qn2g8
        W9YxjaskRZni7J1hJ4anWRey6a9vVzaitsGCuFtJcT3w
X-Google-Smtp-Source: APXvYqy/w5ZF4RwvZK2gV1xbgi1R+Yv2QwN1VvlL/LV2qMhsHq4u3WhRGu+lwwylXaQdCBnZiOngONtUthysX4+1S+0=
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr10663798wmm.81.1567069555930;
 Thu, 29 Aug 2019 02:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com> <CA+icZUVT8GJCPSSB=jLKLu=-OrWAj5W3Rkbx1ar0SGcEq0-D0g@mail.gmail.com>
In-Reply-To: <CA+icZUVT8GJCPSSB=jLKLu=-OrWAj5W3Rkbx1ar0SGcEq0-D0g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 29 Aug 2019 11:05:45 +0200
Message-ID: <CA+icZUXwz96kO97djorQuBVo-Q-SMJe4m6gBKp5=gp6hSHZp3A@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] treewide: prefer __section from compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, will@kernel.org,
        jpoimboe@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        davem@davemloft.net, paul.burton@mips.com,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> $ grep -e __section\(\" -e __section__\(\" -r
>
> arch/um/include/shared/init.h:  __attribute__((__section__(".initcall"
> level ".init"))) = fn
>

2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

Who reads commit messages?
/me hides

- Sedat -
