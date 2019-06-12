Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAACFC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A156F206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hv8TgoCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfFLOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:43:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38125 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfFLOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:43:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so15648548oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9tl7agUX8PHmzxevAoY1c85cGa1CD64Ig+RZa1dCBw=;
        b=Hv8TgoCm9XsWIIy1dM5GKF7BGLp3MBxAoEkHX2+wYCS1rj2z8OH9JWJTgei2P9SlTZ
         O5E1e2cMIAe8tB+Oa/eZNjBBWVNCoS6XkeW4GYs11XKchRDNMr/fTFOCnhMn6uylrKFn
         zlQzDv5MO8mbeYuK7OG6/zP1ieM4dQKQtoqmt0JhSsZsk8t2EDIAuI3uIMz+TLjlQjsn
         MOlamosxGzH3PaVCuwUW235refAjedOgkZu6eWIKabiuIK5z0szJZmUZHba88QH4O68W
         ysYdujkB+J2D446ZLDzz3qcmLXzBkoQ9RwQduWEBQBzcLd3CaJc3CWGg0tdpUlzBVbNi
         za4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9tl7agUX8PHmzxevAoY1c85cGa1CD64Ig+RZa1dCBw=;
        b=QCXQpJDAxfiJjnXxD6/F7FF6xnIq5R3G2qt50LiqGHWGCVg7oe8zIXA11PM/c6yHfP
         35an/P2uvnsBlAODWNuHeSwXSqS6gA9MH3Oh/ZegIlgPJfnr8PyFNZKEcHH/PQEEG0pn
         Pc/Oe+blYdZws1y+99rjwDq2DvfskYcPcDgJlR9zei5gCBVspJWDLEqLyJuF6Qg9Xev8
         YKLekbiGulwKm/4pXDnlO3u4wK5WSpspneV+0NdsyM0VaCq26AroiL9pO8BBTSsYTbeO
         KchLQqiHU4UYlid9oY99sIsvkA9NC4MFuf3uHIkmyvRLWtqx2t6pUtj8WH5aMn2ibYuY
         ryBA==
X-Gm-Message-State: APjAAAWlSNArnY1tBJDcs0a/NlvaX1sWuzwBomkD3xuZ8+HP8QeqjRnC
        jIw1k1rkG3EdTzihUlWg5zazE43TaL+jkHn7w6yB+LxxMO8=
X-Google-Smtp-Source: APXvYqzW+S+G564gDrL+10Ehj3IidoTdNSSRQmtjoKtKX/1ItY3A1Cf4VZL5QQjtRuXnaiaRUyVvCe318bhMpx3L7Ec=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr5907954otq.224.1560350618399;
 Wed, 12 Jun 2019 07:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190611000230.152670-1-fengc@google.com> <20190611000230.152670-3-fengc@google.com>
In-Reply-To: <20190611000230.152670-3-fengc@google.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 12 Jun 2019 20:13:26 +0530
Message-ID: <CAO_48GHkU5aZby7835mx+od6g2BbgvWLKo=dFOxnmEtscArDkg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/3] dma-buf: add DMA_BUF_{GET,SET}_NAME ioctls
To:     Chenbo Feng <fengc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenbo,

Thanks very much for your patches. Other than a couple tiny nits
below, I think these look good, and I will merge them before the end
of this week.
On Tue, 11 Jun 2019 at 05:32, Chenbo Feng <fengc@google.com> wrote:
>
> From: Greg Hackmann <ghackmann@google.com>
>
> This patch adds complimentary DMA_BUF_SET_NAME and DMA_BUF_GET_NAME
> ioctls, which lets userspace processes attach a free-form name to each
> buffer.
This should remove the _GET_NAME bit since it's not there anymore.
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
>  drivers/dma-buf/dma-buf.c    | 49 +++++++++++++++++++++++++++++++++---
>  include/linux/dma-buf.h      |  5 +++-
>  include/uapi/linux/dma-buf.h |  3 +++
>  3 files changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index ffd5a2ad7d6f..c1da5f9ce44d 100644
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
> @@ -297,6 +313,27 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>         return events;
>  }
>
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
> +               goto out_unlock;
> +       }
We might also want to document this better - that name change for a
buffer is still allowed if it doesn't have any attached devices after
its usage is done but before it is destroyed? (theoritically it could
be reused with a different name?)

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
> @@ -335,6 +372,10 @@ static long dma_buf_ioctl(struct file *file,
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
> @@ -376,6 +417,7 @@ static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
>                 goto err_alloc_file;
>         file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
>         file->private_data = dmabuf;
> +       file->f_path.dentry->d_fsdata = dmabuf;
>
>         return file;
>
> @@ -1082,12 +1124,13 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
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

Best,
Sumit.
