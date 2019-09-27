Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49C3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ECF2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mXieyfst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfI0W1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:27:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfI0W1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hskLe/Bp8cWuCbbgML94FyPb3sNJrJ8yv5rcDQ0yZxI=; b=mXieyfstUPkSz9gu9ILvCrV8m
        s809gnuYR7WRtFvgNJJupj47xehs8WwBXanqHxMaIn94K8gmlUzL/VoxypedW9rdWLOqsvPhZ5+kK
        jgQcaf5hf0RZ96J15EbAD5GwlmVG2HmAcOEMNSPE5FC1PxSkYQ2i6nUTOpQJkIUxXfKASgGXcCjg5
        clbRVnryMx1+aWKxYLhL9PWKvJUrFaKODs79/2PEn5YyXpDp4YVjDREIKPTJKmc8cIJKm2Vh92zYE
        3Az95jqgq8DtUVfX5Zi1pc4PFZM5wRi+j4RNqweei3mbfsCyyQnkVSq/NbQg0/xVFdIgnabl0/DUs
        Y2NXqfKMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDyhu-0004O8-1H; Fri, 27 Sep 2019 22:27:22 +0000
Date:   Fri, 27 Sep 2019 15:27:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com
Subject: Re: [PATCH 2/4] rsicv: avoid sending a SIGTRAP to a user thread
 trapped in WARN()
Message-ID: <20190927222722.GG4700@infradead.org>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
 <1569199517-5884-3-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569199517-5884-3-git-send-email-vincent.chen@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:45:15AM +0800, Vincent Chen wrote:
> On RISC-V, when the kernel runs code on behalf of a user thread, and the
> kernel executes a WARN() or WARN_ON(), the user thread will be sent
> a bogus SIGTRAP.  Fix the RISC-V kernel code to not send a SIGTRAP when
> a WARN()/WARN_ON() is executed.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
