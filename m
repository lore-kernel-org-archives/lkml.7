Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E0C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E4D21E6D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KreEZ6td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfFQITp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:19:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfFQITp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bLNZQEWf0s5ffYRlcrJ5UoBdA2dcz1yaQRq0y4hSYAM=; b=KreEZ6td8sbW6SE+GYNkgb+Qd
        cPIEcHl43SZ0CM3LaBPR7qX25BRogbOTkzKYWLh4+kDlnv3Jpv3kdoLlU+7cRj1UZFUcPNHMglW6s
        u5Ir3XOVg21zmYlz+8Kq1WnvOjhZ+ahKtFrvgSRJKwrQrA4Zs6A9WdH+UGnrYMUy4MDaDVueakg4m
        twYAiOHb1AhsNzpH6Gj3ScfWuM4GHom1v2wAHruOddlpJ9T3ACizq4HI8f6uwifGxCm2nmLT1Knnb
        G2EdWjWlFN1C2B6rdIoOX7wSQLdM3/qMA19tiW1E1fhwetykM/J2GafHTNSc2E7prNCY6queI9BPC
        nDHN9mylA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hcmrf-000341-Uk; Mon, 17 Jun 2019 08:19:43 +0000
Date:   Mon, 17 Jun 2019 01:19:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190617081943.GA11274@infradead.org>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
 <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org>
 <20190611152655.GA3972@kroah.com>
 <CAFCwf11DKi+pfvvGR2zN4jvwTQZ9-Lm=OXBs+ZU=E-eFfJOi7A@mail.gmail.com>
 <20190616095554.GA5156@infradead.org>
 <CAFCwf11XU1JydbS-wswXBzm4t-fxLjGyXuHCqrNxTsWzLraSZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11XU1JydbS-wswXBzm4t-fxLjGyXuHCqrNxTsWzLraSZQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 02:24:08PM +0300, Oded Gabbay wrote:
> So the alternative is that my device won't work on POWER9.

The alternative is that we fix the powerpc code to do the right
thing, which already is in progress.
