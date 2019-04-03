Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46582133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gKM4Ohdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCW0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:26:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCW0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4sM4jM/05yRkqplt/Hqwb+t2TNRqvSzWAX2hX/lIuSg=; b=gKM4OhdlR5pJCkjHuQxfY4tJR
        yuAI6w0ZwPku2n5WfEBtrX109MZ61w/f7ut+nzrk1UghQEcxTljzl3OIMIAn7dRe79xgETbIwgXfG
        Q+gyr9/iwSPUvdJ2RV/c+T5rppN4iWcLztDuaDe4tLaDFF79q3p6npb++Z11bZ/Unpouc8jBqb/Gw
        KISdsP9Kz2x3QLyob0h33TTEF1jvHcdJRC7bH59qh6yX1Hlcc94UAq3iNeiwgPIFfGwvrSbzqUhIZ
        N8nvLJD5YEzZKOAGZg+fh5wZvHWKhMXhNJFy38r7jHvlbvm7YOuFxXvm8dlLvO7/ICTC3f1NTsWZw
        nOBU0qaqw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBoKz-0002Wm-3A; Wed, 03 Apr 2019 22:26:29 +0000
Date:   Wed, 3 Apr 2019 15:26:26 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: alienware-wmi: fix kfree on potentially
 uninitialized pointer
Message-ID: <20190403222626.GA11745@wrath>
References: <20190330001712.8923-1-colin.king@canonical.com>
 <20190403220200.GC39081@wrath>
 <424c2bba-1e17-3131-c15b-44462c57e22d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424c2bba-1e17-3131-c15b-44462c57e22d@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:05:12PM +0100, Colin Ian King wrote:
> On 03/04/2019 23:02, Darren Hart wrote:
> > On Sat, Mar 30, 2019 at 12:17:12AM +0000, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Currently the kfree of output.pointer can be potentially freeing
> >> an uninitalized pointer in the case where out_data is NULL. Fix this
> >> by reworking the case where out_data is not-null to perform the
> >> ACPI status check and also the kfree of outpoint.pointer in one block
> >> and hence ensuring the pointer is only freed when it has been used.
> >>
> >> Also replace the if (ptr != NULL) idiom with just if (ptr).
> >>
> >> Fixes: ff0e9f26288d ("platform/x86: alienware-wmi: Correct a memory leak")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > 
> > Thanks for the catch Colin, queued for testing.
> > 
> > Did you trigger this error or detect it via review or static analysis?
> > 
> Static analysis, I'm now running a licensed version of Coverity on one
> of our servers.

We typically include the tool used to identify such bugs, and I see several such
tags for Coverity in the logs. Was there a reason not to include that tag? If
just an oversight, can you provide that tag and I'll amend the commit.

-- 
Darren Hart
VMware Open Source Technology Center
