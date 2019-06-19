Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4960AC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240D72147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfFSJ2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfFSJ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:28:07 -0400
Received: from oasis.local.home (rrcs-50-75-126-20.nys.biz.rr.com [50.75.126.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEE0206E0;
        Wed, 19 Jun 2019 09:28:05 +0000 (UTC)
Date:   Wed, 19 Jun 2019 05:28:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/7] powerpc/ftrace: Update ftrace_location() for
 powerpc -mprofile-kernel
Message-ID: <20190619052800.434ff6f0@oasis.local.home>
In-Reply-To: <1560930937.j2vguryjp3.naveen@linux.ibm.com>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <186656540d3e6225abd98374e791a13d10d86fab.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190618114509.5b1acbe5@gandalf.local.home>
        <1560881411.p0i6a1dkwk.naveen@linux.ibm.com>
        <1560881840.vz9llflvnf.naveen@linux.ibm.com>
        <20190618143234.78539805@gandalf.local.home>
        <1560930937.j2vguryjp3.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 13:26:37 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> > In include/ftrace.h:
> > 
> > #ifndef FTRACE_IP_EXTENSION
> > # define FTRACE_IP_EXTENSION	0
> > #endif
> > 
> > 
> > In arch/powerpc/include/asm/ftrace.h
> > 
> > #define FTRACE_IP_EXTENSION	MCOUNT_INSN_SIZE
> > 
> > 
> > Then we can just have:
> > 
> > unsigned long ftrace_location(unsigned long ip)
> > {
> > 	return ftrace_location_range(ip, ip + FTRACE_IP_EXTENSION);
> > }  
> 
> Thanks, that's indeed nice. I hope you don't mind me adding your SOB for 
> that.

Actually, it's best not to put a SOB by anyone other than yourself. It
actually has legal meaning.

In this case, please add:

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

-- Steve
