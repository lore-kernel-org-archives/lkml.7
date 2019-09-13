Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CCAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CA42053B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfIMTx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:53:28 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:24118 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729670AbfIMTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:53:28 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DJkMKw002171;
        Fri, 13 Sep 2019 19:52:57 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2v0dbgwb29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 19:52:57 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 8389BD5;
        Fri, 13 Sep 2019 19:52:56 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 87B4639;
        Fri, 13 Sep 2019 19:52:55 +0000 (UTC)
Date:   Fri, 13 Sep 2019 13:52:55 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Message-ID: <20190913195255.GA20131@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com>
 <20190801211613.GB3578@hirez.programming.kicks-ass.net>
 <b4597324-6eb8-31fa-e911-63f3b704c974@amd.com>
 <alpine.DEB.2.21.1908012331550.1789@nanos.tec.linutronix.de>
 <20190801214813.GB2332@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1908012352390.1789@nanos.tec.linutronix.de>
 <925c3458-aeae-a44b-ddd5-40a1e173a307@amd.com>
 <20190802162015.GA2349@hirez.programming.kicks-ass.net>
 <20190802163328.GB2349@hirez.programming.kicks-ass.net>
 <20190808203324.GA21769@anatevka.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808203324.GA21769@anatevka.americas.hpqcorp.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_09:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:33:24PM -0600, Jerry Hoemann wrote:
> On Fri, Aug 02, 2019 at 06:33:28PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 02, 2019 at 06:20:15PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 02, 2019 at 02:33:41PM +0000, Lendacky, Thomas wrote:
> > 
> > > > Talking to the hardware folks, they say setting CR8 is a serializing
> > > > instruction and has to communicate out to the APIC, so it's better to
> > > > use CLI/STI.
> > > 
> > > Bah; the Intel SDM states: "MOV CR* instructions, except for MOV CR8,
> > > are serializing instructions", which had given me a little hope.
> > > 
> > > At the same time, all these chips still have the APIC TPR field too, so
> > > much like how the TSC DEADLINE MSR is a hidden APIC write, so too is CR8
> > > I suppose :-(
> > > 
> > > I'll still finish the patches I started, just to see what it would look
> > > like.
> > 
> > Another 'fun' issue I ran into while doing these patches; STI has a 1
> > instruction shadow, which we rely on, MOV CR8 does not. So things like:
> > 
> > native_safe_halt:
> > 	sti
> > 	hlt
> > 
> > turn into:
> > 
> > native_safe_halt:
> > 	cli
> > 	movl $0, %rax
> > 	movq %rax, %cr8
> > 	sti
> > 	hlt
> > 
> 
> Hi Peter,
> 
> What is our the next step here?
> 
> Are you still looking to make this change?
> 
> Do we want to pick up Tom Lendacky's patch on an interim basis while
> you're working on the bigger change?  (I can say we tested Tom's
> patch and it does address the issue we were seeing.)
> 
> Thanks
> 
> Jerry
> 

Hi Peter,

Have you gotten a chance to look into this more?

Thanks

Jerry


-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
