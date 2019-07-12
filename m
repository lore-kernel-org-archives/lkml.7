Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2EFC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D999D217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562967832;
	bh=k1kMOy7zMFVkvn5HZMfWQMJ+21kMNYFvG5B3sS0soSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aR2xTVD0rSIJ1MxIQqcTxouw9Cb740vRdyQkEtgJOeEzuVPrpEKDktqfuGeH3FGr+
	 rkTXcJc4a8+m3BxBBeSqLMKRVKCWHaqR3YySwy7DX7LzXlA4KrSPM4/nVcLR69AsAk
	 bRlJTvYLobE4+bQneQ4jT37dhtIRKu4UC9ShjVhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfGLVnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:43:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39187 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbfGLVnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:43:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so7369582lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rA/D9rY58/fs5DfTPa47BWI/CnDv7aS+U9/i6ol6Kl0=;
        b=Cphumg8FZZER15DDsn3kaYIQANgwhplUMjNh/pqNRj6gToXQ/GVl8MR68I3meplHQg
         TqJs+nOhGg+gMhTBuoUH66mslKADOJ7oyz0mWM/A5Lp8zf6S0KbxV11cca+M493uK4iu
         eLJ3tqhswkydmJIMNrR1hPmG1n5Bf5Y2DVIiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rA/D9rY58/fs5DfTPa47BWI/CnDv7aS+U9/i6ol6Kl0=;
        b=ER+6W5coAjLuml2vkW3ESWFWQ4y9QD/VAdwJ6cayhu/KeJmRy6x5+THjm2g0FXnzQw
         oMwNq34VXq8UI8p8YcBctBaotTFr2EdmXQcIJSY/y7dlVlL/7Jbxw0VF6dSC0OWOSiCN
         fqxMYw4an5afRGhH9IPz30AvV0TjIjEdHiwu5fq7/Yx7SU92IsTYjVKVmpfgZFfWBmux
         gaKgzrIuqzKo4tIOc+ZXL0supKDX1KCvbl40JKE6aY7J4lNddqiCF/Y37jBZwfug/6q5
         ze3Bgs0JCsZ7WViyTn5hQjY3s0Z4FWHZVc5uFECo2OVgJYxZLDR7xfhcAkHHWuUbAIto
         o5eQ==
X-Gm-Message-State: APjAAAXm5+CYJoc04r/w51neCtCPCj/BK/kP72SdveVGr3ylQAuhL94C
        siNokkmwv4Hnx+xLoPC9SLGVrK+pjwI=
X-Google-Smtp-Source: APXvYqwB2qIC/urb0lExM+17/78vuIkR9QDdDO/p+7KF8AX8sGIOz8nP6eF2YEyMbhw0UE+pN6Pe4w==
X-Received: by 2002:a19:c7ca:: with SMTP id x193mr5650098lff.151.1562967827022;
        Fri, 12 Jul 2019 14:43:47 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id v202sm1263373lfa.28.2019.07.12.14.43.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 14:43:46 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id m8so10672974lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:43:46 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr7251964ljk.72.1562967358233;
 Fri, 12 Jul 2019 14:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190712035802.eeH5anzpz%akpm@linux-foundation.org>
 <1562935747.8510.26.camel@lca.pw> <20190712141058.d8fd55c910dbdf6044fab2c4@linux-foundation.org>
In-Reply-To: <20190712141058.d8fd55c910dbdf6044fab2c4@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jul 2019 14:35:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whd4=Dj8MY=z1DExJuJMF3zWswLwNyOQhSEzqPiFhPj-A@mail.gmail.com>
Message-ID: <CAHk-=whd4=Dj8MY=z1DExJuJMF3zWswLwNyOQhSEzqPiFhPj-A@mail.gmail.com>
Subject: Re: [patch 105/147] arm64: switch to generic version of pte allocation
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        anshuman.khandual@arm.com,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>, deanbo422@gmail.com,
        deller@gmx.de, Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ley Foon Tan <lftan@altera.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Hocko <mhocko@suse.com>, mm-commits@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        Guo Ren <ren_guo@c-sky.com>,
        Richard Weinberger <richard@nod.at>,
        Richard Kuo <rkuo@codeaurora.org>, rppt@linux.ibm.com,
        sammy@sammy.net, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 12 Jul 2019 08:49:07 -0400 Qian Cai <cai@lca.pw> wrote:
> >
> > https://lore.kernel.org/linux-mm/20190617151252.GF16810@rapoport-lnx/
>
> That's already merged - it went in via the arm64 tree I think.

No. Only the arch/arm64/include/asm/pgtable.h part got in through the
arm64 tree (commit 615c48ad8f42: "arm64/mm: don't initialize pgd_cache
twice").

The arch/arm64/mm/pgd.c part was missing.

I think I fixed it all up correctly.

                Linus
