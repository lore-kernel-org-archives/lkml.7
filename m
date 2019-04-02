Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD02C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E58820882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfDBOiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:38:18 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43348 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730797AbfDBOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:38:17 -0400
Received: (qmail 3132 invoked by uid 2102); 2 Apr 2019 10:38:16 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Apr 2019 10:38:16 -0400
Date:   Tue, 2 Apr 2019 10:38:16 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kento.A.Kobayashi@sony.com
cc:     oneukum@suse.com, <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
In-Reply-To: <AE5419EAB4965843B3C0C1FE29F1FFE58914EB@JPYOKXMS103.jp.sony.com>
Message-ID: <Pine.LNX.4.44L0.1904021033470.1562-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 Kento.A.Kobayashi@sony.com wrote:

> Hi,
> 
> >> Hi,
> >> 
> >> > Sorry,
> >> > 
> >> > I thought this was clear. Your patch is making the assumption that the reset is triggered by the SCSI layer. You cannot make that assumption, as there is an ioctl for resetting a USB device.
> >> > In case we are getting an error during the reset (our endpoints vanish), the device driver must report that to the USB layer, so the driver will always be disconnected.
> >> > We cannot drop errors.
> >> > 
> >> > 	Regards
> >> > 		Oliver
> >> 
> >> This patch modified uas_post_reset to skip rebind operation to avoid exception while -ENODEV happens not drop error.
> >> If uas_post_reset happens -ENODEV, usb_reset_and_verify_device must happen error.
> >> So,when we use ioctl(USBDEVFS_RESET) to reset device, if usb_reset_and_verify_device happens error, the error will be reported through ioctl return value. 
> >
> >OK, It is possible that I am stupid. We must rebind if uas_post_reset() fails. The driver will crash without the endpoints. Can you please explain again in greater detail, what you are trying to achieve?
> 
> Follow is details for this patch.
> 
> Issue
> - USB subsystem hangs if power off the hub port connecting UAS USB3.0/3.1 device by calling ioctl(USBDEVFS_CONTROL) to do Hub Class Request(CLEAR_FEATURE:PORT_POWER) while the device is being accessed. 
> - Status of the process that is accessing the device becomes DEAD and cannot be killed.
> 
> Root Cause
> - Block layer timeout happens after power off UAS USB device which is accessed as reproduce step. During timeout error handler process, scsi host state becomes SHOST_CANCEL_RECOVERY that causes IO hangs up and lock cannot be released. And in final, usb subsystem hangs up.
> Follow is function call:
> blk_mq_timeout_work 
>   …->scsi_times_out  (… means some functions are not listed before this function.)
>     …-> scsi_eh_scmd_add(scsi_host_set_state to SHOST_RECOVERY) 
>       … -> scsi_error_handler
>         …-> uas_eh_device_reset_handler
>             -> usb_lock_device_for_reset  <- take lock
>               -> usb_reset_device
>                 …-> rebind = uas_post_reset (return 1 since ENODEV) 
>                 …-> usb_unbind_and_rebind_marked_interfaces (rebind=1)
>                    …-> uas_disconnect  (scsi_host_set_state to SHOST_CANCEL_RECOVERY)
>                         … -> scsi_queue_rq

How does scsi_queue_rq get called here?  As far as I can see, this 
shouldn't happen.

>                              -> scsi_host_queue_ready(return 0 causes IO hangs up.)
>             -> usb_unlock_device          <- lock cannot be release since usb_reset_device not finish.
> 
> 
> Countermeasure
> - Make uas_post_reset doesn’t return 1 when ENODEV returns from uas_configure_endpoints since usb_unbind_and_rebind_marded_interfaces doesn’t need to do unbind/rebind operations in this situation.
> blk_mq_timeout_work
>   …->scsi_times_out  (… means some functions are not listed before this function.)
>     …-> scsi_eh_scmd_add(scsi_host_set_state to SHOST_RECOVERY) 
>       … -> scsi_error_handler
>        …-> uas_eh_device_reset_handler (*1)
>            -> usb_lock_device_for_reset  <- take lock
>              -> usb_reset_device
>                -> usb_reset_and_verify_device (return ENODEV and FAILED will be reported to *1)
>                -> uas_post_reset returns 0 when ENODEV => rebind=0 
>                -> usb_unbind_and_rebind_marked_interfaces (rebind=0)

The difference is that uas_disconnect wasn't called here.  But that
routine should not cause any problems -- you're always supposed to be
able to unbind a driver from a device.  So it looks like this is not
the right way to solve the problem.

Alan Stern

>            -> usb_unlock_device          <- release lock
> 
> 
> We can get error(-ENODEV) at uas_eh_device_reset_handler from usb_reset_and_verify_device.
> 
> Regards,
> Kento Kobayashi
> 

