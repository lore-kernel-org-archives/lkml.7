Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4317C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899ED20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhhsv9+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfFMUPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:15:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51979 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfFMUPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:15:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so64278wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDVBcIrL+BffiBHCaT3jcza4XkSQjLMR+H8dXvn27I0=;
        b=vhhsv9+tOTV9YwqbmvoEnYC94NOV3WiYm31tgz10JJDuFFG6HgwR5vZKU1xv9XwL1W
         3t8cf45BysGyA+FVExbhbhcUfrcNE8tL1sQsAuq/Te4U9Z1XIWWQtI3+YhgOqcGhKPdk
         zR3VAioEYBpwOC7fhqQ060eHYBpwYkhHrcPZBo2sODRI2iryGmkyRy15L/Kpp48361Gw
         LHmYbnHJcnUoJ5to4YQz7F5BqCgdbjaX0dHAbF7ukishKEWw/ZP2VTFkESAnRUy/4mfZ
         Ew5X8UkquGva1nOYLH2aymQyX3GMKuf8RevMFH4Nev3dH/b5rVEdnNc7lpeEbvqHlfsW
         Y4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDVBcIrL+BffiBHCaT3jcza4XkSQjLMR+H8dXvn27I0=;
        b=jjmNVRc7DoMch1fUFhY2r638wyjZnBHOt4LHPnI9SWbJQGm6YDORQPk2g2m5QEkkYi
         /W9aMKGOy2g/86QX821OIEhEskH3+f5zh8e26Zq+eMfDmUUTL9eeOqhtBtM0lL/t8UOL
         3VH40C9O/Xi1OnqAExeovXmn6sUfx2/datFI0Wi6lb9fZrEcsxmxBRZQKWOJ0UTMrqhl
         aXqB3/3WbnsVks2w9erYN0QDQH/mW5xAy6cLlx/3TojkvM3bvA8O7SpUb/9AoApWNwxR
         2zkQwTAPKvdgRRDNTrH+Q7NYlrJmzcjQAPrSd3NUm2mr4GALg61MjkIxZnFt0yqt1cv+
         TdvQ==
X-Gm-Message-State: APjAAAXGQl+wFrJ6KhdPxmLHbkJyl9/3AtlWFhQghTUrKq5oFyiQZFw6
        ONDSrXmdAYCwJYQs78u8pi7MafStcget692UCC2NLw==
X-Google-Smtp-Source: APXvYqyQui8Ah5zYudRlx0MK6Fd3AWr22e2jhv0hO/PA5z5XpnlYNcyTPMkH0k18erUhKrKFOoXo2bv2t4mw2JXXcvg=
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr5216859wmc.77.1560456942608;
 Thu, 13 Jun 2019 13:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190612214823.251491-1-fengc@google.com> <20190612214823.251491-3-fengc@google.com>
