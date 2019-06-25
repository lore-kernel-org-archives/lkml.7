Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D1C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E602F205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfFYI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:29:13 -0400
Received: from verein.lst.de ([213.95.11.211]:60882 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfFYI3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:29:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F2E2768B02; Tue, 25 Jun 2019 10:28:40 +0200 (CEST)
Date:   Tue, 25 Jun 2019 10:28:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] powerpc/powernv: remove the unused pnv_pci_set_p2p
 function
Message-ID: <20190625082840.GA31969@lst.de>
References: <20190625081512.16704-1-hch@lst.de> <20190625081512.16704-2-hch@lst.de> <113fb518-0f5a-8ced-8391-abe48869a0cb@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <113fb518-0f5a-8ced-8391-abe48869a0cb@kaod.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:26:03AM +0200, Cédric Le Goater wrote:
> > @@ -280,13 +280,6 @@ int64_t opal_xive_allocate_irq(uint32_t chip_id);
> >  int64_t opal_xive_free_irq(uint32_t girq);
> >  int64_t opal_xive_sync(uint32_t type, uint32_t id);
> >  int64_t opal_xive_dump(uint32_t type, uint32_t id);
> > -int64_t opal_xive_get_queue_state(uint64_t vp, uint32_t prio,
> > -				  __be32 *out_qtoggle,
> > -				  __be32 *out_qindex);
> > -int64_t opal_xive_set_queue_state(uint64_t vp, uint32_t prio,
> > -				  uint32_t qtoggle,
> > -				  uint32_t qindex);
> > -int64_t opal_xive_get_vp_state(uint64_t vp, __be64 *out_w01);
> 
> 
> This hunk seems unrelated.
> 
> These OPAL calls are new. They are used by the XIVE KVM device 
> to get/set the interrupt controller state of a guest. 
> 
> 
> >  int64_t opal_pci_set_p2p(uint64_t phb_init, uint64_t phb_target,
> >  			uint64_t desc, uint16_t pe_number);
> 
> I suppose this is the one ^ you wanted to remove.

Thanks.  I'm pretty sure I had this fixed up before due to a builtbot
warning, but somehow the old version popped up again.
