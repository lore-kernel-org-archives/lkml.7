Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB72C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8245F2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jO0olwCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfDJPpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:45:08 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44197 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbfDJPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:45:08 -0400
Received: by mail-ua1-f65.google.com with SMTP id p13so922180uaa.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOOzgOmnaW9PWM1ThtEHEbDTMZ3kGVHOn2+NNi5Gr40=;
        b=jO0olwCUmQkkI1+UF+TH3pc/VdIW42NCfyqi4pVYh0vexHpxwwY110t7HxlD3kSVrQ
         RHuZDOs8QheyCF5zbqqnai3cB0/tAjohu+Hdrzm2D58eUSaMZuirE6al7j5xLaNTnGYx
         TD+k5xm7dte+cGWrAZkqXLB5WF/TcuCWzHld4/qSq8RNmoLTsSFWfo2GbSddF4IWwgKR
         11LVYFGEAJmSoqg+tvdwmb2bBuxXnS8tBGerYJPG/39vD2iZZtiClf+aSSyozDzUIKS9
         a6Lzz2GFyxt5Ez0+ld/Z/7G9Iyf8sDTgwVa1cn2iBy82VCYnLJbitOTc9hKh2ub+WOl8
         eRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOOzgOmnaW9PWM1ThtEHEbDTMZ3kGVHOn2+NNi5Gr40=;
        b=fb0DeXsCAvnFRInqsQkk+h6uKJqLEvy6QFL6ileyX5ynnx6ZQzP2OOwYPBuW/R6Q0u
         VN5SWja4ARZ1uDoJshaqIe8o2fAuz61i2ElwjVm9vIyVJ1BFcaUSP+cFGfnRC28JgWDa
         zKo2WW45x2SZVOeb4lOsClemc1c4idl6PtuPp021rqX3r1Wg7AyLCblt5sh5scVBwmW1
         hrUSqFTMooBs6JQHOvXN5GTMK1t+sezprYIl+lczBLWkau8kwCZBjX4tCH25jxdT9PDw
         Ew7YVMQ1x7Sk55Bumb2aqSJvK+pvsIahFxF0GAZVYvPLF7Rs5Bh+wEjcK9K796/I7aqH
         ojXQ==
X-Gm-Message-State: APjAAAWRPY4f4LXkgFbE8n4x7wvISvM5/OjkdovRBLpiIwlBIrA3AaW2
        MWgVp+KYT+B9PYg4vJdeU81LLjVRF9BXGl1tXtbOkg==
X-Google-Smtp-Source: APXvYqw0TI6DnAqeMlVRPllfSCLVHooW+otPIG1dlwODTmK+smWDmG5Y1DN8DH9kflLZ4gQiLHA/ylQEgFCoCVv/w/A=
X-Received: by 2002:a9f:2c09:: with SMTP id r9mr21462395uaj.56.1554911106679;
 Wed, 10 Apr 2019 08:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190320163116.39275-1-joel@joelfernandes.org>
 <CAOesGMheoZda84OSz9spQ7p66wot5S_9aaqaKC=QYp+8utASXA@mail.gmail.com>
 <79b6bdbc-890a-5a51-7fa1-aec57889046a@opersys.com> <CAOesGMgGFunOeMt93f57fPspdDSHp2twahhudEDhMvZ=VPJHaQ@mail.gmail.com>
In-Reply-To: <CAOesGMgGFunOeMt93f57fPspdDSHp2twahhudEDhMvZ=VPJHaQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 10 Apr 2019 08:44:54 -0700
Message-ID: <CAKOZueuQFiUVA2N0jj3cb6WkN1AjwDz2C+Q85W_spcjyMLYmjA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Provide in-kernel headers to make extending kernel easier
To:     Olof Johansson <olof@lixom.net>
Cc:     Karim Yaghmour <karim.yaghmour@opersys.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Manoj Rao <linux@manojrajarao.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 8:16 AM Olof Johansson <olof@lixom.net> wrote:
> Anyway, see my other reply just now -- CPIO + a filesystem view, and
> providing said cpio archive in debugfs for those who want to copy it
> off themselves might be something that fits everybody.

I don't think it's worth increasing the complexity of the kernel for
the sake of a little userspace convenience. By including the headers
in the kernel, we solve an important coordination problem --- but we
should solve this problem in the simplest possible way, pushing
whatever complexity possible to userspace, which is more flexible and
which evolves faster. Providing a compressed archive is fine. The user
burden is not large: it's just extracting an archive from a standard
container format. The kernel has no special advantageous way of doing
this job. If userspace wants to cache extraction, it can hash the
compressed archive itself and use the result as a key: it's only 3MB.
But extracting the archive every time is fine. We're not talking about
a huge amount of data, and I don't see a need for the kind of
long-term caching that would require revalidation.

As for cpio vs tar: IME, people are much more familiar with the
latter, and they're both omnipresent on unixish systems. I think it's
fine to rely on a tool that's been part of POSIX for over 30 years.
