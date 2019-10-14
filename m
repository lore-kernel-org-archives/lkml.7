Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D19C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCC020663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfJNJ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:57:37 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37502 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731132AbfJNJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:57:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Tf.EEyp_1571047045;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0Tf.EEyp_1571047045)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Oct 2019 17:57:31 +0800
Date:   Mon, 14 Oct 2019 17:57:25 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20191014095725.GA78693@aaronlu>
References: <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
 <20191010135436.GA67897@aaronlu>
 <CANaguZDCtmXpm_rpTkjsfPPBscHCwz4u1OHwUt3XztzgLJa_jA@mail.gmail.com>
 <20191011073338.GA125778@aaronlu>
 <CANaguZCkKQTmgye+9nQhzQqYBrsnCmcjA46TPmLwN60vvMQ_7w@mail.gmail.com>
 <20191011114851.GA8750@aaronlu>
 <CANaguZBgv5N2Spv-Ldio5Umn6qU7dC0Px66sL9s11W7SK3f4Hg@mail.gmail.com>
 <20191012035503.GA113034@aaronlu>
 <CANaguZBevMsQ_Zy1ozKn2Z5Uj6WBviC6UU+zpTQOVdDDLK6r2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZBevMsQ_Zy1ozKn2Z5Uj6WBviC6UU+zpTQOVdDDLK6r2w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 08:44:32AM -0400, Vineeth Remanan Pillai wrote:
> On Fri, Oct 11, 2019 at 11:55 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> 
> >
> > I don't think we need do the normalization afterwrads and it appears
> > we are on the same page regarding core wide vruntime.

Should be "we are not on the same page..."

[...]
> > The weird thing about my patch is, the min_vruntime is often increased,
> > it doesn't point to the smallest value as in a traditional cfs_rq. This
> > probabaly can be changed to follow the tradition, I don't quite remember
> > why I did this, will need to check this some time later.
> 
> Yeah, I noticed this. In my patch, I had already accounted for this and changed
> to min() instead of max() which is more logical that min_vruntime should be the
> minimum of both the run queue.

I now remembered why I used max().

Assume rq1 and rq2's min_vruntime are both at 2000 and the core wide
min_vruntime is also 2000. Also assume both runqueues are empty at the
moment. Then task t1 is queued to rq1 and runs for a long time while rq2
keeps empty. rq1's min_vruntime will be incremented all the time while
the core wide min_vruntime stays at 2000 if min() is used. Then when
another task gets queued to rq2, it will get really large unfair boost
by using a much smaller min_vruntime as its base.

To fix this, either max() is used as is done in my patch, or adjust
rq2's min_vruntime to be the same as rq1's on each
update_core_cfs_min_vruntime() when rq2 is found empty and then use
min() to get the core wide min_vruntime. Looks not worth the trouble to
use min().
