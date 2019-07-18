Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5BEC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB79B21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563484925;
	bh=picct2x5G7z5eN/bZQA7JUic4g6eKx+sam1kr/kt1rI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D5FrfDT/Mcd93vNg7QZHZDxsPXnNQTo7mFQMgxQV521rI/6lY1k/KhwnTg8i9mFUF
	 uscKklg4ZW7r/03bkHXcmrXEuIF8SRmuP0kkkHOUnpA/UdcOZUdW2NlsJsY+JMbtQ8
	 H8WR5Ku3jau4oNbWQHBAwjurFLq95M3onEvtp1jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391323AbfGRVWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfGRVWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:22:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EDEC21019;
        Thu, 18 Jul 2019 21:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563484923;
        bh=picct2x5G7z5eN/bZQA7JUic4g6eKx+sam1kr/kt1rI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jVzhwBA9+uq4iKWl+Y9YgA6z/5Wi0y+4pyKBZDxq7NUS86OWUpDBbqCQZU6nbYWVm
         0UQJD6Dd9Umf/pnGl+wuCdlbSRp99cNmK6SID9Ki+c2WBzRvTgKFK9m84Iehb3VkJf
         C3WBGg8pTTGn5Xf75DSlJV4zJA/sq4rbHpuxL84E=
Date:   Thu, 18 Jul 2019 14:22:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     howaboutsynergy@protonmail.com
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: compaction: Avoid 100% CPU usage during compaction
 when a task is killed
Message-Id: <20190718142203.22f4672a520a5394afd54fd7@linux-foundation.org>
In-Reply-To: <Wnnv8a76Tvw9MytP99VFfepO4X71QaFWTMyYNrCv1KvQrfDitFfdgbYvH8ibLZ9b1oe_dpPfDdQ1I2wwayzXkRJiYf1fnFOx6sC6udVFveE=@protonmail.com>
References: <20190718085708.GE24383@techsingularity.net>
        <Wnnv8a76Tvw9MytP99VFfepO4X71QaFWTMyYNrCv1KvQrfDitFfdgbYvH8ibLZ9b1oe_dpPfDdQ1I2wwayzXkRJiYf1fnFOx6sC6udVFveE=@protonmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019 11:48:10 +0000 howaboutsynergy@protonmail.com wrote:

> > "howaboutsynergy" reported via kernel buzilla number 204165 that
> <SNIP>
> 
> > I haven't included a Reported-and-tested-by as the reporters real name
> > is unknown but this was caught and repaired due to their testing and
> > tracing. If they want a tag added then hopefully they'll say so before
> > this gets merged.
> >
> nope, don't want :)

I added them:

Reported-by: <howaboutsynergy@protonmail.com>
Tested-by: <howaboutsynergy@protonmail.com>

Having a contact email address is potentially useful.  I'd be more
concerned about anonymity if it involved an actual code modification.

And thanks for your persistence and assistance.
