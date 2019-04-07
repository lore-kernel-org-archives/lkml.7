Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FBC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D1821738
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554633587;
	bh=G6jRbH0bBh2cBTiCzCampR253T6O8EqMZ00FgXlSVzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VLKXtTOzuxB/bH1qj4vDHqCQbNXxoF8VWGiR+ctXVKAGA5q0P4q+Dlq7Oi5CPGzlN
	 aNrX0iyUaSrrD4ZvVd0TLeMqXhkN8dI90XIXiya0ieSgke6riChbsX8sODtNT+F/oC
	 Pr4A49+PI7Nzjpb3W1g8otT0vh/wCHjkWQNXd0jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfDGKjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfDGKjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 06:39:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9238213F2;
        Sun,  7 Apr 2019 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554633584;
        bh=G6jRbH0bBh2cBTiCzCampR253T6O8EqMZ00FgXlSVzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oq7WCol2obeQGK85HmY3uQgGLUHEBgpSGtw/2LdjZgZGlNlsRO+M4Ebh7dJ1hHIOd
         M6fhYc7SQJfbZWwPltmx0kE94ex/lSPznwVICvxaNqgEfFQsjUjAiy+1Ps+Y+aycO0
         nIGMbtyehTvzniNMm2dkk3mtvyJi2JCw3RUhlMts=
Date:   Sun, 7 Apr 2019 11:39:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] iio: accell: mma8452: free iio trigger pointer when
 cleanup
Message-ID: <20190407113939.0717a6c9@archlinux>
In-Reply-To: <1554364635-19653-1-git-send-email-Anson.Huang@nxp.com>
References: <1554364635-19653-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 08:02:05 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> When mma8452 is built as module, once it is insmod and rmmod, below
> kernel dump will show out, the root cause is module being put twice
> if iio trigger pointer is NOT NULL, this patch frees iio trigger
> pointer after iio trigger is unregistered to avoid below kernel
> dump:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 270 at kernel/module.c:1145 module_put+0xd0/0x188
> Modules linked in: mma8452(-)
> CPU: 3 PID: 270 Comm: rmmod Not tainted 5.1.0-rc3-next-20190403-00022-g5ede0c9-dirty #1596
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [<c011272c>] (unwind_backtrace) from [<c010d094>] (show_stack+0x10/0x14)
> [<c010d094>] (show_stack) from [<c0bdc160>] (dump_stack+0xd8/0x10c)
> [<c0bdc160>] (dump_stack) from [<c01275d8>] (__warn+0xf8/0x124)
> [<c01275d8>] (__warn) from [<c0127714>] (warn_slowpath_null+0x3c/0x48)
> [<c0127714>] (warn_slowpath_null) from [<c01ca4d0>] (module_put+0xd0/0x188)
> [<c01ca4d0>] (module_put) from [<c08a5bb4>] (iio_device_unregister_trigger_consumer+0x18/0x24)
> [<c08a5bb4>] (iio_device_unregister_trigger_consumer) from [<c08a0ab4>] (iio_dev_release+0x20/0)
> [<c08a0ab4>] (iio_dev_release) from [<c065c0e8>] (device_release+0x24/0x8c)
> [<c065c0e8>] (device_release) from [<c0be1810>] (kobject_put+0x74/0xd4)
> [<c0be1810>] (kobject_put) from [<c0664dc0>] (release_nodes+0x16c/0x1f0)
> [<c0664dc0>] (release_nodes) from [<c0661b80>] (device_release_driver_internal+0xec/0x1a0)
> [<c0661b80>] (device_release_driver_internal) from [<c0661c90>] (driver_detach+0x44/0x80)
> [<c0661c90>] (driver_detach) from [<c066096c>] (bus_remove_driver+0x4c/0xa0)
> [<c066096c>] (bus_remove_driver) from [<c01cc1a4>] (sys_delete_module+0x130/0x1dc)
> [<c01cc1a4>] (sys_delete_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xe8d87fa8 to 0xe8d87ff0)
> 7fa0:                   0001ffc0 38616d6d be87bbf0 00000880 00000000 be87be98
> 7fc0: 0001ffc0 38616d6d 00323534 00000081 000a9744 be87bf81 000a9790 00000000
> 7fe0: be87bbe8 be87bbd8 0001fe18 b6e381a0
> irq event stamp: 4017
> hardirqs last  enabled at (4035): [<c0188a0c>] console_unlock+0x400/0x630
> hardirqs last disabled at (4052): [<c018868c>] console_unlock+0x80/0x630
> softirqs last  enabled at (4050): [<c0102698>] __do_softirq+0x458/0x554
> softirqs last disabled at (4069): [<c012ed6c>] irq_exit+0x130/0x180
> ---[ end trace a7ba8f1823b1e073 ]---
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Good fine, but the fix is not in the best place.  The key thing is that
any assignment inside a driver to iio_dev->trig should be done
with iio_trigger_get.

indio_dev->trig = iio_trigger_get(trig).  The intent is to avoid this
exact double free, but also handle it correctly if we are using
devm_ for all the handling.

I just did a grep and there are quite a few drivers not doing this though
so it's one we should be more careful about.

Hmm. Anyone fancy doing an audit of existing drivers and checking which
ones have this problem?  Some seem to do exactly what you have
here, but that isn't a the best pattern to encourage.

For this one would you mind trying with the iio_trigger_get
approach and if I'm not missing something, send a v2 fixing it
that way?

Thanks

Jonathan


> ---
>  drivers/iio/accel/mma8452.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 3027811..6b18177 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1475,8 +1475,10 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
>  
>  static void mma8452_trigger_cleanup(struct iio_dev *indio_dev)
>  {
> -	if (indio_dev->trig)
> +	if (indio_dev->trig) {
>  		iio_trigger_unregister(indio_dev->trig);
> +		indio_dev->trig = NULL;
> +	}
>  }
>  
>  static int mma8452_reset(struct i2c_client *client)

