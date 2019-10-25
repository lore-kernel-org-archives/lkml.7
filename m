Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72CFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FFE2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbfJYBiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:38:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:11192 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389101AbfJYBiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:38:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 18:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; 
   d="scan'208";a="188774054"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2019 18:38:01 -0700
Date:   Fri, 25 Oct 2019 09:38:01 +0800
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
Message-ID: <20191025013801.GC42124@shbuild999.sh.intel.com>
References: <20191024053445.GB42124@shbuild999.sh.intel.com>
 <AE86BC94-F91E-454E-8A83-98918C93AD8F@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE86BC94-F91E-454E-8A83-98918C93AD8F@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 06:51:54PM +0800, Qian Cai wrote:
> 
> 
> > On Oct 24, 2019, at 1:34 AM, Feng Tang <feng.tang@intel.com> wrote:
> > 
> > One example is, there was a platform with limited DRAM, so it preset
> > some CMA memory for camera's big buffer allocation use, while it let 
> > these memory to be shared by others when camera was not used. And
> > after long time running, the cma region got fragmented and camera
> > app started to fail due to the buffer allocation failure. And during
> > debugging, we kept monitoring the buddy info for different migrate
> > types.
> 
> For CMA-specific debugging, why CMA debugfs is not enough?

We care about change flow of the numbers of different orders for cma
and other migrate types, sometimes I just use one simple cmd
	watch -d 'cat /proc/pagetypeinfo'
which shows direct and dynamic flows.

Thanks,
Feng


