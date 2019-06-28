Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F96C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300AB2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561728906;
	bh=NK7VdWZqj61oGMb7hOSZNcUxWzYCDi723Oci2tLSdBQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=1FctAKm5kKqnb2t7U95Q20CClYwKqv9mZSw+GPQcUVj59BLHKvLh1DtKI4WsdGLIq
	 EQZOBRvi0VGHfh9q4NsMOIcqNwSAPPluDlUGVCslilhPKJPYrv50Cfx6fdbxMHEN63
	 JSf5XMRYPZAgp6Ktayg6n/ue62syl83Hkz/0VdIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF1NfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfF1NfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:35:04 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6AF208E3;
        Fri, 28 Jun 2019 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561728904;
        bh=NK7VdWZqj61oGMb7hOSZNcUxWzYCDi723Oci2tLSdBQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HrlX0lesqTCm+/fJVu0E4yRRUJ+soSBltekK4jUjqbIZjTW2DcZRd985IeBqC94jX
         eGyqW6PutiXw/Ba+ZxiuhS5PRU57vzG8HKx+fk4/odLWdLKhr4qfrbTkkl2fydwIB1
         CGaQg94QmU2j6NvKfTB8OxGB7enne7VngyMchuyo=
Message-ID: <1561728902.9333.2.camel@kernel.org>
Subject: Re: [PATCH v2] tracing: Fix memory leak in tracing_err_log_open()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Takeshi Misawa <jeliantsurux@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 08:35:02 -0500
In-Reply-To: <20190628105640.GA1863@DESKTOP>
References: <20190628105640.GA1863@DESKTOP>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-06-28 at 19:56 +0900, Takeshi Misawa wrote:
> If tracing_err_log_open() call seq_open(), allocated memory is not
> freed.
> 
> kmemleak report:
> 
> unreferenced object 0xffff92c0781d1100 (size 128):
>   comm "tail", pid 15116, jiffies 4295163855 (age 22.704s)
>   hex dump (first 32 bytes):
>     00 f0 08 e5 c0 92 ff ff 00 10 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d0687d5>] kmem_cache_alloc+0x11f/0x1e0
>     [<000000003e3039a8>] seq_open+0x2f/0x90
>     [<000000008dd36b7d>] tracing_err_log_open+0x67/0x140
>     [<000000005a431ae2>] do_dentry_open+0x1df/0x3a0
>     [<00000000a2910603>] vfs_open+0x2f/0x40
>     [<0000000038b0a383>] path_openat+0x2e8/0x1690
>     [<00000000fe025bda>] do_filp_open+0x9b/0x110
>     [<00000000483a5091>] do_sys_open+0x1ba/0x260
>     [<00000000c558b5fd>] __x64_sys_openat+0x20/0x30
>     [<000000006881ec07>] do_syscall_64+0x5a/0x130
>     [<00000000571c2e94>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fix this by calling seq_release() in tracing_err_log_fops.release().
> 
> Signed-off-by: Takeshi Misawa <jeliantsurux@gmail.com>
> ---
> Dear Steven Rostedt
> 
> Thanks for reviewing.
> 
> > Actually, I think it is safer to have the condition be:
> > 
> >         if (file->f_mode & FMODE_READ)
> > 
> > As that would match the open.
> > 
> > Can you send a v2?
> 
> I send a v2 patch.
> 
> Regards.
> ---
>  kernel/trace/trace.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 83e08b78dbee..4122ccde6ec2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7126,12 +7126,24 @@ static ssize_t tracing_err_log_write(struct
> file *file,
>  	return count;
>  }
>  
> +static int tracing_err_log_release(struct inode *inode, struct file
> *file)
> +{
> +	struct trace_array *tr = inode->i_private;
> +
> +	trace_array_put(tr);
> +
> +	if (file->f_mode & FMODE_READ)
> +		seq_release(inode, file);
> +
> +	return 0;
> +}
> +
>  static const struct file_operations tracing_err_log_fops = {
>  	.open           = tracing_err_log_open,
>  	.write		= tracing_err_log_write,
>  	.read           = seq_read,
>  	.llseek         = seq_lseek,
> -	.release	= tracing_release_generic_tr,
> +	.release        = tracing_err_log_release,
>  };
>  

v2 looks good to me, thanks for sending this fix.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


>  static int tracing_buffers_open(struct inode *inode, struct file
> *filp)
