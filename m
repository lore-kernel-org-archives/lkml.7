Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65183C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410E32184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfCTO7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:59:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCTO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:59:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EB206698A;
        Wed, 20 Mar 2019 14:59:13 +0000 (UTC)
Received: from redhat.com (ovpn-123-180.rdu2.redhat.com [10.10.123.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C80A6CE59;
        Wed, 20 Mar 2019 14:59:04 +0000 (UTC)
Date:   Wed, 20 Mar 2019 10:59:02 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <david@fromorbit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
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
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190320145901.GA3216@redhat.com>
References: <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
 <20190319141416.GA3879@redhat.com>
 <20190319212346.GA26298@dastard>
 <20190319220654.GC3096@redhat.com>
 <20190319235752.GB26298@dastard>
 <20190320000838.GA6364@redhat.com>
 <c854b2d6-5ec1-a8b5-e366-fbefdd9fdd10@nvidia.com>
 <20190320043319.GA7431@redhat.com>
 <BFC3CDEE-4349-44C1-BE11-7C168BC578E1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BFC3CDEE-4349-44C1-BE11-7C168BC578E1@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 20 Mar 2019 14:59:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:55:17AM -0600, William Kucharski wrote:
> 
> 
> > On Mar 19, 2019, at 10:33 PM, Jerome Glisse <jglisse@redhat.com> wrote:
> > 
> > So i believe best we could do is send a SIGBUS to the process that has
> > GUPed a range of a file that is being truncated this would match what
> > we do for CPU acces. There is no reason access through GUP should be
> > handled any differently.
> 
> This should be done lazily, as there's no need to send the SIGBUS unless
> the GUPed page is actually accessed post-truncate.

Issue is that unlike CPU access we might not be able to detect device
access and thus it is not something we can do lazily for everyone.

Cheers,
Jérôme
