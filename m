Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F9420665
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569001577;
	bh=E62ia8SOUrBiyYyyWI8Hdlh2Y8guZZFrUsqYiQPOejk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AT1r2flGbpIWVoXzwW/4XtV0TXfNoqqMSvf3+JC3yLQSrG5HQyWMr37L+Ttx/ZrhM
	 yr89VJWAqxo7ZMCqINIn1uQ5J23FY7crzRFd98qPzooehOZL1nzDf4cqh/d1xlmELL
	 5RxRz0PoyxtmXYIPTlwP4gr7a6RLQ3zWdRj6pWLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393755AbfITRqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389097AbfITRqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:46:16 -0400
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D92920640;
        Fri, 20 Sep 2019 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569001575;
        bh=E62ia8SOUrBiyYyyWI8Hdlh2Y8guZZFrUsqYiQPOejk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyrgx05TpxfWKLOJcjkaSAcmPUb+eZxHRgnq3zFu7Yu4vqeAQ3/z3bYrnM53xPQg3
         sIkdUI0s1DahlDAFD/4eptLYTkfo5UFGZ/UeBlD0N5nLgdkI2koXFCS6N6iVUpZBCS
         Pz2RqCBa2EbGCaMFRQ9fAZ3+M2t8eBzSI2fwTQX4=
Date:   Fri, 20 Sep 2019 11:46:13 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Jared Dominguez <jared.dominguez@dell.com>
Subject: Re: [PATCH v2] nvme-pci: Save PCI state before putting drive into
 deepest state
Message-ID: <20190920174613.GA97775@C02WT3WMHTD6>
References: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 01:15:55PM -0500, Mario Limonciello wrote:
> The action of saving the PCI state will cause numerous PCI configuration
> space reads which depending upon the vendor implementation may cause
> the drive to exit the deepest NVMe state.
> 
> In these cases ASPM will typically resolve the PCIe link state and APST
> may resolve the NVMe power state.  However it has also been observed
> that this register access after quiesced will cause PC10 failure
> on some device combinations.
> 
> To resolve this, move the PCI state saving to before SetFeatures has been
> called.  This has been proven to resolve the issue across a 5000 sample
> test on previously failing disk/system combinations.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

This looks good. It clashes with something I posted yesterday, but
I'll rebase after this one.

Reviewed-by: Keith Busch <kbusch@kernel.org>
