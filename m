Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6354EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357C0216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ha8JL4X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfEIGE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 02:04:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEIGE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2BOt23+dJkgLc2Bad8f0KnjgocjfIoZCIHj0+aoytGs=; b=ha8JL4X+dkphP6/WlM+2dKbKX
        Cs4tQGxKNyGyVTsZAufqdQF/ZmPWotau9cWYyPlQyjdTLN1AGu+j712Hf9bNmH+hkPvlQhzIy+rCU
        /YuFHVBiVcH55t3MRBr/cN2HW6gnzEEQJfea+f/mx++3ztbiy6EKZYjrJbihABev1GolRTJfgyXBB
        MrTd77rD9T4IA7LOmbCXUgnLF6B9/yMtHzSZavUCA0Y8rTn1ovj6wbZb7t9qJg8zXk07YMpAZPaD/
        TH/zicOCsHrW4vmhuDjmXhF2Qo2HOFs6IPA6f6u4B2VWjjNxJKiQZWF8rEwk+0Z/PPc/Ex6tqjGDV
        VKm+aGTlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOcAq-0004Wk-CX; Thu, 09 May 2019 06:04:56 +0000
Date:   Wed, 8 May 2019 23:04:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-mmc@vger.kernel.org, djkurtz@google.com,
        adrian.hunter@intel.com, zwisler@chromium.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in
 mmc_init_request
Message-ID: <20190509060456.GA17096@infradead.org>
References: <20190508185833.187068-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508185833.187068-1-rrangel@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 12:58:32PM -0600, Raul E Rangel wrote:
> It is possible for queuedata to be cleared in mmc_cleanup_queue before
> the request has been started.

Errm.  I think we need to fix that problem instead of working around it.
