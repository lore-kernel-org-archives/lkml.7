Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E49C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9732189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562169354;
	bh=LtErY1G1GbnNDLsjbOl0t5ngJ9E9MA0BzqdAODW16ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d/G8aJlqGhSXy9LZWGEpq+T/I/bfAvEtj/TudsKy00zr22Pp4skG4OngRLTTQHQBZ
	 /bv69n4WjMvimfFxQXP725GeRY8uJVqT1pUH60RTTf8P2U+0O43OWZHq0nQXUcWPAH
	 ZyeMsAIpDrdcj9VElnom825SSwO5es0cBDw26CAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGCPzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCPzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:55:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F70D2189E;
        Wed,  3 Jul 2019 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562169349;
        bh=LtErY1G1GbnNDLsjbOl0t5ngJ9E9MA0BzqdAODW16ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BALQb7k6vDl7xSSqYNbxuFt4qYAlsJK6BtR181viQqg80t+UYPdoe9xD2FuMuwf9W
         XKxPg6RdruHnTwO5Oy/eHaEj5jxb2mlwS0b6O9mR7Dkv17BjU6By0AvhJjIqGpZJBf
         uzgTs1AjAgCB3BlabSn3CDmaIqSYh+CV591N2HJs=
Date:   Wed, 3 Jul 2019 17:55:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 5/9] intel_th: msu: Introduce buffer driver interface
Message-ID: <20190703155547.GA32438@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
 <20190627125152.54905-6-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627125152.54905-6-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 03:51:48PM +0300, Alexander Shishkin wrote:
> Introduces a concept of buffer drivers, which is a mechanism for creating
> trace sinks that would receive trace data from MSC buffers and transfer it
> elsewhere.
> 
> A buffer driver can implement its own window allocation/deallocation if
> it has to. It must provide a callback that's used to notify it when a
> window fills up, so that it can then start a DMA transaction from that
> window 'elsewhere'. This window remains in a 'locked' state and won't be
> used for storing new trace data until the buffer driver 'unlocks' it with
> a provided API call, at which point the window can be used again for
> storing trace data.
> 
> This relies on a functional "last block" interrupt, so not all versions of
> Trace Hub can use this feature.

So you are breaking userspace?  Or just that older userspace tools will
not have this new functionality?

