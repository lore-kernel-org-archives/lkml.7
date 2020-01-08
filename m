Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A5CC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AD6206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgAHVb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:31:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:38087 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHVb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:31:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 13:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="395875074"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2020 13:31:56 -0800
Date:   Wed, 8 Jan 2020 13:42:51 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [bug report] resctrl high memory comsumption
Message-ID: <20200108214250.GB40461@romley-ivt3.sc.intel.com>
References: <CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com>
 <20200108202311.GA40461@romley-ivt3.sc.intel.com>
 <bbc27400-68d9-13fd-7402-d158a6754122@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc27400-68d9-13fd-7402-d158a6754122@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 12:42:17PM -0800, Reinette Chatre wrote:
> Hi Fenghua,
> On 1/8/2020 12:23 PM, Fenghua Yu wrote:
> > On Wed, Jan 08, 2020 at 09:07:41AM -0800, Shakeel Butt wrote:
> >> Recently we had a bug in the system software writing the same pids to
> >> the tasks file of resctrl group multiple times. The resctrl code
> > Subject: [RFC PATCH] x86/resctrl: Fix redundant task movements
> I think your fix would address this specific use case but a slightly
> different use case will still encounter the problem of high memory
> consumption. If for example, sleeping tasks are moved (many times)
> between resource or monitoring groups then their task_works queue would
> just keep growing. It seems that a call to task_work_cancel() before
> adding a new work item should address all these cases?

The checking code in this patch is also helpful to avoid redundant
task move preparation (kzalloc(), task_work_add(), etc) in the same
rdtgroup.

How about adding both the checking code and task_work_cancel()?

Thanks.

-Fenghua
