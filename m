Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D354C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0532133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSXQKdFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKK0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:26:44 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40248 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDKK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:26:42 -0400
Received: by mail-yw1-f68.google.com with SMTP id p64so1858068ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kn1CQ1tYlKG5aPBdLbq4769GlOaJ+hSDTJk4frbl//4=;
        b=wSXQKdFiLT7eRRV1xpEWlnn6oDoyrVoxEQpm7cWhC24G4u9LO5gywM4Mub9N6WDcar
         myRjy2THqlrNXGW+mbO4FlbVGHTmlIdEdysola3NWYAhWp6ATRsm+S6W//rxaUXC3bzI
         I5gFR8F4BSs1FKUYuY4IHHvIGZ8yzYmnRnR10tLXw3vWVfo8++FGgugTe5hM6zqma3Kj
         Y9VLykXXohkBPWKGPkhmvVwwtgmTAfU2t1CRdfwb7pqML4XdiJxLj9zi0J3cG7qcCZBD
         Rc1q1BsaNLLnQv89XCSkNSm4AnlfMXoPs4FO6mHzU10QXZ3ml7W4i3ZZS6yDYmD6Rp0A
         jQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kn1CQ1tYlKG5aPBdLbq4769GlOaJ+hSDTJk4frbl//4=;
        b=ZepLCQntCt435kK6vZ7+tSMugi927Pf/fe13E0i/2JR6NwfOE+QPq9OxtoZmnJ+VhI
         6Snufi/2E7tKUFDylG+P2eFTcWpinwDudXRNB7KWnUy7A39v0wwYGa09mlkKTXBuiEdZ
         ZVPzG2rU1OceYaNfeuhlh9dR1XNGQtXXIjVNEVF1lFYdeXCHHd/GXrZFb1AvD23JZq2C
         nfnV1KnZE7Ycmu9mTc28+r9v/z5EM1s8VltpSxpcBLhi5hygtghvXsbCdbFpcb2Gll99
         kuFjyObH4CMnEjrkYNj0b/urPrX2g1oWVAEOzDkCRmnTpLGfwkVuIauCJgWp7IV8EnN1
         nZ1w==
X-Gm-Message-State: APjAAAWjDv5sTExDd0EW/GN9ThajEmRO490AY1CgFdPeO94a4aFlcksR
        l5H5zF6/aZX9ZBqdcvJdnKn8yLxnaXEnp+8EJ7Y8PQ==
X-Google-Smtp-Source: APXvYqw71x9PVBFYW4WEXSzgn6lidQHTEr8sCuaYmjrzWtuxOZbrjyQ4T70Yg0c8rem4CP+5ly7HmMkawImzeLf7orQ=
X-Received: by 2002:a0d:d407:: with SMTP id w7mr36829790ywd.50.1554978401447;
 Thu, 11 Apr 2019 03:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190410101947.8603-1-juha-matti.tilli@foreca.com>
 <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com>
 <CAA1_w3_4ZeOA-viD4W0QH1rUYPczcwS2KpnsvRhCX2hQniV-kQ@mail.gmail.com>
 <CANn89iLmzADQF5=htGsjNwXrUZxMUYaYZB+6WOM_vo6zG+JB9A@mail.gmail.com> <CAA1_w39v3sjg9qOoX68bSNx_WeWVJxEh3MKrx7G-uJTO7UxhiQ@mail.gmail.com>
In-Reply-To: <CAA1_w39v3sjg9qOoX68bSNx_WeWVJxEh3MKrx7G-uJTO7UxhiQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 11 Apr 2019 03:26:30 -0700
Message-ID: <CANn89iJOAwcAL2Tf=h7R-Sd5BaDyoqDh7KtOgfedSQ6HJYNZRg@mail.gmail.com>
Subject: Re: [PATCH] net: add big honking pfmemalloc OOM warning
To:     Juha-Matti Tilli <juha-matti.tilli@foreca.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Murphy Zhou <xzhou@redhat.com>,
        Yongcheng Yang <yoyang@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:26 PM Juha-Matti Tilli
<juha-matti.tilli@foreca.com> wrote:
>
> On Wed, Apr 10, 2019 at 6:36 PM Eric Dumazet <edumazet@google.com> wrote:
> > Before diving into the details, can we first double check which exact
> > kernel version you are using ?
> >
> > In the past some pfmemalloc bugs have been solved, I do not want spend
> > time finding them a second time.
>
> Of course I can tell the kernel version.
>
> The NFS server is 3.10.0-862.14.4.el7.foreca.x86_64 where "foreca"
> means we've applied a custom Samsung SSD TRIM patch, nothing else
> different from regular CentOS / RHEL kernel.
>
> The NFS client is 3.10.0-957.5.1.el7.x86_64.
>
> The pfmemalloc problem happens at the server, not at the client.
>
> The exact patches in this kernel may be a bit complicated to
> determine, because RHEL apparently likes to maintain their own kernel
> version. They do not have the SNMP counter even, which is why I opened
> a bug report to RHEL Bugzilla. I have extracted source code, so if you
> can tell a list of git commit SHA1 hashes that could fix the issue, I
> can check manually whether they're there, and open bug reports to RHEL
> bugzilla to have them backported if not there.
>
> I at least see this in the exact kernel version I'm using:

Here (netdev/lkml) we deal with current kernels.

Chances are very high the bug(s) you are fighting was(were) already fixed.

Please repro the bug using latest David Miller net tree, otherwise we
will _not_ accept any patch.

Thank you

>
> static inline bool ixgbe_page_is_reserved(struct page *page)
> {
>         return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
> }
>
> ...so ixgbe shouldn't be reusing pfmemalloc pages.
>
> BR, Juha-Matti
