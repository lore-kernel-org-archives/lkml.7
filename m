Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8131020823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNndl0er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfC1QLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:11:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1QLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+EEkJaz73bWFwJOMI8QyVy9DOLmPKZ0V3NJ0szo0Sok=; b=hNndl0erqulTbwfxH+SVybayF
        Vfa4JZhbC/qcPxuti+OEl1qjAJlhiC4XYP0TSI7zaYhdezh5/6vR5P1sQZoFMaNb07KTJ+DNzZVjc
        CEUgMjCFZ+maTpXi2Gd5Gex4Vum+s52xHEqWxoO8H1w8h2l/4c7gd2s/wAwFgMMF/S/O8IBLXX0Gb
        +NUpnpDchMZ3vM/fmfXjsrkUGVhS8/tjzQI//i6WR/4ySZG/hPJhL5jKlzx/scXfiwjqQWDGaktJD
        nOkYeoUM8T+LD8iTuea9SeGdbK7A9klpjanMnfs0jwqNJJZpcWc/mnPNxP9HlX6l/CPrf7SJ78iRg
        zWD8J97bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9Xcs-0000tW-9N; Thu, 28 Mar 2019 16:11:34 +0000
Date:   Thu, 28 Mar 2019 09:11:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] iommu/vt-d: Bounce buffer for untrusted devices
Message-ID: <20190328161134.GA27879@infradead.org>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
 <20190327064823.GA13309@infradead.org>
 <04b41eb3-5584-5c7d-5f5e-7c6f28a19b50@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b41eb3-5584-5c7d-5f5e-7c6f28a19b50@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:33:04PM +0800, Lu Baolu wrote:
> For the swiotlb APIs, I am thinking about keeping current APIs untouched
> and adding below new ones for bounce page.

In the lon run I'd like tow avoid duplicate APIs, especially as the
current low-level swiotlb APIs only two callers.  But please go ahead
with the new APIs for now, I will try to see if we can do something
on top later.
