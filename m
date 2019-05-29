Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F921C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61971208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QBf/sgE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfE2GQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:16:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfE2GQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZvSD57x006kLNUpKDRV5CxeOKDz/YIRDQvZo+hMkQZw=; b=QBf/sgE3gnBGHrSDWCr4TZBIR
        Ys10TSVWzIEQ2ik3RCMsUB+Do+4mLrCAv3ACbdTOWV7/RzIq0OEnqa7RmDU38QCphr7O4SHZclJrV
        P9vrmoFPS0Q6nMqExtar0WsFBgrA2rewQaaydtTKF1mdU78QcLD/JBOYAU8koDaLwpcfEu7eaRaU0
        W7p/TW9u0evxIBQt2WYccVxUMQEIIg7ybcylz7N/67xjhaUxsnGlToK7dd21ar0D4DoWiLBSA9es8
        807glmgPEO99VK5awoViXCsO+0/7+YXwKmVkh+IcZQi7V6IM0FZjMqx3973e+kE2PZFvzvc5LCSai
        mZFZjofsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVrsw-00086V-5O; Wed, 29 May 2019 06:16:26 +0000
Date:   Tue, 28 May 2019 23:16:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, dima@arista.com, tmurphy@arista.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 10/15] iommu/vt-d: Probe DMA-capable ACPI name space
 devices
Message-ID: <20190529061626.GA26055@infradead.org>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
 <20190525054136.27810-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525054136.27810-11-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 01:41:31PM +0800, Lu Baolu wrote:
> Some platforms may support ACPI name-space enumerated devices
> that are capable of generating DMA requests. Platforms which
> support DMA remapping explicitly declares any such DMA-capable
> ACPI name-space devices in the platform through ACPI Name-space
> Device Declaration (ANDD) structure and enumerate them through
> the Device Scope of the appropriate remapping hardware unit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Isn't this something that should be handled through the IOMMU API so
that it covers other IOMMU types as well?

How does this scheme compare to the one implemented in
drivers/acpi/arm64/iort.c?
