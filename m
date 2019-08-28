Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27AAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0232173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566951144;
	bh=P2kgqchgSxi0ulzMu/yHiEHw8JjR/SRHq8lspG7ih8M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yI0ijMZ0nxiCtRZZ4e2IJPPxUVMlCMjMcM3MGnhxHI/xdnQ+bTOA8DnlU1fmeNfp+
	 eItJNjiX1BIxFamDZunKnyuUaiW/rTF9PRMMKMk7i0ogtEFKiimn4DeJMqSdC+cGM4
	 DovG0/tVzdY6i/j4NO1gjU9rTK0q/qr9FT+U14rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfH1AMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:12:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbfH1AMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:12:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7S08IYq032288;
        Tue, 27 Aug 2019 20:11:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uncnfvdxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 20:11:49 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7S08t0P034595;
        Tue, 27 Aug 2019 20:11:49 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uncnfvdx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 20:11:49 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7S0Ao0g006619;
        Wed, 28 Aug 2019 00:11:48 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2unb3ssc23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 00:11:48 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7S0Blni7930552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 00:11:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 754A9B205F;
        Wed, 28 Aug 2019 00:11:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51F1DB2066;
        Wed, 28 Aug 2019 00:11:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.209.133])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 00:11:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F15FA16C17EA; Tue, 27 Aug 2019 17:11:46 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:11:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 0/2] RCU dyntick nesting counter cleanups
Message-ID: <20190828001146.GM26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d648893.1c69fb81.5e60a.fc6c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d648893.1c69fb81.5e60a.fc6c@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:33:52PM -0400, Joel Fernandes (Google) wrote:
> These patches clean up the usage of dynticks nesting counters simplifying the
> code, while preserving the usecases.
> 
> It is a much needed simplification, makes the code less confusing, and prevents
> future bugs such as those that arise from forgetting that the
> dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
> common situations.
> 
> Several nights of rcutorture testing with CONFIG_RCU_EQS_DEBUG on all RCU
> kernel configurations have survived without any splats.
> 
> Further testing is in progress, hence marked as RFC!

My intent was to review this today, but this ran afoul of recent 3.10
work that made for some "interesting" review comments.  Fortunately,
I realized my mistake before sending the email.  I then reviewed the
current 2019 RCU dyntick-idle code.

I am doing some (possibly redundant) rcutorture runs on them here, and
will take a fresh look tomorrow.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> Joel Fernandes (Google) (2):
> rcu/tree: Clean up dynticks counter usage
> rcu/tree: Remove dynticks_nmi_nesting counter
> 
> .../Data-Structures/Data-Structures.rst       | 31 ++----
> Documentation/RCU/stallwarn.txt               |  6 +-
> kernel/rcu/rcu.h                              |  4 -
> kernel/rcu/tree.c                             | 98 +++++++++----------
> kernel/rcu/tree.h                             |  4 +-
> kernel/rcu/tree_stall.h                       |  4 +-
> 6 files changed, 64 insertions(+), 83 deletions(-)
> 
> --
> 2.23.0.187.g17f5b7556c-goog
> 
