Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE4218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555595677;
	bh=TCI8DWIVeimx2GuVy+tLCe2905j5in1mN4GG2jy7FIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sM5gjwnJC9C1J683pqvLsqUrm5DMBEGySpegeeeAGaMtOifVYvKuYvR13Ff/R8TmU
	 KJ7RWAzSOJJWX3cznvD6xsda8uJh2AHTV0F3Mn0dBWiXlXGz9MkYMmYhXOFQdhDOkY
	 RSvLklRWg+uQtC0puxPJnX9KNbDVNxTisv6y7bhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbfDRNyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:54:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:7158 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRNyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:54:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 06:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="317020806"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2019 06:54:34 -0700
Date:   Thu, 18 Apr 2019 07:48:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, axboe@fb.com
Subject: Re: [PATCH] nvme: determine the number of IO queues
Message-ID: <20190418134820.GA7589@localhost.localdomain>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 02:21:57PM +0800, Aaron Ma wrote:
> On 4/18/19 1:33 AM, Maxim Levitsky wrote:
> >>
> >> Maybe its better to add a quirk for the broken device, which needs this?
> 
> Adding quirk only makes the code more complicated.
> This patch doesn't change the default behavior.
> Only handle the NVME error code.

It does change the default behavior. If I have a degraded controller that
can't do IO in a machine with 1000's of CPUs, I have to iterate this
non-standard behavior 1000's of times before the drive is servicable
again. We currenlty figure that out in just a single try.

At least the quirks document *why* the driver is doing non-standard
behavior. We do the IO queue quirks for Macbooks, for example.

But why don't you file a bug report with the device vendor instead? Surely
a firmware fix provides the best possible outcome, and would make this
device work not only in all versions of Linux, but also every standard
compliant driver for any OS.
