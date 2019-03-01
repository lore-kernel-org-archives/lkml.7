Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B28C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282B120857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gUqSTtDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbfCASPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:15:54 -0500
Received: from a9-37.smtp-out.amazonses.com ([54.240.9.37]:50906 "EHLO
        a9-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbfCASPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1551464153;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=FDPvho67mHwhjGZkY+/Kcg+wZ7kTjOJhXHN8h7b6btE=;
        b=gUqSTtDt/xsrAgpcQkYT5r8uyTdVLqlGUGiTMHm+MT7gEpeJZuh5DZzWYecKjf6f
        WDBPABAwh2DBC/Tv5YiPM7nlrQX/JmUTGvQexQL/c24D1934mUifHQl26BDn8Mjipl1
        kl6uclhmilgWQOgNWIru6mtWSvctWkppiJDjQHg4=
Date:   Fri, 1 Mar 2019 18:15:53 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Shaobo He <shaobo@cs.utah.edu>
cc:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxgb4: fix undefined behavior in mem.c
In-Reply-To: <abf425b1-19ba-9cf5-8288-87ac0dbf6ac7@cs.utah.edu>
Message-ID: <010001693a7840a4-9fc27417-7088-431a-9ecd-6836c3293c9d-000000@email.amazonses.com>
References: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu> <1551394596.31902.209.camel@acm.org> <abf425b1-19ba-9cf5-8288-87ac0dbf6ac7@cs.utah.edu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.01-54.240.9.37
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019, Shaobo He wrote:

> I think maybe the more problematic issue is that the value of a freed pointer
> is intermediate.

The pointer is not affected by freeing the data it points to. Thus it
definitely has the same value as before and is not indeterminate.

The pointer points now to an area of memory that could now be in use for
different purposes so maybe it could be taken as a dangerous situation.

But situations like that are common in code.

