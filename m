Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBFCC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB99206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPJlgbNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfG2Upr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:45:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47049 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbfG2Upr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:45:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id c3so5474735pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMrEHRmz/SUwhMpEhzoL0Mw6xHn5eIa1ccchwHTfCGg=;
        b=WPJlgbNETipOyujtvKlH6HINt+YFjSa9gIvaQ65HBAN1terVNMqFdGfYjK9JTqalZP
         CTfan8DoLaM9dEydbVrYnrw3wyespEYa/zlntrZle7b4z2W09X/wDDCuqWS2UUqbhJJg
         1Zx4tSK7eXqtwpKxKBNvBgPc7uMUUD/ijctUCPOVT4sSd5lUf4kXTZuo6iHyEpLA3vU7
         dZAdaweB0GNydgKkVAGwGo149b+embU5Riiavkl9V0ax1ElqlMOOkxN8jS6N6/JoXH6n
         34Fujg9hV2KQNRr8s70fbftl5r9c+zb9K7PaC4Wo5aAdsI2ot3DR17Ied4PU9bUvBqbB
         EFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMrEHRmz/SUwhMpEhzoL0Mw6xHn5eIa1ccchwHTfCGg=;
        b=W5iFnxVmnzx6zGVJ5XfxgI5NJc9zufjymQOL5wESp2KQ7NI/OEGkLaF1iL2JNSHNqf
         WxP5uJgU9aXCYaM97VATi3TA9yQoKcs6CZq/xd/49wwKroKT7fYC6bqpVcr9Nyn7GOah
         uHaO1EMdf4bpWgkfr2GM3Y48+gEq7RlwZY/YZTmX37vm8Z+vEOankQAiMNC35pTDW81Y
         E/s8BLZzyzThdOKfNrJs747d0ecyx2vNeaKA70gUgZI975ZNhFBxHXIwLcVgBVHxMTmi
         J3Bauwr+PsWJG9201pHHaZTOEk8B3YcqkcIrdS5UGxssO7/d+Lnpux5/7ngdlxdMzng3
         HXdQ==
X-Gm-Message-State: APjAAAWMY3wY8p7ci/s9zwLyXuJo9PIFfgmutPwRbnD9j+68ZUOtyCuR
        nh5R1Qy4lgRpp7xpBdtFl3jxBcp28nGz7dwSid9IUA==
X-Google-Smtp-Source: APXvYqwRBA++ZLki3FCDkYfIOm4fZxAqwQa+t0nQs1TnfuIBjlaC+SunAk9780W7jSAo9r9g92a851AjfhqU0PQo/9M=
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr115215537pjq.134.1564433146243;
 Mon, 29 Jul 2019 13:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190729202542.205309-1-ndesaulniers@google.com> <20190729203246.GA117371@archlinux-threadripper>
In-Reply-To: <20190729203246.GA117371@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jul 2019 13:45:35 -0700
Message-ID: <CAKwvOdm7GRBWYhPy4Ni2jbsXJp8gDF-AqaAxeLbZ03+LvHxADQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:32 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Jul 29, 2019 at 01:25:41PM -0700, Nick Desaulniers wrote:
> > But I'm not sure how the inlined code generated would be affected.
>
> For the record:
>
> https://godbolt.org/z/z57VU7
>
> This seems consistent with what Michael found so I don't think a revert
> is entirely unreasonable.

Thanks for debugging/reporting/testing and the Godbolt link which
clearly shows that the codegen for out of line versions is no
different.  The case I can't comment on is what happens when those
`static inline` functions get inlined (maybe the original patch
improves those cases?).
-- 
Thanks,
~Nick Desaulniers
