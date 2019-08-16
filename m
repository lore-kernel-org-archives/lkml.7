Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49354C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 04:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DF52077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 04:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfHPEow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 00:44:52 -0400
Received: from verein.lst.de ([213.95.11.211]:52000 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPEow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 00:44:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1DD368AFE; Fri, 16 Aug 2019 06:44:48 +0200 (CEST)
Date:   Fri, 16 Aug 2019 06:44:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct
 hmm_vma_walk
Message-ID: <20190816044448.GB4093@lst.de>
References: <20190814132746.GE13756@mellanox.com> <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com> <20190815180325.GA4920@redhat.com> <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com> <20190815194339.GC9253@redhat.com> <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com> <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com> <20190815205132.GC25517@redhat.com> <20190816004303.GC9929@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816004303.GC9929@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:43:07AM +0000, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2019 at 04:51:33PM -0400, Jerome Glisse wrote:
> 
> > struct page. In this case any way we can update the
> > nouveau_dmem_page() to check that page page->pgmap == the
> > expected pgmap.
> 
> I was also wondering if that is a problem.. just blindly doing a
> container_of on the page->pgmap does seem like it assumes that only
> this driver is using DEVICE_PRIVATE.
> 
> It seems like something missing in hmm_range_fault, it should be told
> what DEVICE_PRIVATE is acceptable to trigger HMM_PFN_DEVICE_PRIVATE
> and fault all others?

The whole device private handling in hmm and migrate_vma seems pretty
broken as far as I can tell, and I have some WIP patches.  Basically we
should not touch (or possibly eventually call migrate to ram eventually
in the future) device private pages not owned by the caller, where I
try to defined the caller by the dev_pagemap_ops instance.  
