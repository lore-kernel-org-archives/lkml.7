Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF225C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9C7206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZO5QAGGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDCWCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:02:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCWCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pofgyDkxMfYUbQlVrdDi0tNi+OpbfPrCGCVYQGoM2+U=; b=ZO5QAGGrwp4FViHmRJboCAey/
        lRDOJ4fue5oOCibaVdM/db0QGQ6iUTqvvmm5QZtrPKtOtcqSe7f6wsnXy5Ejfu9Ep5iy5J/gCbadx
        EAJ2yfCnWadveNhIWYBmCHOTTdQYPej2HT4sPjZopKHJRKGD/vDEyRGMuQwMalYz5nFS5zw4jSsXD
        kvaqkNEYYWCMP1y6GCnJ2PO1TRrKGYfKg6MASuV8iKhBZZVOQwEykk3+Ow3UzYJe4QIyDdjYzmGTx
        fRPhxtWA+AV6ANRymJGvsprw5CaH1/gLibBwo7E3OF+iSuEhZmI79vJYtsTJavcwYwx7Z1tWgZnxo
        91qIqeUMA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBnxJ-0002cF-7G; Wed, 03 Apr 2019 22:02:01 +0000
Date:   Wed, 3 Apr 2019 15:02:00 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: alienware-wmi: fix kfree on potentially
 uninitialized pointer
Message-ID: <20190403220200.GC39081@wrath>
References: <20190330001712.8923-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330001712.8923-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:17:12AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the kfree of output.pointer can be potentially freeing
> an uninitalized pointer in the case where out_data is NULL. Fix this
> by reworking the case where out_data is not-null to perform the
> ACPI status check and also the kfree of outpoint.pointer in one block
> and hence ensuring the pointer is only freed when it has been used.
> 
> Also replace the if (ptr != NULL) idiom with just if (ptr).
> 
> Fixes: ff0e9f26288d ("platform/x86: alienware-wmi: Correct a memory leak")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the catch Colin, queued for testing.

Did you trigger this error or detect it via review or static analysis?

-- 
Darren Hart
VMware Open Source Technology Center