> +#include <linux/intel_th.h>
>  #include "intel_th.h"
>  #include "msu.h"
>  
> @@ -32,6 +34,7 @@
>   * struct msc_window - multiblock mode window descriptor
>   * @entry:	window list linkage (msc::win_list)
>   * @pgoff:	page offset into the buffer that this window starts at
> + * @lockout:	lockout state, see comment below
>   * @nr_blocks:	number of blocks (pages) in this window
>   * @nr_segs:	number of segments in this window (<= @nr_blocks)
>   * @_sgt:	array of block descriptors
> @@ -40,6 +43,7 @@
>  struct msc_window {
>  	struct list_head	entry;
>  	unsigned long		pgoff;
> +	atomic_t		lockout;
>  	unsigned int		nr_blocks;
>  	unsigned int		nr_segs;
>  	struct msc		*msc;
> @@ -100,6 +104,10 @@ struct msc {
>  	void __iomem		*msu_base;
>  	struct intel_th_device	*thdev;
>  
> +	const struct msu_buffer_driver	*bdrv;
> +	void				*bdrv_priv;
> +
> +	struct work_struct	work;
>  	struct list_head	win_list;
>  	struct sg_table		single_sgt;
>  	struct msc_window	*cur_win;
> @@ -126,6 +134,110 @@ struct msc {
>  	unsigned int		index;
>  };
>  
> +/*
> + * Lockout state transitions:
> + *   READY -> INUSE -+-> LOCKED -+-> READY -> etc.
> + *                   \-----------/
> + * WIN_READY:	window can be used by HW
> + * WIN_INUSE:	window is in use
> + * WIN_LOCKED:	window is filled up and is being processed by the buffer driver
> + *
> + * All state transitions happen automatically, except for the LOCKED->READY,
> + * which needs to be signalled by the buffer driver by calling
> + * intel_th_msc_window_unlock().
> + *
> + * When the interrupt handler has to switch to the next window, it checks
> + * whether it's READY, and if it is, it performs the switch and tracing
> + * continues. If it's LOCKED, it stops the trace.
> + */
> +enum {
> +	WIN_READY = 0,
> +	WIN_INUSE,
> +	WIN_LOCKED
> +};

Why use an atomic for a state?  What's wrong with a "normal" lock?  Are
you _sure_ you are using it correctly?  If so, what is the benefit?

> +static LIST_HEAD(msu_buffer_list);
> +static struct mutex msu_buffer_mutex;
> +
> +struct msu_buffer {
> +	struct list_head		entry;
> +	const struct msu_buffer_driver	*bdrv;
> +};
> +
> +static struct msu_buffer *__msu_buffer_find(const char *name)
> +{
> +	struct msu_buffer *buf;
> +
> +	list_for_each_entry(buf, &msu_buffer_list, entry) {
> +		if (!strcmp(buf->bdrv->name, name))
> +			return buf;
> +	}
> +
> +	return NULL;

No locking of your list?  Shouldn't you annotate that the lock must be
held here for this to work?  Putting a lock outside of a function is a
sure way to make people reading the code go crazy.

> +}
> +
> +static const struct msu_buffer_driver *
> +__msu_buffer_driver_find(const char *name)
> +{
> +	struct msu_buffer *buf = __msu_buffer_find(name);
> +
> +	return buf ? buf->bdrv : NULL;
> +}
> +
> +static const struct msu_buffer_driver *
> +msu_buffer_driver_get(const char *name)
> +{
> +	const struct msu_buffer_driver *bdrv;
> +
> +	mutex_lock(&msu_buffer_mutex);
> +	bdrv = __msu_buffer_driver_find(name);
> +	if (bdrv && !try_module_get(bdrv->owner))
> +		bdrv = NULL;
> +	mutex_unlock(&msu_buffer_mutex);
> +
> +	return bdrv;
> +}
> +
> +int intel_th_msu_buffer_register(const struct msu_buffer_driver *bdrv)
> +{
> +	struct msu_buffer *buf;
> +	int ret = -EEXIST;
> +
> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	mutex_lock(&msu_buffer_mutex);
> +	if (__msu_buffer_driver_find(bdrv->name))
> +		goto out;
> +
> +	buf->bdrv = bdrv;
> +	list_add_tail(&buf->entry, &msu_buffer_list);
> +	ret = 0;
> +out:
> +	mutex_unlock(&msu_buffer_mutex);
> +
> +	if (ret)
> +		kfree(buf);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(intel_th_msu_buffer_register);
> +
> +void intel_th_msu_buffer_unregister(const struct msu_buffer_driver *bdrv)
> +{
> +	struct msu_buffer *buf;
> +
> +	mutex_lock(&msu_buffer_mutex);
> +	buf = __msu_buffer_find(bdrv->name);
> +	if (buf) {
> +		list_del(&buf->entry);
> +		kfree(buf);
> +	}
> +	mutex_unlock(&msu_buffer_mutex);
> +}
> +EXPORT_SYMBOL_GPL(intel_th_msu_buffer_unregister);
> +
>  static inline bool msc_block_is_empty(struct msc_block_desc *bdesc)
>  {
>  	/* header hasn't been written */
> @@ -188,6 +300,25 @@ static struct msc_window *msc_next_window(struct msc_window *win)
>  	return list_next_entry(win, entry);
>  }
>  
> +static size_t msc_win_total_sz(struct msc_window *win)
> +{
> +	unsigned int blk;
> +	size_t size = 0;
> +
> +	for (blk = 0; blk < win->nr_segs; blk++) {
> +		struct msc_block_desc *bdesc = msc_win_block(win, blk);
> +
> +		if (msc_block_wrapped(bdesc))
> +			return win->nr_blocks << PAGE_SHIFT;
> +
> +		size += msc_total_sz(bdesc);
> +		if (msc_block_last_written(bdesc))
> +			break;
> +	}
> +
> +	return size;
> +}
> +
>  /**
>   * msc_find_window() - find a window matching a given sg_table
>   * @msc:	MSC device
> @@ -527,6 +658,9 @@ static int intel_th_msu_init(struct msc *msc)
>  	if (!msc->do_irq)
>  		return 0;
>  
> +	if (!msc->bdrv)
> +		return 0;
> +
>  	mintctl = ioread32(msc->msu_base + REG_MSU_MINTCTL);
>  	mintctl |= msc->index ? M1BLIE : M0BLIE;
>  	iowrite32(mintctl, msc->msu_base + REG_MSU_MINTCTL);
> @@ -554,6 +688,27 @@ static void intel_th_msu_deinit(struct msc *msc)
>  	iowrite32(mintctl, msc->msu_base + REG_MSU_MINTCTL);
>  }
>  
> +static int msc_win_set_lockout(struct msc_window *win, int expect, int new)
> +{
> +	int old;
> +
> +	if (!win->msc->bdrv)
> +		return 0;
> +
> +	old = atomic_cmpxchg(&win->lockout, expect, new);
> +	if (expect == WIN_READY && old == WIN_LOCKED)
> +		return -EBUSY;
> +
> +	/* from intel_th_msc_window_unlock(), don't warn if not locked */
> +	if (expect == WIN_LOCKED && old == new)
> +		return 0;
> +
> +	if (WARN_ONCE(old != expect, "expected lockout state %d, got %d\n",
> +		      expect, old))

How can this be hit?  If it is it, do you want people's machines to
crash (panic on warn)?

Anyway, this fucntion is crazy, why not use a normal enum and a lock?


> +		return -EINVAL;
> +
> +	return 0;
> +}
>  /**
>   * msc_configure() - set up MSC hardware
>   * @msc:	the MSC device to configure
> @@ -571,8 +726,16 @@ static int msc_configure(struct msc *msc)
>  	if (msc->mode > MSC_MODE_MULTI)
>  		return -ENOTSUPP;
>  
> -	if (msc->mode == MSC_MODE_MULTI)
> +	if (msc->mode == MSC_MODE_MULTI) {
> +		/* Window allocation path makes sure this doesn't happen */
> +		if (WARN_ON_ONCE(!msc->cur_win))
> +			return -EINVAL;

If this can never happen, don't test for it.  If it can, test and handle
it properly.  Don't crash.

> +
> +		if (msc_win_set_lockout(msc->cur_win, WIN_READY, WIN_INUSE))
> +			return -EBUSY;
> +
>  		msc_buffer_clear_hw_header(msc);
> +	}
>  
>  	reg = msc->base_addr >> PAGE_SHIFT;
>  	iowrite32(reg, msc->reg_base + REG_MSU_MSC0BAR);
> @@ -594,10 +757,14 @@ static int msc_configure(struct msc *msc)
>  
>  	iowrite32(reg, msc->reg_base + REG_MSU_MSC0CTL);
>  
> +	intel_th_msu_init(msc);
> +
>  	msc->thdev->output.multiblock = msc->mode == MSC_MODE_MULTI;
>  	intel_th_trace_enable(msc->thdev);
>  	msc->enabled = 1;
>  
> +	if (msc->bdrv && msc->bdrv->activate)
> +		msc->bdrv->activate(msc->bdrv_priv);
>  
>  	return 0;
>  }
> @@ -611,10 +778,17 @@ static int msc_configure(struct msc *msc)
>   */
>  static void msc_disable(struct msc *msc)
>  {
> +	struct msc_window *win = msc->cur_win;
>  	u32 reg;
>  
>  	lockdep_assert_held(&msc->buf_mutex);
>  
> +	if (msc->mode == MSC_MODE_MULTI)
> +		msc_win_set_lockout(win, WIN_INUSE, WIN_LOCKED);

Look, the lock is held!  Use it!

Anyway, this patch is odd, please re-review it.

> --- /dev/null
> +++ b/include/linux/intel_th.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Intel(R) Trace Hub data structures for implementing buffer drivers.
> + *
> + * Copyright (C) 2019 Intel Corporation.
> + */
> +
> +#ifndef _INTEL_TH_H_
> +#define _INTEL_TH_H_
> +
> +#include <linux/scatterlist.h>
> +
> +/* MSC operating modes (MSC_MODE) */
> +enum {
> +	MSC_MODE_SINGLE	= 0,
> +	MSC_MODE_MULTI,
> +	MSC_MODE_EXI,
> +	MSC_MODE_DEBUG,
> +};
> +
> +struct msu_buffer_driver {
> +	const char	*name;
> +	struct module	*owner;

Why does a driver have a module pointer?  And then not use it?

> +	/*
> +	 * ->assign() called when buffer 'mode' is set to this driver
> +	 *   (aka mode_store())
> +	 * @device:	struct device * of the msc
> +	 * @mode:	allows the driver to set HW mode (see the enum above)
> +	 * Returns:	a pointer to a private structure associated with this
> +	 *		msc or NULL in case of error. This private structure
> +	 *		will then be passed into all other callbacks.
> +	 */
> +	void	*(*assign)(struct device *dev, int *mode);
> +	/* ->unassign():	some other mode is selected, clean up */
> +	void	(*unassign)(void *priv);
> +	/*
> +	 * ->alloc_window(): allocate memory for the window of a given
> +	 *		size
> +	 * @sgt:	pointer to sg_table, can be overridden by the buffer
> +	 *		driver, or kept intact
> +	 * Returns:	number of sg table entries <= number of pages;
> +	 *		0 is treated as an allocation failure.
> +	 */
> +	int	(*alloc_window)(void *priv, struct sg_table **sgt,
> +				size_t size);
> +	void	(*free_window)(void *priv, struct sg_table *sgt);
> +	/* ->activate():	trace has started */
> +	void	(*activate)(void *priv);
> +	/* ->deactivate():	trace is about to stop */
> +	void	(*deactivate)(void *priv);
> +	/*
> +	 * ->ready():	window @sgt is filled up to the last block OR
> +	 *		tracing is stopped by the user; this window contains
> +	 *		@bytes data. The window in question transitions into
> +	 *		the "LOCKED" state, indicating that it can't be used
> +	 *		by hardware. To clear this state and make the window
> +	 *		available to the hardware again, call
> +	 *		intel_th_msc_window_unlock().
> +	 */
> +	int	(*ready)(void *priv, struct sg_table *sgt, size_t bytes);
> +};

Why isn't this based off of 'struct driver'?

thanks,

greg k-h
