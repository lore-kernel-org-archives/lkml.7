Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B87FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F054214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556145988;
	bh=xMQe/1g8Lq5czfFBXgIObrn4f3AhCHGB5oy2hd4bECI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PecPg4bcD3ykq2oI/jMaAt8oMsH/6BOD5FtMU2nuCyGlRUMi9IPB6nUXcoem3wvby
	 I+T5JGhXALDu9fsXmW6GZiESq94IAMX5lXX3rXX3Xg0J00PdzaNphW87SRzhM+tJyl
	 f5CT19m28Xg9VRI+wBT3Uv3oduxvzIy42D0L13V8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfDXWq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:46:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfDXWq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:46:26 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66179B49;
        Wed, 24 Apr 2019 22:46:25 +0000 (UTC)
Date:   Wed, 24 Apr 2019 15:46:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: fix never set ALLOC_NOFRAGMENT flag
Message-Id: <20190424154624.f1084195c36684453a557718@linux-foundation.org>
In-Reply-To: <20190424090403.GS18914@techsingularity.net>
References: <20190423120806.3503-1-aryabinin@virtuozzo.com>
        <20190423120806.3503-2-aryabinin@virtuozzo.com>
        <20190423120143.f555f77df02a266ba2a7f1fc@linux-foundation.org>
        <20190424090403.GS18914@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 10:04:03 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> On Tue, Apr 23, 2019 at 12:01:43PM -0700, Andrew Morton wrote:
> > On Tue, 23 Apr 2019 15:08:06 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> > 
> > > Commit 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> > > removed setting of the ALLOC_NOFRAGMENT flag. Bring it back.
> > 
> > What are the runtime effects of this fix?
> 
> The runtime effect is that ALLOC_NOFRAGMENT behaviour is restored so
> that allocations are spread across local zones to avoid fragmentation
> due to mixing pageblocks as long as possible.

OK, thanks.  Is this worth a -stable backport?
