Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0EC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C8222DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cEOtN5aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfIDMWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:22:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIDMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p4xwnk3QcMZRDVTI+Ilfg/a5Gh1VJ5mfJ+ENgw6ZREk=; b=cEOtN5aIUSshGFlNm1cUCBAk3y
        EV8E8pW467LFTlqVeymYmD3s6MOrFZoy3EFlNQelrEXJoxRNtk/vLw4o17cx5sbVGQzdgcmPHBFSv
        kjbSCmSdmhSDya9tTK6DwbBd4xveQgg9KDvtvfJxS2Kc1EDppJbkinubrRAgq6F9N2kGuOJiqc/Re
        k4HGhQzkuSrSbMSa+3mTxte66rvMomdVdVFYTWjuYTbWLZYZUblbpE9jJahXb77MzJvrGiuGcnb5f
        UIIegTTmtdXOHPooEI1kLmqSR7zp55J3fS4K2g2FN3vBOAjIlklWu0OEdPI1ZdwHFJz2+JBfDEwg+
        W8Fpch9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5UIW-00060Y-GS; Wed, 04 Sep 2019 12:22:04 +0000
Date:   Wed, 4 Sep 2019 05:22:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 1/4] x86/mm: Export force_dma_unencrypted
Message-ID: <20190904122204.GA16937@infradead.org>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-2-thomas_os@shipmail.org>
 <20190903134627.GA2951@infradead.org>
 <f85e7fa6-54e1-7ac5-ce6c-96349c7af322@shipmail.org>
 <20190903162204.GB23281@infradead.org>
 <558f1224-d157-5848-1752-1430a5b3947e@shipmail.org>
 <20190904065823.GA31794@infradead.org>
 <8698dc21-8679-b4a7-3179-71589fa33ab7@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8698dc21-8679-b4a7-3179-71589fa33ab7@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:32:30AM +0200, Thomas Hellström (VMware) wrote:
> That sounds great. Is there anything I can do to help out? I thought this
> was more or less a dead end since the current dma_mmap_ API requires the
> mmap_sem to be held in write mode (modifying the vma->vm_flags) whereas
> fault() only offers read mode. But that would definitely work.

We'll just need to split into a setup and faul phase.  I have some
sketches from a while ago, let me dust them off so that you can
try them.

> "If it's the latter, then I would like to reiterate that it would be better
> that we work to come up with a long term plan to add what's missing to the
> DMA api to help graphics drivers use coherent memory?"

I don't think we need a long term plan.  We've been adding features
on an as-needed basis.  And now that we have siginificanty less
implementations of the API this actually becomes much easier as well.
