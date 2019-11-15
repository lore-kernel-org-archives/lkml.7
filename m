Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF7BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8D620733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKOWxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:53:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfKOWxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:53:51 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVkTJ-0005aa-9t; Fri, 15 Nov 2019 22:53:45 +0000
Date:   Fri, 15 Nov 2019 23:53:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v11 2/2] selftests: add tests for clone3() with *set_tid
Message-ID: <20191115225343.v6x6vltvxgv54ewl@wittgenstein>
References: <20191115123621.142252-1-areber@redhat.com>
 <20191115123621.142252-2-areber@redhat.com>
 <20191115222018.GB353836@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115222018.GB353836@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 02:20:18PM -0800, Andrei Vagin wrote:
> On Fri, Nov 15, 2019 at 01:36:21PM +0100, Adrian Reber wrote:
> > This tests clone3() with *set_tid to see if all desired PIDs are working
> > as expected. The tests are trying multiple invalid input parameters as
> > well as creating processes while specifying a certain PID in multiple
> > PID namespaces at the same time.
> > 
> > Additionally this moves common clone3() test code into clone3_selftests.h.
> > 
> > Signed-off-by: Adrian Reber <areber@redhat.com>
> > ---
> > v9:
> >  - applied all changes from Christian's review (except using the
> >    NSpid: parsing code from selftests/pidfd/pidfd_fdinfo_test.c)
> > 
> > v10:
> >  - added even more '\n' and include file fixes (Christian)
> > 
> > v11:
> >  - added more return code checking at multiple places (Andrei)
> >  - also add set_tid/set_tid_size to internal struct (Andrei)
> 
> I think we can add a test case to trigger the issue what I found in the
> previous version of the kernel patch. You can find my version of this
> test case in the attached patch.
> 
> nit: we need to flush stdout and stderr buffers before calling the raw
> clone3 syscall and _exit(). Otherwise, some log messages can be lost and
> some of them can be printed twice.
> 
> To trigger this issue, you can run the test and redirect its output to
> file or pipe:
> 
> $ ./clone3_set_tid | cat
> 
> I have attached the patch to address both these problems. It is a draft
> version and may require some work.
> 
> Adrian and Christian, it is up to you to decide whether we want to
> update the current patch or to fix this on top by a separate patch.

If you give me a proper commit with a commit message I'll put it on top
as another patch. :)

Christian
