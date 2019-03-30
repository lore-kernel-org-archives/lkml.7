Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E53C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BF5218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553971609;
	bh=BbR8IU/ctgAcmrI/ED8RahvLshDPYDZ/1dScwEi/3ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Thpa2JX57VcOXWW14pl0n/eJpgiHbQpkGBgwSkb1KAjtzeF3bYjVJETqtajR7j+d0
	 fzUSnOc7PNID10VadLzityhWatkG7VhuiaVdq0ClceViVXeDGU4OsJFA9ZzbM7xEFD
	 jC3ayiA3rJq+Gln3akkgkNoWbdDV8ZszKY848+hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfC3Sqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbfC3Sqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:46:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65A262184C;
        Sat, 30 Mar 2019 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553971606;
        bh=BbR8IU/ctgAcmrI/ED8RahvLshDPYDZ/1dScwEi/3ZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QdpOFb2EPxGZGmQjYAGhOV8Qvm8ugnTvR782bLZZ5d27sUbgbo/Zo18VL5DuqcT1K
         TPif6s5qqY3tmePSeQWJRsUiAPBhiAHZB4ipUj8OUe7S7wANZ94NhHRG1VBUIjVtIy
         kn0mAy/HL1WCeQDoZx2Ia5m3mPPfJhuhj+UwvBhA=
Date:   Sat, 30 Mar 2019 18:46:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH] iio: core: fix a possible circular locking
 dependency
Message-ID: <20190330184641.42516b1e@archlinux>
In-Reply-To: <123b5f03-e1cc-a8a8-9bba-b92fa14e9aec@st.com>
References: <1553262846-23126-1-git-send-email-fabrice.gasnier@st.com>
        <20190324154704.277327e2@archlinux>
        <123b5f03-e1cc-a8a8-9bba-b92fa14e9aec@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 13:51:17 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 3/24/19 4:47 PM, Jonathan Cameron wrote:
