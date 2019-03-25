Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03692085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfCYKrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:47:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:34706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729727AbfCYKrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:47:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9605AAF3F;
        Mon, 25 Mar 2019 10:46:59 +0000 (UTC)
Message-ID: <1553510086.2668.2.camel@suse.com>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
From:   Oliver Neukum <oneukum@suse.com>
To:     Kento.A.Kobayashi@sony.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     usb-storage@lists.one-eyed-alien.net, Jacky.Cao@sony.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 25 Mar 2019 11:34:46 +0100
In-Reply-To: <AE5419EAB4965843B3C0C1FE29F1FFE588EA40@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
         <1552063928.29776.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
         <1552405047.21557.7.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE5873FFB@JPYOKXMS103.jp.sony.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE588EA40@JPYOKXMS103.jp.sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2019-03-25 at 10:21 +0000, Kento.A.Kobayashi@sony.com wrote:
> Hi,
> 
> > > > And the return value(-ENODEV) will be returned to error handler.
> > > > uas_eh_device_reset_handler->usb_reset_device -> usb_reset_and_verify_device (return -ENODEV) Then I wrote that commit message that we think even if we ignore "ENODEV" in post reset to avoid hang issue but the error will also be reported to error handler.
> > > > #If ignore an error and the error will not be reported then it is not good.
> > > 
> > > Well, what do we do now? Are you saying that the state model SCSI is using is wrong?
> > No, it is not wrong.
> > But I think we may want to prevend hang by sleep peocess with continuing to take a lock at blk_execute_rq() from >usb_unbind_and_rebind_marded_interfaces().
> 
> Could you please you can apply this patch for mainline or not?
> If not, could you please tell me why you can't allow to apply this patch?

Sorry,

I thought this was clear. Your patch is making the assumption that
the reset is triggered by the SCSI layer. You cannot make that
assumption, as there is an ioctl for resetting a USB device.
In case we are getting an error during the reset (our endpoints
vanish), the device driver must report that to the USB layer,
so the driver will always be disconnected.
We cannot drop errors.

	Regards
		Oliver

