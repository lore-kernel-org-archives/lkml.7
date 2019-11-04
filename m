Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537ABCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AFA214B2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEkD0RxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfKDQoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:44:55 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38504 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDQoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:44:54 -0500
Received: by mail-vs1-f66.google.com with SMTP id b184so7877565vsc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q70jm26u9XZ544CMir5SgVhhn3tMv2fVqzMb9N7sOwo=;
        b=qEkD0RxP0JDg+iMZcotgM/qHTN7at2kFFBokdWdXqjYduM5zyOwEzb2TF5aPwnGyJ3
         GT34egYWkFkybFCyXjpeUOgGUtHsLdMnwR3r/tcosjVnk2TPjaMxbZ3zqxLuzq3Q0RRF
         Oh6wfgCq2rIMgP+jt++OGpp1ISqo7UHu30guV7cm5uCCX+H4r4MBigW/CgWaNmLW9VJq
         2/gTPJkjrgjcGtP0nhe7qgw9AbOTU6CTmiss7csboTA+BTH/G63RbPHj+XXDW3dCA7n6
         TjIEjff1vDHSp3oHMOdERptntr71iuv2O2Oj7Sgb9b+R9FJV11RdWSg+4F/Tl4xy3wDJ
         TjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q70jm26u9XZ544CMir5SgVhhn3tMv2fVqzMb9N7sOwo=;
        b=CzAyq88b+3vGL8PN4Ja/lgvQn4UUzcJz5gH0kEDamvEnpVp7hQtzCk259Q6D25lvZa
         A/OYe5BZbpOVw59PLH4Pa5qRqgVeQlWnG7+m20eHsApDHkSPGFnqSeXte//bopujvjor
         N/PY/FtJZkvnXrpMTz3eGhX5RDm1XIpZINvXvu9iwyb3pUhuDLohdg6vkPBONNg7SlyK
         c1F31d/Qx/C++4Sh9JFu9hn6qUJEnYTzz4TrngP9ZVrhs725LvEAbtzPrg/EMbFGQV2Y
         kcN+qKqKlDNOgd8ycaBLa6r1TW0Z9fipcvOD9ECMJ8kM5dzslwyR/ZVFcsiMe2YHl7eX
         PXuA==
X-Gm-Message-State: APjAAAVHkYuIVd7IcJaV6Ki4i4bU2B5JN0XEBBoXGF/ztAGaCdCWru5l
        1a8foIuvgTx6BgjceaaHljGTkMazNqLVN3kBhSqTAQ==
X-Google-Smtp-Source: APXvYqz99RRfqGSGz1y7Naug/FRS2hfuYbKBvPPaSvNiJXzefuD28R3923vYy3sTY07Eql7i/9jWqya1BNOh2XyJLNc=
X-Received: by 2002:a05:6102:2041:: with SMTP id q1mr13051687vsr.15.1572885891823;
 Mon, 04 Nov 2019 08:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-5-samitolvanen@google.com>
 <20191104113929.GA45140@lakrids.cambridge.arm.com>
In-Reply-To: <20191104113929.GA45140@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Nov 2019 08:44:40 -0800
Message-ID: <CABCJKueiLpJTB3Vv7EpuQc5mn-n5k2x12dyXsuBdvbp7dDYm=Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/17] arm64: kernel: avoid x18 __cpu_soft_restart
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 3:39 AM Mark Rutland <mark.rutland@arm.com> wrote:
> Trivial nit, but the commit title is missing "in" between x18 and
> __cpu_soft_restart.

Oops, thanks for pointing that out. I'll fix this in v5.

Sami
