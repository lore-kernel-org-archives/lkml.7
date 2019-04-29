Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C56C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45822084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfD2PjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfD2PjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B784307EA86;
        Mon, 29 Apr 2019 15:39:20 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 229906F7E0;
        Mon, 29 Apr 2019 15:39:18 +0000 (UTC)
Date:   Mon, 29 Apr 2019 11:39:16 -0400
From:   Phil Auld <pauld@redhat.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190429153916.GB26806@pauld.bos.csb>
References: <20190427091716.GC99668@gmail.com>
 <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com>
 <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com>
 <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
 <20190428121721.GA121434@gmail.com>
 <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
 <20190429061422.GA20939@gmail.com>
 <24bca399-5370-c4b5-725f-979db06bfc29@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24bca399-5370-c4b5-725f-979db06bfc29@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Apr 2019 15:39:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 09:25:35PM +0800 Li, Aubrey wrote:
> On 2019/4/29 14:14, Ingo Molnar wrote:
> > 
> > * Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> > 
> >>> I suspect it's pretty low, below 1% for all rows?
> >>
> >> Hope my this mail box works for this...
> >>
> >> .-------------------------------------------------------------------------------------------------------------.
> >> |NA/AVX vanilla-SMT     [std% / sem%] | coresched-SMT   [std% / sem%]     +/- |  no-SMT [std% / sem%]    +/-  |
> >> |-------------------------------------------------------------------------------------------------------------|
> >> |  1/1        508.5     [ 0.2%/ 0.0%] |         504.7   [ 1.1%/ 0.1%]    -0.8%|   509.0 [ 0.2%/ 0.0%]    0.1% |
> >> |  2/2       1000.2     [ 1.4%/ 0.1%] |        1004.1   [ 1.6%/ 0.2%]     0.4%|   997.6 [ 1.2%/ 0.1%]   -0.3% |
> >> |  4/4       1912.1     [ 1.0%/ 0.1%] |        1904.2   [ 1.1%/ 0.1%]    -0.4%|  1914.9 [ 1.3%/ 0.1%]    0.1% |
> >> |  8/8       3753.5     [ 0.3%/ 0.0%] |        3748.2   [ 0.3%/ 0.0%]    -0.1%|  3751.3 [ 0.4%/ 0.0%]   -0.1% |
> >> | 16/16      7139.3     [ 2.4%/ 0.2%] |        7137.9   [ 1.8%/ 0.2%]    -0.0%|  7049.2 [ 2.4%/ 0.2%]   -1.3% |
> >> | 32/32     10899.0     [ 4.2%/ 0.4%] |       10780.3   [ 4.4%/ 0.4%]    -1.1%| 10339.2 [ 9.6%/ 0.9%]   -5.1% |
> >> | 64/64     15086.1     [11.5%/ 1.2%] |       14262.0   [ 8.2%/ 0.8%]    -5.5%| 11168.7 [22.2%/ 1.7%]  -26.0% |
> >> |128/128    15371.9     [22.0%/ 2.2%] |       14675.8   [14.4%/ 1.4%]    -4.5%| 10963.9 [18.5%/ 1.4%]  -28.7% |
> >> |256/256    15990.8     [22.0%/ 2.2%] |       12227.9   [10.3%/ 1.0%]   -23.5%| 10469.9 [19.6%/ 1.7%]  -34.5% |
> >> '-------------------------------------------------------------------------------------------------------------'
> > 
> > Perfectly presented, thank you very much!
> 
> My pleasure! ;-)
> 
> > 
> > My final questin would be about the environment:
> > 
> >> Skylake server, 2 numa nodes, 104 CPUs (HT on)
> > 
> > Is the typical nr_running value the sum of 'NA+AVX', i.e. is it ~256 
> > threads for the 128/128 row for example - or is it 128 parallel tasks?
> 
> That means 128 sysbench threads and 128 gemmbench tasks, so 256 threads in sum.
> > 
> > I.e. showing the approximate CPU thread-load figure column would be very 
> > useful too, where '50%' shows half-loaded, '100%' fully-loaded, '200%' 
> > over-saturated, etc. - for each row?
> 
> See below, hope this helps.
> .--------------------------------------------------------------------------------------------------------------------------------------.
> |NA/AVX vanilla-SMT     [std% / sem%]     cpu% |coresched-SMT   [std% / sem%]     +/-     cpu% |  no-SMT [std% / sem%]   +/-      cpu% |
> |--------------------------------------------------------------------------------------------------------------------------------------|
> |  1/1        508.5     [ 0.2%/ 0.0%]     2.1% |        504.7   [ 1.1%/ 0.1%]    -0.8%    2.1% |   509.0 [ 0.2%/ 0.0%]   0.1%     4.3% |
> |  2/2       1000.2     [ 1.4%/ 0.1%]     4.1% |       1004.1   [ 1.6%/ 0.2%]     0.4%    4.1% |   997.6 [ 1.2%/ 0.1%]  -0.3%     8.1% |
> |  4/4       1912.1     [ 1.0%/ 0.1%]     7.9% |       1904.2   [ 1.1%/ 0.1%]    -0.4%    7.9% |  1914.9 [ 1.3%/ 0.1%]   0.1%    15.1% |
> |  8/8       3753.5     [ 0.3%/ 0.0%]    14.9% |       3748.2   [ 0.3%/ 0.0%]    -0.1%   14.9% |  3751.3 [ 0.4%/ 0.0%]  -0.1%    30.5% |
> | 16/16      7139.3     [ 2.4%/ 0.2%]    30.3% |       7137.9   [ 1.8%/ 0.2%]    -0.0%   30.3% |  7049.2 [ 2.4%/ 0.2%]  -1.3%    60.4% |
> | 32/32     10899.0     [ 4.2%/ 0.4%]    60.3% |      10780.3   [ 4.4%/ 0.4%]    -1.1%   55.9% | 10339.2 [ 9.6%/ 0.9%]  -5.1%    97.7% |
> | 64/64     15086.1     [11.5%/ 1.2%]    97.7% |      14262.0   [ 8.2%/ 0.8%]    -5.5%   82.0% | 11168.7 [22.2%/ 1.7%] -26.0%   100.0% |
> |128/128    15371.9     [22.0%/ 2.2%]   100.0% |      14675.8   [14.4%/ 1.4%]    -4.5%   82.8% | 10963.9 [18.5%/ 1.4%] -28.7%   100.0% |
> |256/256    15990.8     [22.0%/ 2.2%]   100.0% |      12227.9   [10.3%/ 1.0%]   -23.5%   73.2% | 10469.9 [19.6%/ 1.7%] -34.5%   100.0% |
> '--------------------------------------------------------------------------------------------------------------------------------------'
> 

That's really nice and clear.

We start to see the penalty for the coresched at 32/32, leaving some cpus more idle than otherwise.  
But it's pretty good overall, for this benchmark at least.

Is this with stock v2 or with any of the fixes posted after? I wonder how much the fixes for
the race that violates the rule effects this, for example. 



Cheers,
Phil


> Thanks,
> -Aubrey

-- 
