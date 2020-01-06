Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7713AC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533E520731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgAFPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:52:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:43886 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgAFPwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:52:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 07:52:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="215235960"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2020 07:52:13 -0800
Date:   Mon, 6 Jan 2020 23:52:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>, ying.huang@intel.com
Subject: Re: [LKP] [cpuidle] 259231a045: will-it-scale.per_process_ops -12.6%
 regression
Message-ID: <20200106155212.GB10439@shbuild999.sh.intel.com>
References: <20190918021334.GL15734@shao2-debian>
 <20191231055923.GA70013@shbuild999.sh.intel.com>
 <20200103023117.GA1313@shbuild999.sh.intel.com>
 <20200103133614.GA6604@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103133614.GA6604@fuller.cnet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Fri, Jan 03, 2020 at 10:36:14AM -0300, Marcelo Tosatti wrote:
> Hi Feng,
> 
> > Anyway, I found commit 259231a04 lost one "break" when moving
> > the original code, thus the semantics is changed to the last
> > enabled state's target_residency instead of the first enabled
> > one's.
> > 
> > I don't know if it's intentional, and I guess no, so here 
> > is a fix patch, please review, thanks
> 
> Not intentional.
> 
> > But even with this patch, the regression is still not recovered.
> > 
> > - Feng
> 
> This has been fixed upstream already, should be on Rafael's GIT tree.

Glad to hear that.

> 
> > >From cddd6b409e18ce97a8d7b851db4400396f71d857 Mon Sep 17 00:00:00 2001
> > From: Feng Tang <feng.tang@intel.com>
> > Date: Thu, 2 Jan 2020 16:58:31 +0800
> > Subject: [PATCH] cpuidle: Add back the lost break in cpuidle_poll_time
> > 
> > Commit c4cbb8b649b5 move the poll time calculation into a
> > new function cpuidle_poll_time(), during which one "break"
> > get lost, and the semantic is changed from the last enabled
> > state's target_residency instead of the first enabled one's.
> > 
> > So add it back.
> > 
> > Fixes: c4cbb8b649b5 "cpuidle: add poll_limit_ns to cpuidle_device structure"
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > ---
> >  drivers/cpuidle/cpuidle.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> About the regression... if you only revert the 
> 
> drivers/cpuidle/poll_state.c
> 
> changes from 
> 
> 259231a045616c4101d023a8f4dcc8379af265a6
> 
> Is the performance regression gone?

Aha, I did tried a similar patch, which can NOT cure the regression.

(You can check if the below patch complies with your idea) 

Another thing I've tried is to move the "poll_limit_ns" to the end of
struct cpuidle_device which could reduce the regression from 12.6%
to about 7.5%

Thanks,
Feng

commit 18260c38f4a802592e1cb6e82eb71ddca7709def
Author: Feng Tang <feng.tang@intel.com>
Date:   Fri Jan 3 09:21:54 2020 +0800

    make the poll_time inline
    
    Signed-off-by: Feng Tang <feng.tang@intel.com>

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index c8fa5f4..e278d9e 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -22,7 +22,24 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 		unsigned int loop_count = 0;
 		u64 limit;
 
-		limit = cpuidle_poll_time(drv, dev);
+		
+		if (likely(dev->poll_limit_ns))
+			limit = dev->poll_limit_ns;
+		else {
+			int i;
+
+			limit = TICK_NSEC;
+			for (i = 1; i < drv->state_count; i++) {
+				if (drv->states[i].disabled || dev->states_usage[i].disable)
+					continue;
+
+				limit = (u64)drv->states[i].target_residency * NSEC_PER_USEC;
+				break;
+			}
+
+			dev->poll_limit_ns = limit;
+		}
+
 
 		while (!need_resched()) {
 			cpu_relax();





