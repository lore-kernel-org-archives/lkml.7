Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F5EC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E638320657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEPPP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:15:57 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:25841 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfEPPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:15:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 308A33F7BB;
        Thu, 16 May 2019 17:15:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rg8RyAX5x_3t; Thu, 16 May 2019 17:15:48 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 7DC0A3F5A0;
        Thu, 16 May 2019 17:15:48 +0200 (CEST)
Date:   Thu, 16 May 2019 17:15:48 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Message-ID: <20190516151548.GB53952@sx9>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com>
 <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com>
 <20190515162858.GB17162@sx9>
 <ed63c117-610c-ea49-f45e-727be220745f@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed63c117-610c-ea49-f45e-727be220745f@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

> I took your code, added the missing mapping and placed it in a patch. 
> Please see attached (compile tested only).

Thanks! Unfortunately, the OHCI fails with errors such as

	usb 1-1: device descriptor read/64, error -12

that I tracked down to the calls

	   hub_port_init
	-> usb_control_msg
	-> usb_internal_control_msg
	-> usb_start_wait_urb
	-> usb_submit_urb
	-> usb_hcd_submit_urb
	-> hcd->driver->urb_enqueue
	-> ohci_urb_enqueue
	-> ed_get
	-> ed_alloc
	-> dma_pool_zalloc
	-> dma_pool_alloc
	-> pool_alloc_page,

which returns NULL. Then I noticed

	/* pool_alloc_page() might sleep, so temporarily drop &pool->lock */

that might be a problem considering that the HCD handles pool memory in
IRQ handlers, for instance:

	   do_IRQ
	-> generic_handle_irq
	-> handle_level_irq
	-> handle_irq_event
	-> handle_irq_event_percpu
	-> __handle_irq_event_percpu
	-> usb_hcd_irq
	-> ohci_irq
	-> ohci_work
	-> finish_urb
	-> __usb_hcd_giveback_urb
	-> usb_hcd_unmap_urb_for_dma
	-> hcd_buffer_free

Also, DMA_BUFFER_SIZE in ohci-ps2.c is only 256 KiB in total. Is the new
pool implementation at least as efficient as the previous one?

Fredrik
