Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E43ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9402196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pfjlXrUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfJKJ00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:26:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfJKJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=owurzTiNQN9tSXfLyNnDQ29PbYAu2ED+zX68t+BoR2c=; b=pfjlXrUKAuJ8zGoYFdMhi9E+N
        otnI+YxI/D2jFU5FXVOySeW4TAVmDYMQCisXIZnP7fQPRb+ba+RQVs3/Bapx75s4Gz7rq/EI0yfMc
        K+3aL1QIuKG/gEP3tO7dZgt6T25zTa6y+Q5Ny1xzv0rTikN3laI3g0PLrOVmoq3beEZPAwvaujXO4
        YefQorUn2TkbYOPr/eQPkCkxRMQeRiGklsnmx3GmzeGg11Q9eH5TG0/A1ngr3Y9U1uXhSWbN/96ta
        CSvotgo+oKOPF5YsIglXJukyAnDXaLNQl9q7YROjedAAYj0Ytt+ofu86uUvP23Iz+lNxO2s7uMhBA
        DtktoxInw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIrBm-0006kg-6h; Fri, 11 Oct 2019 09:26:22 +0000
Date:   Fri, 11 Oct 2019 02:26:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] habanalabs: support vmalloc memory mapping
Message-ID: <20191011092622.GA19962@infradead.org>
References: <20191010140615.26460-1-oshpigelman@habana.ai>
 <20191010140950.GA27176@infradead.org>
 <AM6PR0202MB338206146804E2E2BC18C67FB8940@AM6PR0202MB3382.eurprd02.prod.outlook.com>
 <20191011081055.GA9052@infradead.org>
 <CAFCwf11hYWYNeROT8zpW+fcALijcTUuGVk-NoWvxzCORvd+dew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11hYWYNeROT8zpW+fcALijcTUuGVk-NoWvxzCORvd+dew@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:19:36PM +0300, Oded Gabbay wrote:
> We first allocate, using vmalloc_user, a certain memory block that
> will be used by the ASIC and the user (ASIC is producer, user is
> consumer).
> After we use vmalloc_user, we map the *kernel* pointer we got from the
> vmalloc_user() to the ASIC MMU. We reuse our driver's generic code
> path to map host memory to ASIC MMU and that's why we need the patch
> above. The user does NOT send us the pointer. He doesn't have this
> pointer. It is internal to the kernel driver. To do this reuse, we
> added a call to the is_vmalloc_addr(), so the function will know if it
> is called to work on user pointers, or on vmalloc *kernel* pointers.

But the function can't decided that.  As I said before you can't just
take a value that possibly contains user pointers and call
is_vmalloc_addr on it, as kernel and user address can overlap on
various architectures.

You need to restructure your code to keep the kernel and user pointer
code paths entirely separate.
