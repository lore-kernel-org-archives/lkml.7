Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269CCC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69E42073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575451788;
	bh=olCGYBNqUiviVWQIvUISVF1ya1mFuGUwBKcuWe02w5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LVK03dxWOj3kjV6+DWUi6dDhkZLjrKy3NEgTpnvMg514Y/5KJuVDfYjSAss/jyk7m
	 t1+mHDRBdT+LvKYK+V4R+M1rApxpn6031i7g9jF6krRye60Nhceb8A9gdUZ3reyyXV
	 v6FL50lEVKx0+7rTLAkC2bLDl/TZ0kAmQQlVwjdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfLDJ3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:29:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfLDJ3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:29:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A18820675;
        Wed,  4 Dec 2019 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575451785;
        bh=olCGYBNqUiviVWQIvUISVF1ya1mFuGUwBKcuWe02w5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgpthHgQ4pZiPs1SeA4WN16ryXE8z7kGsS2Nfg7w3eSzy8phuZ/jczqJAkJdcoh+F
         dNfVPuA/3+EK+uS6fT4q+QMRDTKv7tQHPYYUkBX1K8f+C/22B1TPZB+KsJZCePobXH
         KmL81FjgHZO/PVDLHr4aRz1gYeqf8G+PSYwxrK6g=
Date:   Wed, 4 Dec 2019 10:29:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guoheyi <guoheyi@huawei.com>
Cc:     Mike Waychison <mikew@google.com>, linux-kernel@vger.kernel.org,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: firmware: dmi-sysfs: why is the access mode of dmi sysfs entries
 restricted to 0400?
Message-ID: <20191204092942.GA3557583@kroah.com>
References: <42bb2db8-66e0-3df4-75b7-98b2b2bcfca8@huawei.com>
 <20191204074133.GA3548765@kroah.com>
 <dac22bed-f138-471e-c19a-e31c5c910d48@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dac22bed-f138-471e-c19a-e31c5c910d48@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:01:06PM +0800, Guoheyi wrote:
> 
> 在 2019/12/4 15:41, Greg Kroah-Hartman 写道:
> > On Wed, Dec 04, 2019 at 03:31:22PM +0800, Guoheyi wrote:
> > > Hi,
> > > 
> > > Why is the access mode of dmi sysfs entries restricted to 0400? Is it for
> > > security concern? If it is, which information do we consider as privacy?
> > There's lots of "interesting" information in dmi entries that you
> > probably do not want all processes reading, which is why they are
> > restricted.
> > 
> > > We would like to fetch CPU information from non-root application, is there
> > > feasible way to do that?
> > What specific CPU information is not currently exported in /proc/cpuinfo
> > that only shows up in DMI entries that you are interested in?
> 
> We'd like to get processor manufacturer, speed and version, and pass the
> information to qemu virtual machine, for users of VM might be happy to see
> this instead of "unknown xxx", while qemu may run as non-root.

Careful about this as if you move that virtual machine around, those
values will change and if userspace was depending on them being static
(set up at program start time), then you might have problems.

good luck!

greg k-h
