Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8633BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635E021655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406923AbfJXFeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:34:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:52126 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404022AbfJXFet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:34:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 22:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,223,1569308400"; 
   d="scan'208";a="192074234"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga008.jf.intel.com with ESMTP; 23 Oct 2019 22:34:46 -0700
Date:   Thu, 24 Oct 2019 13:34:45 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191024053445.GB42124@shbuild999.sh.intel.com>
References: <20191024033313.GA42124@shbuild999.sh.intel.com>
 <15BA6C88-21C1-4BF3-BB10-2A207AEBB401@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15BA6C88-21C1-4BF3-BB10-2A207AEBB401@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:34:41PM +0800, Qian Cai wrote:
> 
> 
> > On Oct 23, 2019, at 11:33 PM, Feng Tang <feng.tang@intel.com> wrote:
> > 
> > We have been using the /proc/pagetypeinfo for debugging, mainly for
> > client platforms like phones/tablets. We met problems like very slow
> > system response or OOM things, and many of them could be related with
> > memory pressure or fragmentation issues, where monitoring /proc/pagetypeinfo
> > will be very useful for debugging.
> 
> This description of use case is rather vague. Which part of the information in that file is critical to debug an OOM or slow system that is not readily available in places like /proc/zoneinfo, /proc/buddyinfo, sysrq-m, or OOM trace etc?

One example is, there was a platform with limited DRAM, so it preset
some CMA memory for camera's big buffer allocation use, while it let 
these memory to be shared by others when camera was not used. And
after long time running, the cma region got fragmented and camera
app started to fail due to the buffer allocation failure. And during
debugging, we kept monitoring the buddy info for different migrate
types.

Thanks,
Feng
