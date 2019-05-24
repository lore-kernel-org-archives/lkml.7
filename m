Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E3C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE86217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbfEXCy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731522AbfEXCy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:54:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5080C2177E;
        Fri, 24 May 2019 02:54:25 +0000 (UTC)
Date:   Thu, 23 May 2019 22:54:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Behmer <jbehmer@google.com>
Cc:     Craig Barabas <craigbarabas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Correct commit mask for page data size
Message-ID: <20190523225423.372ef0b0@oasis.local.home>
In-Reply-To: <CAMmhGq+VCHWp4s-Xh3ZUtxEudgqK-C1LYhttFpc4MUOrzRD3Ag@mail.gmail.com>
References: <CAMmhGq+VCHWp4s-Xh3ZUtxEudgqK-C1LYhttFpc4MUOrzRD3Ag@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 06:49:07 -0700
Jason Behmer <jbehmer@google.com> wrote:

Hi Jason,

I just noticed this email. I know it's a late response, but since you
Cc'd LKML, I figured I would respond anyway, and at least have an
answer in the archives ;-)

> Hi Steven,
> We're wondering what the correct number of bits to take from the
> commit field is when determining the size of the page data.  The
> format file shows the bottom 56 bits not overlapping with anything:
> 
>         field: local_t commit;  offset:8;       size:8; signed:1;
>         field: int overwrite;   offset:8;       size:1; signed:1;
> 
> We first naively interpreted this as the size, but eventually ran into
> cases where this gave back a nonsense result.  But then in our
> investigation of what the correct thing to do is, we found conflicting
> answers.

Yeah, I hated that above, but the format didn't have a good way to show
the overwrite without breaking existing tools :-/

> 
> In the kernel we see that commit is often updated to write, which is
> masked against RB_WRITE_MASK.  So it seems taking the bottom 20 bits
> is correct.  However, in trace-cmd, a fairly authoritative parser, we
> see that COMMIT_MASK is set to take the bottom 27 bits and set that to
> the page data size.

The way the kernel uses that number is that the first 20 bits are the
size. Then we have an internal counter (top 12 bits) used for
synchronizing when the trace crosses pages. But these internal numbers
will never be exposed when it is sent off to the reader. Hence, those
bits are meaningless.

Now I probably could make the trace-cmd header just use those 20 bits,
as they never will be used for the size. When I wrote that, I just made
sure that the flags that are added to the page by the reader code was
not set. Which is why there is a discrepancy between the two masks.
> 
> Could you provide some guidance?

Thanks for pointing this out. Again, the reason for the difference is
that they were created from two different perspectives. One was that it
would use the top 12 bytes for internal purposes, the other was just to
allow for up to 5 flags by the reader.

Does that make sense?

-- Steve

