Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25CDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8E72051A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfKMQhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKMQhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:37:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FEA2051A;
        Wed, 13 Nov 2019 16:37:30 +0000 (UTC)
Date:   Wed, 13 Nov 2019 11:37:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC 1/2] docs: ftrace: Clarify the RAM impact of
 buffer_size_kb
Message-ID: <20191113113730.213ddd72@gandalf.local.home>
In-Reply-To: <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
References: <cover.1573661658.git.frank@generalsoftwareinc.com>
        <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 11:32:36 -0500
"Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:

> The current text could mislead the user into believing that the number
> of pages allocated by each CPU ring buffer is calculated by the round
> up of the division: buffer_size_kb / PAGE_SIZE.
> 
> Clarify that the number of pages allocated is the round up of the
> division: buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE). Add an
> example that shows how the number of pages allocated could be off by
> 5 pages more compared with how the current text suggests it should be.
> 
> Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
> ---
>  Documentation/trace/ftrace.rst | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index e3060eedb22d..ec2c4eff95a6 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -188,8 +188,17 @@ of ftrace. Here is a list of some of the key files:
>  	If the last page allocated has room for more bytes
>  	than requested, the rest of the page will be used,
>  	making the actual allocation bigger than requested or shown.
> -	( Note, the size may not be a multiple of the page size
> -	due to buffer management meta-data. )

The above is not untrue ;-)

> +
> +        The number of pages allocated for each CPU buffer may not
> +        be the same than the round up of the division:
> +        buffer_size_kb / PAGE_SIZE. This is because part of each page is
> +        used to store a page header with metadata. E.g. with
> +        buffer_size_kb=4096 (kilobytes), a PAGE_SIZE=4096 bytes and a
> +        BUF_PAGE_HDR_SIZE=16 bytes (BUF_PAGE_HDR_SIZE is the size of the
> +        page header with metadata) the number of pages allocated for each
> +        CPU buffer is 1029, not 1024. The formula for calculating the
> +        number of pages allocated for each CPU buffer is the round up of:
> +        buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE).

I have no problem with this patch, but the concern of documenting the
implementation here, which will most likely not be updated if the
implementation is ever changed, which is why I was vague to begin with.

But it may never be changed as that code has been like that for a
decade now.

-- Steve


>  
>  	Buffer sizes for individual CPUs may vary
>  	(see "per_cpu/cpu0/buffer_size_kb" below), and if they do

