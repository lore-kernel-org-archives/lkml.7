Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A63C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058DD214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LPkgo6ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfCLQiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:38:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UiOQp9qUbRXpmfo0n/2vGWlv5vBMy1xj5zDW0UdwMJ8=; b=LPkgo6yaZhgT2XWC3e6KKTUFV
        tkJVSw1OPM/FPkyZizs4jOGRX5hRA9HycLpTAWe0XeTHzutqvQYdu61xMXFH1yvhQqBupVKxe72f8
        gLLCiFPiwkfz1tpggh5ZpOqAdilyrSe5ymNIgpd9GCYq+b165LEWbRYfSjfPucQMTj0lk9h4WAmxy
        rgyR1DHJl7b97y5PhbD2WDs5EuIN5MhnbR46uuGfYOn7WcVkQN3F3gphUriBPwAu6Kf90SwC/X3pK
        J3vuifU/X2GCuaxRiYQmi/wL3poPP+qL59i2L6LboZM5Jp001R//FZl9wdnSIYTRoHbcq+D9aDtDE
        SpLSSzNdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3kQP-0004jF-Gm; Tue, 12 Mar 2019 16:38:45 +0000
Date:   Tue, 12 Mar 2019 09:38:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
Message-ID: <20190312163845.GA13141@infradead.org>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312060005.12189-5-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
> This adds the APIs for bounce buffer specified domain
> map() and unmap(). The start and end partial pages will
> be mapped with bounce buffered pages instead. This will
> enhance the security of DMA buffer by isolating the DMA
> attacks from malicious devices.

Please reuse the swiotlb code instead of reinventing it.
