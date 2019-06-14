Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E29BC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012D820B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFNBPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 21:15:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:15131 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfFNBPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 21:15:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 18:15:14 -0700
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2019 18:15:13 -0700
Date:   Thu, 13 Jun 2019 18:14:54 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v4 05/21] x86/hpet: Reserve timer for the HPET
 hardlockup detector
Message-ID: <20190614011454.GA6347@ranerica-svr.sc.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1558660583-28561-6-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1906112152430.2214@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906112152430.2214@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:54:25PM +0200, Thomas Gleixner wrote:
> On Thu, 23 May 2019, Ricardo Neri wrote:
> 
> > HPET timer 2 will be used to drive the HPET-based hardlockup detector.
> > Reserve such timer to ensure it cannot be used by user space programs or
> > for clock events.
> > 
> > When looking for MSI-capable timers for clock events, skip timer 2 if
> > the HPET hardlockup detector is selected.
> 
> Why? Both the changelog and the code change lack an explanation why this
> timer is actually touched after it got reserved for the platform. The
> reservation should make it inaccessible for other things.

hpet_reserve_platform_timers() will give the HPET char driver a data
structure which specifies which drivers are reserved. In this manner,
they cannot be used by applications via file opens. The timer used by
the hardlockup detector should be marked as reserved.

Also, hpet_msi_capability_lookup() populates another data structure
which is used when obtaining an unused timer for a HPET clock event.
The timer used by the hardlockup detector should not be included in such
data structure.

Is this the explanation you would like to see? If yes, I will include it
in the changelog.

Thanks and BR,
Ricardo

