Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64497C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6B9218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553933524;
	bh=CmXayo+v2L6LUnVuA0ctB6cNGDm6jVh2TuombAr/QbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EoxIivhDuQzQGjhkzHPeWgZJn+Eb+jWvR2I/GPdQEcAUYlcxw4beiBYoxGBkGxqZu
	 A4yfQYkAHwuZrBCcpwtDtR/B7k8t38JN+tUoKbMTFzCxjMyTDlP/LhAX4Jaah/Nno+
	 MmXDOIIUWh+knCUTJzbkdChkOOOGX9tisLrtoahE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfC3IMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 04:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfC3IMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 04:12:02 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7B4218A3;
        Sat, 30 Mar 2019 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553933521;
        bh=CmXayo+v2L6LUnVuA0ctB6cNGDm6jVh2TuombAr/QbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HkGiUP11NPRnLchIrAeqdvG2n2/hPh1bVomFVseaUb9kAQ4cOI744fMQlduiJaE5+
         5mER87/z6a15aAe0HmlUAIkP27nS/rrgV0UncAXrj6I9644czXbvyGmn8ag2nPBpBD
         o4PS3+QrpjaFNVLxR25ywmmLx+5YbqlO2ZlxDeTY=
Date:   Sat, 30 Mar 2019 09:11:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: a kernel address leak via copy_to_user in drivers/tty/rocket.c
Message-ID: <20190330081156.GA3149@kroah.com>
References: <CABXRUiSUzuf+Ki1Pj9oUkgZC0ELkA4N1aZpwBrZ7Gu3nyGwPMQ@mail.gmail.com>
 <20190330071413.GA5507@kroah.com>
 <CABXRUiSvSP=L3Twkya9HiuzQHmJngTET3XEKoxGGpSfPxb-_tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXRUiSvSP=L3Twkya9HiuzQHmJngTET3XEKoxGGpSfPxb-_tw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 04:02:38PM +0800, Fuqian Huang wrote:
> I add a function to mask all pointer fields of struct r_port. (Other
> pointer fields may have a similar issue, so I set all pointer fields
> to NULL);
> The modified code is marked with ">"
> 
> >1274 static void mask_pointer(struct r_port *info, struct r_port *masked_info) {
> >1275   memcpy(masked_info, info, sizeof (struct r_port));
> >1276   masked_info->port.tty = NULL;
> >1277   masked_info->port.itty = NULL;
> >1278   masked_info->port.ops = NULL;
> >1279   masked_info->port.client_ops = NULL;
> >1280   memset(&masked_info->port.open_wait.head, 0, sizeof(struct list_head));
> >1281   memset(&masked_info->port.delta_msr_wait.head, 0, sizeof(struct list_head));
> >1282   memset(&masked_info->port.mutex.wait_list, 0, sizeof(struct list_head));
> >1283   memset(&masked_info->port.buf_mutex.wait_list, 0, sizeof(struct list_head));
> >1284   masked_info->port.xmit_buf = NULL;
> >1285   masked_info->port.client_data = NULL;
> >1286   masked_info->ctlp = NULL;
> >1287   masked_info->xmit_buf = NULL;
> >1288   memset(&masked_info->write_mtx.wait_list, 0, sizeof(struct list_head));
> >1289 }
> 1290
> 1291 /*  IOCTL call handler into the driver */
> 1292 static int rp_ioctl(struct tty_struct *tty,
> 1293         unsigned int cmd, unsigned long arg)
> 1294 {
> 1295   struct r_port *info = tty->driver_data;
> >1296   struct r_port *masked_info;
> 1297   void __user *argp = (void __user *)arg;
> 1298   int ret = 0;
> 1299
> 1300   if (cmd != RCKP_GET_PORTS && rocket_paranoia_check(info, "rp_ioctl"))
> 1301     return -ENXIO;
> 1302   switch (cmd) {
> 1303   case RCKP_GET_STRUCT:
> >1304     masked_info = kzalloc(sizeof (struct r_port), GFP_KERNEL);
> >1305     mask_pointer(info, masked_info);
> >1306     if (copy_to_user(argp, masked_info, sizeof (struct r_port)))
> 1307       ret = -EFAULT;

Please read Documentation/SubmittingPatches for the proper way to create
and submit a patch such that we can apply it.

thanks!

greg k-h
