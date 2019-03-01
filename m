Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81BE206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbfCARj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:39:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:23660 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbfCARj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:39:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 09:39:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,428,1544515200"; 
   d="scan'208";a="303633003"
Received: from spandruv-mobl3.jf.intel.com ([10.252.135.12])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2019 09:39:27 -0800
Message-ID: <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date:   Fri, 01 Mar 2019 09:39:27 -0800
In-Reply-To: <9956076.F4luUDm1Dq@aspire.rjw.lan>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is how I would fix the issue reported in BZ 200759 (see this
> patch series
> from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).
> 
> Patch [1/2] causes intel_pstate to update all policies if it gets a
> _PPC change
> notification and sees a global turbo disable/enable change.
> 
> Patch [2/2] makes it update cpuinfo.max_freq for all policies in
> those cases.
> 
> The patches here have not been tested yet, so testing would be much
> appreciated.
> 
> Of course, comments are welcome too!

This is the only platform, someone reported such issue.
Can we solve this by some udev rules and offline/online cpu 1-3 on
power source change?

There are examples of changing governors on power source change.
https://bbs.archlinux.org/viewtopic.php?id=207186

Here instead of changing governor just
echo 0 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 0 >
/sys/devices/system/cpu/cpu2/online
echo 1 >
/sys/devices/system/cpu/cpu2/online
echo 0 >
/sys/devices/system/cpu/cpu3/online
echo 1 >
/sys/devices/system/cpu/cpu3/online

Thanks,
Srinivas

> 
> Thanks,
> Rafael
> 

