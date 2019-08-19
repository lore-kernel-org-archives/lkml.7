Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7FBC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014132087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566210176;
	bh=STiJZOt42oj1KxMyTRjcwJ7/7jepLX+1DeqOPISvHu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=emGKitX1BVh4M8oUloqngW85WQvm/Z3ybncuynpqwxu4Wpz1YJiOOPO4mOWDjDZHZ
	 9ZfKQM0jXMCWmtjX5m6WxYJf/p9tWcTDpUhcD1lcLhwqpX/tV4Dp+fDg7z0RdIfSmT
	 iAgq+e6suACjryFnKZdL+PYjrzMX0Yrx+KxB0EFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfHSKWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfHSKWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:22:54 -0400
Received: from localhost (unknown [89.205.137.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0801A20844;
        Mon, 19 Aug 2019 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566210173;
        bh=STiJZOt42oj1KxMyTRjcwJ7/7jepLX+1DeqOPISvHu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSfvYQruOZ74HfxDq5pXJ335/bi8y292W1KajC1Gb/xZqJ2dJPULUtZLUlzHN+BKH
         +fGmW3CI81obiDkhZBHtTtF9taGxqOsiJRIjyvA864wPU9zQT2S2WaBDdEwb3j38r9
         LwJqt2Nf0Pn9Iy+ZdAfMc9UYJVWkyKAlzMFFDR54=
Date:   Mon, 19 Aug 2019 12:22:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190819102250.GA2030@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141225.GC23267@kroah.com>
 <5d5a6757.1c69fb81.e0678.2ab2SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d5a6757.1c69fb81.e0678.2ab2SMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:09:23PM +0800, zhangfei.gao@foxmail.com wrote:
> Hi, Greg
> 
> Thanks for your kind suggestion.
> 
> On 2019/8/15 下午10:12, Greg Kroah-Hartman wrote:
> > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > diff --git a/include/uapi/misc/uacce.h b/include/uapi/misc/uacce.h
> > > new file mode 100644
> > > index 0000000..44a0a5d
> > > --- /dev/null
> > > +++ b/include/uapi/misc/uacce.h
> > > @@ -0,0 +1,44 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +#ifndef _UAPIUUACCE_H
> > > +#define _UAPIUUACCE_H
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/ioctl.h>
> > > +
> > > +#define UACCE_CLASS_NAME	"uacce"
> > Why is this in a uapi file?
> User app need get attribute from /sys/class,
> For example: /sys/class/uacce/hisi_zip-0/xxx
> UACCE_CLASS_NAME here tells app which subsystem to open,
> /sys/class/subsystem/

But that never comes from a uapi file.  No other subsystem does this.

thanks,

greg k-h
