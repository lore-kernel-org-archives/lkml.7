Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8945C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CE3206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556205956;
	bh=59I6dUdmKaNfnmPOyLiLVrGc1J4bM8FMIFPvAl3lNvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qd9/ELNnoGDw1AD92eYe67wu8FpScyMA6nAtuhs7iDOJNCqkFE5VVxNKXNK9YeaVp
	 N73UXhO5/dK/2TEB97SaoHbheVPx20xZOXL4Qnq8ormsQdCDnca0G2znq5L5j9oNMo
	 Lh7TPU4JUOKgDxvWC969WdDRmuC7IlWKuDqSW97E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfDYPZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:25:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:41694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727337AbfDYPZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:25:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F7B5AF26;
        Thu, 25 Apr 2019 15:25:52 +0000 (UTC)
Date:   Thu, 25 Apr 2019 17:25:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        rppt@linux.vnet.ibm.com, ard.biesheuvel@linaro.org,
        andrew.murray@arm.com, james.morse@arm.com, marc.zyngier@arm.com,
        sboyd@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: configurable sparsemem section size
Message-ID: <20190425152550.GY12751@dhcp22.suse.cz>
References: <20190423203843.2898-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423203843.2898-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-04-19 16:38:43, Pavel Tatashin wrote:
> sparsemem section size determines the maximum size and alignment that
> is allowed to offline/online memory block. The bigger the size the less
> the clutter in /sys/devices/system/memory/*. On the other hand, however,
> there is less flexability in what granules of memory can be added and
> removed.
> 
> Recently, it was enabled in Linux to hotadd persistent memory that
> can be either real NV device, or reserved from regular System RAM
> and has identity of devdax.
> 
> The problem is that because ARM64's section size is 1G, and devdax must
> have 2M label section, the first 1G is always missed when device is
> attached, because it is not 1G aligned.
> 
> Allow, better flexibility by making section size configurable.

Is there any inherent reason (64k page size?) that enforces such a large
memsection?
-- 
Michal Hocko
SUSE Labs
