Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B78C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906012186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCNWTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:19:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbfCNWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:19:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EMDdIX041621
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 18:19:02 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r7v5ks5dh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 18:19:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Mar 2019 22:19:01 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 22:18:58 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EMIv2d23855248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 22:18:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92B38B2064;
        Thu, 14 Mar 2019 22:18:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 759EAB205F;
        Thu, 14 Mar 2019 22:18:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 22:18:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8EE8716C33A8; Thu, 14 Mar 2019 15:19:43 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:19:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Barret Rhoden <brho@google.com>,
        Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eial Czerwacki <eial@scalemp.com>,
        linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
Reply-To: paulmck@linux.ibm.com
References: <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
 <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
 <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
 <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
 <20190313212255.GY13351@linux.ibm.com>
 <20190313212912.GK50184@devbig004.ftw2.facebook.com>
 <20190313231155.GC13351@linux.ibm.com>
 <20190314173619.GL50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314173619.GL50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031422-0052-0000-0000-0000039B54DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010759; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01174414; UDB=6.00614109; IPR=6.00955079;
 MB=3.00025981; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-14 22:19:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031422-0053-0000-0000-000060281CC7
Message-Id: <20190314221943.GQ4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 10:36:19AM -0700, Tejun Heo wrote:
> On Wed, Mar 13, 2019 at 04:11:55PM -0700, Paul E. McKenney wrote:
> > commit 34f67df09cc0c6bf082a7cfca435373caeeb8d82
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Wed Mar 13 16:06:22 2019 -0700
> > 
> >     srcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
> >     
> >     Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module
> >     requires that the size of the reserved region be increased, which is
> >     not something we want to be doing all that often.  Instead, loadable
> >     modules should define an srcu_struct and invoke init_srcu_struct()
> >     from their module_init function and cleanup_srcu_struct() from their
> >     module_exit function.  Note that modules using call_srcu() will also
> >     need to invoke srcu_barrier() from their module_exit function.
> >     
> >     This commit enforces this advice by refusing to define DEFINE_SRCU()
> >     and DEFINE_STATIC_SRCU() within loadable modules.
> >     
> >     Suggested-by: Barret Rhoden <brho@google.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> Looks-great-to-me-by: Tejun Heo <tj@kernel.org>

Applied.  ;-)

							Thanx, Paul

> Thanks. :)
> 
> -- 
> tejun
> 

