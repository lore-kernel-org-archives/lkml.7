Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D5C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B97421773
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554027204;
	bh=CL5ux2w2gwRC2FHT+84dC7W00eEZWK7YaJ47frjYbvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BFN2lSkiG5truOOwhazhiYPCPKKU0ififkuxjFGBHStCGShDOYt5rjfYV1kxFftHA
	 jOBVxNuzhDMjlHFIaZ9N1EqfMGdLF0mR4Z1fmRdFBtSxycuCDDMgmDBrqcP1kCPRoN
	 mCHIZVFbTMMhhmQoYN8wE+lEVLDYd+ll5LDlkWjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfCaKNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfCaKNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:13:23 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446D0206DD;
        Sun, 31 Mar 2019 10:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554027201;
        bh=CL5ux2w2gwRC2FHT+84dC7W00eEZWK7YaJ47frjYbvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=phMOmb34ZxI4JfUIeOKkHVaktqHOKT+rbj1Fk1Rblb7PzRFYKRZRQZKtxVN3hFT7P
         A2Xsx2EQq7oJlZ93bCSaf01uWuySDKHhbYStnDmJEOWsiFbGKDodj1qo9tIRnpyHbo
         mcZIrEQmJ6CG5JC+LJo8la5zgpMGzMruLyhCHULU=
Date:   Sun, 31 Mar 2019 11:13:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: core: fix a possible circular locking
 dependency
Message-ID: <20190331111316.08531aaf@archlinux>
In-Reply-To: <1553518883-27972-1-git-send-email-fabrice.gasnier@st.com>
References: <1553518883-27972-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 14:01:23 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> This fixes a possible circular locking dependency detected warning seen
> with:
> - CONFIG_PROVE_LOCKING=y
> - consumer/provider IIO devices (ex: "voltage-divider" consumer of "adc")
> 
> When using the IIO consumer interface, e.g. iio_channel_get(), the consumer
> device will likely call iio_read_channel_raw() or similar that rely on
> 'info_exist_lock' mutex.
> 
> typically:
> ...
> 	mutex_lock(&chan->indio_dev->info_exist_lock);
> 	if (chan->indio_dev->info == NULL) {
> 		ret = -ENODEV;
> 		goto err_unlock;
> 	}
> 	ret = do_some_ops()
> err_unlock:
> 	mutex_unlock(&chan->indio_dev->info_exist_lock);
> 	return ret;
> ...
> 
> Same mutex is also hold in iio_device_unregister().
> 
> The following deadlock warning happens when:
> - the consumer device has called an API like iio_read_channel_raw()
>   at least once.
> - the consumer driver is unregistered, removed (unbind from sysfs)
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.19.24 #577 Not tainted
> ------------------------------------------------------
> sh/372 is trying to acquire lock:
> (kn->count#30){++++}, at: kernfs_remove_by_name_ns+0x3c/0x84
> 
> but task is already holding lock:
> (&dev->info_exist_lock){+.+.}, at: iio_device_unregister+0x18/0x60
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&dev->info_exist_lock){+.+.}:  
>        __mutex_lock+0x70/0xa3c
>        mutex_lock_nested+0x1c/0x24
>        iio_read_channel_raw+0x1c/0x60
>        iio_read_channel_info+0xa8/0xb0
>        dev_attr_show+0x1c/0x48
>        sysfs_kf_seq_show+0x84/0xec
>        seq_read+0x154/0x528
>        __vfs_read+0x2c/0x15c
>        vfs_read+0x8c/0x110
>        ksys_read+0x4c/0xac
>        ret_fast_syscall+0x0/0x28
>        0xbedefb60
> 
> -> #0 (kn->count#30){++++}:  
>        lock_acquire+0xd8/0x268
>        __kernfs_remove+0x288/0x374
>        kernfs_remove_by_name_ns+0x3c/0x84
>        remove_files+0x34/0x78
>        sysfs_remove_group+0x40/0x9c
>        sysfs_remove_groups+0x24/0x34
>        device_remove_attrs+0x38/0x64
>        device_del+0x11c/0x360
>        cdev_device_del+0x14/0x2c
>        iio_device_unregister+0x24/0x60
>        release_nodes+0x1bc/0x200
>        device_release_driver_internal+0x1a0/0x230
>        unbind_store+0x80/0x130
>        kernfs_fop_write+0x100/0x1e4
>        __vfs_write+0x2c/0x160
>        vfs_write+0xa4/0x17c
>        ksys_write+0x4c/0xac
>        ret_fast_syscall+0x0/0x28
>        0xbe906840
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&dev->info_exist_lock);
>                                lock(kn->count#30);
>                                lock(&dev->info_exist_lock);
>   lock(kn->count#30);
> 
>  *** DEADLOCK ***
> ...
> 
> cdev_device_del() can be called without holding the lock. It should be safe
> as info_exist_lock prevents kernelspace consumers to use the exported
> routines during/after provider removal. cdev_device_del() is for userspace.
> 
> Help to reproduce:
> See example: Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> sysv {
> 	compatible = "voltage-divider";
> 	io-channels = <&adc 0>;
> 	output-ohms = <22>;
> 	full-ohms = <222>;
> };
> 
> First, go to iio:deviceX for the "voltage-divider", do one read:
> $ cd /sys/bus/iio/devices/iio:deviceX
> $ cat in_voltage0_raw
> 
> Then, unbind the consumer driver. It triggers above deadlock warning.
> $ cd /sys/bus/platform/drivers/iio-rescale/
> $ echo sysv > unbind
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

I've added a fixes tag to ac917a81117ce0286847666b55dd265f6cda8383
and marked for stable.

Applied to the fixes-togreg branch of iio.git.  

Ouch this one has been there since 2012

Jonathan

> ---
> Changes in v2:
> - call cdev_device_del() without holding the lock, as proposed by Jonathan
>   without reordering the unregister routine.
> ---
>  drivers/iio/industrialio-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4700fd5..9c4d921 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1743,10 +1743,10 @@ EXPORT_SYMBOL(__iio_device_register);
>   **/
>  void iio_device_unregister(struct iio_dev *indio_dev)
>  {
> -	mutex_lock(&indio_dev->info_exist_lock);
> -
>  	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>  
> +	mutex_lock(&indio_dev->info_exist_lock);
> +
>  	iio_device_unregister_debugfs(indio_dev);
>  
>  	iio_disable_all_buffers(indio_dev);

