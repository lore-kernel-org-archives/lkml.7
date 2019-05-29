Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A903C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F231A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfE2JwX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:52:23 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:33324 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2JwX (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Wed, 29 May 2019 05:52:23 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 29 May 2019 03:52:22 -0600
Message-Id: <5CEE56510200007800233550@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 29 May 2019 03:52:17 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Stefano Stabellini" <sstabellini@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v2 1/3] xen/swiotlb: fix condition for
 calling xen_destroy_contiguous_region()
References: <20190529090407.1225-1-jgross@suse.com>
 <20190529090407.1225-2-jgross@suse.com>
In-Reply-To: <20190529090407.1225-2-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 29.05.19 at 11:04, <jgross@suse.com> wrote:
> The condition in xen_swiotlb_free_coherent() for deciding whether to
> call xen_destroy_contiguous_region() is wrong: in case the region to
> be freed is not contiguous calling xen_destroy_contiguous_region() is
> the wrong thing to do: it would result in inconsistent mappings of
> multiple PFNs to the same MFN. This will lead to various strange
> crashes or data corruption.
> 
> Instead of calling xen_destroy_contiguous_region() in that case a
> warning should be issued as that situation should never occur.
> 
> Cc: stable@vger.kernel.org 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>


