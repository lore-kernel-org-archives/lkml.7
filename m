Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC958C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0D4206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfLLCoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:44:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:5564 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfLLCoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:44:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 18:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,304,1571727600"; 
   d="scan'208";a="225754041"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2019 18:44:31 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/vt-d bad RMRR workarounds
To:     Barret Rhoden <brho@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
References: <20191211194606.87940-1-brho@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <35f49464-0ce5-9998-12a0-624d9683ea18@linux.intel.com>
Date:   Thu, 12 Dec 2019 10:43:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211194606.87940-1-brho@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/12/19 3:46 AM, Barret Rhoden via iommu wrote:
> I can imagine a bunch of ways around this.
> 
> One option is to hook in a check for buggy RMRRs in intel-iommu.c.  If
> the base and end are 0, just ignore the entry.  That works for my
> specific buggy DMAR entry.  There might be other buggy entries out
> there.  The docs specify some requirements on the base and end (called
> limit) addresses.
> 
> Another option is to change the sanity check so that unmapped ranges are
> considered OK.  That would work for my case, but only because we're
> hiding the firmware bug: my DMAR has a bad RMRR that happens to fall into a
> reserved or non-existent range.  The downside here is that we'd
> presumably be setting up an IOMMU mapping for this bad RMRR.  But at
> least it's not pointing to any RAM we're using.  (That's actually what
> goes on in the current, non-kexec case for me.  Phys page 0 is marked
> RESERVED, and I have an RMRR that points to it.)  This option also would
> cover any buggy firmwares that use an actual RMRR that pointed to memory
> that was omitted from the e820 map.
> 
> A third option: whenever the RMRR sanity check fails, just ignore it and
> return 0.  Don't set up the rmrru.  Right now, we completely abort DMAR
> processing.  If there was an actual device that needed to poke this
> memory that failed the sanity check (meaning, not RESERVED, currently),
> then we're already in trouble; that device could clobber RAM, right?  If
> we're going to use the IOMMU, I'd rather the device be behind an IOMMU
> with*no*  mapping for the region, so it couldn't clobber whatever we
> happened to put in that location.
> 
> I actually think all three options are reasonable ideas independently of
> one another.  This patchset that does all three.  Please take at least
> one of them.  =)  (May require a slight revision if you don't take all
> of them).

The VT-d spec defines the BIOS considerations about RMRR in section 8.4:

"
BIOS must report the RMRR reported memory addresses as reserved (or as
EFI runtime) in the system memory map returned through methods such as
INT15, EFI GetMemoryMap etc.
"

So we should treat it as firmware bug if the RMRR range is not mapped as
RESERVED in the system memory map table.

As for how should the driver handle this case, ignoring buggy RMRR with
a warning message might be a possible choice.

Best regards,
baolu
