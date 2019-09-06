Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA1020842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbfIFIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:37:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731558AbfIFIhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:37:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DC41AB87;
        Fri,  6 Sep 2019 08:37:17 +0000 (UTC)
Date:   Fri, 6 Sep 2019 10:37:15 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] amd/iommu: flush old domains in kdump kernel
Message-ID: <20190906083715.GD5457@suse.de>
References: <9d271f88-949a-7356-c516-be95b1566c94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d271f88-949a-7356-c516-be95b1566c94@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:09:48PM -0500, Stuart Hayes wrote:
> When devices are attached to the amd_iommu in a kdump kernel, the old device
> table entries (DTEs), which were copied from the crashed kernel, will be
> overwritten with a new domain number.  When the new DTE is written, the IOMMU
> is told to flush the DTE from its internal cache--but it is not told to flush
> the translation cache entries for the old domain number.
> 
> Without this patch, AMD systems using the tg3 network driver fail when kdump
> tries to save the vmcore to a network system, showing network timeouts and
> (sometimes) IOMMU errors in the kernel log.
> 
> This patch will flush IOMMU translation cache entries for the old domain when
> a DTE gets overwritten with a new domain number.

Hmm, this seems to point to an interesting implementation detail of the
AMD IOMMUs. In theory, when the DTE is flushed, there shouldn't be any
device transactions looked up with the old domain id anymore, and thus
no faults should happen.

Anyway, applied the patch, thanks.


Regards,

	Joerg
