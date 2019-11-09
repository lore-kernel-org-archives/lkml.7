Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819DC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D382196F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573298318;
	bh=3Hq1uBKmbxWSyUaunSKUQp7cR6TxylIJ4pSQvHWS7Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wv3Hgwkl9ybTv+OPA4WbLoBYP1TjsJpkSlScmNxmHqUXSdI+o+6WpmRv3Brk110Bm
	 HcBTSE+5M6qHN0yrxeM+u8fejXqDfnmYTcL/nrULhYkWBYt7mYvcH648wtbOHY7BCQ
	 3ao32r1ieSESHnzk2NJWPnShqapUUpMn/dBQOmw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfKILSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 06:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbfKILSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 06:18:37 -0500
Received: from localhost (unknown [122.167.114.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50EAD215EA;
        Sat,  9 Nov 2019 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573298316;
        bh=3Hq1uBKmbxWSyUaunSKUQp7cR6TxylIJ4pSQvHWS7Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmkzuavN3jwaaLLRT3+0E5FSZqUBd4lnAoT85QaQgJf9A4jVzwLkitGq6sruZTxm5
         0pJN/VBw++T0ED+sctbq7NZNXUkNgFhhfwts+gWVzXh6920GoXySLzM3nmtVcpnvp0
         YeLxeZjdfbz304lHhZyrXUp0/dLvPWoHpJHkaP64=
Date:   Sat, 9 Nov 2019 16:48:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 0/3] soundwire: use UniqueID only when relevant
Message-ID: <20191109111823.GD952516@vkoul-mobl>
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 18:48, Pierre-Louis Bossart wrote:
> The hardware UniqueID, typically enabled with pin-strapping, is
> required during enumeration to avoid conflicts between devices of the
> same type.
> 
> When there are no devices of the same type, using the UniqueID is
> overkill and results in a lot of probe errors due to mismatches
> between ACPI tables and hardware capabilities. For example it's not
> uncommon for BIOS vendors to copy/paste the same settings between
> platforms but the hardware pin-strapping is different. This is
> perfectly legit and permitted by MIPI specs.
> 
> With this patchset, the UniqueID is only used when multiple devices of
> the same type are detected. The loop to detect multiple identical
> devices is not super efficient but with typically fewer than 4 devices
> per link there's no real incentive to be smarter.
> 
> This change is only implemented for ACPI platforms, for DeviceTree
> there is no change.

I do not fully agree with the approach here but I do understand why this
was done and do not have a better alternative, so applied now

-- 
~Vinod
