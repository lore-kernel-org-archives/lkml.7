Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60538C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FB42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfEUKci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:32:38 -0400
Received: from verein.lst.de ([213.95.11.211]:59186 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfEUKch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:32:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B230C68AFE; Tue, 21 May 2019 12:32:14 +0200 (CEST)
Date:   Tue, 21 May 2019 12:32:14 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Message-ID: <20190521103214.GB1973@lst.de>
References: <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com> <20190514182931.GA2559@sx9> <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com> <20190515162858.GB17162@sx9> <ed63c117-610c-ea49-f45e-727be220745f@nxp.com> <20190516151548.GB53952@sx9> <5fa97254-3038-6fe7-a7e7-a267262049c6@nxp.com> <20190517174159.GA32450@sx9> <3c8897e9-218e-3fff-1735-816ffd30e908@nxp.com> <20190520154156.GA3664@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520154156.GA3664@sx9>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 05:41:56PM +0200, Fredrik Noring wrote:
> 2. A device address is supplied as phys_addr_t phys to gen_pool_add_virt().
>    This seems to work in this particular DMA application, but there will be
>    problems if someone does phys_to_virt() or suchlike. Can this be improved
>    or clearly explained? gen_pool_virt_to_phys() searches in address ranges,
>    for example, so it appears the implementation uses phys quite carefully.

Well, it is a physical address, but not one that has a kernel mapping.
So phys_addr_t seems right here, but an additional comment explaining it
is not in the kernel mapping never hurts.
