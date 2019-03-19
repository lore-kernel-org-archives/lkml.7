Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24970C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3BE20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553015576;
	bh=yb7rlhAOyr2DIgzIdNxF8fTby0EHadFxRYY0HkyNJDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=apGQQtOntANvZ6DoQ5bedhMVSMcJdFOCY9QyQpqCFSDs2UtoIhcnwpL9nTzv2SrY6
	 qFmGPPHG3Gt0fxINhr7M5M87u2eI56W35Gg24hu/mTjEP+71mVFAuHnQup88khnHqK
	 dxBhOAVHCi3BarRzTEsaOtwzJsBEycgQuFWMT3dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfCSRMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:12:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfCSRMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:12:54 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E79E3B2C;
        Tue, 19 Mar 2019 17:12:52 +0000 (UTC)
Date:   Tue, 19 Mar 2019 10:12:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-Id: <20190319101249.d2076f4bacbef948055ae758@linux-foundation.org>
In-Reply-To: <20190319165802.GA3656@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
        <20190313012706.GB3402@redhat.com>
        <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
        <20190318170404.GA6786@redhat.com>
        <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
        <20190319165802.GA3656@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 12:58:02 -0400 Jerome Glisse <jglisse@redhat.com> wrote:

> > So I think I'll throw up my hands, drop them all and shall await
> > developments :(
> 
> What more do you want to see ? I can repost with the ack already given
> and the improve commit wording on some of the patch. But from user point
> of view nouveau is already upstream, ODP RDMA depends on this patchset
> and is posted and i have given link to it. amdgpu is queue up. What more
> do i need ?

I guess I can ignore linux-next for a few days.  

Yes, a resend against mainline with those various updates will be
helpful.  Please go through the various fixes which we had as well:


mm-hmm-use-reference-counting-for-hmm-struct.patch
mm-hmm-do-not-erase-snapshot-when-a-range-is-invalidated.patch
mm-hmm-improve-and-rename-hmm_vma_get_pfns-to-hmm_range_snapshot.patch
mm-hmm-improve-and-rename-hmm_vma_fault-to-hmm_range_fault.patch
mm-hmm-improve-driver-api-to-work-and-wait-over-a-range.patch
mm-hmm-improve-driver-api-to-work-and-wait-over-a-range-fix.patch
mm-hmm-improve-driver-api-to-work-and-wait-over-a-range-fix-fix.patch
mm-hmm-add-default-fault-flags-to-avoid-the-need-to-pre-fill-pfns-arrays.patch
mm-hmm-add-an-helper-function-that-fault-pages-and-map-them-to-a-device.patch
mm-hmm-support-hugetlbfs-snap-shoting-faulting-and-dma-mapping.patch
mm-hmm-allow-to-mirror-vma-of-a-file-on-a-dax-backed-filesystem.patch
mm-hmm-allow-to-mirror-vma-of-a-file-on-a-dax-backed-filesystem-fix.patch
mm-hmm-allow-to-mirror-vma-of-a-file-on-a-dax-backed-filesystem-fix-2.patch
mm-hmm-add-helpers-for-driver-to-safely-take-the-mmap_sem.patch

Also, the discussion regarding [07/10] is substantial and is ongoing so
please let's push along wth that.

What is the review/discussion status of "[PATCH 09/10] mm/hmm: allow to
mirror vma of a file on a DAX backed filesystem"?

