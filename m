Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C909BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB00E2154A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfK1HFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:05:43 -0500
Received: from verein.lst.de ([213.95.11.211]:50681 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfK1HFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:05:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CFD2968C7B; Thu, 28 Nov 2019 08:05:38 +0100 (CET)
Date:   Thu, 28 Nov 2019 08:05:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Message-ID: <20191128070538.GB20274@lst.de>
References: <20191114124646.74790-1-pasic@linux.ibm.com> <20191119121022.03aed69a.pasic@linux.ibm.com> <20191119080420-mutt-send-email-mst@kernel.org> <20191122140827.0ead345c.pasic@linux.ibm.com> <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com> <20191126184527.GA10481@lst.de> <20191128004225.GA11539@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128004225.GA11539@ashkalra_ubuntu_server>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 12:42:25AM +0000, Ashish Kalra wrote:
> Why can't we leverage CMA instead of SWIOTLB for DMA when SEV is
> enabled, CMA is well integerated with the DMA subsystem and handles
> encrypted pages when force_dma_unencrypted() returns TRUE. 
> 
> Though, CMA might face the same issues as SWIOTLB bounce buffers, it's
> size is similarly setup statically as SWIOTLB does or can be set as a 
> percentage of the available system memory.

How is CMA integrated with SEV?  CMA just gives a contiguous chunk
of memory, which still needs to be remapped as unencrypted before
returning it to the user.
