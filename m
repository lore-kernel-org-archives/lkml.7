Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3609DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CB521852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfGZQKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfGZQKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:10:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A4621850;
        Fri, 26 Jul 2019 16:10:40 +0000 (UTC)
Date:   Fri, 26 Jul 2019 12:10:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 08/13] recordmcount: Clarify what cleanup() does
Message-ID: <20190726121038.6c69548b@gandalf.local.home>
In-Reply-To: <bf4508b8f5c191473d9f7476f1361e61dd2ae0eb.1563992889.git.mhelsley@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
        <bf4508b8f5c191473d9f7476f1361e61dd2ae0eb.1563992889.git.mhelsley@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 14:05:02 -0700
Matt Helsley <mhelsley@vmware.com> wrote:

> cleanup() mostly frees/unmaps the malloc'd/privately-mapped
> copy of the ELF file recordmcount is working on, which is
> set up in mmap_file(). It also deals with positioning within
> the pseduo prive-mapping of the file and appending to the ELF
> file.
> 
> Split into two steps:
> 	mmap_cleanup() for the mapping itself
> 	file_append_cleanup() for allocations storing the
> 		appended ELF data.
> 
> Also, move the global variable initializations out of the main,
> per-object-file loop and nearer to the alloc/init (mmap_file())
> and two cleanup functions so we can more clearly see how they're
> related.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>

Hi Matt,

I reviewed up to this patch and they look fine. I may pull these in as
I don't need a review form Josh for these patches.

Thanks!

-- Steve
