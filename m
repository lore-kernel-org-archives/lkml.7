Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCA5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC200218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562168708;
	bh=4bEx2PHRJoMxBY41o63CkWSUHRgvU+55fu5hHJBmVlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0hhXYowlbiIa0M97SODk/EyW02Dg3YSelyjeP5l79tED6dBrfphuZu6irTxgnpQWk
	 ZnNM0g9jGUY7Xn33rwCuXRIJixH6qJEVtJAOfGuZw7VFaG5Dg7gxQfwHunTZgwFChS
	 e4iYm6zA5WfNh4+RcW0dJYqw5J8XhmWV0WXsE1FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGCPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:45:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7B6218A0;
        Wed,  3 Jul 2019 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562168705;
        bh=4bEx2PHRJoMxBY41o63CkWSUHRgvU+55fu5hHJBmVlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaVqK6h1gl+Cyxni2mC/7Xn8CTAtumIQJyp4FgWolL4t0qvKu3eXpedumtNPz1wXV
         HRHDX3XYtpo4P5Hc4taHDkrasv0w7WpVLnZu/zo46gegSHH44ZbMvTjGCl0463lBEo
         5pcRlbmzSpFSNNRbHfJT9KudFYI7nFceZDvm73+8=
Date:   Wed, 3 Jul 2019 17:45:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 1/9] intel_th: msu: Fix unused variable warning on
 arm64 platform
Message-ID: <20190703154503.GA19083@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
 <20190627125152.54905-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627125152.54905-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 03:51:44PM +0300, Alexander Shishkin wrote:
> From: Shaokun Zhang <zhangshaokun@hisilicon.com>
> 
> Commit ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
> introduced the following warnings on non-x86 architectures, as a result
> of reordering the multi mode buffer allocation sequence:
> 
> > drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
> > drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’
> > [-Wunused-variable]
> > int ret = -ENOMEM, i;
> >                    ^
> > drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
> > drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’
> > [-Wunused-variable]
> > int i;
> >     ^
> 
> Fix this compiler warning by factoring out set_memory sequences and making
> them x86-only.
> 
> Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> Fixes: ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/hwtracing/intel_th/msu.c | 40 +++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 13 deletions(-)

Should be backported to stable trees, I'll add the tag...

