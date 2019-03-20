Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F8BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC02184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5Xhif6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfCTLUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:20:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfCTLUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X0UZ2Ky/zStGHPaiYjOhz7nuC7+B3z5ZswtS2vYbX0k=; b=P5Xhif6soKuu27UyLw0TJwt/C
        g7xrtrWG+7HryAGydpaDjOzzLE9hFy3fvrjNfU6qMKF/chFBOkOCGxxmntD1+x0rR+bV4YU33Lh4Z
        SK4dVmHgpGdCjSvZrwf1xQ1ib9/Du59c0XiSCwlT/FRVBuPZYYkHS8dbNVCpPzrtnYzsoJQJKnIgf
        OB6sdGR8ndX/HMvYrV6Qtp9sRvO1cc++XFEwXrDujZN248gpAulDa0RZsHpRTWocZlWQsEGmCS0IY
        ReAOcRWeLdr0STaS8VT7lut7bUqEbKmpgPDfEPdX8qfcGO1SiABMYc/usMdt30poz+7CBpRiWBBHu
        oFlP3BEqQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6ZGJ-0005lm-Qz; Wed, 20 Mar 2019 11:19:59 +0000
Date:   Wed, 20 Mar 2019 04:19:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190320111959.GV19508@bombadil.infradead.org>
References: <20190320073540.12866-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320073540.12866-1-bhe@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:35:38PM +0800, Baoquan He wrote:
>  /*
> - * returns the number of sections whose mem_maps were properly
> - * set.  If this is <=0, then that means that the passed-in
> - * map was not consumed and must be freed.
> + * sparse_add_one_section - add a memory section
> + * @nid:	The node to add section on
> + * @start_pfn:	start pfn of the memory range
> + * @altmap:	device page map
> + *
> + * Return 0 on success and an appropriate error code otherwise.
>   */

I think it's worth documenting what those error codes are.  Seems to be
just -ENOMEM and -EEXIST, but it'd be nice for users to know what they
can expect under which circumstances.

Also, -EEXIST is a bad errno to return here:

$ errno EEXIST
EEXIST 17 File exists

What file?  I think we should be using -EBUSY instead in case this errno
makes it back to userspace:

$ errno EBUSY
EBUSY 16 Device or resource busy

