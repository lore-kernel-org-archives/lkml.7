Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81493C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55203216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557343319;
	bh=9Xg9FuSv22g3aFkK29+khcYqGtrIxPjQGIg9Y7LKCyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HnBU6aRBzAVUo9DCOuE1XZ7U181Dq39GsfyulDEf0gkuOnTKduVce690SGDrHiYPD
	 IjQtsxeuys4Y9EEjtk6+41broLdxd7aCt+V5PuFql7zCIxrqQFTNV/LdP1tGfnjcLF
	 Ne1LDJeoGITp3tgwDkD3p1MVqvlMHj9Z9rM38aCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfEHTV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:21:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:36234 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfEHTV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:21:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 12:21:57 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2019 12:21:57 -0700
Date:   Wed, 8 May 2019 13:16:24 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Message-ID: <20190508191624.GA8365@localhost.localdomain>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508185955.11406-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 02:59:55AM +0800, Kai-Heng Feng wrote:
> +static int nvme_do_resume_from_idle(struct pci_dev *pdev)
> +{
> +	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> +	int result;
> +
> +	pdev->dev_flags &= ~PCI_DEV_FLAGS_NO_D3;
> +	ndev->ctrl.suspend_to_idle = false;
> +
> +	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (result < 0)
> +		goto out;
> +
> +	result = nvme_pci_configure_admin_queue(ndev);
> +	if (result)
> +		goto out;
> +
> +	result = nvme_alloc_admin_tags(ndev);
> +	if (result)
> +		goto out;
> +
> +	ndev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
> +	ndev->ctrl.max_segments = NVME_MAX_SEGS;
> +	mutex_unlock(&ndev->shutdown_lock);

This lock was never locked.

But I think these special suspend/resume routines are too similar to the
existing ones, they should just incorporate this feature if we need to
do this.
