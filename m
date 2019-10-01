Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D2AECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5006521855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tP7kQ9mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfJASAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:00:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33167 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJASAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:00:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so2172269pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrPCibXZ8aAVlYeWu3qzUI+I4f/2IsCgC/T/cZwtUTk=;
        b=tP7kQ9mFk9GH83DD4Wn7w8bkC2bvSljjKeU02a8Ws9I/OYWSsc6I77CXb3DX8fKZ3Y
         uSiRydgZIuYa5+LNm0P/n1NC/j3RE9nl3yFtR3evY8dySp4mAv8FZHaVm03nLvysHSRw
         +S8bnOuLMJdRsQwaDpcvGUhY6rQo8oKkgT6pNIL8I3CrSef8L19AJraS9IWX/wr03g19
         Z8h6MQLFqYMCz6v/A4QO6EDDSwfq8sq1ZkFQAoQVWhRd4/7MRaBv3BByYgeyEdxwVB0o
         S8+cVyjvrip1SyEKNjzCZgx3HNFJCcHvrc8CTFr5GQEAa3ljNPfZ94BpEmNhIPLuJViz
         VyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrPCibXZ8aAVlYeWu3qzUI+I4f/2IsCgC/T/cZwtUTk=;
        b=GJmCaSqE19uWe2zll5WDKWqG60+elqs+Lpybfrj0mpmzG82G8ZXMomrOy6UVrPWowP
         cnUIrNO8uVphaBf74n1hjLTn379u1C8QhqafOk00HALZRy1D6votI8IjmIpbNvZKjqBb
         VBvM+ZtbxT/nQeCQV2xXONZ+iDR/o6cuILsI2cqmyNPRPut3uD1bYxY6Mo3jboF17T+p
         15z+QyHMRxft3TRImRFRXbmf2HX7jBXDK6radJKXqx48Fp1eBFjjSBNAzDlV7bKjTmTf
         BNA1txGVByTHE8rqvMjHffIGIl9Vkj7j1WrwkCORWUuTmaQMZ5/nYX8VFztiUqr5RPoa
         7d8A==
X-Gm-Message-State: APjAAAWzPh4+bGcTYtzydr0SyR+RFnrD7Q8jnnTKloUXbLozfb6Kh/M9
        EpwuRaVOACqQ8woBQiM+0Z8dRnsk2KI/pnMGsRrrYw==
X-Google-Smtp-Source: APXvYqwYNCvEPHPmb+tyytchKsZjMGzhL9IBjNboIg7WvPbiYbOhSRJ0ENEMO+ep9ULQ6v9Zpf55jzuTzQTkRZD7kEo=
X-Received: by 2002:a63:2f45:: with SMTP id v66mr7764492pgv.263.1569952822500;
 Tue, 01 Oct 2019 11:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
In-Reply-To: <20191001175512.GK25745@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 11:00:11 -0700
Message-ID: <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> > I apologize; I don't mean to be difficult.  I would just like to avoid
> > surprises when code written with the assumption that it will be
> > inlined is not.  It sounds like we found one issue in arm32 and one in
> > arm64 related to outlining.  If we fix those two cases, I think we're
> > close to proceeding with Masahiro's cleanup, which I view as a good
> > thing for the health of the Linux kernel codebase.
>
> Except, using the C preprocessor for this turns the arm32 code into
> yuck:
>
> 1. We'd need to turn get_domain() and set_domain() into multi-line
>    preprocessor macro definitions, using the GCC ({ }) extension
>    so that get_domain() can return a value.
>
> 2. uaccess_save_and_enable() and uaccess_restore() also need to
>    become preprocessor macro definitions too.
>
> So, we end up with multiple levels of nested preprocessor macros.
> When something goes wrong, the compiler warning/error message is
> going to be utterly _horrid_.

That's why I preferred V1 of Masahiro's patch, that fixed the inline
asm not to make use of caller saved registers before calling a
function that might not be inlined.
-- 
Thanks,
~Nick Desaulniers
