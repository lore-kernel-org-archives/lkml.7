Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7393C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F9B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KT0tbWbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfCTM6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:58:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RJJJ7yyKVRQ4bRHWvA5mb5SYeK0JcTI2cvUihx2K9Do=; b=KT0tbWbT3amQ5wEKoASz7O7C1
        33OJa5pQjT1aKz0p9LaJfXvSj3j+SjSn8h36n0sI6Mqh+yTwBmzZM+FkIH5UZnkgsazqLd6W/1OHR
        pMbGeOkUHdBQ48rLKzCJu1EDH6SsfinNWUJal3Lzpmtvy+DHtz6Eo2JF/XKkQk61ezhn6kTublY1S
        lftW0dQW9qR490BWN/pKvS5UvBf29Dg2108uID5QdGW7EYPid/RqyahMVgD0Jg3QZ28jBHwbV5zwZ
        bGZLnxO20VX7pWSBiH0zAqcmhRV/8PYSqcmNY/wzrVyhjdQP4UKMKL3hrVpwdu6Qk/eno4ReccB5M
        RsNJBwzdQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6anr-0005wS-BG; Wed, 20 Mar 2019 12:58:43 +0000
Date:   Wed, 20 Mar 2019 05:58:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190320125843.GY19508@bombadil.infradead.org>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320111959.GV19508@bombadil.infradead.org>
 <20190320122011.stuoqugpjdt3d7cd@d104.suse.de>
 <20190320122243.GX19508@bombadil.infradead.org>
 <20190320123658.GF13626@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320123658.GF13626@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 02:36:58PM +0200, Mike Rapoport wrote:
> There are more than a thousand -EEXIST in the kernel, I really doubt all of
> them mean "File exists" ;-)

And yet that's what the user will see if it's ever printed with perror()
or similar.  We're pretty bad at choosing errnos; look how abused
ENOSPC is:

$ errno ENOSPC
ENOSPC 28 No space left on device

net/sunrpc/auth_gss/gss_rpc_xdr.c:              return -ENOSPC;

... that's an authentication failure, not "I've run out of disc space".
