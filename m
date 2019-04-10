Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A473C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218182075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDJTYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:24:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45803 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDJTYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:24:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so3166405ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtE6u2CmznELGPlCVTCwPsq3DHN6UfubwmUZHQ7hukE=;
        b=Ug30KgNvcrO8NeW5kgNoXcpPn8vWVJG3EsQa04V4bdgPnPyAuKQ7Q+NAShdqrSfmid
         YrU8bTNMUKdm7SSTVJWFZf5IJHginZFahV01Y0uYvGmUB7IlqWlFZuApjPP7ukolc300
         d6U/NAaKAMon09b5zxfpCUNeiN9d+VYlsc3fkdEAIh4oTDFgAjaeLeyWJUlE3EAk1oBd
         /eC54FMZVGwRTuMEpR74cmyDArYa7IwxlIJ03gi/9FhFj80Psx3/DqfJeLpkH9ajgsaL
         9WaJwXhtfpnkKLdOHtwnUqQE6yoQn9SjEuJMIDut7XUguBAz3eoIT31icnQxELerg4ZV
         +uGw==
X-Gm-Message-State: APjAAAXoGB6C410/mtGNEjQHcL7gdlnzs7bVskmDTMwUImRbCZ6a1Fnk
        h70aJWo5bShG7s8hyUzO9w6ODiofu/yHdw/Ib6oP4Q==
X-Google-Smtp-Source: APXvYqzdv80NDTGtMIGMaQvkukaFVx5C4001Ihov26htNLdHQ5y8kBxHe9F+QYg4M4YdFSQY4qH2O4cw20fwJuItjBY=
X-Received: by 2002:a2e:9649:: with SMTP id z9mr7319296ljh.92.1554924270348;
 Wed, 10 Apr 2019 12:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-3-mcroce@redhat.com>
 <CAGXu5jKc2q3gnBrJ5JowDvOC_tSR5o9iKuF+JVKMJYWAPOZANQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKc2q3gnBrJ5JowDvOC_tSR5o9iKuF+JVKMJYWAPOZANQ@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 10 Apr 2019 21:23:54 +0200
Message-ID: <CAGnkfhwZEqX03H7PqsSTa=GVwZXX127hQO5YHzJasAEYtpLMZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 8:46 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Apr 8, 2019 at 3:09 PM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > Use the shared variables for range check, instead of declaring a local one
> > in every source file.
>
> I was expecting this to be a tree-wide change for all the cases found
> by patch 1's "git grep".
>

Hi Kees,

I have already the whole patch ready, but I was frightened by the
output of get_maintainer.pl, so I decided to split the patch into
small pieces and send the first one.
Patches for /proc/sys/net and drivers/ are pretty big, and can be
merged after the 1/2 inclusion.

> Slight change to the grep for higher accuracy:
>
> $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
> 245
>

Right, my regexp wrongly matches also one_hundred, one_jiffy, etc.
Anywqay, I did the changes by hand, so apart the commit message, the
content should be safe.

> Only 31 sources:
> $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' | cut -d: -f1 |
> sort -u > /tmp/list.txt
> $ wc -l /tmp/list.txt
> 31
>
> One thing I wonder about is if any of these cases depend on the extra
> variable being non-const (many of these are just "static int").
>
> $ egrep -H '\b(zero|one|int_max)\b.*=' $(cat /tmp/list.txt) | grep -v static
>
> Looks like none, so it'd be safe. How about doing this tree-wide for
> all 31 cases? (Coccinelle might be able to help.)
>

It could be true for other sysctl values like
xpc_disengage_max_timelimit or fscache_op_wq, but it's very unlikely
that someone writes, for example, 5 into a variable named "zero". If
it does, it most likely a bug, so const is our friend.

Regards,
-- 
Matteo Croce
per aspera ad upstream
