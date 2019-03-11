Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE16C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EF821738
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfCKWN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:13:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727138AbfCKWNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:13:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BM9SXQ030700
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 18:13:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r5ybbt59f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 18:13:23 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 11 Mar 2019 22:13:23 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 22:13:21 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BMDKSN23003236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 22:13:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 219CAB2089;
        Mon, 11 Mar 2019 22:13:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03FBEB2080;
        Mon, 11 Mar 2019 22:13:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 22:13:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EB40716C34A1; Mon, 11 Mar 2019 15:13:21 -0700 (PDT)
Date:   Mon, 11 Mar 2019 15:13:21 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>, agk@redhat.com,
        dm-devel@redhat.com, mpatocka@redhat.com, iliastsi@arrikto.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind helpers
Reply-To: paulmck@linux.ibm.com
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com>
 <20190311181607.GA9388@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311181607.GA9388@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031122-0052-0000-0000-000003993F59
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010741; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01172999; UDB=6.00613254; IPR=6.00953653;
 MB=3.00025936; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-11 22:13:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031122-0053-0000-0000-0000601F5CE7
Message-Id: <20190311221321.GP13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 11:16:08AM -0700, Christoph Hellwig wrote:
> On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
> > Hi Paul and Christoph,
> > 
> > You've added your Signed-off-by to include/linux/list_bl.h commits in
> > the past.  I'm not sure how this proposed patch should be handled.
> > 
> > These new hlist_bl_add_{before,behind} changes are a prereq for
> > dm-snapshot changes that Nikos has proposed, please see:
> > https://patchwork.kernel.org/patch/10739265/
> > 
> > Any assistance/review you, or others on LKML, might be able to provide
> > would be appreciated.
> 
> I just killed two helpers.  That being said assuming that we only
> rely on the next pointer for the lockless traversals the changes look
> fine to me, but the code might be beyond my paygrade..

First, apologies for being slow on this one.

Second, were the two helpers hlist_bl_add_{before,behind}()?  If so, I
guess there is not much point in me looking them over.  Though perhaps
I should be looking something else over?

							Thanx, Paul

