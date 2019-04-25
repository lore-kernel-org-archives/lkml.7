Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E6C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14711206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfDYPbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:31:47 -0400
Received: from foss.arm.com ([217.140.101.70]:46574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDYPbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:31:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B20D4A78;
        Thu, 25 Apr 2019 08:31:45 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC243F557;
        Thu, 25 Apr 2019 08:31:40 -0700 (PDT)
Date:   Thu, 25 Apr 2019 16:31:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20190425153138.GC25193@fuggles.cambridge.arm.com>
References: <20190423203843.2898-1-pasha.tatashin@soleen.com>
 <20190425152550.GY12751@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425152550.GY12751@dhcp22.suse.cz>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 05:25:50PM +0200, Michal Hocko wrote:
> On Tue 23-04-19 16:38:43, Pavel Tatashin wrote:
> > sparsemem section size determines the maximum size and alignment that
> > is allowed to offline/online memory block. The bigger the size the less
> > the clutter in /sys/devices/system/memory/*. On the other hand, however,
> > there is less flexability in what granules of memory can be added and
> > removed.
> > 
> > Recently, it was enabled in Linux to hotadd persistent memory that
> > can be either real NV device, or reserved from regular System RAM
> > and has identity of devdax.
> > 
> > The problem is that because ARM64's section size is 1G, and devdax must
> > have 2M label section, the first 1G is always missed when device is
> > attached, because it is not 1G aligned.
> > 
> > Allow, better flexibility by making section size configurable.
> 
> Is there any inherent reason (64k page size?) that enforces such a large
> memsection?

I gave *vague* memories of running out of bits in the page flags if we
changed this, but that was a while back. If that's no longer the case,
then I'm open to changing the value, but I really don't want to expose
it as a Kconfig option as proposed in this patch. People won't have a
clue what to set and it doesn't help at all with the single-Image effort.

Will
