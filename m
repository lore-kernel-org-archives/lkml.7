Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB567C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9F72075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554182551;
	bh=bpv8p/rlQ6oBZobF2Q89JuzxeaJ3OgKetbQByQ3EFdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mCbDv0D95pTJV7aGjV+e9z7E68shpGcDvi/qoU6M7d34heceFPHHDM0FGNXe/XKri
	 5kFsrgEo2V7JDtk3PUsMC76d5f4WjkUP4BtFVtFAlwrskJWDeRfjMLT/KC106DlWhU
	 yArKaHNVat84fidjCAMqB+9Bya36Ct/6Z7pQmO98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfDBFWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:22:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDBFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:22:30 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C85C109D;
        Tue,  2 Apr 2019 05:22:29 +0000 (UTC)
Date:   Mon, 1 Apr 2019 22:22:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Oskar Schirmer <oskar@scara.com>
Subject: Re: [PATCH] lib: Fix possible incorrect result from rational
 fractions helper
Message-Id: <20190401222228.5692d7e8d5b979a8c574e76c@linux-foundation.org>
In-Reply-To: <20190330205855.19396-1-tpiepho@gmail.com>
References: <20190330205855.19396-1-tpiepho@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2019 13:58:55 -0700 Trent Piepho <tpiepho@gmail.com> wrote:

> In some cases the previous algorithm would not return the closest
> approximation.  This would happen when a semi-convergent was the
> closest, as the previous algorithm would only consider convergents.
> 
> As an example, consider an initial value of 5/4, and trying to find the
> closest approximation with a maximum of 4 for numerator and denominator.
> The previous algorithm would return 1/1 as the closest approximation,
> while this version will return the correct answer of 4/3.
> 
> To do this, the main loop performs effectively the same operations as it
> did before.  It must now keep track of the last three approximations,
> n2/d2 .. n0/d0, while before it only needed the last two.
> 
> If an exact answer is not found, the algorithm will now calculate the
> best semi-convergent term, t, which is a single expression with two
> divisions:
>     min((max_numerator - n0) / n1, (max_denominator - d0) / d1)
> 
> This will be used if it is better than previous convergent.  The test
> for this is generally a simple comparison, 2*t > a.  But in an edge
> case, where the convergent's final term is even and the best allowable
> semi-convergent has a final term of exactly half the convergent's final
> term, the more complex comparison (d0*dp > d1*d) is used.
> 
> I also wrote some comments explaining the code.  While one still needs
> to look up the math elsewhere, they should help a lot to follow how the
> code relates to that math.

What are the userspace-visible runtime effects of this change?
