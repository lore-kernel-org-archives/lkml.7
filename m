Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BAFC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463122171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565878826;
	bh=8eZZYxqGdKlMwHYaUNSwYgzDgjkPy44iEuYkZcgKkD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eDq2vETjfaX6HsG5m6MpqYb5XMp/XdDQ1CpBUlPY9bHtMjki4sSnpul18cVjvx7lF
	 99SSqC77EIuPwP/e3qABEzJTiD+IwHbzqsjTJnwAts8D6cezHQeomEy/+P0+7iIEY7
	 C9znzBcGp3sCqvchKid0y+TLEROb86YU6+ktFgYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfHOOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732815AbfHOOUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:20:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 802822084D;
        Thu, 15 Aug 2019 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565878824;
        bh=8eZZYxqGdKlMwHYaUNSwYgzDgjkPy44iEuYkZcgKkD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JW6xNW658rey32GV398pH5z6+FMCmW4s+58gMdNaHx6h2jLklbxzOp6P8fIAIXcT4
         1D3ntQ5rq8rNt1sB34u2b5ynVRmyORMvn3p2vhbhOr1OQ4MZxALc8bTCwj7of6y3y+
         RVLC10ay9wn/vmBf8ewOgZlDLFpH1gFByFU3lzqM=
Date:   Thu, 15 Aug 2019 16:20:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190815142021.GE23267@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> +/* lock to protect all queues management */
> +static DECLARE_RWSEM(uacce_qs_lock);
> +#define uacce_qs_rlock() down_read(&uacce_qs_lock)
> +#define uacce_qs_runlock() up_read(&uacce_qs_lock)
> +#define uacce_qs_wlock() down_write(&uacce_qs_lock)
> +#define uacce_qs_wunlock() up_write(&uacce_qs_lock)

Do not define your own locking macros.  That makes the code impossible
to review.

And are you _sure_ you need a rw lock?  You have benchmarked where it
has a performance impact?

> +/**
> + * uacce_wake_up - Wake up the process who is waiting this queue
> + * @q the accelerator queue to wake up
> + */
> +void uacce_wake_up(struct uacce_queue *q)
> +{
> +	dev_dbg(&q->uacce->dev, "wake up\n");

ftrace is your friend, no need for any such logging lines anywhere in
these files.

> +	wake_up_interruptible(&q->wait);
> +}
> +EXPORT_SYMBOL_GPL(uacce_wake_up);

...

> +static struct attribute *uacce_dev_attrs[] = {
> +	&dev_attr_id.attr,
> +	&dev_attr_api.attr,
> +	&dev_attr_node_id.attr,
> +	&dev_attr_numa_distance.attr,
> +	&dev_attr_flags.attr,
> +	&dev_attr_available_instances.attr,
> +	&dev_attr_algorithms.attr,
> +	&dev_attr_qfrs_offset.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group uacce_dev_attr_group = {
> +	.name	= UACCE_DEV_ATTRS,
> +	.attrs	= uacce_dev_attrs,
> +};

Why is your attribute group in a subdirectory?  Why not in the "normal"
class directory?

You are adding sysfs files to the kernel without any Documentation/ABI/
entries, which is a requirement.  Please fix that up for the next time
you send these.

> +static const struct attribute_group *uacce_dev_attr_groups[] = {
> +	&uacce_dev_attr_group,
> +	NULL
> +};
> +
> +static int uacce_create_chrdev(struct uacce *uacce)
> +{
> +	int ret;
> +
> +	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +

Shouldn't this function create the memory needed for this structure?
You are relying ont he caller to do it for you, why?


> +	cdev_init(&uacce->cdev, &uacce_fops);
> +	uacce->dev_id = ret;
> +	uacce->cdev.owner = THIS_MODULE;
> +	device_initialize(&uacce->dev);
> +	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
> +	uacce->dev.class = uacce_class;
> +	uacce->dev.groups = uacce_dev_attr_groups;
> +	uacce->dev.parent = uacce->pdev;
> +	dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
> +	ret = cdev_device_add(&uacce->cdev, &uacce->dev);
> +	if (ret)
> +		goto err_with_idr;
> +
> +	dev_dbg(&uacce->dev, "create uacce minior=%d\n", uacce->dev_id);
> +	return 0;
> +
> +err_with_idr:
> +	idr_remove(&uacce_idr, uacce->dev_id);
> +	return ret;
> +}
> +
> +static void uacce_destroy_chrdev(struct uacce *uacce)
> +{
> +	cdev_device_del(&uacce->cdev, &uacce->dev);
> +	idr_remove(&uacce_idr, uacce->dev_id);
> +}
> +
> +static int uacce_default_get_available_instances(struct uacce *uacce)
> +{
> +	return -1;

Do not make up error values, use the proper -EXXXX value instead.

> +}
> +
> +static int uacce_default_start_queue(struct uacce_queue *q)
> +{
> +	dev_dbg(&q->uacce->dev, "fake start queue");
> +	return 0;

Why even have this function if you do not do anything in it?

> +}
> +
> +static int uacce_dev_match(struct device *dev, void *data)
> +{
> +	if (dev->parent == data)
> +		return -EBUSY;

There should be in-kernel functions for this now, no need for you to
roll your own.

thanks,

greg k-h
