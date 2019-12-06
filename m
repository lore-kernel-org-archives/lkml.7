Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBD8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE6E2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OHHQFTVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFK1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:27:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5+ss5VBQeK/5DXHbF5iltw+Lt6xrWEPBKgMVgHDfp7s=; b=OHHQFTVEdLhOnZjFVDL+LOxMd
        8R/bk6fPrbSm3BUm4w/qV6agHSqHgFU3UlXr+Vpp+/8u5xgVbeF2JHjjRl96YA5ALw5Gd7yoDeeWx
        cFnDTzpFUrVP+ju6SXNAiO2haqr6cMO/NE/ft5nsRROvm42pZENjBSuxumYuzpovV1vVikhlsLzZQ
        t7o8mPD4HrbDKY/UX4YGnrwFKhYP9Pe7bZxhctnQ4c3tV9OS7NsK3QFkGUDDrDOkgqU0dLOknzOVl
        F34/w8SKFLbesvioTJKh6zwGznADJk5Vj7ZdyB8hy46k9SbeKhbJNjQj3MkxE7fHZD5GE5Jfv5wPo
        YUuuVwwAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idApw-0003uO-5i; Fri, 06 Dec 2019 10:27:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF633303F45;
        Fri,  6 Dec 2019 11:26:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4ED092B26E20D; Fri,  6 Dec 2019 11:27:46 +0100 (CET)
Date:   Fri, 6 Dec 2019 11:27:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de
Subject: Re: [Patch v2 4/6] x86/mm: Refine debug print string retrieval
 function
Message-ID: <20191206102746.GD2844@hirez.programming.kicks-ass.net>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
 <20191205021403.25606-5-richardw.yang@linux.intel.com>
 <20191205091311.GD2810@hirez.programming.kicks-ass.net>
 <20191206015126.GB3846@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206015126.GB3846@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 09:51:26AM +0800, Wei Yang wrote:

> >> +#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
> >> +	static const char *sz[2] = { "4K", "4M" };
> >> +#else
> >> +	static const char *sz[4] = { "4K", "2M", "1G", "" };
> >> +#endif
> >> +	unsigned int idx, s;
> >>  
> >> +	for (idx = 0; idx < maxidx; idx++, mr++) {
> >> +		s = (mr->page_size_mask >> PG_LEVEL_2M) & (ARRAY_SIZE(sz) - 1);
> >
> >Is it at all possible for !PAE to have 1G here, if you use the sz[4]
> >definition unconditionally?
> >
> 
> You mean remove the ifdef and use sz[4] for both condition?
> 
> Then how to differentiate 4M and 2M?

Argh, I'm blind.. I failed to spot that. N/m then.
