Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AC6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E502146E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCNAZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 20:25:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbfCNAZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 20:25:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2E0J44V100934
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 20:25:07 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r7873a1jn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 20:25:06 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Mar 2019 00:25:06 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 00:25:02 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2E0P1aN20971656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 00:25:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FF30B2067;
        Thu, 14 Mar 2019 00:25:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D70FB2064;
        Thu, 14 Mar 2019 00:25:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 00:25:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 780E716C5F31; Wed, 13 Mar 2019 17:25:05 -0700 (PDT)
Date:   Wed, 13 Mar 2019 17:25:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nikos Tsironis <ntsironis@arrikto.com>, agk@redhat.com,
        dm-devel@redhat.com, mpatocka@redhat.com, iliastsi@arrikto.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind helpers
Reply-To: paulmck@linux.ibm.com
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com>
 <20190311181607.GA9388@infradead.org>
 <20190311221321.GP13351@linux.ibm.com>
 <20190311224333.GA16968@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311224333.GA16968@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031400-0072-0000-0000-0000040AA984
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010753; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173994; UDB=6.00613855; IPR=6.00954657;
 MB=3.00025969; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-14 00:25:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031400-0073-0000-0000-00004B7B01BD
Message-Id: <20190314002505.GD13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 06:43:33PM -0400, Mike Snitzer wrote:
> On Mon, Mar 11 2019 at  6:13pm -0400,
> Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> 
> > On Mon, Mar 11, 2019 at 11:16:08AM -0700, Christoph Hellwig wrote:
> > > On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
> > > > Hi Paul and Christoph,
> > > > 
> > > > You've added your Signed-off-by to include/linux/list_bl.h commits in
> > > > the past.  I'm not sure how this proposed patch should be handled.
> > > > 
> > > > These new hlist_bl_add_{before,behind} changes are a prereq for
> > > > dm-snapshot changes that Nikos has proposed, please see:
> > > > https://patchwork.kernel.org/patch/10739265/
> > > > 
> > > > Any assistance/review you, or others on LKML, might be able to provide
> > > > would be appreciated.
> > > 
> > > I just killed two helpers.  That being said assuming that we only
> > > rely on the next pointer for the lockless traversals the changes look
> > > fine to me, but the code might be beyond my paygrade..
> > 
> > First, apologies for being slow on this one.
> 
> No problem.
>  
> > Second, were the two helpers hlist_bl_add_{before,behind}()?  If so, I
> > guess there is not much point in me looking them over.  Though perhaps
> > I should be looking something else over?
> 
> No, think Christoph was referring to his commit 1879fd6a26571fd4e8e1f
> from 2011.
> 
> Anyway, I'd like you to look over this new proposed patch that
> introduces hlist_bl_add_{before,behind}(), please see:
> https://patchwork.kernel.org/patch/10835713/
> 
> If you're happy with the patch, and can provide your Reviewed-by or
> Acked-by, I'll then pick it up as a prereq for the broader dm-snapshot
> changes that Nikos has provided.

I replied to the version earlier in this email thread.  Looks close,
but a couple of questions.

							Thanx, Paul

