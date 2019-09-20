Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD42AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D92086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569022473;
	bh=/YosVo+HfPJ1Yw7oV0CNBOb4mub/i8BluEt8xwgoZjI=;
	h=Date:From:To:Subject:In-Reply-To:References:List-ID:From;
	b=DbVHO2BTmLIbB5tdpnlYEPh1UAxqhd48vGWFoARRqIybscwmgQtANPJ3+Fhp6OJsL
	 cCwwxfeEr9Wjia2kJ1raOzRFNcs1lMyfVMMYiGwq/AMyjjmxerlbU64RQuwreUYCJ0
	 R0mlojxDnZeLjCJP7guBHe4He/1NFBRHuPg0gexM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437174AbfITXec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404978AbfITXec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:34:32 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549D520644;
        Fri, 20 Sep 2019 23:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569022471;
        bh=/YosVo+HfPJ1Yw7oV0CNBOb4mub/i8BluEt8xwgoZjI=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=riudAg9NPMdG04g2ulcp+aHRAcidmwbPWim4HcWamQR0be66tZ5Q7jYIqkrSEQNxk
         IpeKbjIdEVvM0bQkVgqZhabasj3FfHRZgs9O1GNmfok9i6Rtz3jDt+qC6BOscGCRMY
         RUp30OZP4cFAaJzu6FdfaxxgGfL0Hbe9gxesq6HE=
Date:   Fri, 20 Sep 2019 16:34:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/4] debug_pagealloc improvements through page_owner
Message-Id: <20190920163430.4b24cc18d2ae552822a0ffaf@linux-foundation.org>
In-Reply-To: <20190822160344.716eda34585271fa4a519d4c@linux-foundation.org>
References: <20190820131828.22684-1-vbabka@suse.cz>
        <20190822160344.716eda34585271fa4a519d4c@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 16:03:44 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 20 Aug 2019 15:18:24 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > v2: also fix THP split handling (added Patch 1) per Kirill
> > 
> > The debug_pagealloc functionality serves a similar purpose on the page
> > allocator level that slub_debug does on the kmalloc level, which is to detect
> > bad users. One notable feature that slub_debug has is storing stack traces of
> > who last allocated and freed the object. On page level we track allocations via
> > page_owner, but that info is discarded when freeing, and we don't track freeing
> > at all. This series improves those aspects. With both debug_pagealloc and
> > page_owner enabled, we can then get bug reports such as the example in Patch 4.
> > 
> > SLUB debug tracking additionaly stores cpu, pid and timestamp. This could be
> > added later, if deemed useful enough to justify the additional page_ext
> > structure size.
> 
> Thanks.  I split [1/1] out of the series as a bugfix and turned this
> into a three-patch series.
> 

None of which anyone has yet reviewed :(


