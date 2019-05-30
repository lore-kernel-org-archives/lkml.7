Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4EEC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E144025A3C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qw1P2yCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfE3GfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:35:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Ge7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jr8TFbprzSDAQ8IU8dPBj96p3eA/WBFaKx/uITpNZxo=; b=qw1P2yCe/tNQ53IWK8sRhTlQ/
        7BOzfMuds62GDyiMXXH0kaXp1Y+C9rv3rPLSzwvtXfy2QGuFj7Z4GM+RO8YF28VJED1HBAVuJiacv
        HfYJ8LtXhewzVwZPvZj+5oYXx2zT6rEK1SyEt/ODgaLXdjqFaYQUKil4+7nXra90GSGQk7EXlZj8Y
        zR8FSrFgCmzAQsmE0qwBRRVez9amvdlg3cLbTtuDXOhSU8dOxHmsBsyayqcOKZhpq7X5TjV0Vtph+
        SNe5iYHi6xjjdAMoXuQN3GXfEYLx/kF6PhaP+VsY3yVJyVgoDw6XzDkR0ixeywqN5YUy/hPRiubF1
        hBGqc8phQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWEeR-0000fN-4p; Thu, 30 May 2019 06:34:59 +0000
Date:   Wed, 29 May 2019 23:34:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 4/4] arm64/mm: Drop vm_fault_t argument from
 __do_page_fault()
Message-ID: <20190530063459.GA2181@infradead.org>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
 <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 06:04:45PM +0530, Anshuman Khandual wrote:
> __do_page_fault() is over complicated with multiple goto statements. This
> cleans up code flow and while there drops the vm_fault_t argument.

There is no argument dropped anywhere, just a local variable.