> > On Fri, 22 Mar 2019 14:54:06 +0100
> > Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >   
> >> This fixes a possible circular locking dependency detected warning seen
> >> with:
> >> - CONFIG_PROVE_LOCKING=y
> >> - consumer/provider IIO devices (ex: "voltage-divider" consumer of "adc")
> >>
> >> When using the IIO consumer interface, e.g. iio_channel_get(),
> >> the consumer device will likely call iio_read_channel_raw() or similar that
> >> rely on 'info_exist_lock' mutex.
> >>
> >> typically:
> >> ...
> >> 	mutex_lock(&chan->indio_dev->info_exist_lock);
> >> 	if (chan->indio_dev->info == NULL) {
> >> 		ret = -ENODEV;
> >> 		goto err_unlock;
> >> 	}
> >> 	ret = do_some_ops()
> >> err_unlock:
> >> 	mutex_unlock(&chan->indio_dev->info_exist_lock);
> >> 	return ret;
> >> ...
> >>
> >> Same mutex is also hold in iio_device_unregister().
> >>
> >> The following deadlock warning happens when:
> >> - the consumer device has called an API like iio_read_channel_raw()
> >>   at least once.
> >> - the consumer driver is unregistered, removed (unbind from sysfs)
> >>
> >> ======================================================
> >> WARNING: possible circular locking dependency detected
> >> 4.19.24 #577 Not tainted
> >> ------------------------------------------------------
> >> sh/372 is trying to acquire lock:
> >> (kn->count#30){++++}, at: kernfs_remove_by_name_ns+0x3c/0x84
> >>
> >> but task is already holding lock:
> >> (&dev->info_exist_lock){+.+.}, at: iio_device_unregister+0x18/0x60
> >>
> >> which lock already depends on the new lock.
> >>
> >> the existing dependency chain (in reverse order) is:
> >>  
> >> -> #1 (&dev->info_exist_lock){+.+.}:    
> >>        __mutex_lock+0x70/0xa3c
> >>        mutex_lock_nested+0x1c/0x24
> >>        iio_read_channel_raw+0x1c/0x60
> >>        iio_read_channel_info+0xa8/0xb0
> >>        dev_attr_show+0x1c/0x48
> >>        sysfs_kf_seq_show+0x84/0xec
> >>        seq_read+0x154/0x528
> >>        __vfs_read+0x2c/0x15c
> >>        vfs_read+0x8c/0x110
> >>        ksys_read+0x4c/0xac
> >>        ret_fast_syscall+0x0/0x28
> >>        0xbedefb60
> >>  
> >> -> #0 (kn->count#30){++++}:    
> >>        lock_acquire+0xd8/0x268
> >>        __kernfs_remove+0x288/0x374
> >>        kernfs_remove_by_name_ns+0x3c/0x84
> >>        remove_files+0x34/0x78
> >>        sysfs_remove_group+0x40/0x9c
> >>        sysfs_remove_groups+0x24/0x34
> >>        device_remove_attrs+0x38/0x64
> >>        device_del+0x11c/0x360
> >>        cdev_device_del+0x14/0x2c
> >>        iio_device_unregister+0x24/0x60
> >>        release_nodes+0x1bc/0x200
> >>        device_release_driver_internal+0x1a0/0x230
> >>        unbind_store+0x80/0x130
> >>        kernfs_fop_write+0x100/0x1e4
> >>        __vfs_write+0x2c/0x160
> >>        vfs_write+0xa4/0x17c
> >>        ksys_write+0x4c/0xac
> >>        ret_fast_syscall+0x0/0x28
> >>        0xbe906840
> >>
> >> other info that might help us debug this:
> >>
> >>  Possible unsafe locking scenario:
> >>
> >>        CPU0                    CPU1
> >>        ----                    ----
> >>   lock(&dev->info_exist_lock);
> >>                                lock(kn->count#30);
> >>                                lock(&dev->info_exist_lock);
> >>   lock(kn->count#30);
> >>
> >>  *** DEADLOCK ***
> >> ...
> >>
> >> So only hold the mutex to:
> >> - disable all buffers while 'info' is available
> >> - set 'info' to NULL
> >> Then release it to call cdev_device_del and so on.
> >>
> >> Help to reproduce:
> >> See example: Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> >> sysv {
> >> 	compatible = "voltage-divider";
> >> 	io-channels = <&adc 0>;
> >> 	output-ohms = <22>;
> >> 	full-ohms = <222>;
> >> };
> >>
> >> First, go to iio:deviceX for the "voltage-divider", do one read:
> >> $ cd /sys/bus/iio/devices/iio:deviceX
> >> $ cat in_voltage0_raw
> >>
> >> Then, unbind the consumer driver. It triggers above deadlock warning.
> >> $ cd /sys/bus/platform/drivers/iio-rescale/
> >> $ echo sysv > unbind
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>  
> > I'm not in principle against the fix. However it is reordering the
> > remove wrt to the probe which I'm not so keen on.
> >   
> 
> Hi Jonathan,
> 
> I also had it in mind. Just one thing confused me:
> - The ->info struct is filled in by the device driver before calling one
> of the "iio_device_register" routines.
> - But it's assigned to NULL inside the unregister routine.
> That's also why I've sent it as RFC.

Yeah, IIRC we debated whether this was fair use of the pointer
when this handling was originally introduced.  The arguement Lars
(I think) made was that we always knew this pointer had no valid
use after this call, so why not use it even if we break the balance
of probe / remove.

> 
> > The cdev register is fundamentally the point where the device
> > becomes exposed to userspace, so we naturally want to do it last
> > (and remove it first).  I worry that we may have some paths
> > in which we don't sanity check the existence of info (which
> > is kind of our backup plan to indicate the device has gone
> > away).
> > 
> > Are we safe to instead of reordering, just not take the lock
> > until after the problem functions?  Info doesn't go
> > away until later so I think we are.  I haven't looked it in that
> > much detail though!  
> 
> Ok, thanks for making up my mind :-). As far as I understand, the
> "info_exist_lock" targets the inkern users (e.g. exported routines). So,
> cdev_device_del() can probably be called unlocked, without reordering.
Yes, I think you are right.

> 
> > 
> > Thanks for raising this as it's a nasty little problem.  
> 
> I'll send a v2 based on your proposal.
Cool. Thanks!

Jonathan
> 
> Thanks for your help,
> Best Regards,
> Fabrice
> 
> > 
> > Jonathan
> > 
> >   
> >> ---
> >>  drivers/iio/industrialio-core.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> >> index 4700fd5..e03d6ff 100644
> >> --- a/drivers/iio/industrialio-core.c
> >> +++ b/drivers/iio/industrialio-core.c
> >> @@ -1745,19 +1745,19 @@ void iio_device_unregister(struct iio_dev *indio_dev)
> >>  {
> >>  	mutex_lock(&indio_dev->info_exist_lock);
> >>  
> >> -	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> >> -
> >> -	iio_device_unregister_debugfs(indio_dev);
> >> -
> >>  	iio_disable_all_buffers(indio_dev);
> >>  
> >>  	indio_dev->info = NULL;
> >>  
> >> +	mutex_unlock(&indio_dev->info_exist_lock);
> >> +
> >> +	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> >> +
> >> +	iio_device_unregister_debugfs(indio_dev);
> >> +
> >>  	iio_device_wakeup_eventset(indio_dev);
> >>  	iio_buffer_wakeup_poll(indio_dev);
> >>  
> >> -	mutex_unlock(&indio_dev->info_exist_lock);
> >> -
> >>  	iio_buffer_free_sysfs_and_mask(indio_dev);
> >>  }
> >>  EXPORT_SYMBOL(iio_device_unregister);  
> >   

