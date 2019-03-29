Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D8C218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfC2TmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:42:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39304 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2TmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:42:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h9xOC-00078P-WE; Fri, 29 Mar 2019 19:42:09 +0000
Date:   Fri, 29 Mar 2019 19:42:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>
Subject: Re: [PATCH v2 3/4] x86/fpu: Fix __user annotations
Message-ID: <20190329194208.GE2217@ZenIV.linux.org.uk>
References: <20190329163047.223508-1-jannh@google.com>
 <20190329163047.223508-3-jannh@google.com>
 <20190329180329.hl3t7a43sg3sshsf@ltop.local>
 <CAG48ez2+AeBuJ8i8RKL3THc1Nq1_vPyqLTXep8CvJgqVtGYCig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2+AeBuJ8i8RKL3THc1Nq1_vPyqLTXep8CvJgqVtGYCig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 08:25:25PM +0100, Jann Horn wrote:
> Oooh, it's a sparse bug.

It's *not* a bug.  

> Apparently it's significant that the user pointer is stored as a
> __u64, and __u64 is defined as unsigned long long.

Yes, it is.  Casts to uintptr_t (== unsigned long on all targets)
are OK; any other arithmetical type gives a warning, and quite
deliberately so.

Don't do it.  If you want to say "I'm converting it to integer,
all traces of its origin are gone", use an idiomatic cast.
