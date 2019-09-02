Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E7C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAE92190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567414338;
	bh=7q45iXzXunLrEfdieCJt0HR3qgt6eiWPJ1ACWX2hDCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bsi64pGxu3nvUMnyh0p40Ix79m1O3cT76StpxSm2HrPfx8bBdKLewV/a/4PrsW1Y2
	 CNT7RYVqw88YGuYACiiW5Ubn36EZynAP/zH6/d9/NJZksCp4920qyqjAfrerCmF/ct
	 aGtN+npjnTKczc3wuKyrhqhqpMqV2/OF7Wyn86SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfIBIwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbfIBIwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:52:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DFC22173E;
        Mon,  2 Sep 2019 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567414335;
        bh=7q45iXzXunLrEfdieCJt0HR3qgt6eiWPJ1ACWX2hDCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skhlZgoeLultlGdvSHZDVs5Z26meHCHmYjdwNPNOSUDnaTsB4QfP4YKiizkVJFGs8
         jTy0B2ochghJttd+sPsFx3dgHAE6fMzFvBEPiEJel2R6dBbOop7z1sJLkAou+A0nEn
         conUjlhWV2CkOQAet8efuNQFwsMLU6Hdh5PATxj4=
Date:   Mon, 2 Sep 2019 10:52:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v2 2/2] uacce: add uacce driver
Message-ID: <20190902085213.GB18410@kroah.com>
References: <1566998876-31770-1-git-send-email-zhangfei.gao@linaro.org>
 <1566998876-31770-3-git-send-email-zhangfei.gao@linaro.org>
 <20190828152201.GA10163@kroah.com>
 <5c2b0889-ea05-1ecd-fe5b-40611bd31945@linaro.org>
 <20190829095439.GA13915@kroah.com>
 <39f792df-e3e3-eaa6-f78b-bf325b79f1b7@linaro.org>
 <eb9dd458-a82a-593a-1165-ff268ec995b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9dd458-a82a-593a-1165-ff268ec995b0@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:44:16AM +0800, zhangfei wrote:
> 
> Hi, Greg
> 
> On 2019/8/30 下午10:54, zhangfei wrote:
> > > > On 2019/8/28 下午11:22, Greg Kroah-Hartman wrote:
> > > > > On Wed, Aug 28, 2019 at 09:27:56PM +0800, Zhangfei Gao wrote:
> > > > > > +struct uacce {
> > > > > > +    const char *drv_name;
> > > > > > +    const char *algs;
> > > > > > +    const char *api_ver;
> > > > > > +    unsigned int flags;
> > > > > > +    unsigned long qf_pg_start[UACCE_QFRT_MAX];
> > > > > > +    struct uacce_ops *ops;
> > > > > > +    struct device *pdev;
> > > > > > +    bool is_vf;
> > > > > > +    u32 dev_id;
> > > > > > +    struct cdev cdev;
> > > > > > +    struct device dev;
> > > > > > +    void *priv;
> > > > > > +    atomic_t state;
> > > > > > +    int prot;
> > > > > > +    struct mutex q_lock;
> > > > > > +    struct list_head qs;
> > > > > > +};
> > > > > At a quick glance, this problem really stood out to me.  You CAN NOT
> > > > > have two different objects within a structure that have different
> > > > > lifetime rules and reference counts.  You do that here with both a
> > > > > 'struct cdev' and a 'struct device'.  Pick one or the other, but never
> > > > > both.
> > > > > 
> > > > > I would recommend using a 'struct device' and then a 'struct cdev *'.
> > > > > That way you get the advantage of using the driver model properly, and
> > > > > then just adding your char device node pointer to "the side" which
> > > > > interacts with this device.
> > > > > 
> > > > > Then you might want to call this "struct uacce_device" :)
> I think I understand now.
> 'struct device' and then a 'struct cdev' have different refcounts.
> Using 'struct cdev *', the release is not in uacce.c, but controlled by cdev
> itself.
> So uacce is decoupled with cdev.
> 
> //Using 'struct cdev *'
> cdev_alloc->cdev_dynamic_release:kfree(p);
> uacce_destroy_chrdev:
> cdev_device_del->cdev_del(cdev)->kobject_put(&p->kobj);
> if (refcount--) == 0
> cdev_dynamic_release->kfree(p);
> 
> //Using 'struct device'
> cdev_init->cdev_default_release
> cdev is freed in uacce.c,
> So 'struct device' and then a 'struct cdev' are bind together, while cdev
> and uacce->dev have different refcount.

Yes, that is exactly the reason, glad you figured it out.

thanks,

greg k-h
