Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78FBC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A839420675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbfETJWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:22:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729598AbfETJWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:22:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07D5DAF5F;
        Mon, 20 May 2019 09:22:24 +0000 (UTC)
Message-ID: <1558343365.12672.2.camel@suse.com>
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
From:   Oliver Neukum <oneukum@suse.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     linux-mm@kvack.org, gregkh@linuxfoundation.org,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        m.szyprowski@samsung.com, ytk.lee@samsung.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 20 May 2019 11:09:25 +0200
In-Reply-To: <20190520055657.GA31866@infradead.org>
References: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
         <20190520055657.GA31866@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On So, 2019-05-19 at 22:56 -0700, Christoph Hellwig wrote:
> Folks, you can't just pass arbitary GFP_ flags to dma allocation
> routines, beause very often they are not just wrappers around
> the page allocator.
> 
> So no, you can't just fine grained control the flags, but the
> existing code is just as buggy.
> 
> Please switch to use memalloc_noio_save() instead.
> 

Hi,

we actually do. It is just higher up in the calling path:

int usb_reset_device(struct usb_device *udev)
{
        int ret;
        int i;
        unsigned int noio_flag;
        struct usb_port *port_dev;
        struct usb_host_config *config = udev->actconfig;
        struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);

        if (udev->state == USB_STATE_NOTATTACHED ||
                        udev->state == USB_STATE_SUSPENDED) {
                dev_dbg(&udev->dev, "device reset not allowed in state %d\n",
                                udev->state);
                return -EINVAL;
        }

        if (!udev->parent) {
                /* this requires hcd-specific logic; see ohci_restart() */
                dev_dbg(&udev->dev, "%s for root hub!\n", __func__);
                return -EISDIR;
        }

        port_dev = hub->ports[udev->portnum - 1];

        /*
         * Don't allocate memory with GFP_KERNEL in current
         * context to avoid possible deadlock if usb mass
         * storage interface or usbnet interface(iSCSI case)
         * is included in current configuration. The easist
         * approach is to do it for every device reset,
         * because the device 'memalloc_noio' flag may have
         * not been set before reseting the usb device.
         */
        noio_flag = memalloc_noio_save();

So, do we need to audit the mem_flags again?
What are we supposed to use? GFP_KERNEL?

	Regards
		Oliver

