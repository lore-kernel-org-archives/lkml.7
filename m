Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE47206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbfIFNrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:47:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:59301 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393462AbfIFNq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:46:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 06:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="334895571"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2019 06:46:56 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i6EZj-0007Jg-Qq; Fri, 06 Sep 2019 16:46:55 +0300
Date:   Fri, 6 Sep 2019 16:46:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        darcari@redhat.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/power/x86/intel-speed-select: Display core
 count for bucket
Message-ID: <20190906134655.GU2680@smile.fi.intel.com>
References: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
 <20190905233748.6822-2-srinivas.pandruvada@linux.intel.com>
 <780a3faf-9e44-64f4-a354-bdee39af3af5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <780a3faf-9e44-64f4-a354-bdee39af3af5@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 05:39:54AM -0400, Prarit Bhargava wrote:
> On 9/5/19 7:37 PM, Srinivas Pandruvada wrote:
> > Read the bucket and core count relationship via MSR and display
> > when displaying turbo ratio limits.

> > +	ret = isst_send_msr_command(cpu, 0x1ae, 0, buckets_info);
> 
> ^^^ you can get rid of the magic number 0x1ae by doing (sorry for the cut-and-paste)
> 
> diff --git a/tools/power/x86/intel-speed-select/Makefile b/tools/power/x86/intel
> index 12c6939dca2a..087d802ad844 100644
> --- a/tools/power/x86/intel-speed-select/Makefile
> +++ b/tools/power/x86/intel-speed-select/Makefile
> @@ -15,6 +15,8 @@ endif
>  MAKEFLAGS += -r
> 
>  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

> +override CFLAGS += -I../../../include
> +override CFLAGS += -DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'

I guess it can be done in more neat way.

> As I've been looking at this code I have been wondering why didn't you just use
> the standard /dev/cpu/X/msr interface that other x86 power utilities (turbostat,
> x86_energy_perf_policy) use?  Implementing msr_read() is trivial (warning
> untested and uncompiled code)

Actually good point!

-- 
With Best Regards,
Andy Shevchenko