In-Reply-To: <20190612214823.251491-3-fengc@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jun 2019 13:15:31 -0700
Message-ID: <CAJuCfpE2ncX3B8eJQJx5sC3-ZmZ32asOZKkgPKzuPe2T1Ua15w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dma-buf: add DMA_BUF_SET_NAME ioctls
To:     Chenbo Feng <fengc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 2:48 PM 'Chenbo Feng' via kernel-team
<kernel-team@android.com> wrote:
>
> From: Greg Hackmann <ghackmann@google.com>
>
> This patch adds complimentary DMA_BUF_SET_NAME  ioctls, which lets
> userspace processes attach a free-form name to each buffer.
>
> This information can be extremely helpful for tracking and accounting
> shared buffers.  For example, on Android, we know what each buffer will
> be used for at allocation time: GL, multimedia, camera, etc.  The
> userspace allocator can use DMA_BUF_SET_NAME to associate that
> information with the buffer, so we can later give developers a
> breakdown of how much memory they're allocating for graphics, camera,
> etc.
>
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> Signed-off-by: Chenbo Feng <fengc@google.com>
> ---
>  drivers/dma-buf/dma-buf.c    | 64 ++++++++++++++++++++++++++++++++++--
>  include/linux/dma-buf.h      |  5 ++-
>  include/uapi/linux/dma-buf.h |  3 ++
>  3 files changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index ffd5a2ad7d6f..87a928c93c1a 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -48,8 +48,24 @@ struct dma_buf_list {
>
>  static struct dma_buf_list db_list;
>
> +static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
> +{
> +       struct dma_buf *dmabuf;
> +       char name[DMA_BUF_NAME_LEN];
> +       size_t ret = 0;
> +
> +       dmabuf = dentry->d_fsdata;
> +       mutex_lock(&dmabuf->lock);
> +       if (dmabuf->name)
> +               ret = strlcpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
> +       mutex_unlock(&dmabuf->lock);
> +
> +       return dynamic_dname(dentry, buffer, buflen, "/%s:%s",
> +                            dentry->d_name.name, ret > 0 ? name : "");
> +}
> +
>  static const struct dentry_operations dma_buf_dentry_ops = {
> -       .d_dname = simple_dname,
> +       .d_dname = dmabuffs_dname,
>  };
>
>  static struct vfsmount *dma_buf_mnt;
> @@ -297,6 +313,42 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>         return events;
>  }
>
> +/**
> + * dma_buf_set_name - Set a name to a specific dma_buf to track the usage.
> + * The name of the dma-buf buffer can only be set when the dma-buf is not
> + * attached to any devices. It could theoritically support changing the
> + * name of the dma-buf if the same piece of memory is used for multiple
> + * purpose between different devices.
> + *
> + * @dmabuf [in]     dmabuf buffer that will be renamed.
> + * @buf:   [in]     A piece of userspace memory that contains the name of
> + *                  the dma-buf.
> + *
> + * Returns 0 on success. If the dma-buf buffer is already attached to
> + * devices, return -EBUSY.
> + *
> + */
> +static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
> +{
> +       char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
> +       long ret = 0;
> +
> +       if (IS_ERR(name))
> +               return PTR_ERR(name);
> +
> +       mutex_lock(&dmabuf->lock);
> +       if (!list_empty(&dmabuf->attachments)) {
> +               ret = -EBUSY;

Are you missing kfree(name) here?

> +               goto out_unlock;
> +       }
> +       kfree(dmabuf->name);
> +       dmabuf->name = name;
> +
> +out_unlock:
> +       mutex_unlock(&dmabuf->lock);
> +       return ret;
> +}
> +
>  static long dma_buf_ioctl(struct file *file,
>                           unsigned int cmd, unsigned long arg)
>  {
> @@ -335,6 +387,10 @@ static long dma_buf_ioctl(struct file *file,
>                         ret = dma_buf_begin_cpu_access(dmabuf, direction);
>
>                 return ret;
> +
> +       case DMA_BUF_SET_NAME:
> +               return dma_buf_set_name(dmabuf, (const char __user *)arg);
> +
>         default:
>                 return -ENOTTY;
>         }
> @@ -376,6 +432,7 @@ static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
>                 goto err_alloc_file;
>         file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
>         file->private_data = dmabuf;
> +       file->f_path.dentry->d_fsdata = dmabuf;
>
>         return file;
>
> @@ -1082,12 +1139,13 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>                         continue;
>                 }
>
> -               seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\n",
> +               seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\t%s\n",
>                                 buf_obj->size,
>                                 buf_obj->file->f_flags, buf_obj->file->f_mode,
>                                 file_count(buf_obj->file),
>                                 buf_obj->exp_name,
> -                               file_inode(buf_obj->file)->i_ino);
> +                               file_inode(buf_obj->file)->i_ino,
> +                               buf_obj->name ?: "");
>
>                 robj = buf_obj->resv;
>                 while (true) {
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 58725f890b5b..582998e19df6 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -255,10 +255,12 @@ struct dma_buf_ops {
>   * @file: file pointer used for sharing buffers across, and for refcounting.
>   * @attachments: list of dma_buf_attachment that denotes all devices attached.
>   * @ops: dma_buf_ops associated with this buffer object.
> - * @lock: used internally to serialize list manipulation, attach/detach and vmap/unmap
> + * @lock: used internally to serialize list manipulation, attach/detach and
> + *        vmap/unmap, and accesses to name
>   * @vmapping_counter: used internally to refcnt the vmaps
>   * @vmap_ptr: the current vmap ptr if vmapping_counter > 0
>   * @exp_name: name of the exporter; useful for debugging.
> + * @name: userspace-provided name; useful for accounting and debugging.
>   * @owner: pointer to exporter module; used for refcounting when exporter is a
>   *         kernel module.
>   * @list_node: node for dma_buf accounting and debugging.
> @@ -286,6 +288,7 @@ struct dma_buf {
>         unsigned vmapping_counter;
>         void *vmap_ptr;
>         const char *exp_name;
> +       const char *name;
>         struct module *owner;
>         struct list_head list_node;
>         void *priv;
> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> index d75df5210a4a..dbc7092e04b5 100644
> --- a/include/uapi/linux/dma-buf.h
> +++ b/include/uapi/linux/dma-buf.h
> @@ -35,7 +35,10 @@ struct dma_buf_sync {
>  #define DMA_BUF_SYNC_VALID_FLAGS_MASK \
>         (DMA_BUF_SYNC_RW | DMA_BUF_SYNC_END)
>
> +#define DMA_BUF_NAME_LEN       32
> +
>  #define DMA_BUF_BASE           'b'
>  #define DMA_BUF_IOCTL_SYNC     _IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
> +#define DMA_BUF_SET_NAME       _IOW(DMA_BUF_BASE, 1, const char *)
>
>  #endif
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
