Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDFDC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAAB21835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HthA4Kw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLFJXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:23:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfLFJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w6d0CZuvcMqu+wJfVHMmqWR4DRbXsscP/TEWag2t4Mo=; b=HthA4Kw32LMywhCYmP6wbAVUp
        eGqRCpEBlOcj/Q5Nd11L2uk70TbDI4o+grqlibkdJa1RuOnQO0QkdLQZSb0ycRbf3Zgs3pbdoyRDZ
        bpjO4AORYr3cMmBOtjmQXFBlKrNO6ylkXZarBFQG/mJA45MN2xX5grbfecXhExc+Vmmn8WQU6sura
        /Ly6Bd0o3aQ4sqteiFhWVA5maHG2CR/ciIl3G4DQD7D41TlEAT5L4aspwK0CHIGuvQeWHdb5czTCI
        /T1HBcC1LhXlwXsH2QiXwXfV956jCDUFrn1XhIUNY8M3aIMtl7FsxZKNai/IaPnRFZFLOHJHf8vfE
        SdfUPctIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1id9po-0004vJ-Px; Fri, 06 Dec 2019 09:23:36 +0000
Date:   Fri, 6 Dec 2019 01:23:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     colyli@suse.de, kent.overstreet@gmail.com,
        linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org
Subject: Re: [PATCH 2/2] [PATCH] bcache: __write_super to handle page sizes
 other than 4k
Message-ID: <20191206092336.GA7650@infradead.org>
References: <1575622543-22470-1-git-send-email-liangchen.linux@gmail.com>
 <1575622543-22470-2-git-send-email-liangchen.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575622543-22470-2-git-send-email-liangchen.linux@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:55:43PM +0800, Liang Chen wrote:
> __write_super assumes super block data starts at offset 0 of the page
> read in with __bread from read_super, which is not true when page size
> is not 4k. We encountered the issue on system with 64K page size - commonly
>  seen on aarch64 architecture.
> 
> Instead of making any assumption on the offset of the data within the page,
> this patch calls __bread again to locate the data. That should not introduce
> an extra io since the page has been held when it's read in from read_super,
> and __write_super is not on performance critical code path.

No need to use buffer heads here, you can just use offset_in_page
to calculate the offset.  Similarly I think the read side shouldn't
use buffer heads either (it is the only use of buffer heads in bcache!),
a siple read_cache_page should be all that is needed.
