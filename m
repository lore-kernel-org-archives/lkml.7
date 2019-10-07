Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF7DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F86920867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b6Z6RJnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfJGGNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:13:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJGGNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pfP6drXPoprKVpMZwbtJ9L/Nw9mUyKupJm/GF1sbNHc=; b=b6Z6RJnwPHq7I9g1QevfL56ut
        uLNea6ljrTVw7c49cfta16/0gOL8KpdOovhRpL3/2GP0rT29ZMiZ/LvJXsdaEn3HV6q3L4rNTDQI3
        c+wgg2BG2w4YI7OGepeWYJrSXu0iQENetmCOZ2CNh6qBppccaZQzPm72Ple6H3A1dyTR62NF6Ama7
        roHumnpoIHKVkuaCeiTRCSTPSRWtsUtH2EmBlALDWG2Fy1nDlFU7xIt085E15UemeOyU5seWJ9Ael
        sbgLTsY17kFOx7WvlFoLutLMSuWaoYzYiuXWMSerHROaRg4brFgURyQheim/CFoxHtogJghBd6YZ4
        8orT/mAxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHMGq-00080T-UU; Mon, 07 Oct 2019 06:13:24 +0000
Date:   Sun, 6 Oct 2019 23:13:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, jgg@ziepe.ca,
        christophe.leroy@c-s.fr, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
Message-ID: <20191007061324.GB17978@infradead.org>
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:22:35PM -0700, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify sg_miter_stop() to validate the page pointer
> before calling PageSlab(). This check prevents a crash
> that will occur if PageSlab() gets called with a page
> pointer that is not backed by page struct.
> 
> A virtual address obtained from ioremap() for a physical
> address in PCI address space can be assigned to a
> scatterlist segment using the public scatterlist API
> as in the following example:

As Jason pointed out that is not a valid use of scatterlist.  What
are you trying to do here at a higher level?
