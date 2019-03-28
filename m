Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DBAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466E92173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfC1PPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:15:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfC1PPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:15:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AE8FAFB8;
        Thu, 28 Mar 2019 15:15:48 +0000 (UTC)
Message-ID: <1553786139.14990.6.camel@suse.com>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
From:   Oliver Neukum <oneukum@suse.com>
To:     Kento.A.Kobayashi@sony.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     usb-storage@lists.one-eyed-alien.net, Jacky.Cao@sony.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Thu, 28 Mar 2019 16:15:39 +0100
In-Reply-To: <AE5419EAB4965843B3C0C1FE29F1FFE588FCC9@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
         <1552063928.29776.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
         <1552405047.21557.7.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE5873FFB@JPYOKXMS103.jp.sony.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE588EA40@JPYOKXMS103.jp.sony.com>
         <1553510086.2668.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE588FCC9@JPYOKXMS103.jp.sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2019-03-28 at 07:53 +0000, Kento.A.Kobayashi@sony.com wrote:
> Hi,
> 
> > Sorry,
> > 
> > I thought this was clear. Your patch is making the assumption that the reset is triggered by the SCSI layer. You cannot make that assumption, as there is an ioctl for resetting a USB device.
> > In case we are getting an error during the reset (our endpoints vanish), the device driver must report that to the USB layer, so the driver will always be disconnected.
> > We cannot drop errors.
> > 
> > 	Regards
> > 		Oliver
> 
> This patch modified uas_post_reset to skip rebind operation to avoid exception while -ENODEV happens not drop error.
> If uas_post_reset happens -ENODEV, usb_reset_and_verify_device must happen error.
> So,when we use ioctl(USBDEVFS_RESET) to reset device, if usb_reset_and_verify_device happens error, the error will be reported through ioctl return value. 

OK, It is possible that I am stupid. We must rebind if uas_post_reset()
fails. The driver will crash without the endpoints. Can you please
explain again in greater detail, what you are trying to achieve?

	Regards
		Oliver

