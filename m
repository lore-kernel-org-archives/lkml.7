Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F22FC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B4D20679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfD1W2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 18:28:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbfD1W2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 18:28:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3SMJCSr058643
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 18:28:06 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s5dr5v1uj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 18:28:06 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 28 Apr 2019 23:28:06 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 28 Apr 2019 23:28:02 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3SMS1Ur31457436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Apr 2019 22:28:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1273B205F;
        Sun, 28 Apr 2019 22:28:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93DBAB2065;
        Sun, 28 Apr 2019 22:28:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.36])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 28 Apr 2019 22:28:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3FB1816C093C; Sun, 28 Apr 2019 15:28:01 -0700 (PDT)
Date:   Sun, 28 Apr 2019 15:28:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Add data-race detection
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1904221214370.1384-100000@iolanthe.rowland.org>
 <20190426144108.GA6235@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426144108.GA6235@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042822-2213-0000-0000-00000383940C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011013; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01195785; UDB=6.00627051; IPR=6.00976632;
 MB=3.00026638; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-28 22:28:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042822-2214-0000-0000-00005E372C84
Message-Id: <20190428222801.GL3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-28_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=747 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904280163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 04:41:08PM +0200, Andrea Parri wrote:
> On Mon, Apr 22, 2019 at 12:18:09PM -0400, Alan Stern wrote:
> > This patch adds data-race detection to the Linux-Kernel Memory Model.
> > As part of this effort, support is added for:
> > 
> > 	compiler barriers (the barrier() function), and
> > 
> > 	a new Preserved Program Order term: (addr ; [Plain] ; wmb)
> > 
> > Data races are marked with a special Flag warning in herd.  It is
> > not guaranteed that the model will provide accurate predictions when a
> > data race is present.
> > 
> > The patch does not include documentation for the data-race detection
> > facility.  The basic design has been explained in various emails, and
> > a separate documentation patch will be submitted later.
> > 
> > This work is based on an earlier formulation of data races for the
> > LKMM by Andrea Parri.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> For the entire series,
> 
> Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Applied and pushed, thank you both!

But I forgot to remove my old x86 adaption patch.  Next rebase!  ;-/

							Thanx, Paul

