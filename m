Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07E0218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551318878;
	bh=TbFE+6dMBZm1rzfX4E4Fz9qBFi4AtNbRwsBU+BvlPh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y7RvIsO8IbzLhLmu/6++0MNMgUtlHKPG+dz6VjbEL/kf4H847t+ueiluQxz4J3MBK
	 A5vbnM6eMGznaD0Xiayw8xHIlyctb6jY27Fh3bVii0HamBnANfKgHxdy3+veRCsbmP
	 ZG/h5M60b77J7dxx3MWN+pYv9o50xWQimfMaEbFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfB1Byg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbfB1Byg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:54:36 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC6620863;
        Thu, 28 Feb 2019 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551318875;
        bh=TbFE+6dMBZm1rzfX4E4Fz9qBFi4AtNbRwsBU+BvlPh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E6q/bCVnTO6a1EbhEIbnhBZ3r00VMmN0WOhYFTE1RxKNsOVM/I8c1aoaux93CoE2q
         vp5g3vu9uYaDLWtJseOe3OB27wTUAmBg/gae0Vs34CKoa2yip3fhjUl6ey0uzyPisz
         8zKr/Jlae1GDyBg30GO1ZY0KUJODm1sfzRqakFmQ=
Date:   Thu, 28 Feb 2019 10:54:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/5] tracing/probes: uaccess: Add support user-space
 access
Message-Id: <20190228105431.ca1fbf6ae6fca15de2f17c22@kernel.org>
In-Reply-To: <20190227223239.x42tnefzwpbpkq3t@ast-mbp>
References: <155127853496.32576.3705994926675037747.stgit@devbox>
        <20190227223239.x42tnefzwpbpkq3t@ast-mbp>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 14:32:41 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Feb 27, 2019 at 11:42:15PM +0900, Masami Hiramatsu wrote:
> > 
> > For perf-probe, we can add some attribute for each argument
> > which indicate that the variable in user space. But still
> > we can not decide it automatically by DWARF since __user attribute
> > is not transrated to DWARF attribute.
> 
> clang has partial support for __attribute__((noderef, address_space(1)))
> We'll work on patches to make it complete and pass __user attribute
> all the way to debug info.

Great! That's what I need. Could you point where (or who) I should check the
implementation?
I guess it will add DW_AT_segment to variable instance, if so it is easy
to support it in perf probe.

> 
> If somebody can work with gcc folks to do the same that would be awesome.
> 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
