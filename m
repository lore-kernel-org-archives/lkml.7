Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866DC0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DD6216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405175AbfHIAz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 20:55:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:56413 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbfHIAz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 20:55:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 17:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="258890899"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2019 17:55:26 -0700
Date:   Thu, 8 Aug 2019 17:44:39 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86/kernel/cpu/umwait.c - remove unused variable
Message-ID: <20190809004438.GA56628@romley-ivt3.sc.intel.com>
References: <79734.1565272329@turing-police>
 <alpine.DEB.2.21.1908082158580.2882@nanos.tec.linutronix.de>
 <141835.1565295884@turing-police>
 <alpine.DEB.2.21.1908082229010.2882@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1908082229010.2882@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:32:38PM +0200, Thomas Gleixner wrote:
> Valdis,
> 
> On Thu, 8 Aug 2019, Valdis Klētnieks wrote:
> > On Thu, 08 Aug 2019 22:04:03 +0200, Thomas Gleixner said: It isn't 
> > clear that whatever is doing the device_initcall()s will be able to 
> > do any reasonable recovery if we return an error, so any error 
> > recovery is going to have to happen before the function returns. It 
> > might make sense to do an 'if (ret) return;' before going further in 
> > the function, but given the comment a few lines further down about 
> > ignoring errors, it was apparently considered more important to 
> > struggle through and register stuff in sysfs even if umwait was 
> > broken....
> 
> I missed that when going through it.
> 
> The right thing to do is to have a cpu_offline callback which clears 
> the umwait MSR. That covers also the failure in the cpu hotplug setup. 
> Then handling an error return makes sense and keeps everything in a 
> workable shape.

When cpu is offline, the MSR won't be used. We don't need to clear it, right?

Thanks.

-Fenghua

