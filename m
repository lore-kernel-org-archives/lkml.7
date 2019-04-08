Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31012C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C5821473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LxXKg4kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfDHONY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:13:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfDHONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+reI6IWjQov4mB0Up+1lm8sZxqlFGW/kzlH+giQh14c=; b=LxXKg4kWXS+faNbwg9ehOyy7I
        ykui4EQtxXgWSPztHpHwAaSTZmBp8YI+nN5EgmMkzTz45HBo/N8Y0lbq1ugpo9vnAPKJeADDq0Hq/
        7uGezLBTg8bBVTjyZVPP2nePjTScdPOx9qapOgq+slTxvf1gFc/aHpKUUh/Z9OPYVZKWVFeKZxzTD
        cqqfKJmy+t0CQRofvcimWJ7tpLnxQQPpiiHf9ikR6k1fQx7/waVKLRgB9x1L1Nek0qtOwYq1mTqeg
        BOKtO2kTqCEEjJ0fLVxOGjFtHEATp7bjbthy0i4SnELwcCC8NN4V185M+CBfpND7xDRDxbd4QnkuG
        aDvpTksyQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDV1N-0003P9-Lc; Mon, 08 Apr 2019 14:13:13 +0000
Date:   Mon, 8 Apr 2019 07:13:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     akpm@linux-foundation.org, william.kucharski@oracle.com,
        ira.weiny@intel.com, palmer@sifive.com, axboe@kernel.dk,
        keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/gup.c: fix the wrong comments
Message-ID: <20190408141313.GU22763@bombadil.infradead.org>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408023746.16916-1-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:37:45AM +0800, Huang Shijie wrote:
> When CONFIG_HAVE_GENERIC_GUP is defined, the kernel will use its own
> get_user_pages_fast().
> 
> In the following scenario, we will may meet the bug in the DMA case:
> 	    .....................
> 	    get_user_pages_fast(start,,, pages);
> 	        ......
> 	    sg_alloc_table_from_pages(, pages, ...);
> 	    .....................
> 
> The root cause is that sg_alloc_table_from_pages() requires the
> page order to keep the same as it used in the user space, but
> get_user_pages_fast() will mess it up.

I don't understand how get_user_pages_fast() can return the pages in a
different order in the array from the order they appear in userspace.
Can you explain?
