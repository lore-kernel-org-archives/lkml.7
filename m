Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01BFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C3124C1B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfFDKHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:07:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:59677 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfFDKHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:07:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 03:07:50 -0700
X-ExtLoop1: 1
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2019 03:07:49 -0700
Date:   Tue, 4 Jun 2019 18:07:35 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        LKML <linux-kernel@vger.kernel.org>, "lkp@01.org" <lkp@01.org>,
        "David S. Miller" <davem@davemloft.net>, ying.huang@intel.com
Subject: Re: [LKP] [tcp] 8b27dae5a2: netperf.Throughput_Mbps -25.7% regression
Message-ID: <20190604100735.s2g3tc35ofybimek@shbuild888>
References: <20190403063436.GG20952@shao2-debian>
 <20190530103048.hfld4t4m37jsg4yo@shbuild888>
 <CANn89iL4TYBYVnRhzVAH8UXSptStnYkZ+Rq3swzsMWngRJmGCA@mail.gmail.com>
 <20190530152314.ise5ycz6sdwfygph@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530152314.ise5ycz6sdwfygph@shbuild888>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:23:14PM +0800, Feng Tang wrote:
> Hi Eric,
> 
> On Thu, May 30, 2019 at 05:21:40AM -0700, Eric Dumazet wrote:
> > On Thu, May 30, 2019 at 3:31 AM Feng Tang <feng.tang@intel.com> wrote:
> > >
> > > On Wed, Apr 03, 2019 at 02:34:36PM +0800, kernel test robot wrote:
> > > > Greeting,
> > > >
> > > > FYI, we noticed a -25.7% regression of netperf.Throughput_Mbps due to commit:
> > > >
> > > >
> > > > commit: 8b27dae5a2e89a61c46c6dbc76c040c0e6d0ed4c ("tcp: add one skb cache for rx")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > >
> > > Hi Eric,
> > >
> > > Could you help to check this? thanks,
> > >
> > 
> > Hmmm... patch is old and had some bugs that have been fixed.
> > 
> > What numbers do you have with more recent kernels ?
> 
> 
> I just run the test  with 5.2-rc2, and the regression is still there.

Hi Eric,

Any hint on this?

From the perf data, the spinlock contention has an obvious increase:

9.28            +7.6       16.91        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__free_pages_ok.___pskb_trim
18.55           +8.6       27.14        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill

And for commit 8b27dae5a2 ("tcp: add one skb cache for rx"), IIUC, it
is not a real cache like the "tx skb cache" patch, and kind of a
delayed freeing.

Thanks,
Feng

 
