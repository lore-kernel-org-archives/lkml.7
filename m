Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BED0C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3612D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDKKSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:18:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33736 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:18:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so6442300qtb.0;
        Thu, 11 Apr 2019 03:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DHhgBXQ0z77tvZpUH6fOOpqgWzNNEa0UaCE/Q5ZlQE=;
        b=meZe+6e8naF5ZEwaoSbUIs9VlcvP55hQaDlWcY3U6s9f5qhf0oXLxF5/MIhMSjASO9
         fbJVKZ5cRCWo2WPuvAh0fBu7DA2BV9uy0/MsLvRUOsfU9RqZqyHD1W/gz88nZWHRt8U0
         fE02LDqqRRAXeF1WFOi1H6lyTXQ7rU7Ik0yAe4uzI1+Uyz9eHDOZUTL/ofEnDVDx5ANg
         ELEiEdseVMCCT0RDJ1PvYDdcF79B52KXJJGQwR3iawZfmh3JFA0G/nq8TQAnWG1ndfVH
         ZTJgKA0Rb3bSDfngKgpqNXb1XCSwu2mJ78aEjHlAPxI48I1jr4Vphsx08nwXcIaWrGMv
         2UaQ==
X-Gm-Message-State: APjAAAX/GG5jgsoDrCEVZuIcbhtVB9vvzxaDyfufEYQj9Q7IGY04B4IO
        QNROK1FprVoNsmb8+/cB8jKUjLZRwD8fzulnLK4=
X-Google-Smtp-Source: APXvYqzxGzPRVsikYtH/R8v51echGOnwOUuchObZERN7Vqz5/vGF176FNxASc8nu9q2YfppJz5wcv3MpttbK5iZf108=
X-Received: by 2002:a0c:e014:: with SMTP id j20mr38802961qvk.172.1554977929444;
 Thu, 11 Apr 2019 03:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de> <CAKwvOdnZjj_FRQkAqmmmMcG=s+TGFXqQS5-ZhT2E9fcGu-nm8w@mail.gmail.com>
In-Reply-To: <CAKwvOdnZjj_FRQkAqmmmMcG=s+TGFXqQS5-ZhT2E9fcGu-nm8w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Apr 2019 12:18:33 +0200
Message-ID: <CAK8P3a3bn8yWHfhwppXdTfkyy7_uM=_OySKahoQtOyBxBT5QoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: only build for new CPUs with clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:20 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > llvm does does not understand -march=z9-109 and older target
>
> Please file bugs for these in LLVM's issue tracker.  It might be
> possible to enable these additional architecture variants if they're
> similar to existing ones and simply unrecognized.  IIRC, we had this
> issue with armv7 variants.

I really don't see that as necessary here. While generally speaking,
it would be nice to support the widest possible range of hardware,
and it would not be hard to add this support, it seems highly unlikely
that anyone would actually want to use that in case of s390.

The last enterprise distros to support z9 were SLES11 (end of life as
of last month) and RHEL6 (ending its 10 year life next year). Anyone
who is still on those releases will probably not install a brand new
compiler, and anyone who is on newer releases won't run on prehistoric
hardware.

Debian still runs on very old hardware in theory, but even there you'd
have a hard time finding someone to test the output of the compiler
on an old machine.

       Arnd
