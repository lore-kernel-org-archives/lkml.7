Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B012AECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844252067D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571285509;
	bh=OG/e9cbDVf6MXuiL6WpjqtCgrty2CJLM5dlbKC/B2s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gHo2+FHKTl0gHmjSZPGeGdcySlgkSTVpqTIC+zfB6wmnJJh21eBJjX1I3d4ZPfqgo
	 YDi/MYP+iIXkPFMARS+/iPiLfG/mGk6uSstfy75o21t1TtQRtmNxQDPXAqMg5SSwOg
	 ruWcVrIbQ5NfgBifjhrRQ01livp01OGCiuGxjoaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407721AbfJQELh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 00:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407691AbfJQELg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 00:11:36 -0400
Received: from localhost (unknown [122.178.218.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CBA2067D;
        Thu, 17 Oct 2019 04:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571285495;
        bh=OG/e9cbDVf6MXuiL6WpjqtCgrty2CJLM5dlbKC/B2s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CApPIGjjgv7lxeVcwfArS9QvEROVMD8J6i+CPDXVslaZX4+UbSSSjui4ZAW66vKYf
         EhDhrFllt8RKoDbVjew8WsIsTFPuvVvsqeY8KK4WRrJtgmqvDXU/Q4cWvGz52gmt3l
         /ZEar8610bvYZJqhBB21DTJLAFN/hqpN2Pk1BXKM=
Date:   Thu, 17 Oct 2019 09:41:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data Path DMA
 Interface) support
Message-ID: <20191017041124.GN2654@vkoul-mobl>
References: <20190930020440.7754-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930020440.7754-1-peng.ma@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-09-19, 02:04, Peng Ma wrote:
> The MC(Management Complex) exports the DPDMAI(Data Path DMA Interface)
> object as an interface to operate the DPAA2(Data Path Acceleration
> Architecture 2) qDMA Engine. The DPDMAI enables sending frame-based
> requests to qDMA and receiving back confirmation response on transaction
> completion, utilizing the DPAA2 QBMan(Queue Manager and Buffer Manager
> hardware) infrastructure. DPDMAI object provides up to two priorities for
> processing qDMA requests.
> The following list summarizes the DPDMAI main features and capabilities:
> 	1. Supports up to two scheduling priorities for processing
> 	service requests.
> 	- Each DPDMAI transmit queue is mapped to one of two service
> 	priorities, allowing further prioritization in hardware between
> 	requests from different DPDMAI objects.
> 	2. Supports up to two receive queues for incoming transaction
> 	completion confirmations.
> 	- Each DPDMAI receive queue is mapped to one of two receive
> 	priorities, allowing further prioritization between other
> 	interfaces when associating the DPDMAI receive queues to DPIO
> 	or DPCON(Data Path Concentrator) objects.
> 	3. Supports different scheduling options for processing received
> 	packets:
> 	- Queues can be configured either in 'parked' mode (default),
> 	or attached to a DPIO object, or attached to DPCON object.
> 	4. Allows interaction with one or more DPIO objects for
> 	dequeueing/enqueueing frame descriptors(FD) and for
> 	acquiring/releasing buffers.
> 	5. Supports enable, disable, and reset operations.
> 
> Add dpdmai to support some platforms with dpaa2 qdma engine.

Applied both, thanks

-- 
~Vinod
