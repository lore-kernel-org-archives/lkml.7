Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DFC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1580222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EkqNdgLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbfJDQL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:11:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389835AbfJDQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZigWl2XUxD4WRWUTA/3vfeUpk5NKCjS7IgLz46LNi1A=; b=EkqNdgLsMbx9rbnh1JuxQuReh
        yRNVUJ1YJDniW5TezYjNLj3ilThtLq4Bpl88bvH52e9Er9kCbV9gYeSg0V+KvsKlXaYMTUI/WzYu5
        VNr4ttDz/d035oI+SGcxoX/pfDk/2oTt0MhE2pPNHylHOkgsUDgk3JIflBOLCsAPbG2Hpmzc5gpie
        PRzhtO2erK6rrkURbtZ3JbFPrmtd9Cyxb6TIvJEe3gDp+Fh6VeTEuELAO3wx3+4t7xlGPkmyWBMnG
        N77irQsP1EsOTNQFt5GHQ88feVuqiQoY5qTDP0stlPw5Tru7McoZC66pd1WwRXgPjp8NcteHPHgl+
        z2FZn43kQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGQAq-0001EE-V6; Fri, 04 Oct 2019 16:11:20 +0000
Date:   Fri, 4 Oct 2019 09:11:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        khlebnikov@yandex-team.ru, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap.c: reuse mergeable anon_vma as parent when fork
Message-ID: <20191004161120.GI32665@bombadil.infradead.org>
References: <20191004160632.30251-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004160632.30251-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 12:06:32AM +0800, Wei Yang wrote:
> After this change, kernel build test reduces 20% anon_vma allocation.

But does it have any effect on elapsed time or peak memory consumption?
