Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC28C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFA12087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566210258;
	bh=VLojVFkzgZHan5LdoxkG4JqccjfzZ2dNUwTalgtbLs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vK2yiJKPfpzSlLFDYWIUmLdNtwbr8zNGp2+g3Kg7zM1Az67rkZyk8726cPITaiJbI
	 SjhNlQAp9mXw3rK2uOXn8QQK8OPwKNYNwZz+EBxEswCX62Vhqao6VWHxWDbDCe3kJt
	 D0qzUoWs4/2TklpZsloxJEZi55OcbOQcGta7XRsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfHSKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHSKYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:24:16 -0400
Received: from localhost (unknown [89.205.137.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D5E20844;
        Mon, 19 Aug 2019 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566210255;
        bh=VLojVFkzgZHan5LdoxkG4JqccjfzZ2dNUwTalgtbLs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9rsGWl6kVBUeUY+a+/HZCNBzNChfpsHXWIjokmjqwRs56olELAHr2Ue0s1oaY6tn
         jtWiMNHiI6NG2msRfHxhpDw/9NWnN3YatEZJobCTH7tooqZdt2VcXkc3xnTk8bGpVa
         t7M3n8o/sdbYtmcnZOMnCmakfzZR41QIbkSVMPSg=
Date:   Mon, 19 Aug 2019 12:24:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190819102413.GB2030@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815142021.GE23267@kroah.com>
 <5d5a6f5b.1c69fb81.9d35e.5303SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d5a6f5b.1c69fb81.9d35e.5303SMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:43:40PM +0800, zhangfei.gao@foxmail.com wrote:
> Hi, Greg
> 
> On 2019/8/15 下午10:20, Greg Kroah-Hartman wrote:
> > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > +/* lock to protect all queues management */
> > > +static DECLARE_RWSEM(uacce_qs_lock);
> > > +#define uacce_qs_rlock() down_read(&uacce_qs_lock)
> > > +#define uacce_qs_runlock() up_read(&uacce_qs_lock)
> > > +#define uacce_qs_wlock() down_write(&uacce_qs_lock)
> > > +#define uacce_qs_wunlock() up_write(&uacce_qs_lock)
> > Do not define your own locking macros.  That makes the code impossible
> > to review.
> > 
> > And are you _sure_ you need a rw lock?  You have benchmarked where it
> > has a performance impact?
> OK, will use uacce_mutex for this first version, and put performance tunning
> later.
> > > +/**
> > > + * uacce_wake_up - Wake up the process who is waiting this queue
> > > + * @q the accelerator queue to wake up
> > > + */
> > > +void uacce_wake_up(struct uacce_queue *q)
> > > +{
> > > +	dev_dbg(&q->uacce->dev, "wake up\n");
> > ftrace is your friend, no need for any such logging lines anywhere in
> > these files.
> OK, will remove the dev_dbg.
> > > +	wake_up_interruptible(&q->wait);
> > > +}
> > > +EXPORT_SYMBOL_GPL(uacce_wake_up);
> > ...
> > 
> > > +static struct attribute *uacce_dev_attrs[] = {
> > > +	&dev_attr_id.attr,
> > > +	&dev_attr_api.attr,
> > > +	&dev_attr_node_id.attr,
> > > +	&dev_attr_numa_distance.attr,
> > > +	&dev_attr_flags.attr,
> > > +	&dev_attr_available_instances.attr,
> > > +	&dev_attr_algorithms.attr,
> > > +	&dev_attr_qfrs_offset.attr,
> > > +	NULL,
> > > +};
> > > +
> > > +static const struct attribute_group uacce_dev_attr_group = {
> > > +	.name	= UACCE_DEV_ATTRS,
> > > +	.attrs	= uacce_dev_attrs,
> > > +};
> > Why is your attribute group in a subdirectory?  Why not in the "normal"
> > class directory?
> Yes,  .name = UACCE_DEV_ATTRS can be removed to make it simple.
> Then attrs are in /sys/class/uacce/hisi_zip-x/xxx
> > 
> > You are adding sysfs files to the kernel without any Documentation/ABI/
> > entries, which is a requirement.  Please fix that up for the next time
> > you send these.
> Will add Documentation/ABI/entries in next version.
> > > +static const struct attribute_group *uacce_dev_attr_groups[] = {
> > > +	&uacce_dev_attr_group,
> > > +	NULL
> > > +};
> > > +
> > > +static int uacce_create_chrdev(struct uacce *uacce)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > Shouldn't this function create the memory needed for this structure?
> > You are relying ont he caller to do it for you, why?
> I think you mean uacce structure here.
> Yes, currently we count on caller to prepare uacce structure and call
> uacce_register(uacce).
> We still think this method is simpler, prepare uacce, register uacce.
> And there are other system using the same method, like crypto
> (crypto_register_acomp), nand, etc.

crypto is not a subsystem to ever try to emulate :)

You are creating a structure with a lifetime that you control, don't
have someone else create your memory, that's almost never what you want
to do.  Most all driver subsystems create their own memory chunks for
what they need to do, it's a much better pattern.

Especially when you get into pointer lifetime issues...

> > > +	cdev_init(&uacce->cdev, &uacce_fops);
> > > +	uacce->dev_id = ret;
> > > +	uacce->cdev.owner = THIS_MODULE;
> > > +	device_initialize(&uacce->dev);
> > > +	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
> > > +	uacce->dev.class = uacce_class;
> > > +	uacce->dev.groups = uacce_dev_attr_groups;
> > > +	uacce->dev.parent = uacce->pdev;
> > > +	dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
> > > +	ret = cdev_device_add(&uacce->cdev, &uacce->dev);
> > > +	if (ret)
> > > +		goto err_with_idr;
> > > +
> > > +	dev_dbg(&uacce->dev, "create uacce minior=%d\n", uacce->dev_id);
> > > +	return 0;
> > > +
> > > +err_with_idr:
> > > +	idr_remove(&uacce_idr, uacce->dev_id);
> > > +	return ret;
> > > +}
> > > +
> > > +static void uacce_destroy_chrdev(struct uacce *uacce)
> > > +{
> > > +	cdev_device_del(&uacce->cdev, &uacce->dev);
> > > +	idr_remove(&uacce_idr, uacce->dev_id);
> > > +}
> > > +
> > > +static int uacce_default_get_available_instances(struct uacce *uacce)
> > > +{
> > > +	return -1;
> > Do not make up error values, use the proper -EXXXX value instead.
> > 
> > > +}
> > > +
> > > +static int uacce_default_start_queue(struct uacce_queue *q)
> > > +{
> > > +	dev_dbg(&q->uacce->dev, "fake start queue");
> > > +	return 0;
> > Why even have this function if you do not do anything in it?
> OK, will remove these two funcs.
> > > +}
> > > +
> > > +static int uacce_dev_match(struct device *dev, void *data)
> > > +{
> > > +	if (dev->parent == data)
> > > +		return -EBUSY;
> > There should be in-kernel functions for this now, no need for you to
> > roll your own.
> Sorry, do not find this function.
> Only find class_find_device, which still require match.

It is in linux-next, look there...

thanks,

greg k-h
