Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31987C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99CE20665
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yLbcUFVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfEXIPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:15:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36861 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389160AbfEXIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:15:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10so6443749lfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pY20TLIKVkI1/Bl2d5BcPoMjZP1eL0jlGVq4XWFCLqw=;
        b=yLbcUFVUKHOR54BpTzOG46y3ETP7QeyZEj3PxIvxlmWXhu+p3XLcJfFXKnkco7NJEd
         OKeoWywqIAob+YJUoOUQtJkbOuABUegFkduX0AfOuvdmxruzZjtEjeby+ZBqbQIoKov8
         RZZ7uIDhZJ1ql/XGJljY32KPbbpSJG+j1Yxpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pY20TLIKVkI1/Bl2d5BcPoMjZP1eL0jlGVq4XWFCLqw=;
        b=Ate2Eo3vVtf7OIxFjOjR3qr6xBcO6NU4Fn/kdg0AKMIb9lZMskNDbOTUyD+D0vMFTQ
         ZYEV7k40BptUgac5LL0B/xLHjo+3d+gmut2bnaWldSJ7SD7QNxf+CGIqbz3P7Ufny5SI
         vXc/Ws9xurr2ZaUv80QSVWVWpQ5A/FvzqhphgHmRPR41WBxgOk01fzqL0jC4ZBlUD9MS
         LpYhrr/jqv4jv7uCI0DJAIXILVblvXuFVe8HaFOkayFPXuK2Jibn7NOOCsKSQsUAvJbU
         59m43Z01SS4r9kOxilhdB2DcDk1nFmUZ8jeQyUIAXjPC2b9GJdjOcy91dA4tmkeKgZRl
         lxqw==
X-Gm-Message-State: APjAAAXJzkKZ/Abzl/MzHEjvfgDkMg0YlGDpAXgd/nLBqrRflKZsyXTT
        ximfgVSNe1wwY3wPYNlaorKZeKjrprIx8zWjYHRujw==
X-Google-Smtp-Source: APXvYqzVMi4pg2qRCfQfJd5BsbX8em3+Hdl2SMJgN+BItmMDwe24Jng0frtTTmpTZt9GG9xJXeqVFKyK1swQ88DNA7Q=
X-Received: by 2002:a05:6512:507:: with SMTP id o7mr29687719lfb.137.1558685729981;
 Fri, 24 May 2019 01:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190522114314.515b410d@canb.auug.org.au>
In-Reply-To: <20190522114314.515b410d@canb.auug.org.au>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 24 May 2019 11:15:17 +0300
Message-ID: <CAEXW_YR99jkobkTUJLKjX-swR_AVYrjFzQcaD8j1JuZZ=dK9Qw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the pidfd tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 4:43 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>
>   kernel/pid.c
>
> between commit:
>
>   99e9da7f2796 ("pid: add pidfd_open()")

Fix LGTM. Thank you.


>
> from the pidfd tree and commit:
>
>   51c59c914840 ("kernel/pid.c: convert struct pid:count to refcount_t")
>
> from the akpm-current tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc kernel/pid.c
> index 39181ccca846,b59681973dd6..000000000000
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@@ -37,8 -36,7 +37,8 @@@
>   #include <linux/init_task.h>
>   #include <linux/syscalls.h>
>   #include <linux/proc_ns.h>
> - #include <linux/proc_fs.h>
> + #include <linux/refcount.h>
>  +#include <linux/sched/signal.h>
>   #include <linux/sched/task.h>
>   #include <linux/idr.h>
>
