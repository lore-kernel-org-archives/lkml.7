Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2253FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C89214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="dElPNkce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfCLEwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:52:08 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:59870 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbfCLEwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1552366327;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=qK7Kkdb/luLy5flAaiCvdcEVBIH2RfSi6TODITDFLgA=;
        b=dElPNkceskPXXplCyxkN3dRK3hqf46DyzKgPZ7kq+A9+qVfIrCUBt86RwQ9sawsh
        l/WOqpQNr7g2MIGzf2mgaad0g5o3koVlF16EgjpIcP5ROkP90TqcntjqBI+w1bPoYQe
        xcBj3TFY3yhzoc369I5gBAAaRilESZrIA3dLnEaI=
Date:   Tue, 12 Mar 2019 04:52:07 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jerome Glisse <jglisse@redhat.com>
cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
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
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
In-Reply-To: <20190308190704.GC5618@redhat.com>
Message-ID: <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com> <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com> <20190308190704.GC5618@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.12-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019, Jerome Glisse wrote:

> >
> > It would good if that understanding would be enforced somehow given the problems
> > that we see.
>
> This has been discuss extensively already. GUP usage is now widespread in
> multiple drivers, removing that would regress userspace ie break existing
> application. We all know what the rules for that is.

The applications that work are using anonymous memory and memory
filesystems. I have never seen use cases with a real filesystem and would
have objected if someone tried something crazy like that.

Because someone was able to get away with weird ways of abusing the system
it not an argument that we should continue to allow such things. In fact
we have repeatedly ensured that the kernel works reliably by improving the
kernel so that a proper failure is occurring.


> > > In fact, the GUP documentation even recommends that pattern.
> >
> > Isnt that pattern safe for anonymous memory and memory filesystems like
> > hugetlbfs etc? Which is the common use case.
>
> Still an issue in respect to swapout ie if anon/shmem page was map
> read only in preparation for swapout and we do not report the page
> as dirty what endup in swap might lack what was written last through
> GUP.

Well swapout cannot occur if the page is pinned and those pages are also
often mlocked.

> >
> > Yes you now have the filesystem as well as the GUP pinner claiming
> > authority over the contents of a single memory segment. Maybe better not
> > allow that?
>
> This goes back to regressing existing driver with existing users.

There is no regression if that behavior never really worked.

> > Two filesystem trying to sync one memory segment both believing to have
> > exclusive access and we want to sort this out. Why? Dont allow this.
>
> This is allowed, it always was, forbidding that case now would regress
> existing application and it would also means that we are modifying the
> API we expose to userspace. So again this is not something we can block
> without regressing existing user.

We have always stopped the user from doing obviously stupid and risky
things. It would be logical to do it here as well.

