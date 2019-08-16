Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20958C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D8D2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565989298;
	bh=MxoPEBdUgeGG8r1YMtqWjR43bDHROWKuxhhQbv0Dyd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uqTH0Yu44oWhLYd5AeCFwB0dvRPeIXuGMG5W8/BUjKiL5RX/z9s1FL/AeBK9Rni2n
	 DZFzNDQnM8p7aS5q1URhOCWloyWR73WgV2K8PbZT7bmEysCAsBg1OkCK29Kg7YG13S
	 5inTLNs/qtMB+dAQ6LLrAy5DqqMXXMYFvyteoFj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfHPVBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfHPVBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:01:36 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D7C2133F;
        Fri, 16 Aug 2019 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565989295;
        bh=MxoPEBdUgeGG8r1YMtqWjR43bDHROWKuxhhQbv0Dyd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V+taPJeoXoU39dnw4eLkWys2oiJYLOa4Kz30m61AGUDeqfuWPigLu5mtk/NBZ4EVe
         B+vgjZJsohmFph06ZE175qMwGCufq9Lz2dwY9FU1nW8Qnmq5y54FKkcs3RmSkO7pGl
         B5jzTM/MEaZDZcmqg90IE5o1Sx27v/d00qBxFkww=
Date:   Fri, 16 Aug 2019 14:01:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/4] resource: add a not device managed
 request_free_mem_region variant
Message-Id: <20190816140134.1f3225bed9bf2734c03341b1@linux-foundation.org>
In-Reply-To: <20190816065434.2129-2-hch@lst.de>
References: <20190816065434.2129-1-hch@lst.de>
        <20190816065434.2129-2-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 08:54:31 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Just add a simple macro that passes a NULL dev argument to
> dev_request_free_mem_region, and call request_mem_region in the
> function for that particular case.

Nit:

> +struct resource *request_free_mem_region(struct resource *base,
> +		unsigned long size, const char *name);

This isn't a macro ;)
