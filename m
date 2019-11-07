Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A80214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZ5+6wBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfKGQ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:26:43 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:32900 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:26:43 -0500
Received: by mail-ua1-f66.google.com with SMTP id c16so779429uan.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHVtna/ZK+ShoKE32vj/oIbQxq9UojFvas7d10KE8fg=;
        b=jZ5+6wBUk83wQPpJmxaIJELl84GXA/0+SmIJmGXKvPs+KkSBCCgqHgiiibcWA8tRTA
         HujJfE7DBIWcM4BdMqqm6Hcz+9CU85jfwEisPSpmYX8SNxvApOvMGdldNngt4QFlmguy
         L9WnpbCJuTK9/aD4SnBylkT5OXPccTKbvcPGHh1zNsTtz8OVlthkWe7v5As5buBEZozX
         Jz55FqoRAWXkZ9JM6qJpTKAC26iMxf6eygQfKLebtlCRS+d76RCGYyoBCD/ETzxuMdUU
         WKTMq/WWxlASzp8vUChued4POTmR6TtUPEetUvMBxAXDXrkob1IGUEAmcarqNNHiev2a
         mTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHVtna/ZK+ShoKE32vj/oIbQxq9UojFvas7d10KE8fg=;
        b=lTnRP9DavlWOYC0aqLdSRB6Yj5I1gxFZE5mWO1DTxoRxpd7EUHfMOWnmVSm1LIz2St
         VBxvF306MZpwctHjzhj2bZuHVHJlmO/7niaDPoB4FRjqYDvEGVk1sbaSJRUInGkPfPJk
         QLqfwcrKQk7cUrDtbcjwCuJVD0RUQ2tSDMl0npbY4/gldSE+YrqazPjrNLJRt8MWO5es
         cqNZmpNMU4GU/75FuzSP+Jp3Zj22O9acAMPmCHydsjyKPShHHl5obN1JpUglGn6av4ZZ
         kZtGaOvQiS86gYUhYOGrWaUukGAmyMJ4UkUn0trWJK2IKAzMOicuAWoN+eCLlqajvxVv
         9AJQ==
X-Gm-Message-State: APjAAAVHYor5pQUBe9UrozDllhV0jrAaN7mgs7ArCP/DTo1ebEtrwNmE
        klD0XutJ1dItTfemmoTSPPDVvpshEROPkPHOEZK1Zg==
X-Google-Smtp-Source: APXvYqyLUUrZngxfbpK2EJw4lHfelTLISIcLLsL1NXa8kNArn8q1ZLsKkeVxBc7Gqn8x30++WT7p1IgHdkDpA3Dvs2U=
X-Received: by 2002:ab0:2381:: with SMTP id b1mr2931374uan.106.1573144001488;
 Thu, 07 Nov 2019 08:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191105235608.107702-1-samitolvanen@google.com> <20191105235608.107702-12-samitolvanen@google.com>
 <CANiq72mZC-G_R_RJjapZS+NvkQcrjdiri0NyHUgesFzUpe-MDg@mail.gmail.com> <CAKv+Gu9DD12BPV_jNv9Hjw4oSiZvtdiVVjB-B8WLXCoPL4CA9Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu9DD12BPV_jNv9Hjw4oSiZvtdiVVjB-B8WLXCoPL4CA9Q@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 7 Nov 2019 08:26:30 -0800
Message-ID: <CABCJKuc9sxRRkfieExiFcYu0Cx=ZC=jyw2xXqsoQhF5-46HVDw@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] arm64: efi: restore x18 if it was corrupted
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 2:51 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 6 Nov 2019 at 05:46, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Wed, Nov 6, 2019 at 12:56 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > If we detect a corrupted x18 and SCS is enabled, restore the register
> > > before jumping back to instrumented code. This is safe, because the
> > > wrapper is called with preemption disabled and a separate shadow stack
> > > is used for interrupt handling.
> >
> > In case you do v6: I think putting the explanation about why this is
> > safe in the existing comment would be best given it is justifying a
> > subtlety of the code rather than the change itself. Ard?
> >
>
> Agreed, but only if you have to respin for other reasons.

Sure, sounds good to me. I'll update the comment if other changes are needed.

Sami
