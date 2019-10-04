Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F6C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96ED222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cwx4hIJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfJDMKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:10:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59900 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJDMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fqX+HVWO3sNM75kjP5U6ICYzph+15bTG0LHXrFap22M=; b=cwx4hIJePaeGPIOtObfGjpKFY
        rIapApyhjZgE6DloCdBY++lzFWXMvfxug3tnprRS+nJdbshhM/QtN+wooheYnJJzkmcMUY3+LDUgp
        TTKbnjemCt/mIEyGRd5Rf6K5rKr6FJaafP4TKpAopQ9ey5Ur9HoqBfl0EKDbYVeC4WyMO1lg4H9b1
        ufo3LDnUXXNlBAPRaW9NJjj7+WgcbSpZnF1zlvwzpGHZRTak6B3cXc2acMUfk9VfoIaAu/9nz91Jy
        RpsibJy99//hkcNU9uzg8WgfuUEpW+0QtvD8BpV63mHJNxx4LYIvmNnMJtXFhT4P3U3gmWrPjKpq+
        tco43++YA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGMPZ-0000lj-CB; Fri, 04 Oct 2019 12:10:17 +0000
Date:   Fri, 4 Oct 2019 05:10:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: piggyback lru_add_drain_all() calls
Message-ID: <20191004121017.GG32665@bombadil.infradead.org>
References: <157018386639.6110.3058050375244904201.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157018386639.6110.3058050375244904201.stgit@buzz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 01:11:06PM +0300, Konstantin Khlebnikov wrote:
> This is very slow operation. There is no reason to do it again if somebody
> else already drained all per-cpu vectors after we waited for lock.
> +	seq = raw_read_seqcount_latch(&seqcount);
> +
>  	mutex_lock(&lock);
> +
> +	/* Piggyback on drain done by somebody else. */
> +	if (__read_seqcount_retry(&seqcount, seq))
> +		goto done;
> +
> +	raw_write_seqcount_latch(&seqcount);
> +

Do we really need the seqcount to do this?  Wouldn't a mutex_trylock()
have the same effect?
