Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B661C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1204E2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDIN7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:59:37 -0400
Received: from verein.lst.de ([213.95.11.211]:50624 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfDIN7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:59:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B7C7268B02; Tue,  9 Apr 2019 15:59:24 +0200 (CEST)
Date:   Tue, 9 Apr 2019 15:59:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: per-device dma_map_ops for intel-iommu?
Message-ID: <20190409135924.GA11431@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David and Joerg,

do you remember a good reason why intel-iommu is not using per-device
dma_map_ops like the AMD iommu or the various ARM iommus?

Right now intel-iommu.c contains a half-asses reimplementation of the
dma direct code for the iommu_no_mapping() case, and it would seem
much nicer to just fall back to that case and not even call into
intel-iommu in that case.
