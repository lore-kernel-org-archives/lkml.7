Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F1AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06F20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfEPNyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:54:50 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:55164 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfEPNyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:54:49 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 09:54:49 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 5EC873F38D;
        Thu, 16 May 2019 15:47:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JVcPQQ_ePVLB; Thu, 16 May 2019 15:47:27 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 60D9F3F4C2;
        Thu, 16 May 2019 15:47:26 +0200 (CEST)
Date:   Thu, 16 May 2019 15:47:25 +0200
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
Message-ID: <20190516134725.GA53952@sx9>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com>
 <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com>
 <20190515162858.GB17162@sx9>
 <0fea5fa7-e2b0-b34d-3bf8-976007df2dc2@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fea5fa7-e2b0-b34d-3bf8-976007df2dc2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

> > The kernel oopses with "unable to handle kernel paging request at virtual
> > address 000aba0b" in hcd_alloc_coherent via usb_hcd_map_urb_for_dma. 
> 
> By any chance, does this address looks like the dma_addr that the device 
> should target?

Yes, that looks like a typical device address suitable for its DMA.

> Actually, I think I'm misusing genalloc and also it appears that i need 
> to add a mapping on the phys address. So my plan is to change the 
> "unsigned long virt" to be the void * returned by the mapping operation 
> and the phys_addr_t be the dma_addr_t. I'll return with a patch.

Great, I'm happy to test your next patch revision.

Fredrik
