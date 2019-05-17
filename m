Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48242087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukQJJ6QW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfEQPgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:36:35 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41325 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfEQPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:36:34 -0400
Received: by mail-lf1-f43.google.com with SMTP id d8so5644295lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oZcAaE96cSVFWi9Z2GMlWClyPZwgW4ysxzcgvnYID2w=;
        b=ukQJJ6QWk/wEWo45qlJo55ycIMOzrNaD/adNVJiPR6LgZz+jATCHfkKEwDA5e6hWHq
         1oPQQZKdJU+V4YSjNARNb4tzmjZ53aLzUXNsz/agIMwWcs8psk5gVQdTXaRGG0u5HgGb
         oUqtYERB1ptM6flPp0Unimi/ZV3qiNFfql7uAdSPqYGwbielDc/SeCk0JzYCKJeNqIAJ
         Rpf/lEX3lAetp1HdXFi6a7Y9rFbNLj+gQvdnRzhhR4BEKMDQ5jXDavCqgEI0+K34WD34
         qKRdivF0KpiCsHavuTnnTp68NHCkJY5WRlfmpzwwvqGp3uSLg3NQb4Eu1ndB98xRGI0s
         3s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oZcAaE96cSVFWi9Z2GMlWClyPZwgW4ysxzcgvnYID2w=;
        b=LK04AbjQgls7e/krU+M2MEy64dZLAQad+lLDz74PBF6zV4SQEFdo1QlL3tGJZj1YFA
         cxr164mIve6fdBzRU+7UOmOn4b08ra75K7bnlz63+Sc6J6nkBBvrsoOrGKrmPCQpeKbT
         u/SV9T0163gw86gru0T0cYJsT5+0zd1PgMbnE85+t/no2SZ9MA1zLk2bnFxi4Htw42OG
         D2+KzR/+lbAGkJs2BsGrlj8qyGCPTMZGZiHqIaYtJ7qSlCpcP254tIhWKJbyAVWnEFCR
         cmsgbiJg7zc5dVEeq9qgIV1zx1iSMPRvf95Bp0yy5IcDi2w0yBrSNjI2MV7v6tDXy17i
         wzAA==
X-Gm-Message-State: APjAAAUYoe1aUjvZswzuKVpXDkIJqAoCdX83t9/J9786WOyc/3eLrK7A
        jX8M5oR2OOOeXrqszb3LIMZFTm4h3lsCkG/b4aQgsg==
X-Google-Smtp-Source: APXvYqz64d2LvnJfbN5s9Gb1Iyfpq0GgEc7anMX6fK9nGSMysnHpVM4aVTsGauTros3Zi5dYfKdhTRyzoN/v9tBQ1aQ=
X-Received: by 2002:a19:7d42:: with SMTP id y63mr20552876lfc.54.1558107391166;
 Fri, 17 May 2019 08:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z9GcY-d19ROSXgAq4-d_hOBVArfgGV1VdYcYD_X1coPQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Z9GcY-d19ROSXgAq4-d_hOBVArfgGV1VdYcYD_X1coPQ@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 17 May 2019 08:36:19 -0700
Message-ID: <CAHRSSEw7QAfuKsQhHNZcwizn5zEVA6CjAdO7qh69g3fkXrk7DA@mail.gmail.com>
Subject: Re: binder stress testing
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, May 17, 2019 at 3:26 AM
To: Greg Kroah-Hartman, Arve Hj=C3=B8nnev=C3=A5g, Todd Kjos, Martijn Coenen=
,
Joel Fernandes, Christian Brauner, open list:ANDROID DRIVERS, LKML
Cc: syzkaller

> Hi,
>
> I have 2 questions re drivers/android/binder.c stress testing.
>
> 1. Are there any docs on the kernel interface? Or some examples on how
> to use it and reference syscall sequences to make it do something
> meaningful?
> I hopefully figured out struct layouts and offsets of objects thing,
> but I still can't figure out handles, pointers, nodes, pointer to
> nodes... pointer to data (?), references, cookies and where does one
> get valid values for these.

The kernel interface is not well documented since it isn't intended to
be used apart from libbinder. The best example for your purposes is
probably the binderDriverInterfaceTest which you can find at
https://android.googlesource.com/platform/frameworks/native/+/refs/heads/ma=
ster/libs/binder/tests/binderDriverInterfaceTest.cpp.

The libbinder source is at
https://android.googlesource.com/platform/frameworks/native/+/refs/heads/ma=
ster/libs/binder.

