Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F74C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA172088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556206921;
	bh=D2Iuvsrp3bx79rGa/wq+w7GHIBzLICFaDzZw9rIKylI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WtOCoVE/K1o5hUS11xOBslmnRkBhrV6RgjU3c+6NBpXpktJyxB10hMo4i0m5uPhiB
	 hWIrk3WKSVT0v0hMDyhKRNquSxNSxdGwZ0KNljWDuc2/bgu3eaiLDKmjNtQRcXDwmp
	 +055BEYlOz7TeOqRbNoUAIeJKTXCWBUZOl1BJldE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfDYPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:41:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:45256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbfDYPl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:41:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7F89AFED;
        Thu, 25 Apr 2019 15:41:57 +0000 (UTC)
Date:   Thu, 25 Apr 2019 17:41:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        catalin.marinas@arm.com, rppt@linux.vnet.ibm.com,
        ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: configurable sparsemem section size
Message-ID: <20190425154156.GZ12751@dhcp22.suse.cz>
References: <20190423203843.2898-1-pasha.tatashin@soleen.com>
 <20190425152550.GY12751@dhcp22.suse.cz>
 <20190425153138.GC25193@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425153138.GC25193@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 16:31:38, Will Deacon wrote:
> On Thu, Apr 25, 2019 at 05:25:50PM +0200, Michal Hocko wrote:
> > On Tue 23-04-19 16:38:43, Pavel Tatashin wrote:
> > > sparsemem section size determines the maximum size and alignment that
> > > is allowed to offline/online memory block. The bigger the size the less
> > > the clutter in /sys/devices/system/memory/*. On the other hand, however,
> > > there is less flexability in what granules of memory can be added and
> > > removed.
> > > 
> > > Recently, it was enabled in Linux to hotadd persistent memory that
> > > can be either real NV device, or reserved from regular System RAM
> > > and has identity of devdax.
> > > 
> > > The problem is that because ARM64's section size is 1G, and devdax must
> > > have 2M label section, the first 1G is always missed when device is
> > > attached, because it is not 1G aligned.
> > > 
> > > Allow, better flexibility by making section size configurable.
> > 
> > Is there any inherent reason (64k page size?) that enforces such a large
> > memsection?
> 
> I gave *vague* memories of running out of bits in the page flags if we
> changed this, but that was a while back. If that's no longer the case,
> then I'm open to changing the value, but I really don't want to expose
> it as a Kconfig option as proposed in this patch. People won't have a
> clue what to set and it doesn't help at all with the single-Image effort.

Ohh, I absolutely agree about the config option part JFTR. 1GB section
loos quite excessive. I am not really sure a standard arm64 memory
layout looks though.
-- 
Michal Hocko
SUSE Labs
