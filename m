Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9466C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967E320883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C372Ku1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFYWSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:18:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36408 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYWSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:18:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so134673pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awYKMTwppxDTR6NBxb7uirnj6XnB7PgoXZkf4dMINis=;
        b=C372Ku1ZgFRNfC9cCGooCD+UNHGZ1H8hEY3/fKmk7Yxv4op/f4FYDkT8fIvnMn+RoF
         MwYC6cnSqKMHr5szUV4KjKSo3KoOr7O3R8UPhnL74TqJWVCDrlBu3bid2tR48jyE2piO
         ITZkjVhRjNeQISKSNyKc0SNsU39N31UnmbEIdCQO+2F6qmCCfV8T8Wx2K8tAyNJuul3j
         AzFn16lgCgqdyZ5Bk0kD4V1An8YjMu0ubj5cyvjtokRLNKCs3bUo31PrToRYnR3zwLut
         AX3q+6gMK6LbyXyoF1LzaS61gap1dAKURQHPVGIfic1R9FRTgSWXdoPLD1oBW8DMaPxe
         Gx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awYKMTwppxDTR6NBxb7uirnj6XnB7PgoXZkf4dMINis=;
        b=toULtnjwGc+4p/f+RK0sYK8mjDG9f5Q/EKCDN+nVBot2zjwTHjVmM2NrC0vYfBjlDR
         LEsPi+ga/dLuJmn9wmd9yEXUwWepnnC169qEo6YTrQv/LQpFBVSs+ffGk3USX9VnJBcH
         Wa2nsnNNb0Sgk6T502d149U4mgH7pOxMnIf3W71365kCib+EC6nM6vs5R2ZI8jUmr1Cd
         SyubFwrjhIu0/hl0D8bvBBlHrQcIZAKkv0z78r6nrtVJZt7XWSUVtU50DmDRbjHu2DvC
         XsFxTnEyFz8vdoQHthrVY1LSQ5n9g9MBl6NJxJo84gDQCaCdrf8L3bQkv14hYldqIIgK
         yCwQ==
X-Gm-Message-State: APjAAAVaJ3ju8jb3ofBFUMiHBrbEWY2zzktCZB9XWuttBV3LLoanz8XP
        sMTCrF+7zVHZmpzcNkGDuRqJ08k3+oCZUTqtZo4wuDTzJODawQ==
X-Google-Smtp-Source: APXvYqw+q1fIASsmhBvTDOZ3GTmyUIocToZu4yXDv2KsVbBwQYDwrHYv5lWJIra5LmSUZY8aMZSdaee5y0LGjN6CNqA=
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr212067pjq.134.1561501125656;
 Tue, 25 Jun 2019 15:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
 <20190617222034.10799-8-linux@rasmusvillemoes.dk> <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
 <12bd1adc-2258-ad5d-f6c9-079fdf0821b8@rasmusvillemoes.dk> <CAKwvOdkqy8=V17qEM_SMDEAh=UX5Y2-nj9EUkC169nEiXc_JzA@mail.gmail.com>
 <70aa7b96-e19d-5f8b-1ff6-af15715623e5@rasmusvillemoes.dk>
In-Reply-To: <70aa7b96-e19d-5f8b-1ff6-af15715623e5@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jun 2019 15:18:34 -0700
Message-ID: <CAKwvOdkWo5yG7LrtGL_ht-XHFgNqx_t6rP+hHhcPyb+Ud1N+HA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:35 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 24/06/2019 23.53, Nick Desaulniers wrote:
> > On Thu, Jun 20, 2019 at 1:46 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >> Well, apart from booting, I've mostly just tested that the debugfs
> >> control file is identical before and after enabling relative pointers,
> >
> > mainline x86_64 defconfig+CONFIG_DYNAMIC_DEBUG
> > $ cat /dfs/dynamic_debug/control  | wc -l
> > 2488
> >
> >
> > mainline x86_64 defconfig+CONFIG_DYNAMIC_DEBUG+this patch series
> > $ cat /dfs/dynamic_debug/control  | wc -l
> > 2486
> >
> > (seems like maybe 2 are missing?  Let me try to collect a diff. Maybe
> > 2 were removed in this series?)
>
> Hm, no pr_debugs should have been added or removed. Perhaps you have a
> slightly different set of modules loaded? Otherwise there's something
> odd going on, and a diff would be really nice. It's possible that the
> order of the lines are different, so you may have to sort them to get a
> meaningful diff. (A diff is nice extra sanity check even if the line
> count matches, of course).

You can fetch my logs from the latest commit to this dummy branch:
https://github.com/ClangBuiltLinux/linux/commit/90096d926aaf94eb84584a4418fde7c8d42dddea

Looking at `meld wo_patches.txt w_patches.txt`, it looks like:
1. line numbers in some translation units are adjusted.  maybe this is
intentional?
2. pci_pm_suspend_noirq seems to exist twice(?) before your patches, once after
3. xhci_urb_enqueue seems to exist three times before your patches, twice after

-- 
Thanks,
~Nick Desaulniers
