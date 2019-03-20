Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAE92175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k/O7iAIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfCTLXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:23:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfCTLXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RwGTGene4l5p7MPYR0Zrx0BW45jaABhyE21chVO0jp0=; b=k/O7iAIOy9XbE3sh69klrAVTq
        4cC5oIxDGGC83Oxv0x9dsSXQKLi+Cbcki8gQGz0c457zT9Nw5R3c/qIhXQAq4Yi9fOicr5+jNPuWl
        HC5JiD7oJ5ZZQs10oPO3Nl3lbqzALRVJ5MUDKYjuZsMZscYu9HeWzBxxWPrIbJ3kOMIJdbcoSskbC
        6kwxZCifdyDGrBv1mBkXrU3b6smoTk+35HDCQgQCIp7mHKx5EdHRZdTPr7dEj6KP85c9RNNtsoDJa
        A8HffEJUJmqWQJ9+8LAA8dVoJQjvX6r1LSbgz9y0AbDtPhxj82svcM+sijBQIjfiVpPlHQKoRUJ25
        HwJBJKDwA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6ZJD-0007OI-MC; Wed, 20 Mar 2019 11:22:59 +0000
Date:   Wed, 20 Mar 2019 04:22:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        mhocko@suse.com, rppt@linux.vnet.ibm.com,
        richard.weiyang@gmail.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/sparse: Optimize sparse_add_one_section()
Message-ID: <20190320112259.GW19508@bombadil.infradead.org>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320073540.12866-2-bhe@redhat.com>
 <20190320075649.GC13626@rapoport-lnx>
 <20190320101318.GP18740@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320101318.GP18740@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:13:18PM +0800, Baoquan He wrote:
> +	if (!memmap) {
> +		ret = -ENOMEM;
> +		goto out2;

Documentation/process/coding-style:

Choose label names which say what the goto does or why the goto exists.  An
example of a good name could be ``out_free_buffer:`` if the goto frees ``buffer``.
Avoid using GW-BASIC names like ``err1:`` and ``err2:``, as you would have to
renumber them if you ever add or remove exit paths, and they make correctness
difficult to verify anyway.

