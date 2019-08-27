Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32B0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B339D2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566921790;
	bh=Wuon1Ne3AM4+fpOK6WFO/oTO3QLSdasSlXHYlRfeXWg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=NJy4umZzLwbuvxTgsd6mvfF2xY6+YGj/GB5guDC+Rg5dcdmi66AOWSkaZnWBvrka7
	 m7aUCUUM9BIKVDwfUCyJErZIvraW2YYLaoyYizyRP0VMXVFCHT3ea8ZmSQdUrzMFVR
	 VhMY79SgBvWWSR0hMeGgQuMFo8jNRt4bZa8tQ3zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfH0QDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:03:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbfH0QDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:03:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RFvY7b145430;
        Tue, 27 Aug 2019 12:02:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2un5cxyryn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 12:02:25 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7RFwG8t000842;
        Tue, 27 Aug 2019 12:02:24 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2un5cxyrxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 12:02:24 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7RFxZr0018609;
        Tue, 27 Aug 2019 16:02:23 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 2ujvv68jgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 16:02:23 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7RG2NDo52756750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 16:02:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AD0FB2064;
        Tue, 27 Aug 2019 16:02:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A39DB205F;
        Tue, 27 Aug 2019 16:02:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 16:02:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9D6E216C2A50; Tue, 27 Aug 2019 09:02:23 -0700 (PDT)
Date:   Tue, 27 Aug 2019 09:02:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Rename rcu_node_context_switch() to
 rcu_note_context_switch()
Message-ID: <20190827160223.GH26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190827093603.x2dist7q5e2z36c5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827093603.x2dist7q5e2z36c5@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:36:03AM +0200, Sebastian Andrzej Siewior wrote:
> While Paul was explaning some RCU magic I noticed a typo in
> rcu_note_context_switch().
> Replace rcu_node_context_switch() with rcu_note_context_switch().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Good eyes, queued for v5.5, thank you!

Sounds like I should explain RCU magic more often, then.  ;-)

							Thanx, Paul

> ---
>  .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html    | 2 +-
>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg         | 2 +-
>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> index c64f8d26609fb..54db02b74f636 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> @@ -481,7 +481,7 @@ section that the grace period must wait on.
>  </table>
>  
>  <p>If the CPU does a context switch, a quiescent state will be
> -noted by <tt>rcu_node_context_switch()</tt> on the left.
> +noted by <tt>rcu_note_context_switch()</tt> on the left.
>  On the other hand, if the CPU takes a scheduler-clock interrupt
>  while executing in usermode, a quiescent state will be noted by
>  <tt>rcu_sched_clock_irq()</tt> on the right.
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> index 2bcd742d6e491..069f6f8371c20 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> @@ -3880,7 +3880,7 @@
>           font-style="normal"
>           y="-4418.6582"
>           x="3745.7725"
> -         xml:space="preserve">rcu_node_context_switch()</text>
> +         xml:space="preserve">rcu_note_context_switch()</text>
>      </g>
>      <g
>         transform="translate(1881.1886,54048.57)"
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
> index 779c9ac31a527..7d6c5f7e505c6 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
> @@ -753,7 +753,7 @@
>           font-style="normal"
>           y="-4418.6582"
>           x="3745.7725"
> -         xml:space="preserve">rcu_node_context_switch()</text>
> +         xml:space="preserve">rcu_note_context_switch()</text>
>      </g>
>      <g
>         transform="translate(3131.2648,-585.6713)"
> -- 
> 2.23.0
> 
