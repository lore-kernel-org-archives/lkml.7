Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F45C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255892183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YjBUampI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCTBBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:01:07 -0400
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:38558 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727205AbfCTBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553043666;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=Qm0r/S4Ne4XTZAHDLismxE9m3x/wdarSZ1AUHvBMnnQ=;
        b=YjBUampIgq93H7NdpjoHwlbka+MNSa7HfbivjdfJz2BjHertUJNb19GG8bNMjG+N
        iF35ywDLZrnkqgecUxB12DQFn/81gops112YhDaaLzDBYIwTlS8+I+gs1fhkLMhugh0
        f8t9ZHIseriw4WNyToiVQfCpkHirywg0aSE2ezwA=
Date:   Wed, 20 Mar 2019 01:01:06 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dave Chinner <david@fromorbit.com>
cc:     Jerome Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
In-Reply-To: <20190319235752.GB26298@dastard>
Message-ID: <01000169989db656-8868a4b2-a8eb-4666-872f-2ed9885c99e6-000000@email.amazonses.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com> <20190308213633.28978-2-jhubbard@nvidia.com> <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1> <20190319134724.GB3437@redhat.com> <20190319141416.GA3879@redhat.com> <20190319212346.GA26298@dastard>
 <20190319220654.GC3096@redhat.com> <20190319235752.GB26298@dastard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.20-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Dave Chinner wrote:

> So the plan for GUP vs writeback so far is "break fsync()"? :)

Well if its an anonymous page and not a file backed page then the
semantics are preserved. Disallow GUP long term pinning (marking stuff like in this
patchset may make that possible) and its clean.
