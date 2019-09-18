Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3826C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B185208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBxLekX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfIRNjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:39:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfIRNjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+FPdW41hn3jWUMh2kiLzcZnIMCmJZbpOQUJ5V447Q0c=; b=MBxLekX4f+O/r7ZOpsCS4BmYF0
        wXC+caKqsmuKJrAfiFMUMM1IwLz8k0zHaQx2cyPmR/O/IcYQKogHi0qMHLnhEbOUniOs1IhtRC04E
        OMWFaaRiU8U06M+d4d7i6bkAWYZwv+Bzun0AvUztVmNfW55gG7D2NbHsdB0Y7JmSGepLtcA3ftTfp
        Wvdb2pLf//HYFzrI64DTF+PPUodJttLH5B66HVlJI77GZWDXsxBbRZQQNSX7wg9+3UOUgZg2myiSl
        cF5eQIJaP0RChTD9hmm0aL000QnIptqKofOMCdVl44RgIhxNal+5vffQ0EBhcqgcjJpM6vOD0268c
        5Yvd7arA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAaBR-0005iN-HP; Wed, 18 Sep 2019 13:39:49 +0000
Date:   Wed, 18 Sep 2019 06:39:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/2] Fix SEV user-space mapping of unencrypted
 coherent memory
Message-ID: <20190918133949.GA20296@infradead.org>
References: <20190917130115.51748-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190917130115.51748-1-thomas_os@shipmail.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks sensibe to me.  x86 folks let me know if you guys want
to pick this up or if I should take it.

On Tue, Sep 17, 2019 at 03:01:13PM +0200, Thomas Hellström (VMware) wrote:
> As far as I can tell there are no current users of dma_mmap_coherent() with
> SEV or SME encryption which means that there is no need to CC stable.

Note that the usbfs access really should use it, as the current version
is completely broken on non-coherent architectures.  That already
triggered on x86 dma_mmap_coherent fix.  So I'd actually like to see
a stable backport to avoid hitting surprises.
