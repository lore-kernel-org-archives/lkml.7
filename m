Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A851C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B41420835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJubGaVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCGFBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:01:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfCGFBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tU/hlJU8VvRBjnpc0IVqG3D04FZPbB5MBMU/9Tb3auw=; b=jJubGaVlkVh9e7FLikY6BAXps
        Pt1kan2T+GwidNMz6qYcjsaRDudN/MZsaDrOABueGGNDCDSqBkG9oH36Ty8drl4AGBKRb96krhzKU
        +ZjkjUR5Mr4/9vpSq2aMLHEMZek/fbfGUeg6sTJXpcV01tRUt9ZqCOCcO+TRzTalkdexCWS++2w73
        yKZzAVyII9ju7tfsiq/OxuoZl8DltxuPYYxiXi3oXQVmbq3m8n6tkkRVjrzoYMpXtSpmC5j9J+opc
        OVICPnTtguX7pJhhtyaEzo6r2KUfAV21jU1JGyIFw9hV2WL/7JZ4/xZRGzTit74hUiWEBcARrZPhI
        CivthLnIg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1l9R-0008SL-Me; Thu, 07 Mar 2019 05:01:01 +0000
Date:   Wed, 6 Mar 2019 21:01:00 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up a
 battery node
Message-ID: <20190307050100.GA44339@wrath>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-3-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:40:00PM +0100, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. Add a different compatible string to the 1.5
> battery.

Hi Lubomir,

Thanks for the recent Cc and pointer to here. In general, I have no
problem with the net changes. I do have some concerns from a
reviewability and change documentation perspective.

You document your intent above, but you also made several other changes
to get there which aren't documented, so when reviewing they stand out
as "why is this here?".

From what I can tell, this change contains:

1) Cleanup of olpc_dt_interpret() calls to avoid splitting string
literals (noted in the patch history, but not called out as an
intentional change)

2) Refactoring of logic and breaking out the check for the compatible
property into olpc_dt_compatible_match

3) Addition of "we're running very old firmware if this is missing"
checks - I'm not sure how this relates to the stated problem and
the intended fix.

4) The addition of the xo1.5 compatible property.

All the other things makes it very difficult to determine if this patch
does what you describe - and only what you describe.

In general please:
a) Cleanup code
b) Refactor code
c) Change functionality

In that order - that way the new functionality is what show up when
someone does a git blame on the file (rather than a cleanup patch, which
isn't as useful in defect analysis).

And always document in your commit messages the approach you take to fix
the reported issue.

Thanks,


-- 
Darren Hart
VMware Open Source Technology Center
