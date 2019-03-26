Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E87E206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfCZAiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:38:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:50923 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfCZAiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:38:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 17:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="137240692"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 25 Mar 2019 17:38:04 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1BB0D301C16; Mon, 25 Mar 2019 17:38:04 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:38:04 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org
Subject: Re: [RESEND PATCH v6 04/12] x86/fsgsbase/64: Enable FSGSBASE
 instructions in the helper functions
Message-ID: <20190326003804.GK18020@tassilo.jf.intel.com>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
 <1552680405-5265-5-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1903251107300.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903251107300.1798@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    So on user space to kernel space transitions swapping in kernel GS should
>    simply do:
>      userGS = RDGSBASE()
>      WRGSBASE(kernelGS)

This would also need to find kernelGS first, by doing RDPID and then
reading it  from memory in the right index
(which might be a full cache miss if you're unlucky)

SWAPGS will be a lot faster, especially in these rare worst cases
because it has all its state inside the CPU.

-Andi

BTW you managed to only review after Chang went on a long vacation.

<rant>
I don't understand why it takes that long to review these changes
It's one of the largest performance improvements for the context
switch and the NMI in many years plus gives a new free register
to user space, but it only makes progress at a glacial pace.
The original patches for this were posted in 2016.
</rant>

