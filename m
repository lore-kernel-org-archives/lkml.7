Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493832075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FRRQQ2vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfC0Gsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:48:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfC0Gsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=63Ryn2rD5TwxTFUhwXGHbiT/Ud9UrL6aq59pEhlawn0=; b=FRRQQ2vtzIPMLWuhrXGcmhyMu
        YRPyXNve6b0hPfC5OH1kNDgcKqbMhjkekWJovRdK5bvO3UUIx1wRRRS0bd5PROSf7VrggG6jmlZYv
        NmHqsJ0XikbJZAB0O94lBYOqI45P2j/mbbhFdLM4+YuIvUPuBoasvyFUcU7e9SZiU3M22p/NXKNgv
        63ISMXeajva5S4CiqW1UzpzYf/fuKTT4e/4McRZbVTcaWW6lUh5RoR96UKPlDJUWTDjYi1wxpaCDq
        YEnUCs51ku+Nd9boMXCG4mB6Fcf8InWERjeasar5eDSfTtXYwfXCDa7K0SXIGkFdw1i4wKmhPJMQ4
        frGoeFmiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h92MK-0003YQ-19; Wed, 27 Mar 2019 06:48:24 +0000
Date:   Tue, 26 Mar 2019 23:48:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] iommu/vt-d: Bounce buffer for untrusted devices
Message-ID: <20190327064823.GA13309@infradead.org>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:34:56PM +0800, Lu Baolu wrote:
>   - During the v1 review cycle, we discussed the possibility
>     of reusing swiotlb code to avoid code dumplication, but
>     we found the swiotlb implementations are not ready for the
>     use of bounce page pool.
>     https://lkml.org/lkml/2019/3/19/259

So make it ready.  You too can contribute to common code.  Robin
also explicitly asked to make the bounce policy iommu-subsystem wide.
