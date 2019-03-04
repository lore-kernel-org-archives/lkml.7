Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5396EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156B120836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551692660;
	bh=zAZlAHRkJ7NKE4d+noU5LnAjtjHzfEn9tW99OJWjxw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2XTYBdtI4e04hBm+gU9fF4oocqIRkLQLxYx0febNLBQZUSNZQ3x0MX6RPxTLoAA8V
	 tdSKHMo9yBAeaSItdIeHF73QcW/IoU8rZVKcKt6R8bj7vfQG3C4PoJYikYkkjE78D7
	 LsdLq0zUCEA6vLWIMNZ9gwvM3LW76rqeACEtf7j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfCDJoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfCDJoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:44:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1847F20836;
        Mon,  4 Mar 2019 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551692657;
        bh=zAZlAHRkJ7NKE4d+noU5LnAjtjHzfEn9tW99OJWjxw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEl0S2YFmBDXnjfk7nTVsg22nZ1p9+FZZg25MzyCyCnCIqcP6hRxQ3NeFJrOe6T2u
         b1jVLn1nbxrgp0jTb78w8HeLj3eM26F1nTUnFYWb0ywmDolrFp+2pzIdmSPQXXKgzQ
         QEJEpa1Ph0yp3v3vJVH/DYvGnWaufsZgfi4ZtVJ4=
Date:   Mon, 4 Mar 2019 10:44:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "He, Bo" <bo.he@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wang, Yu Y" <yu.y.wang@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 12/88] usb: dwc3: gadget: synchronize_irq dwc irq in
 suspend
Message-ID: <20190304094414.GA12587@kroah.com>
References: <20190304081630.610632175@linuxfoundation.org>
 <20190304081631.046461963@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A5C632@SHSMSX104.ccr.corp.intel.com>
 <CGME20190304085654epcas2p1284f13532438678e8ba53d232ca02a34@epcas2p1.samsung.com>
 <20190304085350.GA18354@kroah.com>
 <a3d017c7-d671-3ba9-15d6-0028595d5d59@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d017c7-d671-3ba9-15d6-0028595d5d59@samsung.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:03:27AM +0100, Marek Szyprowski wrote:
> Hi Greg,
> 
> On 2019-03-04 09:53, Greg Kroah-Hartman wrote:
> > On Mon, Mar 04, 2019 at 08:46:30AM +0000, He, Bo wrote:
> >> Hi, Greg:
> >> 	Marek Szyprowski report the patch has issue that calling synchronize_irq() under dwc->lock spinlock, he has upload the below patch for the issue:
> >>
> >> dwc3_gadget_suspend() is called under dwc->lock spinlock. In such context calling synchronize_irq() is not allowed. Move the problematic call out of the protected block to fix the following kernel BUG during system
> > <snip>
> >
> > Is this patch in Linus's tree yet?  If so, what is the git commit id?
> >
> > If not, is this also an issue in 5.0?
> 
> The fix has not been merged yet. The issue is also present in v5.0.

Ok, please make sure it is properly tagged for the stable releases and
we will be fine.

thanks,

greg k-h
