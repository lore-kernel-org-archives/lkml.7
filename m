Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCFCC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4893E206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKUXxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKUXxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:53:41 -0500
Received: from oasis.local.home (unknown [66.170.99.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7CE3206C2;
        Thu, 21 Nov 2019 23:53:40 +0000 (UTC)
Date:   Thu, 21 Nov 2019 18:53:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
Message-ID: <20191121185339.4ef626df@oasis.local.home>
In-Reply-To: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
References: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 19:20:21 +0900
Kusanagi Kouichi <slash@ac.auone-net.jp> wrote:

> If DEBUG_FS=n, compile fails with the following error:
> 
> kernel/trace/trace.c: In function 'tracing_init_dentry':
> kernel/trace/trace.c:8658:9: error: passing argument 3 of 'debugfs_create_automount' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  8658 |         trace_automount, NULL);
>       |         ^~~~~~~~~~~~~~~
>       |         |
>       |         struct vfsmount * (*)(struct dentry *, void *)
> In file included from kernel/trace/trace.c:24:
> ./include/linux/debugfs.h:206:25: note: expected 'struct vfsmount * (*)(void *)' but argument is of type 'struct vfsmount * (*)(struct dentry *, void *)'
>   206 |      struct vfsmount *(*f)(void *),
>       |      ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
> 

Please add the tag:

 Reported-by: kbuild test robot <lkp@intel.com>

You can also add:

 Link: https://lore.kernel.org/lkml/201911211354.zYtbB4MD%25lkp@intel.com/

-- Steve

> Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
> ---
>  include/linux/debugfs.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> index 58424eb3b329..798f0b9b43ae 100644
> --- a/include/linux/debugfs.h
> +++ b/include/linux/debugfs.h
> @@ -54,6 +54,8 @@ static const struct file_operations __fops = {				\
>  	.llseek  = no_llseek,						\
>  }
>  
> +typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
> +
>  #if defined(CONFIG_DEBUG_FS)
>  
>  struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
> @@ -75,7 +77,6 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
>  struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
>  				      const char *dest);
>  
> -typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
>  struct dentry *debugfs_create_automount(const char *name,
>  					struct dentry *parent,
>  					debugfs_automount_t f,
> @@ -203,7 +204,7 @@ static inline struct dentry *debugfs_create_symlink(const char *name,
>  
>  static inline struct dentry *debugfs_create_automount(const char *name,
>  					struct dentry *parent,
> -					struct vfsmount *(*f)(void *),
> +					debugfs_automount_t f,
>  					void *data)
>  {
>  	return ERR_PTR(-ENODEV);

