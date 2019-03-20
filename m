Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21254C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D8A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553108730;
	bh=Ud5pQyrzJqlgkmZ5sWHMRcYZLmx7jKu7SaQel/2Pyxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jIVp1iXhQUZAOJRZVpzUonTuPU1lYLS0LdtXDSXKWmAYbRGtI/WshB6IECfYfDDof
	 91mwZxMy4BIrMCC36zklcSXope7hi9f4aYKUN1tKk6StJ9VB5sW/mGyjjZPC+62K87
	 /QZ62yG/MxFP+gMEdN1hc3wxhbDRoGozE3Ex+zxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCTTF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:05:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:05:28 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6FE4D49C8;
        Wed, 20 Mar 2019 19:05:27 +0000 (UTC)
Date:   Wed, 20 Mar 2019 12:05:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH RESEND] eventfd: prepare id to userspace via fdinfo
Message-Id: <20190320120525.3ed8d21648ea8a573bbd4acf@linux-foundation.org>
In-Reply-To: <20190320092929.14628-1-yamato@redhat.com>
References: <20190320092929.14628-1-yamato@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 18:29:29 +0900 Masatake YAMATO <yamato@redhat.com> wrote:

> Finding endpoints of an IPC channel is one of essential task to
> understand how a user program works. Procfs and netlink socket provide
> enough hints to find endpoints for IPC channels like pipes, unix
> sockets, and pseudo terminals. However, there is no simple way to find
> endpoints for an eventfd file from userland. An inode number doesn't
> hint. Unlike pipe, all eventfd files share the same inode object.
> 
> To provide the way to find endpoints of an eventfd file, this patch
> adds "eventfd-id" field to /proc/PID/fdinfo of eventfd as identifier.
> Address for eventfd context is used as id.
> 
> A tool like lsof can utilize the information to print endpoints.
> 
> ...
>
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -297,6 +297,7 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
>  	seq_printf(m, "eventfd-count: %16llx\n",
>  		   (unsigned long long)ctx->count);
>  	spin_unlock_irq(&ctx->wqh.lock);
> +	seq_printf(m, "eventfd-id: %p\n", ctx);
>  }
>  #endif

Is it a good idea to use a bare kernel address for this?  How does this
interact with printk pointer randomization and hashing?

