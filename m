Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FBEC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E872245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvjmPGaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFWuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:50:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41124 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLFWuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:50:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id bd4so3321954plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0riUqAQ9KJmR0KLv8Y1JmTN4AxBmbDidTAabyI8WLM4=;
        b=CvjmPGaHYt7Fk59w4IG3gtg0H9jfBUJVTLvrLXYNwz4/vYsyQCo/BqVFbHMBCdohie
         m1wjjW1JIZrxT+rnv7yLmtkImyIg8S3FR4+/tTZHVh8rx5vH/OnbKrjhrEeh8s5lbga+
         wcEAeIvHfLLKUZzgERgHazKD/Fv0y4D54zAo0Yx08lw89jvflreRxCzTt8doK3NjGW4Q
         sJV3nNzOfX9/WTfasTD9cp+KQRGRIG3smUZFkjF71SFrlpTzMmFPjWFUdLo1ae+BdoP0
         LsrWqzgOKTnDXeuoLdREH0M3rq6+DTRfPjXrPYubssoe+l+m59gmOpRwDv4j+cTH+X5e
         1a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0riUqAQ9KJmR0KLv8Y1JmTN4AxBmbDidTAabyI8WLM4=;
        b=TJjMt7f4HZ6iRDjA6wSZ79furNxrnyr+ZJCNEbpmmCKYzVeau5oWIVd8hnGuicwEy8
         jz7UymljZtU3eAstVV1p9extfv0ILbolM6rmorpBPs+pxHBmTv28n9/P0RytYAVuR5M+
         C5ZthcH5/yjQ2KQammyJ+/pzXzogFsNAVocVaJcdUcWVM2ttqPlG4/cqNOa6HS/sVYr4
         oMhCzLYUkZ9dxVpbI3SQuydBWkjVv8m8lNeIC0rfGfDjG/PNzhuGWd+C+lYbwc43mz0M
         MomAxEKnIzw7DSnNeu2s8DRWbG4S35L0vY5/qHv6qRaIIz1k/ut27S5FENQxYqbwWY07
         YDFQ==
X-Gm-Message-State: APjAAAXMn6SpnTrT/7+2fio4cXP6kynHl5yAK8jchkr3ZRRttTbPWzpQ
        PfBXo3FcTCRDKZRvKRWpMMlscn3JxljyLwbov+6upA==
X-Google-Smtp-Source: APXvYqxZb3qZLhT/tPljxS+wFVdxBrtjVSf2AfNUhesSCCcb0yeSN/+DZmHjqUhdO00p3A87s0OdCw0SaLG7Ya7glf8=
X-Received: by 2002:a17:902:7c84:: with SMTP id y4mr16526668pll.297.1575672606927;
 Fri, 06 Dec 2019 14:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-3-brendanhiggins@google.com> <aa7b77aa-bf3a-6919-ed66-37af00d856d2@cambridgegreys.com>
In-Reply-To: <aa7b77aa-bf3a-6919-ed66-37af00d856d2@cambridgegreys.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 6 Dec 2019 14:49:55 -0800
Message-ID: <CAFd5g45_PaL_rSbhrUD1RJ1ZWasptG+z7TO9_B4-Qafs90L2KA@mail.gmail.com>
Subject: Re: [RFC v1 2/2] uml: remove support for CONFIG_STATIC_LINK
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        johannes.berg@intel.com, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:41 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 06/12/2019 02:01, Brendan Higgins wrote:
> > CONFIG_STATIC_LINK appears to have been broken since before v4.20. It
> > doesn't play nice with CONFIG_UML_NET_VECTOR=y:
> >
> > /usr/bin/ld: arch/um/drivers/vector_user.o: in function
> > `user_init_socket_fds': vector_user.c:(.text+0x430): warning: Using
> > 'getaddrinfo' in statically linked applications requires at runtime the
> > shared libraries from the glibc version used for linking
> >
> > And it seems to break the ptrace check:
> >
> > Checking that ptrace can change system call numbers...check_ptrace :
> > child exited with exitcode 6, while expecting 0; status 0x67f
> > [1]    126822 abort      ./linux mem=256M
> >
> > Given the importance of ptrace in UML, CONFIG_STATIC_LINK seems totally
> > broken right now; remove it in order to fix allyesconfig for ARCH=um.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
[...]
> The ptrace check was discussed on the list this week - it is the enable
> constructors commit in 5.3-rc1.
>
> A patch reverting it was submitted by Johannes yesterday.
>
> I did not try disabling/enabling static link - good catch.
>
> Otherwise, I agree - static link should probably go.
>
> Adding PCAP throws even more warnings and the AF_XDP work I have in
> progress generates a whole page of them. Considering that the resulting
> executable is not really static there is no point keeping the option.

Sounds good. I will send this out again as a non-RFC patch.
