Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A761C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591AE218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfDEPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbfDEPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:18:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3B2218D3;
        Fri,  5 Apr 2019 15:18:57 +0000 (UTC)
Date:   Fri, 5 Apr 2019 11:18:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix buffer_ref pipe ops
Message-ID: <20190405111855.466225c6@gandalf.local.home>
In-Reply-To: <20190404215925.253531-1-jannh@google.com>
References: <20190404215925.253531-1-jannh@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Apr 2019 23:59:25 +0200
Jann Horn <jannh@google.com> wrote:

> This fixes multiple issues in buffer_pipe_buf_ops:
> 
>  - The ->steal() handler must not return zero unless the pipe buffer has
>    the only reference to the page. But generic_pipe_buf_steal() assumes
>    that every reference to the pipe is tracked by the page's refcount,
>    which isn't true for these buffers - buffer_pipe_buf_get(), which
>    duplicates a buffer, doesn't touch the page's refcount.
>    Fix it by using generic_pipe_buf_nosteal(), which refuses every
>    attempted theft. It should be easy to actually support ->steal, but the
>    only current users of pipe_buf_steal() are the virtio console and FUSE,
>    and they also only use it as an optimization. So it's probably not worth
>    the effort.
>  - The ->get() and ->release() handlers can be invoked concurrently on pipe
>    buffers backed by the same struct buffer_ref. Make them safe against
>    concurrency by using refcount_t.
>  - The pointers stored in ->private were only zeroed out when the last
>    reference to the buffer_ref was dropped. As far as I know, this
>    shouldn't be necessary anyway, but if we do it, let's always do it.

Honestly, the entire implementation of the splice code for me was very
confusing. Not much documentation on it, so I just looked at what
others did and tried my best to copy them, bugs and all ;-)

> 
> Cc: stable@vger.kernel.org # v4.11
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Completely untested (apart from compiling it). I don't really know
> anything about how the tracing subsystem works.

I applied this and ran it through my suite of trace-cmd tests which
uses the splice code quite heavily, and it didn't trigger any bugs.

I don't see anything wrong with this patch, so I'll pull it and run it
through the rest of my tests.

Thanks!

-- Steve


> 
>  fs/splice.c               |  4 ++--
>  include/linux/pipe_fs_i.h |  1 +
>  kernel/trace/trace.c      | 28 ++++++++++++++--------------
>  3 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 3ee7e82df48f..e75807380caa 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -330,8 +330,8 @@ const struct pipe_buf_operations default_pipe_buf_ops = {
>  	.get = generic_pipe_buf_get,
>  };
>  
> -static int generic_pipe_buf_nosteal(struct pipe_inode_info *pipe,
> -				    struct pipe_buffer *buf)
> +int generic_pipe_buf_nosteal(struct pipe_inode_info *pipe,
> +			     struct pipe_buffer *buf)
>  {
>  	return 1;
>  }
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 787d224ff43e..a830e9a00eb9 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -174,6 +174,7 @@ void free_pipe_info(struct pipe_inode_info *);
>  void generic_pipe_buf_get(struct pipe_inode_info *, struct pipe_buffer *);
>  int generic_pipe_buf_confirm(struct pipe_inode_info *, struct pipe_buffer *);
>  int generic_pipe_buf_steal(struct pipe_inode_info *, struct pipe_buffer *);
> +int generic_pipe_buf_nosteal(struct pipe_inode_info *, struct pipe_buffer *);
>  void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
>  void pipe_buf_mark_unmergeable(struct pipe_buffer *buf);
>  
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 21153e64bf1c..0cfa13a60086 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7025,19 +7025,23 @@ struct buffer_ref {
>  	struct ring_buffer	*buffer;
>  	void			*page;
>  	int			cpu;
> -	int			ref;
> +	refcount_t		refcount;
>  };
>  
> +static void buffer_ref_release(struct buffer_ref *ref)
> +{
> +	if (!refcount_dec_and_test(&ref->refcount))
> +		return;
> +	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
> +	kfree(ref);
> +}
> +
>  static void buffer_pipe_buf_release(struct pipe_inode_info *pipe,
>  				    struct pipe_buffer *buf)
>  {
>  	struct buffer_ref *ref = (struct buffer_ref *)buf->private;
>  
> -	if (--ref->ref)
> -		return;
> -
> -	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
> -	kfree(ref);
> +	buffer_ref_release(ref);
>  	buf->private = 0;
>  }
>  
> @@ -7046,14 +7050,14 @@ static void buffer_pipe_buf_get(struct pipe_inode_info *pipe,
>  {
>  	struct buffer_ref *ref = (struct buffer_ref *)buf->private;
>  
> -	ref->ref++;
> +	refcount_inc(&ref->refcount);
>  }
>  
>  /* Pipe buffer operations for a buffer. */
>  static const struct pipe_buf_operations buffer_pipe_buf_ops = {
>  	.confirm		= generic_pipe_buf_confirm,
>  	.release		= buffer_pipe_buf_release,
> -	.steal			= generic_pipe_buf_steal,
> +	.steal			= generic_pipe_buf_nosteal,
>  	.get			= buffer_pipe_buf_get,
>  };
>  
> @@ -7066,11 +7070,7 @@ static void buffer_spd_release(struct splice_pipe_desc *spd, unsigned int i)
>  	struct buffer_ref *ref =
>  		(struct buffer_ref *)spd->partial[i].private;
>  
> -	if (--ref->ref)
> -		return;
> -
> -	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
> -	kfree(ref);
> +	buffer_ref_release(ref);
>  	spd->partial[i].private = 0;
>  }
>  
> @@ -7125,7 +7125,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  			break;
>  		}
>  
> -		ref->ref = 1;
> +		refcount_set(&ref->refcount, 1);
>  		ref->buffer = iter->trace_buffer->buffer;
>  		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
>  		if (IS_ERR(ref->page)) {

