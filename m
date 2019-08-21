Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E247DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D012339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566379032;
	bh=gwn1/xDiKSubkWvuayTGmBJNoVwzSbDob1EbN35UB5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vlmzmsvUzCga1pnDxOwHv7Xk0hBWjXV5msCo9DqOjWsaDe7IJJ8J7eb3hBVtOEvSJ
	 KU+jRLlEnSPmi3F1xHjK3mVWKra6+R+HY1tn4YpNd/hXujgvcr+TP/t+OfZPfTV93v
	 YEM6ICtCw3PdlGK9blcicuRCBa5ErpnzUvpYuFjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfHUJRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfHUJRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:17:11 -0400
Received: from localhost (unknown [12.166.174.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5709622DA7;
        Wed, 21 Aug 2019 09:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566379030;
        bh=gwn1/xDiKSubkWvuayTGmBJNoVwzSbDob1EbN35UB5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZFMg1FFAZLW15Cy+ISuHVa/LFyyJxGN7OXhs9ymQRyyca5IOVRcK+B7uHICrDURB
         k2z++nlmhuXGDoEwhI5gQyL20eTyB6bnxAscelKXpkLcGNi1mJ6mLMg0SN6g1TYwCw
         c7SaFG0mf7pqTDgras04+R7Xi6Dey/Zc3OO+BE1k=
Date:   Wed, 21 Aug 2019 02:17:09 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190821091709.GA22914@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141351.GD23267@kroah.com>
 <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
 <20190820165947.GC3736@kroah.com>
 <5d5cf0fc.1c69fb81.ec57f.b853SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d5cf0fc.1c69fb81.ec57f.b853SMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 03:21:18PM +0800, zhangfei.gao@foxmail.com wrote:
> Hi, Greg
> 
> On 2019/8/21 上午12:59, Greg Kroah-Hartman wrote:
> > On Tue, Aug 20, 2019 at 09:08:55PM +0800, zhangfei wrote:
> > > 
> > > On 2019/8/15 下午10:13, Greg Kroah-Hartman wrote:
> > > > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > > > +int uacce_register(struct uacce *uacce)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!uacce->pdev) {
> > > > > +		pr_debug("uacce parent device not set\n");
> > > > > +		return -ENODEV;
> > > > > +	}
> > > > > +
> > > > > +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
> > > > > +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> > > > > +		dev_warn(uacce->pdev,
> > > > > +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
> > > > > +	}
> > > > THat is odd, why even offer this feature then if it is a major issue?
> > > UACCE_DEV_NOIOMMU maybe confusing here.
> > > 
> > > In this mode, app use ioctl to get dma_handle from dma_alloc_coherent.
> > That's odd, why not use the other default apis to do that?
> > 
> > > It does not matter iommu is enabled or not.
> > > In case iommu is disabled, it maybe dangerous to kernel, so we added warning here, is it required?
> > You should use the other documentated apis for this, don't create your
> > own.
> I am sorry, not understand here.
> Do you mean there is a standard ioctl or standard api in user space, it can
> get dma_handle from dma_alloc_coherent from kernel?

There should be a standard way to get such a handle from userspace
today.  Isn't that what the ion interface does?  DRM also does this, as
does UIO I think.

Do you have a spec somewhere that shows exactly what you are trying to
do here, along with example userspace code?  It's hard to determine it
given you only have one "half" of the code here and no users of the apis
you are creating.

thanks,

greg k-h
