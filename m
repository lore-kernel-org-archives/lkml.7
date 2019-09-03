Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11973C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D320623431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jcvUO5jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfICQWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:22:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UO9hWJW4yTDv0Ua44/8X2p24FCn5xNduwObwDZgiqIo=; b=jcvUO5jhaFRd0+7W62bbMATuml
        3KryIU+bGqTHHUgDwgnGG74+bqnGkTh9xAoWLz/j8E/yPPzAwsv/yF5HJbE1mUDLNnQ6cImEb/Fie
        AxgTmjCnc/v/Y/0xB9QqsgMyjyVnOtCqvmRWK4O7AbGXhtbTgeDFcIc9zs8kRH5QOwq1wRWfWrXVJ
        TOdqKN18tJn4Qgqf9GjdMr2vpuoCrjVwF7DKzXNvIsIhxidQ69DXtkPMkzZC0IiqGyWCa2s4byReE
        pDocAdxQ1wVBZCN0cq1yHbTKgE2Yto5NFP7BHgPahDhFVvNvMh3oalfrvy7YNp89TEmvqKGAg0VF0
        UXhONTrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5BZE-0007OA-QT; Tue, 03 Sep 2019 16:22:04 +0000
Date:   Tue, 3 Sep 2019 09:22:04 -0700
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
Message-ID: <20190903162204.GB23281@infradead.org>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-2-thomas_os@shipmail.org>
 <20190903134627.GA2951@infradead.org>
 <f85e7fa6-54e1-7ac5-ce6c-96349c7af322@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f85e7fa6-54e1-7ac5-ce6c-96349c7af322@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:32:45PM +0200, Thomas Hellström (VMware) wrote:
> Is this a layer violation concern, that is, would you be ok with a similar
> helper for TTM, or is it that you want to force the graphics drivers into
> adhering strictly to the DMA api, even when it from an engineering
> perspective makes no sense?

From looking at DRM I strongly believe that making DRM use the DMA
mapping properly makes a lot of sense from the engineering perspective,
and this series is a good argument for that positions.  If DRM was using
the DMA properl we would not need this series to start with, all the
SEV handling is hidden behind the DMA API.  While we had occasional
bugs in that support fixing it meant that it covered all drivers
properly using that API.
