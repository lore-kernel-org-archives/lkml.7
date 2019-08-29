Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52650C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D54C233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567072484;
	bh=+4kdOtMbDwXYfgCGMCQNLYfWZlPkkh26NsA6W0hbz8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2cR33lr5Tjqne9pSIAKodTSjDjq9EkDuWLbVaLy01Juo/dooyldFrRzGz/sNjNwdh
	 /k06GAK2K2drshdxT1zVkrSiOZHDlQMslTvucGBRpb5sBE/GsGK1WMblUEcVstUJRq
	 D9lZS676/rxGCUgYs13hxkQUMtwT2Y1lR+/+3PzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfH2Jyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2Jyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:54:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6752339E;
        Thu, 29 Aug 2019 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567072481;
        bh=+4kdOtMbDwXYfgCGMCQNLYfWZlPkkh26NsA6W0hbz8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrGL/ZwOTlfS0b8+bwlCtgpeFuxnYAR4oFIA6mq4mVMrXtR/2AFEvN+ICWPL7103G
         TvTsVQc/+PBqAdLKdglqA8wfui0vrD1RDNJUwwSQVDUvhuN78CC3V0leF6d4Z1huSj
         bf7+YQY8LdPE1x4s4e4lN3QY0qv/cck708zW92JY=
Date:   Thu, 29 Aug 2019 11:54:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v2 2/2] uacce: add uacce driver
Message-ID: <20190829095439.GA13915@kroah.com>
References: <1566998876-31770-1-git-send-email-zhangfei.gao@linaro.org>
 <1566998876-31770-3-git-send-email-zhangfei.gao@linaro.org>
 <20190828152201.GA10163@kroah.com>
 <5c2b0889-ea05-1ecd-fe5b-40611bd31945@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c2b0889-ea05-1ecd-fe5b-40611bd31945@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 05:05:13PM +0800, zhangfei wrote:
> Hi, Greg
> 
> On 2019/8/28 下午11:22, Greg Kroah-Hartman wrote:
> > On Wed, Aug 28, 2019 at 09:27:56PM +0800, Zhangfei Gao wrote:
> > > +struct uacce {
> > > +	const char *drv_name;
> > > +	const char *algs;
> > > +	const char *api_ver;
> > > +	unsigned int flags;
> > > +	unsigned long qf_pg_start[UACCE_QFRT_MAX];
> > > +	struct uacce_ops *ops;
> > > +	struct device *pdev;
> > > +	bool is_vf;
> > > +	u32 dev_id;
> > > +	struct cdev cdev;
> > > +	struct device dev;
> > > +	void *priv;
> > > +	atomic_t state;
> > > +	int prot;
> > > +	struct mutex q_lock;
> > > +	struct list_head qs;
> > > +};
> > At a quick glance, this problem really stood out to me.  You CAN NOT
> > have two different objects within a structure that have different
> > lifetime rules and reference counts.  You do that here with both a
> > 'struct cdev' and a 'struct device'.  Pick one or the other, but never
> > both.
> > 
> > I would recommend using a 'struct device' and then a 'struct cdev *'.
> > That way you get the advantage of using the driver model properly, and
> > then just adding your char device node pointer to "the side" which
> > interacts with this device.
> > 
> > Then you might want to call this "struct uacce_device" :)
> 
> Here the 'struct cdev' and 'struct device' have the same lifetime and
> refcount.

No they do not, that's impossible as refcounts are incremented from
different places (i.e. userspace).

> They are allocated with uacce when uacce_register and freed when
> uacce_unregister.

And that will not work.

> 
> To make it clear, how about adding this.
> 
> +static void uacce_release(struct device *dev)
> +{
> +       struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
> +
> +       idr_remove(&uacce_idr, uacce->dev_id);
> +       kfree(uacce);
> +}
> +
>  static int uacce_create_chrdev(struct uacce *uacce)
>  {
>         int ret;
> @@ -819,6 +827,7 @@ static int uacce_create_chrdev(struct uacce *uacce)
>         uacce->dev.class = uacce_class;
>         uacce->dev.groups = uacce_dev_attr_groups;
>         uacce->dev.parent = uacce->pdev;
> +       uacce->dev.release = uacce_release;

You have to have a release function today, otherwise you will get nasty
kernel messages from the log.  I don't know why you aren't seeing that
already.

>         dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
>         ret = cdev_device_add(&uacce->cdev, &uacce->dev);
>         if (ret)
> @@ -835,7 +844,7 @@ static int uacce_create_chrdev(struct uacce *uacce)
>  static void uacce_destroy_chrdev(struct uacce *uacce)
>  {
>         cdev_device_del(&uacce->cdev, &uacce->dev);
> -       idr_remove(&uacce_idr, uacce->dev_id);
> +       put_device(&uacce->dev);
>  }
> 
>  static int uacce_dev_match(struct device *dev, void *data)
> @@ -1042,8 +1051,6 @@ void uacce_unregister(struct uacce *uacce)
>         uacce_destroy_chrdev(uacce);
> 
>         mutex_unlock(&uacce_mutex);
> -
> -       kfree(uacce);
>  }
> 
> 
> uacce_destroy_chrdev->put_device(&uacce->dev)->uacce_release->kfree(uacce).
> 
> And find there are many examples in driver/
> $ grep -rn cdev_device_add drivers/
> drivers/rtc/class.c:362:        err = cdev_device_add(&rtc->char_dev,
> &rtc->dev);
> rivers/gpio/gpiolib.c:1181:    status = cdev_device_add(&gdev->chrdev,
> &gdev->dev);
> drivers/soc/qcom/rmtfs_mem.c:223:       ret =
> cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
> drivers/input/joydev.c:989:     error = cdev_device_add(&joydev->cdev,
> &joydev->dev);
> drivers/input/mousedev.c:907:   error = cdev_device_add(&mousedev->cdev,
> &mousedev->dev);
> drivers/input/evdev.c:1419:     error = cdev_device_add(&evdev->cdev,
> &evdev->dev);

Are you sure these all have the full structures inbedded in them?

> 
> like drivers/input/evdev.c,
> evdev is alloced with initialization of dev and cdev,
> and evdev is freed in release ops evdev_free
> struct evdev {
>         struct device dev;
>         struct cdev cdev;
>         ~

Ick, that too is totally wrong and needs to be fixed.

Please don't copy incorrect code, that's why we review stuff :)

thanks,

greg k-h
