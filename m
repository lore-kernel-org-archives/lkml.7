Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBFFC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE7320881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfD1As7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 20:48:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55684 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfD1As6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 20:48:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2CFDA1F453;
        Sun, 28 Apr 2019 00:48:58 +0000 (UTC)
Date:   Sun, 28 Apr 2019 00:48:58 +0000
From:   Eric Wong <e@80x24.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Davidlohr Bueso <dave@stgolabs.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Omar Kilani <omar.kilani@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190428004858.el3yk6hljloeoxza@dcvr>
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr>
 <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> I tried to replicate the failure on qemu.
> I do not see the failure with N=32.

> Does it work for N < 32?

Depends on number of cores you have; I have 4 cores, 8 threads
with HT; so I needed to have a lot of load on the machine to get
it to fail (it takes about 1 minute).

cmogstored is intended to run on machines that were already
saturated in CPU/memory from other processes, but not HDD I/O
bandwidth.

> Does any other signal work?

SIGCONT does, via:

   perl -i -p -e 's/SIGURG/SIGCONT/g' `git ls-files`

> Are there any other architectures that fail?

I don't have other arches (well, 32-bit x86, but I've never
really tried cmogstored on that, even).

> Could you help me figure out how to run just the one test that is failing?

Just running one test won't trigger since it needs a busy
machine; but:

	make test/mgmt_auto_adjust.log
	(and "rm make test/mgmt_auto_adjust.log" if you want to rerun)

Thanks for looking into this.  Fwiw, cmogstored uses epoll in
strange and uncommon ways which has led to kernel bugfixes
in the past.
