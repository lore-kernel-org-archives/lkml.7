Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0403C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77A12173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbfHHUe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:34:56 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:53004 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729780AbfHHUe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:34:56 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78KQfvN011881;
        Thu, 8 Aug 2019 20:33:26 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2u8rx0rsxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 20:33:26 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 9B1C757;
        Thu,  8 Aug 2019 20:33:25 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 912AC4E;
        Thu,  8 Aug 2019 20:33:24 +0000 (UTC)
Date:   Thu, 8 Aug 2019 14:33:24 -0600
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
Message-ID: <20190808203324.GA21769@anatevka.americas.hpqcorp.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802163328.GB2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:33:28PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 06:20:15PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 02, 2019 at 02:33:41PM +0000, Lendacky, Thomas wrote:
> 
> > > Talking to the hardware folks, they say setting CR8 is a serializing
> > > instruction and has to communicate out to the APIC, so it's better to
> > > use CLI/STI.
> > 
> > Bah; the Intel SDM states: "MOV CR* instructions, except for MOV CR8,
> > are serializing instructions", which had given me a little hope.
> > 
> > At the same time, all these chips still have the APIC TPR field too, so
> > much like how the TSC DEADLINE MSR is a hidden APIC write, so too is CR8
> > I suppose :-(
> > 
> > I'll still finish the patches I started, just to see what it would look
> > like.
> 
> Another 'fun' issue I ran into while doing these patches; STI has a 1
> instruction shadow, which we rely on, MOV CR8 does not. So things like:
> 
> native_safe_halt:
> 	sti
> 	hlt
> 
> turn into:
> 
> native_safe_halt:
> 	cli
> 	movl $0, %rax
> 	movq %rax, %cr8
> 	sti
> 	hlt
> 

Hi Peter,

What is our the next step here?

Are you still looking to make this change?

Do we want to pick up Tom Lendacky's patch on an interim basis while
you're working on the bigger change?  (I can say we tested Tom's
patch and it does address the issue we were seeing.)

Thanks

Jerry

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
