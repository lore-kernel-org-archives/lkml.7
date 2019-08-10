Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F17C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724BA217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfHJDjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 23:39:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726011AbfHJDjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 23:39:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7A3aYaC052078
        for <linux-kernel@vger.kernel.org>; Fri, 9 Aug 2019 23:39:04 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u9ee8wt7h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 23:39:04 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 10 Aug 2019 04:39:03 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 10 Aug 2019 04:38:58 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7A3cv2f8192338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Aug 2019 03:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A07B2064;
        Sat, 10 Aug 2019 03:38:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3529B205F;
        Sat, 10 Aug 2019 03:38:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 10 Aug 2019 03:38:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B4C1C16C9A73; Fri,  9 Aug 2019 20:38:57 -0700 (PDT)
Date:   Fri, 9 Aug 2019 20:38:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Reply-To: paulmck@linux.ibm.com
References: <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
 <20190809163346.GF28441@linux.ibm.com>
 <20190809202226.GC255533@google.com>
 <20190809202645.GD255533@google.com>
 <20190809212512.GF255533@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809212512.GF255533@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081003-0064-0000-0000-000004073C35
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011577; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244611; UDB=6.00656652; IPR=6.01026095;
 MB=3.00028115; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-10 03:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081003-0065-0000-0000-00003E9CF9E0
Message-Id: <20190810033857.GQ28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908100038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:25:12PM -0400, Joel Fernandes wrote:
> On Fri, Aug 09, 2019 at 04:26:45PM -0400, Joel Fernandes wrote:
> > On Fri, Aug 09, 2019 at 04:22:26PM -0400, Joel Fernandes wrote:
> > > On Fri, Aug 09, 2019 at 09:33:46AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Aug 09, 2019 at 11:39:24AM -0400, Joel Fernandes wrote:
> > > > > On Fri, Aug 09, 2019 at 08:16:19AM -0700, Paul E. McKenney wrote:
> > > > > > On Thu, Aug 08, 2019 at 07:30:14PM -0400, Joel Fernandes wrote:
> > > > > [snip]
> > > > > > > > But I could make it something like:
> > > > > > > > 1. Letting ->head grow if ->head_free busy
> > > > > > > > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > > > > > > > 
> > > > > > > > This would even improve performance, but will still risk going out of memory.
> > > > > > > 
> > > > > > > It seems I can indeed hit an out of memory condition once I changed it to
> > > > > > > "letting list grow" (diff is below which applies on top of this patch) while
> > > > > > > at the same time removing the schedule_timeout(2) and replacing it with
> > > > > > > cond_resched() in the rcuperf test.  I think the reason is the rcuperf test
> > > > > > > starves the worker threads that are executing in workqueue context after a
> > > > > > > grace period and those are unable to get enough CPU time to kfree things fast
> > > > > > > enough. But I am not fully sure about it and need to test/trace more to
> > > > > > > figure out why this is happening.
> > > > > > > 
> > > > > > > If I add back the schedule_uninterruptibe_timeout(2) call, the out of memory
> > > > > > > situation goes away.
> > > > > > > 
> > > > > > > Clearly we need to do more work on this patch.
> > > > > > > 
> > > > > > > In the regular kfree_rcu_no_batch() case, I don't hit this issue. I believe
> > > > > > > that since the kfree is happening in softirq context in the _no_batch() case,
> > > > > > > it fares better. The question then I guess is how do we run the rcu_work in a
> > > > > > > higher priority context so it is not starved and runs often enough. I'll
> > > > > > > trace more.
> > > > > > > 
> > > > > > > Perhaps I can also lower the priority of the rcuperf threads to give the
> > > > > > > worker thread some more room to run and see if anything changes. But I am not
> > > > > > > sure then if we're preparing the code for the real world with such
> > > > > > > modifications.
> > > > > > > 
> > > > > > > Any thoughts?
> > > > > > 
> > > > > > Several!  With luck, perhaps some are useful.  ;-)
> > > > > > 
> > > > > > o	Increase the memory via kvm.sh "--memory 1G" or more.  The
> > > > > > 	default is "--memory 500M".
> > > > > 
> > > > > Thanks, this definitely helped.
> > > 
> > > Also, I can go back to 500M if I just keep KFREE_DRAIN_JIFFIES at HZ/50. So I
> > > am quite happy about that. I think I can declare that the "let list grow
> > > indefinitely" design works quite well even with an insanely heavily loaded
> > > case of every CPU in a 16CPU system with 500M memory, indefinitely doing
> > > kfree_rcu()in a tight loop with appropriate cond_resched(). And I am like
> > > thinking - wow how does this stuff even work at such insane scales :-D
> > 
> > Oh, and I should probably also count whether there are any 'total number of
> > grace periods' reduction, due to the batching!
>  
> And, the number of grace periods did dramatically drop (by 5X) with the
> batching!! I have modified the rcuperf test to show the number of grace
> periods that elapsed during the test.

Very good!  Batching for the win!  ;-)

							Thanx, Paul

