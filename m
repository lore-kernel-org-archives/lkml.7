Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C81C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1095620692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KYEU3O4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404599AbfIJGLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:11:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbfIJGLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0OlTj7DXpHCk8/Cet3gIZRH6ht6v2JPpcLLEodIn3mE=; b=KYEU3O4X4h5OlvA3vMrRL+/5G
        3+NIrpr5m0SE4kkP3xwQGc2Se1a7cwobERWyuzI3xawpqP6kVK/ASb5gADRVYoXboLGXaM23kRoZy
        w3rB8siioFkF/Tm/yvd1nJwe8H8PqBVVz65xB52L8StAjqCZKoEgrY07M4UNfCx6CfaHI2s/A+Wn+
        eSKcrih5TmbtiuYJ7EeN8K4SSv08xbCkFHIKF74fh2fb0wi+lYYS+K6B5frefZb3We2dsbxNk92He
        OCrvwX1JOBD63s0PeciBC6abccc8OTXtq4cD6jdeReBFYnr1DSLc4lG/dzfQCWbhOCpAfx3bCD0jQ
        VCZ5qdcBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ZMs-0005d1-VR; Tue, 10 Sep 2019 06:11:10 +0000
Date:   Mon, 9 Sep 2019 23:11:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        pv-drivers@vmware.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH 0/2] Fix SEV user-space mapping of unencrypted
 coherent memory
Message-ID: <20190910061110.GA10968@infradead.org>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905112311.GA10199@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905112311.GA10199@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:23:11AM -0700, Christoph Hellwig wrote:
> This looks fine from the DMA POV.  I'll let the x86 guys comment on the
> rest.

Do we want to pick this series up for 5.4?  Should I queue it up in
the dma-mapping tree?
