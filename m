Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE873C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25CD20644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfG3Pvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:51:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3Pvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:51:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBA843E2D3;
        Tue, 30 Jul 2019 15:51:40 +0000 (UTC)
Received: from redhat.com (ovpn-112-36.rdu2.redhat.com [10.10.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFACB608A5;
        Tue, 30 Jul 2019 15:51:37 +0000 (UTC)
Date:   Tue, 30 Jul 2019 11:51:34 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] mm: remove the MIGRATE_PFN_WRITE flag
Message-ID: <20190730155134.GA10366@redhat.com>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-10-hch@lst.de>
 <20190729233044.GA7171@redhat.com>
 <20190730054633.GA28515@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730054633.GA28515@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 30 Jul 2019 15:51:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 07:46:33AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 29, 2019 at 07:30:44PM -0400, Jerome Glisse wrote:
> > On Mon, Jul 29, 2019 at 05:28:43PM +0300, Christoph Hellwig wrote:
> > > The MIGRATE_PFN_WRITE is only used locally in migrate_vma_collect_pmd,
> > > where it can be replaced with a simple boolean local variable.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > NAK that flag is useful, for instance a anonymous vma might have
> > some of its page read only even if the vma has write permission.
> > 
> > It seems that the code in nouveau is wrong (probably lost that
> > in various rebase/rework) as this flag should be use to decide
> > wether to map the device memory with write permission or not.
> > 
> > I am traveling right now, i will investigate what happened to
> > nouveau code.
> 
> We can add it back when needed pretty easily.  Much of this has bitrotted
> way to fast, and the pending ppc kvmhmm code doesn't need it either.

Not using is a serious bug, i will investigate this friday.

Cheers,
Jérôme