>
> 2. In my tests any transaction breaks binder device until the next reboot=
.
> If I open binder device twice, mmap, set context and then the process
> dies, then everything it released fine, in particular the context
> (context_mgr_node gone). So the device is ready for a next test:
>
> [   40.247970][ T6239] binder: binder_open: 6238:6239
> [   40.250819][ T6239] binder: 6238:6239 node 1 u0000000000000000
> c0000000000000000 created
> [   40.253365][ T6239] binder: binder_mmap: 6238 200a0000-200a2000 (8
> K) vma f9 pagep 8000000000000025
> [   40.256454][ T6239] binder: binder_open: 6238:6239
> [   40.259604][ T6239] binder: binder_mmap: 6238 200c0000-200c2000 (8
> K) vma f9 pagep 8000000000000025
> [   40.271526][ T6238] binder: 6238 close vm area 200a0000-200a2000 (8
> K) vma 180200d9 pagep 8000000000000025
> [   40.273113][ T6238] binder: 6238 close vm area 200c0000-200c2000 (8
> K) vma 180200d9 pagep 8000000000000025
> [   40.275058][   T17] binder: binder_flush: 6238 woke 0 threads
> [   40.275997][   T17] binder: binder_flush: 6238 woke 0 threads
> [   40.276968][   T17] binder: binder_deferred_release: 6238 threads
> 0, nodes 0 (ref 0), refs 0, active transactions 0
> [   40.278626][   T17] binder: binder_deferred_release: 6238
> context_mgr_node gone
> [   40.279756][   T17] binder: binder_deferred_release: 6238 threads
> 1, nodes 1 (ref 0), refs 0, active transactions 0
>
>
> However, if I also send a transaction between these fd's, then
> context_mgr_node is not released:
>
> [  783.851403][ T6167] binder: binder_open: 6166:6167
> [  783.858801][ T6167] binder: 6166:6167 node 1 u0000000000000000
> c0000000000000000 created
> [  783.862458][ T6167] binder: binder_mmap: 6166 200a0000-200a2000 (8
> K) vma f9 pagep 8000000000000025
> [  783.865777][ T6167] binder: binder_open: 6166:6167
> [  783.867892][ T6167] binder: binder_mmap: 6166 200c0000-200c2000 (8
> K) vma f9 pagep 8000000000000025
> [  783.870810][ T6167] binder: 6166:6167 write 76 at 0000000020000180,
> read 0 at 0000000020000300
> [  783.872211][ T6167] binder: 6166:6167 BC_TRANSACTION 2 -> 6166 -
> node 1, data 0000000020000200-00000000200002c0 size 88-24-16
> [  783.873819][ T6167] binder: 6166:6167 node 3 u0000000000000000
> c0000000000000000 created
> [  783.875032][ T6167] binder: 6166 new ref 4 desc 1 for node 3
> [  783.875860][ T6167] binder:         node 3 u0000000000000000 -> ref 4 =
desc 1
> [  783.876868][ T6167] binder: 6166:6167 wrote 76 of 76, read return 0 of=
 0
> [  783.886714][ T6167] binder: 6166 close vm area 200a0000-200a2000 (8
> K) vma 180200d9 pagep 8000000000000025
> [  783.888161][ T6167] binder: 6166 close vm area 200c0000-200c2000 (8
> K) vma 180200d9 pagep 8000000000000025
> [  783.890134][   T27] binder: binder_flush: 6166 woke 0 threads
> [  783.891036][   T27] binder: binder_flush: 6166 woke 0 threads
> [  783.892027][ T2903] binder: release 6166:6167 transaction 2 out, still=
 active
> [  783.893097][ T2903] binder: unexpected work type, 4, not freed
> [  783.893947][ T2903] binder: undelivered TRANSACTION_COMPLETE
> [  783.894849][ T2903] binder: node 3 now dead, refs 1, death 0
> [  783.895717][ T2903] binder: binder_deferred_release: 6166 threads
> 1, nodes 1 (ref 1), refs 0, active transactions 1
>
>
> And all subsequent tests will fail because "BINDER_SET_CONTEXT_MGR
> already set" presumably to the now unrecoverably dead process:
>
> [  831.085174][ T6191] binder: binder_open: 6190:6191
> [  831.087450][ T6191] binder: BINDER_SET_CONTEXT_MGR already set
> [  831.088910][ T6191] binder: 6190:6191 ioctl 4018620d 200000c0 returned=
 -16
> [  831.090626][ T6191] binder: binder_mmap: 6190 200a0000-200a2000 (8
> K) vma f9 pagep 8000000000000025
> [  831.092783][ T6191] binder: binder_open: 6190:6191
> [  831.094076][ T6191] binder: binder_mmap: 6190 200c0000-200c2000 (8
> K) vma f9 pagep 8000000000000025
> [  831.096218][ T6191] binder: 6190:6191 write 76 at 0000000020000180,
> read 0 at 0000000020000300
> [  831.097606][ T6191] binder: 6190:6191 BC_TRANSACTION 5 -> 6166 -
> node 1, data 0000000020000200-00000000200002c0 size 88-24-16
> [  831.099251][ T6191] binder_alloc: 6166: binder_alloc_buf, no vma
> [  831.100433][ T6191] binder: 6190:6191 transaction failed 29189/-3,
> size 88-24 line 3157
> [  831.101559][ T6191] binder: 6190:6191 wrote 76 of 76, read return 0 of=
 0
> [  831.110317][ T6191] binder: 6190 close vm area 200a0000-200a2000 (8
> K) vma 180200d9 pagep 8000000000000025
> [  831.111752][ T6191] binder: 6190 close vm area 200c0000-200c2000 (8
> K) vma 180200d9 pagep 8000000000000025
> [  831.113266][ T3344] binder: binder_flush: 6190 woke 0 threads
> [  831.114147][ T3344] binder: binder_flush: 6190 woke 0 threads
> [  831.115087][ T3344] binder: undelivered TRANSACTION_ERROR: 29189
> [  831.115991][ T3344] binder: binder_deferred_release: 6190 threads
> 1, nodes 0 (ref 0), refs 0, active transactions 0
> [  831.117525][ T3344] binder: binder_deferred_release: 6190 threads
> 1, nodes 0 (ref 0), refs 0, active transactions 0
>
>
> The question is: if processes that opened the device and ever mapped
> it are now completely gone, should it reset the original state when
> context can be bound again? Is it a bug in binder that it does not? If
> so, is there some kind of temp work-around for this?

If all the processes that opened the device are gone, everything
should be cleaned up and leave binder in a useable state. When the
device is in this state, can you dump out
/sys/debug/kernel/binder/state and send it to me?

>
> Thanks
