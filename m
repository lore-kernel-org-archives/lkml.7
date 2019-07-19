Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3C0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E3021873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563573879;
	bh=WpIhaQ1joRo/MH17c0t17VXik9ibq2E9ekgS84Bsqq0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=tAKPeiSonp2rBvHymnlK8vnBfOs99BzIUVa8lVnPxh/vyovkR2dTBixe0R0sU8Q+4
	 KzcqXsOw0NBTwbcjj5HVdcY1QB7M0hmL5kfRZerHPjXIaLaFBQzDQP2p+fsQMw6xBQ
	 z5TEK/vjcPxlziqflSXmUSaIg1p1bMVjKp/DMSH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGSWEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 18:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfGSWEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:04:37 -0400
Received: from [172.20.8.67] (fs96f9c61d.tkyc509.ap.nuro.jp [150.249.198.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC2E2084D;
        Fri, 19 Jul 2019 22:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563573877;
        bh=WpIhaQ1joRo/MH17c0t17VXik9ibq2E9ekgS84Bsqq0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=urXENChsdLG1xeJQdusgUINM/llCFuGkdvhSq4cG5a3Yrv/AiqVp/HQC6s4LD/tDN
         14dvkAbSxzCr5Xmpnuc+1tKdq7HTFrwHBmxcsULbDkjOHyaX6O+oTFbk1gnlcncBvT
         OKOnhmedUzhdkvVUPs7l//ehcSC5UgGGIUhf3SW8=
Subject: Re: [PATCH v2 0/2] usbip: Implement SG support
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <7eaaf016-8da5-6089-fe19-bf62c3bbe187@kernel.org>
Date:   Fri, 19 Jul 2019 16:04:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705164355.14025-1-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/19 10:43 AM, Suwan Kim wrote:
> There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> doesn't supported SG, so USB storage driver on vhci breaks SG list
> into multiple URBs and it causes error that a transfer got terminated
> too early because the transfer length for one of the URBs was not
> divisible by the maxpacket size.
> 
> To support SG, vhci doesn't map and unmap URB for DMA to use native
> SG list (urb->num_sgs). In DMA mapping function of vhci, it sets
> URB_DMA_MAP_SG flag in urb->transfer_flags if URB has SG list and
> this flag will tell the stub driver to use SG list.
> 
> In this patch, vhci basically support SG and it sends each SG list
> entry to the stub driver. Then, the stub driver sees the total length
> of the buffer and allocates SG table and pages according to the total
> buffer length calling sgl_alloc(). After the stub driver receives
> completed URB, it again sends each SG list entry to vhci.
> 
> If HCD of the server doesn't support SG, the stub driver breaks a
> single SG reqeust into several URBs and submit them to the server's
> HCD. When all the split URBs are completed, the stub driver
> reassembles the URBs into a single return command and sends it to
> vhci.
> 
> Alan fixed vhci bug with the USB 3.0 storage device by modifying
> USB storage driver.
> ("usb-storage: Set virt_boundary_mask to avoid SG overflows")
> But the fundamental solution of it is to add SG support to vhci.
> 
> This patch works well with the USB 3.0 storage devices without Alan's
> patch, and we can revert Alan's patch if it causes some troubles.
> 
> Suwan Kim (2):
>    usbip: Skip DMA mapping and unmapping for urb at vhci
>    usbip: Implement SG support to vhci
> 
>   drivers/usb/usbip/stub.h         |   7 +-
>   drivers/usb/usbip/stub_main.c    |  52 +++++---
>   drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
>   drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
>   drivers/usb/usbip/usbip_common.c |  60 +++++++--
>   drivers/usb/usbip/vhci_hcd.c     |  29 ++++-
>   drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
>   7 files changed, 391 insertions(+), 121 deletions(-)
> 

Hi Suwan,

I have been traveling and would like to test this series before I ask
Greg to pick it up.

Just a quick note that I will get to this early next week.

thanks,
-- Shuah
