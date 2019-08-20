Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9178C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B301214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566311624;
	bh=ydinMJI9qM+u2naxA0AkkAYz3ega+bGQc59+jdnyhpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MnBaGRYjFLdbl7qU+3RIazQxcSWvYft+EnEmqdfJlM9mzw9ysYoks0Y/TkTjphA1V
	 +ZE1Ho9znxJpA9BjF1tGIOzyK+CgrIpKp5GvS2FnIbuwf0WCmF/Kf+sLEPeeJKLwO1
	 m0XVjXBplmU+ngJ9hAvWO51vIhuJK4VP6lf+ZWUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfHTOdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbfHTOdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:33:43 -0400
Received: from localhost (unknown [12.166.174.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A0020673;
        Tue, 20 Aug 2019 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566311621;
        bh=ydinMJI9qM+u2naxA0AkkAYz3ega+bGQc59+jdnyhpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/BqYITVeTNLr9pvvOB8aY0a+uUa5eesxprypPW4xpGSRyWSCpmoKV6BeXI7mvz55
         yBHAn8fI4QQqHkTraJbeRDilFwgPSZcnKuSfx5IIg+H8PdWSSp8KqabI4nvZWr//W6
         noxaXpwhd/4NLgiaQ4Ucx6amWwBtolwH6rnHMsZE=
Date:   Tue, 20 Aug 2019 07:33:41 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190820143341.GB1536@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815142021.GE23267@kroah.com>
 <5d5a6f5b.1c69fb81.9d35e.5303SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190819102413.GB2030@kroah.com>
 <0f7c6241-2028-76e7-0314-8b99cd353bd6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f7c6241-2028-76e7-0314-8b99cd353bd6@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:36:50PM +0800, zhangfei wrote:
> Hi, Greg
> 
> On 2019/8/19 下午6:24, Greg Kroah-Hartman wrote:
> > > > > +static int uacce_create_chrdev(struct uacce *uacce)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > Shouldn't this function create the memory needed for this structure?
> > > > You are relying ont he caller to do it for you, why?
> > > I think you mean uacce structure here.
> > > Yes, currently we count on caller to prepare uacce structure and call
> > > uacce_register(uacce).
> > > We still think this method is simpler, prepare uacce, register uacce.
> > > And there are other system using the same method, like crypto
> > > (crypto_register_acomp), nand, etc.
> > crypto is not a subsystem to ever try to emulate :)
> > 
> > You are creating a structure with a lifetime that you control, don't
> > have someone else create your memory, that's almost never what you want
> > to do.  Most all driver subsystems create their own memory chunks for
> > what they need to do, it's a much better pattern.
> > 
> > Especially when you get into pointer lifetime issues...
> OK, understand now, thanks for your patience.
> will use this instead.
> struct uacce_interface {
>         char name[32];
>         unsigned int flags;
>         struct uacce_ops *ops;
> };
> struct uacce *uacce_register(struct device *dev, struct uacce_interface
> *interface);

What?  Why do you need a structure?  A pointer to the name and the ops
should be all that is needed, right?

And 'dev' here is a pointer to the parent, right?  Might want to make
that explicit in the name of the variable :)

> > > > > +
> > > > > +static int uacce_dev_match(struct device *dev, void *data)
> > > > > +{
> > > > > +	if (dev->parent == data)
> > > > > +		return -EBUSY;
> > > > There should be in-kernel functions for this now, no need for you to
> > > > roll your own.
> > > Sorry, do not find this function.
> > > Only find class_find_device, which still require match.
> > It is in linux-next, look there...
> > 
> Suppose you mean the funcs: device_match_name,
> device_match_of_node,device_match_devt etc.
> Here we need dev->parent, there still no such func.

You should NEVER be matching on a parent.  If so, your use of the driver
model is wrong :)

Remind me to really review the use of the driver core code in your next
submission of this series please, I think it needs it.

thanks,

greg k-h
