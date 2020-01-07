Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63466C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FD0207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dIul6ScW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgAGN15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:27:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGN15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZgcWgVZWoALXHLMfZ5dpmFvCO8GJAsNY0kanZ31E1kw=; b=dIul6ScW9Fbch0ICIUvuHBOO1
        zVBnim7uI5MjoOdSJO936XOCLdQgnx6NXaMEZkeTPb8hGZvTbIO2dkoFmZWrrRQn3O17XLgd3ELpS
        l/28oBCKWRckv4yyId6YsIM0orB3rMVQwzbzzvtePESxtDJeAepuDnU0jEGF408b1dLC5M6IwsEqX
        oCpNNMguL9raxbAHfizNieQTLLKl2m0uUgWN8mKVUDT/oserZeMCcVTNshRJAV+snKsjaoSsnjGZV
        uZQWF8D4aOSRAwDZX7xe5WauZ8LR/K4ahd07ohuW2xqaBp3JftAx7w/x7/WNe0PO/BCILWTMWC/ij
        tYkheqReg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iootj-0001Xd-88; Tue, 07 Jan 2020 13:27:51 +0000
Date:   Tue, 7 Jan 2020 05:27:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>,
        Jim Yan <jimyan@baidu.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
Message-ID: <20200107132751.GA584@infradead.org>
References: <20191224062240.4796-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224062240.4796-1-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WTF is a NVMe host supposed to mean for a PCIe device.  NVMe defines
the host as following:

"1.6.16 host

An entity that interfaces to an NVM subsystem through one or more
controllers and submits commands to Submission Queues and retrieves
command completions from Completion Queues."

in other words - the Linux kernel is the NVMe host.  You need to
describe this magic broken piece of crap a lot better than that.
