Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC3C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C267520727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfKZOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:41:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60519 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKZOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:41:25 -0500
Received: from [185.81.136.22] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iZc1r-0003xg-5h; Tue, 26 Nov 2019 14:41:23 +0000
Date:   Tue, 26 Nov 2019 15:41:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
Message-ID: <20191126144121.kzkujr27ga36gqnf@wittgenstein>
References: <20191124195225.31230-1-jongk@linux-m68k.org>
 <CAMuHMdVv9FU+kTf7RDd=AFKL12tJxzmGbX4jZZ8Av3VCZUzwhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVv9FU+kTf7RDd=AFKL12tJxzmGbX4jZZ8Av3VCZUzwhA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 10:12:25AM +0100, Geert Uytterhoeven wrote:
> Hi Kars,
> 
> On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > Wire up the clone3() syscall for m68k. The special entry point is done in
> > assembler as was done for clone() as well. This is needed because all
> > registers need to be saved. The C wrapper then calls the generic
> > sys_clone3() with the correct arguments.
> >
> > Tested on A1200 using the simple test program from:
> >
> >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/

Please note that we now have a growing test-suite for the clone3()
syscall under
tools/testing/selftests/clone3/*

You can test on a suitable kernel with

make TARGETS=clone3 kselftest

> >
> > Cc: linux-m68k@vger.kernel.org
> > Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
> 
> Thanks a lot!
> Works fine on ARAnyM, too.
> 
> Looks good to me, but I'll wait a bit before applying, so the syscall experts
> can chime in, if needed.

Otherwise this looks good to me.
Thanks for moving this forward. One day we'll be able to remove
ARCH_WANT_SYS_CLONE3 completely. :)

	Christian
