Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BECC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D14721743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfEUP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:27:47 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:50146 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEUP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:27:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A52EE3F847;
        Tue, 21 May 2019 17:27:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pXdB0DCDnpoE; Tue, 21 May 2019 17:27:44 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9932C3F73E;
        Tue, 21 May 2019 17:27:43 +0200 (CEST)
Date:   Tue, 21 May 2019 17:27:43 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        JuergenUrban@gmx.de
Subject: Re: [PATCH v5 2/5] USB: use genalloc for USB HCs with local memory
Message-ID: <20190521152743.GA4693@sx9>
References: <20190521140748.20012-1-laurentiu.tudor@nxp.com>
 <20190521140748.20012-3-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190521140748.20012-3-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Laurentiu!

> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -216,6 +216,9 @@ struct usb_hcd {
>  #define	HC_IS_RUNNING(state) ((state) & __ACTIVE)
>  #define	HC_IS_SUSPENDED(state) ((state) & __SUSPEND)
>  
> +	/* allocator for HCs having local memory */
> +	struct gen_pool         *localmem_pool;
> +

I have tested patches 1, 2 and 5, and they seem to work. Nice! May I
suggest clarifying the NULL pointers? I think that may help someone
debugging or maintaining this in the future. Something like this:

--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -385,6 +385,8 @@ struct ohci_hcd {
 
 	/*
 	 * memory management for queue data structures
+	 *
+	 * @td_cache and @ed_cache are %NULL if &usb_hcd.localmem_pool is used.
 	 */
 	struct dma_pool		*td_cache;
 	struct dma_pool		*ed_cache;
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -211,7 +211,7 @@ struct usb_hcd {
 #define	HC_IS_RUNNING(state) ((state) & __ACTIVE)
 #define	HC_IS_SUSPENDED(state) ((state) & __SUSPEND)
 
-	/* allocator for HCs having local memory */
+	/* allocator for HCs having local memory, or %NULL */
 	struct gen_pool         *localmem_pool;
 
 	/* more shared queuing code would be good; it should support

Fredrik
