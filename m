Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40398C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B87022DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567572573;
	bh=RYQZWS5hLfcr4O5kK1IFeMvLQwPkEx3NNbUeONqFX3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JwyT06KkKBPUCtDlKhyQ+nTqrDPl67bfkY3T4guF9O+iYxGp1G5aUUwg+wb7BMbIE
	 /GBq1g/jM7LAwNLN910ZT4ldx0jGNmVRQn3R73UjaTbcFKXIzeiMNW/dKJIFOKvgE8
	 MAiDcXyb3EdTVI6pGjdj51Q3ZFz6iT8PU5rGZsYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfIDEtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDEtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:49:32 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32FD22CED;
        Wed,  4 Sep 2019 04:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567572571;
        bh=RYQZWS5hLfcr4O5kK1IFeMvLQwPkEx3NNbUeONqFX3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssDS0DU1XeYSG1mO+bd136PXrajZ/9hLDpCa8jw1UoALJgtf8mDfybn7yqyTiEKHg
         BodLq3Ixe+2kcnGxiNCnVqYxx1CXfZLqelCQzWeo+5J96jr5g0NAWv3DdMGSxpfDz6
         TdzBHzoTtjGYjrYEwUSyBE8JKevALla8afoRr0Zw=
Date:   Wed, 4 Sep 2019 10:18:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioat/dca: Use struct_size() helper
Message-ID: <20190904044822.GX2672@vkoul-mobl>
References: <20190828184015.GA4273@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828184015.GA4273@embeddedor>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-19, 13:40, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct ioat_dca_priv {
> 	...
>         struct ioat_dca_slot     req_slots[0];
> };
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following form:
> 
> sizeof(*ioatdca) + (sizeof(struct ioat_dca_slot) * slots)
> 
> with:
> 
> struct_size(ioatdca, req_slots, slots)
> 
> This code was detected with the help of Coccinelle.

Please do not invent subsystem tags, git log should tell you the
convention to be used!

Applied after fixing tags, thanks

-- 
~Vinod
