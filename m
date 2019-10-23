Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDAFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BB921906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="edqcx+u+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i0XqgQqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfJWQ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:58:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfJWQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:58:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BE63960DB8; Wed, 23 Oct 2019 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571849888;
        bh=e/wbk7W51qosh1x31nJNEuLAxvnQRx8M8ayYRV5U3eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edqcx+u+rlmocI2E86il4NC0lXAUiJ0VXXX3etgyxoQhitzri37iHd9IHR3m+TQR2
         UfNZeqL9X0vG9KyyxRLVx74Er4dWWritg0vZkDymTzbh4eogvCPS9DKIVbqjb/l0ek
         1jdStirZfReVfjq2xKODj+mbER4Ndow2NUIaIkOA=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D54960DB8;
        Wed, 23 Oct 2019 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571849887;
        bh=e/wbk7W51qosh1x31nJNEuLAxvnQRx8M8ayYRV5U3eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0XqgQqBfDxVfDQ6znF3gcx2COuTjhZ19Nb5eIKcq/bGbJHXbq5vbPqV2SOst+Ezg
         QbwXeTP6U403KXRPyXTAQh9kXzhHdZhRGTOHPvyXA0mwhlSZaPw8NEQ1x9f/IB+jlt
         OU9ynhfOTw1gvQQmNdk4JYrXtZJVqTixWAej2H1w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D54960DB8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Wed, 23 Oct 2019 09:58:04 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Correct the logic for finding last SG
 entry
Message-ID: <20191023165804.GD9754@jackp-linux.qualcomm.com>
References: <1559141985-17104-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <87y32gcvc1.fsf@linux.intel.com>
 <BYAPR02MB559181C009B74446A797838DA7170@BYAPR02MB5591.namprd02.prod.outlook.com>
 <87ftoldh48.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftoldh48.fsf@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anurag,

On Fri, Jun 07, 2019 at 09:49:59AM +0300, Felipe Balbi wrote:
> Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
> >>> The dma_map_sg() merges sg1 & sg2 memory regions into sg1-
> >>>dma_address.
> >>> Similarly sg3 & sg4 into sg2->dma_address, sg5 & sg6 into the
> >>> sg3->dma_address and sg6 & sg8 into sg4->dma_address. Here the
> >>memory
> >>> regions are merged but the page_link properties like SG_END are not
> >>> retained into the merged sgs.
> >>
> >>isn't this a bug in the scatterlist mapping code? Why doesn't it keep
> >>SG_END?
> >>
> >
> > Thanks for providing your comment.
> >
> > I don't think it is a bug, instead I feel some enhancement needs to be done in
> > dma-mapping code.
> >
> > SG_END represents the last sg entry in the sglist and it is correctly getting
> > set to the last sg entry.
> >
> > The issue happens only when 2 or more sg entry pages are merged into
> > contiguous dma-able address and sg_is_last() is used to find the last sg entry
> > with valid dma address.
> 
> Right, and that's something that's bound to happen. I'm arguing that, perhaps,
> dma API should move SG_END in case entries are merged.
> 
> > I think that along with sg_is_last() a new flag (SG_DMA_END) and function
> > (something like sg_dma_is_last() ) needs to be added into dma-mapping code for
> > identifying the last valid sg entry with valid dma address. So that we can
> > make use of that function instead of sg_is_last().
> 
> Sure, propose a patch to DMA API.

I'm curious if this was ever resolved. I just ran into this exact issue
with Android ADB which uses 16KB buffers, along with f_fs supporting
S/G since 5.0, combined with our IOMMU which performs this merging
behavior, so it resulted in a single TRB getting queued with CHN=1 and
LST=0 and thus the transfer never completes. Your initial patch resolves
the issue for me, but upon revisiting this discussion I couldn't tell if
you had attempted to patch DMA API instead as per Felipe's suggestion.

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
