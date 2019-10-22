Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFB0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF42820B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbfJVVpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733177AbfJVVpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:45:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2938D2084B;
        Tue, 22 Oct 2019 21:45:53 +0000 (UTC)
Date:   Tue, 22 Oct 2019 17:45:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hassan Naveed <hnaveed@wavecomp.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH] TRACING: FTRACE: Use xarray structure for ftrace
 syscalls
Message-ID: <20191022174551.2fcc85fd@gandalf.local.home>
In-Reply-To: <20191022155104.29b062a5@gandalf.local.home>
References: <20191022182303.14829-1-hnaveed@wavecomp.com>
        <20191022155104.29b062a5@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 15:51:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >  static struct syscall_metadata *syscall_nr_to_meta(int nr)
> >  {
> > -	if (!syscalls_metadata || nr >= NR_syscalls || nr < 0)
> > -		return NULL;
> > -
> > -	return syscalls_metadata[nr];
> > +	return xa_load(&syscalls_metadata, (unsigned long)nr);
> >  }
> >  

There appears to be a slight overhead to this for archs that do not
have a sparse syscall array. I wonder if we should make this only
applicable for archs (via adding a HAVE_SPARSE_SYSCALL_NR define and
checking against it). Then if an arch doesn't have a sparse array of
system calls, it uses a normal lookup, but for archs that do, it can
define this for this type of lookup.

There's not much to this patch, so it wouldn't be too difficult to
support both methods.

Without this patch I ran:

# trace-cmd start -e syscalls
# /work/c/hackbench 50
Time: 15.702
# /work/c/hackbench 50
Time: 15.932
# /work/c/hackbench 50
Time: 15.893
# /work/c/hackbench 50
Time: 16.038
# /work/c/hackbench 50
Time: 15.429


With the patch it had:

# trace-cmd start -e syscalls
# /work/c/hackbench 50
Time: 16.582
# /work/c/hackbench 50
Time: 15.972
# /work/c/hackbench 50
Time: 16.078
# /work/c/hackbench 50
Time: 16.133
# /work/c/hackbench 50
Time: 16.263

-- Steve
