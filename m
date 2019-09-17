Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02256C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E0721670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EKBUzXLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfIQAcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 20:32:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQAcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 20:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1PxCHCzaKSbBf9rQHzOPWiqgMBxIvS6Iq4POGaifyXQ=; b=EKBUzXLj3MJGCQpH2J47/ny/v
        Y+v6GWj6Khs7GfhrmTvRgzHpJUBQoXd/IN9sLAgOp4Okd2T3aGduXKIFl6m/zGr3zl1lE7wZV/t00
        c7d7mSWs/Gt5HfHT8MTkGWrQSano25MQu+53hbzIfR7c3fMfWf1S8pPGuui0uXdDjYUfUWnHCqLJ+
        AfVR0hiTEk43CILYHGcn42rGHF1f+QPyuEQ9+IcgozZVCLqm6x2uTCAe8fATmJlStTlTlvpIgQW7Y
        FHiBr3G/Yud478ZDsrWglXj4sw5S2lf5ETD6nkLt1YdkoWjF71I1G6QXg6pc93tTLSM0wfKNej1gs
        nx5l3NK7Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA1Pd-0002oB-Hk; Tue, 17 Sep 2019 00:32:09 +0000
Date:   Mon, 16 Sep 2019 17:32:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] usercopy: Skip HIGHMEM page checking
Message-ID: <20190917003209.GS29434@bombadil.infradead.org>
References: <201909161431.E69B29A0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909161431.E69B29A0@keescook>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 02:32:56PM -0700, Kees Cook wrote:
> When running on a system with >512MB RAM with a 32-bit kernel built with:
> 
> 	CONFIG_DEBUG_VIRTUAL=y
> 	CONFIG_HIGHMEM=y
> 	CONFIG_HARDENED_USERCOPY=y
> 
> all execve()s will fail due to argv copying into kmap()ed pages, and on
> usercopy checking the calls ultimately of virt_to_page() will be looking
> for "bad" kmap (highmem) pointers due to CONFIG_DEBUG_VIRTUAL=y:

I don't understand why you want to skip the check.  We must not cross a
page boundary of a kmapped page.

