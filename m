Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A03C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6EA20715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577102672;
	bh=vqOz333XcUpVViuOrdBVCgE2uG8ahOJUCqixAmKA3Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hfgo955UIYQgN0yEaHGHLKlPH+mq6jxt49U6jg9w81neEMN8/9nU0IR04EGpia9tx
	 OcixpMg0ArUaY40ePtuBzob9ip24850ugWGsmD2dsQBDIumpD3jhck8eJUPp88l7TO
	 B7ZTZ1wB1zf76QDW0BLzE6GDsgFx89E5EAlEa5gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLWMEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfLWMEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 07:04:30 -0500
Received: from localhost (50-198-241-253-static.hfc.comcastbusiness.net [50.198.241.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F8A20709;
        Mon, 23 Dec 2019 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577102670;
        bh=vqOz333XcUpVViuOrdBVCgE2uG8ahOJUCqixAmKA3Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PP3Sh8ubh48fkuc5aTmqk2o+R2cjxLpWJIg2mIbr1NOL838UsBUAQ9XMXIBcBzFhq
         51cQqlfQkRwTVyvj/TJwr1Jdx4xPvaa8IjKDjzAsJrlcfodNeH4auuRVAxhp0rrEmB
         anlEtoUZgq0eSeFnUDDXtNQ6ok7Bhi7MQiJiFv+s=
Date:   Mon, 23 Dec 2019 07:04:28 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        vincent.whitchurch@axis.com, alexios.zavras@intel.com,
        tglx@linutronix.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: Re: [PATCH] misc: Use kzalloc() instead of kmalloc() with flag
 GFP_ZERO.
Message-ID: <20191223120428.GB114474@kroah.com>
References: <1577065918-25513-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577065918-25513-1-git-send-email-wang.yi59@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 09:51:58AM +0800, Yi Wang wrote:
> From: Huang Zijiang <huang.zijiang@zte.com.cn>
> 
> Use kzalloc instead of manually setting kmalloc
> with flag GFP_ZERO since kzalloc sets allocated memory
> to zero.
> 
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  drivers/misc/mic/host/mic_boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
> index 7335759..c1f87a4 100644
> --- a/drivers/misc/mic/host/mic_boot.c
> +++ b/drivers/misc/mic/host/mic_boot.c
> @@ -137,7 +137,7 @@ static void *__mic_dma_alloc(struct device *dev, size_t size,
>      struct scif_hw_dev *scdev = dev_get_drvdata(dev);
>      struct mic_device *mdev = scdev_to_mdev(scdev);
>      dma_addr_t tmp;
> -    void *va = kmalloc(size, gfp | __GFP_ZERO);
> +void *va = kzalloc(size, gfp);

Odd indation :(

Always use checkpatch.pl on your patches to ensure you do not add new
problems.

How did this get past 2 different people???

greg k-h
