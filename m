Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9595CC31E41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3C220872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDkIXhZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfGKRQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:16:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42693 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbfGKRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:16:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so3357131plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCizNin/YuQ8CqFX75d8uBly25uZLZWRMwnAi+o26d8=;
        b=mDkIXhZDwmAfFt75IUi6h+IS+ueAuxHBdiqTKeKrZVFrNA1vDM495IZLbRasMReS9B
         0B+tu/TZrug73T7zVlHPsmzJKnHRaZhR1T0Xyhp8uiAHroHrxDhauOxrM6dtguzXEGfA
         vmmI7gxQqCyq8iBVJ1YZ9ITf8Z9Mu8B5s1ux6EdAjYpRjNpr35dBTesy3Mg/AMGq0Jd8
         dh6VQSIXUb9+5SRfu+ZWQE2BmU8oVgi0tDM7E6q7TCup0r5pKrddHpi92sJtkWJfX7a0
         h7h5+RcJJOArAIfQjvM9lqj/n7BCh5WeDau6otU3NskqphB816ftN2cVrUZxLZd4t7Aq
         7Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCizNin/YuQ8CqFX75d8uBly25uZLZWRMwnAi+o26d8=;
        b=mlEa0OYHjlkijkVnmtWZRLGlydDDPuTKXIpt6aXGXgrKc9ttN7zoSC5ImLqPBEeVUG
         h00nSJju13anDrZEEdB5KXBT+1wZZnElJHZMjr6h46m4RToJ78ptZnv0ostD4ZM18Pz2
         yeup0Q3s8fO9Kb4QJjF5D4yCITl/wGCAUxQtieO2Fx7C3Wej4Y46MYs0OXHL0BQ4vlrU
         16eORCt9L+2/bCItaOtpV0mFVmdQSXleHnvqY4dYVmUqLgFlEgigeaewkLArucRnbTu8
         8u/jrv9zzBELp0GGOCjTuOlDBWvOFp07NGFFbFtwl/2hRV72MhiNgM+8da1shWfzGPkL
         QuiA==
X-Gm-Message-State: APjAAAWVHSbtASW+tAKaPrmFqJ72sc8Avx9PEI6fiZVbk+5bOAAUYU8Z
        lTb4EFcSmMdqa0CT9EpW+W0sHGS+GYWHBKRMgR+7uA==
X-Google-Smtp-Source: APXvYqx+LKdPWY7QUEwDHjZ4T8lEaM4hx232WgllbGz/r5PjAl6YmOZzCwbLv8i25PkI8phRZL4RlpXGPVWWtpDKC1A=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr5789107plq.223.1562865415492;
 Thu, 11 Jul 2019 10:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper> <20190711133915.GA25807@ziepe.ca>
In-Reply-To: <20190711133915.GA25807@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jul 2019 10:16:44 -0700
Message-ID: <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 6:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> > Maybe time to start plumbing Clang into your test flow until it can get
> > intergrated with more CI setups? :) It can catch some pretty dodgy
> > behavior that GCC doesn't:
>
> I keep asking how to use clang to build the kernel and last I was told
> it still wasn't ready..
>
> Is it ready now? Is there some flow that will compile with clang
> warning free, on any arch? (at least the portion of the kernel I check)

$ make CC=clang ...

Let us know if you find something we haven't already.
https://clangbuiltlinux.github.io/
https://github.com/ClangBuiltLinux/linux/issues
-- 
Thanks,
~Nick Desaulniers
