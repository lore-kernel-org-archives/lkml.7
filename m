Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79763C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DA021852
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566192385;
	bh=8mqL7sJqdV6/4rHKJ1fvbrxryWKzfYZx2UQm6cr+Lx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BPpl7FNa0AiK/Nssehw2dgNvJ+ttOD9dCEFCPgVnX1suf0KxE5sp/qRHGiIExDqTb
	 R2aZjJQb+CFxHW+CfQwxNVLs59Vmavgud4WbwB4cDLt4rk1IRUtJx1WDD7HCZwcuhP
	 oh4t4rUxLA8wUclpX0lg/XBBVUtnUzc7qicgscXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfHSF0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfHSF0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:26:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50BC2087E;
        Mon, 19 Aug 2019 05:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566192382;
        bh=8mqL7sJqdV6/4rHKJ1fvbrxryWKzfYZx2UQm6cr+Lx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ron3YMkGmgUjS73C5r6xf1opxCK0Kg8aRrcqfOSFCPFjhqR+lSRPKkKxtxWuotyZ9
         cRtgbpGkjP8Ql46SBdHHIn2PMaXCC/8nNrjAvUcbckpVnniLEjf9hG/26UDt9sFrlv
         mol7mexXdm6LPwXLra4FZYgWTT6pmarJYUcDJ9do=
Date:   Mon, 19 Aug 2019 07:26:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     devel@driverdev.osuosl.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Jack Ren <jack.ren@intel.com>, Liu Shuo <shuo.a.liu@intel.com>,
        Mingqiang Chi <mingqiang.chi@intel.com>
Subject: Re: [RFC PATCH 04/15] drivers/acrn: add the basic framework of acrn
 char device driver
Message-ID: <20190819052619.GC915@kroah.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-5-git-send-email-yakui.zhao@intel.com>
 <20190816070559.GB1368@kroah.com>
 <cedb90e7-da98-9075-e647-075fa3a3e7ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cedb90e7-da98-9075-e647-075fa3a3e7ae@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:02:33PM +0800, Zhao, Yakui wrote:
> 
> 
> On 2019年08月16日 15:05, Greg KH wrote:
> > On Fri, Aug 16, 2019 at 10:25:45AM +0800, Zhao Yakui wrote:
> > > ACRN hypervisor service module is the important middle layer that allows
> > > the Linux kernel to communicate with the ACRN hypervisor. It includes
> > > the management of virtualized CPU/memory/device/interrupt for other ACRN
> > > guest. The user-space applications can use the provided ACRN ioctls to
> > > interact with ACRN hypervisor through different hypercalls.
> > > 
> > > Add one basic framework firstly and the following patches will
> > > add the corresponding implementations, which includes the management of
> > > virtualized CPU/memory/interrupt and the emulation of MMIO/IO/PCI access.
> > > The device file of /dev/acrn_hsm can be accessed in user-space to
> > > communicate with ACRN module.
> > > 
> > > Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
> > > Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> > > Co-developed-by: Jack Ren <jack.ren@intel.com>
> > > Signed-off-by: Jack Ren <jack.ren@intel.com>
> > > Co-developed-by: Mingqiang Chi <mingqiang.chi@intel.com>
> > > Signed-off-by: Mingqiang Chi <mingqiang.chi@intel.com>
> > > Co-developed-by: Liu Shuo <shuo.a.liu@intel.com>
> > > Signed-off-by: Liu Shuo <shuo.a.liu@intel.com>
> > > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > > ---
> > >   drivers/staging/Kconfig         |   2 +
> > 
> > Also, your subject line for all of these patches are wrong, it is not
> > drivers/acrn :(
> 
> Thanks for the pointing out it.
> 
> It will be fixed.
> 
> > 
> > And you forgot to cc: the staging maintainer :(
> 
> Do you mean that the maintainer of staging subsystem is also added in the
> patch commit log?

Did you not run scripts/get_maintainer.pl on your patches to determine
who to send patches to?  Always do that.

> > As I have said with NUMEROUS Intel patches in the past, I now refuse to
> > take patches from you all WITHOUT having it signed-off-by someone from
> > the Intel "OTC" group (or whatever the Intel Linux group is called these
> > days).  They are a resource you can not ignore, and if you do, you just
> > end up making the rest of the kernel community grumpy by having us do
> > their work for them :(
> > 
> > Please work with them.
> 
> OK. I will work with some peoples in OTC group to prepare the better ACRN
> driver.

Thank you.

greg k-h
