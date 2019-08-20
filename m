Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1B1C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39FA22CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfHTC0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:26:23 -0400
Received: from verein.lst.de ([213.95.11.211]:52591 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfHTC0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:26:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B59668B02; Tue, 20 Aug 2019 04:26:19 +0200 (CEST)
Date:   Tue, 20 Aug 2019 04:26:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/4] resource: add a not device managed
 request_free_mem_region variant
Message-ID: <20190820022619.GA23225@lst.de>
References: <20190818090557.17853-1-hch@lst.de> <20190818090557.17853-2-hch@lst.de> <CAPcyv4iaNtmvU5e8_8SV9XsmVCfnv8e7_YfMi46LfOF4W155zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iaNtmvU5e8_8SV9XsmVCfnv8e7_YfMi46LfOF4W155zg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 06:28:30PM -0700, Dan Williams wrote:
> 
> Previously we would loudly crash if someone passed NULL to
> devm_request_free_mem_region(), but now it will silently work and the
> result will leak. Perhaps this wants a:

We'd still instantly crash due to the dev_name dereference, right?
