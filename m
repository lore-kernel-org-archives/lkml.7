Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E2C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F1B22CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566661224;
	bh=84wGP4tI4nDESrw+F/x06vL01Lcwm1Pw9jY2yeAXleM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PmWZLEdwRkNGBIJvz8KgZhOtGEwbwy99uPeVMCoTiJ+mS0TVo+6kmiThBiUXdD7LA
	 se4+f7SshacuDL5KKQ8LA2xj7CnqhFT9DZBDDA+rpKPtip+/mP88iA+HakSPYcAWxU
	 0GC47zQn9G4pPb34gX4rV5RtP1dFYObvRPLDOBJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfHXPkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 11:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfHXPkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 11:40:23 -0400
Received: from localhost (unknown [89.205.134.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21AE2133F;
        Sat, 24 Aug 2019 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566661222;
        bh=84wGP4tI4nDESrw+F/x06vL01Lcwm1Pw9jY2yeAXleM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvnrtZ6aCxXPxmbyTrD6pu//z9S3i0BCkTzmSU0xlKRPvzTC3MeoIgbs9xGlR0eAp
         053Zl6TDVx0Ig9XS+UPYuwnNzPogil347RgvILO1RDdKK2tLy9quZ3D5CaLtzM4Cbk
         OMLPs8OPzIdPOOiHHdBqdxcsN7fGPy6JF0j6DLus=
Date:   Sat, 24 Aug 2019 17:40:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190824154018.GA29647@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815142021.GE23267@kroah.com>
 <5d5a6f5b.1c69fb81.9d35e.5303SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190819102413.GB2030@kroah.com>
 <0f7c6241-2028-76e7-0314-8b99cd353bd6@linaro.org>
 <20190820143341.GB1536@kroah.com>
 <3e237a99-8832-30d5-11de-f65325195478@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e237a99-8832-30d5-11de-f65325195478@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 08:53:01PM +0800, zhangfei wrote:
> 
> 
> On 2019/8/20 下午10:33, Greg Kroah-Hartman wrote:
> > On Tue, Aug 20, 2019 at 08:36:50PM +0800, zhangfei wrote:
> > > Hi, Greg
> > > 
> > > On 2019/8/19 下午6:24, Greg Kroah-Hartman wrote:
> > > > > > > +static int uacce_create_chrdev(struct uacce *uacce)
> > > > > > > +{
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
> > > > > > > +	if (ret < 0)
> > > > > > > +		return ret;
> > > > > > > +
> > > > > > Shouldn't this function create the memory needed for this structure?
> > > > > > You are relying ont he caller to do it for you, why?
> > > > > I think you mean uacce structure here.
> > > > > Yes, currently we count on caller to prepare uacce structure and call
> > > > > uacce_register(uacce).
> > > > > We still think this method is simpler, prepare uacce, register uacce.
> > > > > And there are other system using the same method, like crypto
> > > > > (crypto_register_acomp), nand, etc.
> > > > crypto is not a subsystem to ever try to emulate :)
> > > > 
> > > > You are creating a structure with a lifetime that you control, don't
> > > > have someone else create your memory, that's almost never what you want
> > > > to do.  Most all driver subsystems create their own memory chunks for
> > > > what they need to do, it's a much better pattern.
> > > > 
> > > > Especially when you get into pointer lifetime issues...
> > > OK, understand now, thanks for your patience.
> > > will use this instead.
> > > struct uacce_interface {
> > >          char name[32];
> > >          unsigned int flags;
> > >          struct uacce_ops *ops;
> > > };
> > > struct uacce *uacce_register(struct device *dev, struct uacce_interface
> > > *interface);
> > What?  Why do you need a structure?  A pointer to the name and the ops
> > should be all that is needed, right?
> We are thinking transfer structure will be more flexible.
> And modify api later would be difficult, requiring many drivers modify
> together.
> Currently parameters need a flag, a pointer to the name, and ops, but in
> case more requirement from future drivers usage.
> Also refer usb_register_dev, sdhci_pltfm_init etc, and the structure para
> can be set as static.

Ok, I can live with that, but it is a bit more complex.  However, if you
are creating a new device structure, your "core" has to do it, do not
rely on the driver to do it for you as that is just lots of duplicated
logic everywhere.  Not to mention a reference counting nightmare.

> > And 'dev' here is a pointer to the parent, right?  Might want to make
> > that explicit in the name of the variable :)
> Yes, 'dev' is parent, will change to 'pdev', thanks.

Use "struct device *parent" it's much more obvious that way and does not
look like crazy hungarian notation :)

thanks,

greg k-h
