Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88659C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65948206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lopY/BRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfGYS6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:58:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYS6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uM1m72nodYHDEUlSsjslsPY2INrx+IqGO9Kqpg6MkME=; b=lopY/BRo9oAHx6/JdfjuDyu9Z
        RMbXMxg4xB9JD+NYF+mRAUKmgCXsDuWmLIj3Hogbw28fXWoV4lzj2niNe8BIFE7DXuibFeiN0cdBE
        UCfcTVOUloizBGEhRd1Ng4REhVzIeqKYOlKicz1HOKsdZL/wPDBxAtvww+zKrNc1vKtihZZxKhmJu
        1jWKI7WPrnq43+9RYoGp9ZLcwucz40YhAeSEbJZjaWlbWXQhqXWIbUfFKCUTxy4HDN2J5a4HKBcTW
        VZMHVSESwIGnKO9XWRap/PffQi54zOUHP+U4G0juZqRkC6p98l/DBV8JDhUC+Vi4/Q2jIvmvsMRf+
        Up7EnRc7Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqiwC-0007WD-Ug; Thu, 25 Jul 2019 18:58:01 +0000
Date:   Thu, 25 Jul 2019 11:58:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, vbabka@suse.cz, cai@lca.pw,
        aryabinin@virtuozzo.com, osalvador@suse.de, rostedt@goodmis.org,
        mingo@redhat.com, pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/10] mm/page_alloc: use unsigned int for "order" in
 should_compact_retry()
Message-ID: <20190725185800.GC30641@bombadil.infradead.org>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
 <20190725184253.21160-2-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725184253.21160-2-lpf.vector@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 02:42:44AM +0800, Pengfei Li wrote:
>  static inline bool
> -should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
> -		     enum compact_result compact_result,
> -		     enum compact_priority *compact_priority,
> -		     int *compaction_retries)
> +should_compact_retry(struct alloc_context *ac, unsigned int order,
> +	int alloc_flags, enum compact_result compact_result,
> +	enum compact_priority *compact_priority, int *compaction_retries)
>  {
>  	int max_retries = MAX_COMPACT_RETRIES;

One tab here is insufficient indentation.  It should be at least two.
Some parts of the kernel insist on lining up arguments with the opening
parenthesis of the function; I don't know if mm really obeys this rule,
but you're indenting function arguments to the same level as the opening
variables of the function, which is confusing.
