Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B79C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D747B20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfHLOUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:20:09 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46886 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727206AbfHLOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:20:08 -0400
Received: (qmail 2923 invoked by uid 2102); 12 Aug 2019 10:20:07 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Aug 2019 10:20:07 -0400
Date:   Mon, 12 Aug 2019 10:20:07 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
cc:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <877e7iu0xw.fsf@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908121018430.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Felipe Balbi wrote:

> I don't understand the intricacies of the coherent API to judge if it's
> a bug in the API itself. In any case, here's where the splat comes from:
> 
> void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> 		dma_addr_t dma_handle, unsigned long attrs)
> {
> 	const struct dma_map_ops *ops = get_dma_ops(dev);
> 
> 	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
> 		return;
> 	/*
> 	 * On non-coherent platforms which implement DMA-coherent buffers via
> 	 * non-cacheable remaps, ops->free() may call vunmap(). Thus getting
> 	 * this far in IRQ context is a) at risk of a BUG_ON() or trying to
> 	 * sleep on some machines, and b) an indication that the driver is
> 	 * probably misusing the coherent API anyway.
> 	 */
> 	WARN_ON(irqs_disabled());
> 
> 	if (!cpu_addr)
> 		return;
> 
> 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
> 	if (dma_is_direct(ops))
> 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
> 	else if (ops->free)
> 		ops->free(dev, size, cpu_addr, dma_handle, attrs);
> }
> EXPORT_SYMBOL(dma_free_attrs);
> 
> maybe you're gonna have to fire up a workqueue to free this memory for
> you :-(
> 
> Unless someone else has better ideas. Alan, Greg, any ideas?

I don't understand it very well myself, but there have been posts by 
some of the DMA maintainers on this topic.  Maybe you can try asking 
them.

Alan Stern

