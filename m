Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F372085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCRO0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:26:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727709AbfCRO0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:26:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2IEPoKh089038
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:26:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ractyrtbv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:26:29 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Mar 2019 14:26:28 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Mar 2019 14:26:24 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2IEQOns18219232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 14:26:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8F20B2065;
        Mon, 18 Mar 2019 14:26:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBA4FB2064;
        Mon, 18 Mar 2019 14:26:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Mar 2019 14:26:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 44E8216C340C; Mon, 18 Mar 2019 07:27:12 -0700 (PDT)
Date:   Mon, 18 Mar 2019 07:27:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Eial Czerwacki <eial@scalemp.com>
Cc:     Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>,
        Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Shai Fultheim <shai@scalemp.com>, Oren Twaig <oren@scalemp.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
Reply-To: paulmck@linux.ibm.com
References: <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
 <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
 <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
 <20190313212255.GY13351@linux.ibm.com>
 <20190313212912.GK50184@devbig004.ftw2.facebook.com>
 <20190313231155.GC13351@linux.ibm.com>
 <20190314173619.GL50184@devbig004.ftw2.facebook.com>
 <20190314221943.GQ4102@linux.ibm.com>
 <f44f1d5f-67b4-6ffd-80c1-28c48828f85b@scalemp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44f1d5f-67b4-6ffd-80c1-28c48828f85b@scalemp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031814-0060-0000-0000-0000031E11B4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010780; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176157; UDB=6.00615167; IPR=6.00956842;
 MB=3.00026032; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-18 14:26:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031814-0061-0000-0000-000048A60B3A
Message-Id: <20190318142712.GF4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903180107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:18:48AM +0200, Eial Czerwacki wrote:
> Greetings Paul,
> 
> On 3/15/19 12:19 AM, Paul E. McKenney wrote:
> > On Thu, Mar 14, 2019 at 10:36:19AM -0700, Tejun Heo wrote:
> >> On Wed, Mar 13, 2019 at 04:11:55PM -0700, Paul E. McKenney wrote:
> >>> commit 34f67df09cc0c6bf082a7cfca435373caeeb8d82
> >>> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> >>> Date:   Wed Mar 13 16:06:22 2019 -0700
> >>>
> >>>     srcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
> >>>     
> >>>     Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module
> >>>     requires that the size of the reserved region be increased, which is
> >>>     not something we want to be doing all that often.  Instead, loadable
> >>>     modules should define an srcu_struct and invoke init_srcu_struct()
> >>>     from their module_init function and cleanup_srcu_struct() from their
> >>>     module_exit function.  Note that modules using call_srcu() will also
> >>>     need to invoke srcu_barrier() from their module_exit function.
> >>>     
> >>>     This commit enforces this advice by refusing to define DEFINE_SRCU()
> >>>     and DEFINE_STATIC_SRCU() within loadable modules.
> >>>     
> >>>     Suggested-by: Barret Rhoden <brho@google.com>
> >>>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> >>
> >> Looks-great-to-me-by: Tejun Heo <tj@kernel.org>
> > 
> > Applied.  ;-)
> > 
> > 							Thanx, Paul
> > 
> >> Thanks. :)
> >>
> >> -- 
> >> tejun
> >>
> > 
> > 
> 
> when can this patch be found in the kernel mainline git repo? I'd like
> to test and see if the patch that started this mail thread still occurs.

Thank you for your interest!

It is a3f5f4fae725 ("srcu: Forbid DEFINE{,_STATIC}_SRCU() from modules")
in my -rcu tree.  If all goes well, I will submit it to the v5.2 merge
window.  I do not expect it to be submitted to -stable.

And -rcu is here:

	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

							Thanx, Paul

