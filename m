Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A818C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4B121726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfFZRuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:50:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbfFZRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:50:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QHgM3u022896;
        Wed, 26 Jun 2019 13:49:58 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tcb7jnq41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 13:49:58 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5QHdmme011574;
        Wed, 26 Jun 2019 17:49:57 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 2t9by70tak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 17:49:57 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5QHnvj354395304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 17:49:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28EBBB205F;
        Wed, 26 Jun 2019 17:49:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1621CB2065;
        Wed, 26 Jun 2019 17:49:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jun 2019 17:49:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6D20D16C2F90; Wed, 26 Jun 2019 10:49:58 -0700 (PDT)
Date:   Wed, 26 Jun 2019 10:49:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux@arm.linux.org.uk, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH arm] Use common outgoing-CPU-notification code
Message-ID: <20190626174958.GH26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190611192410.GA27930@linux.ibm.com>
 <20190617115809.GA3767@lakrids.cambridge.arm.com>
 <20190617130657.GL26519@linux.ibm.com>
 <20190626164159.GI20635@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626164159.GI20635@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 05:42:00PM +0100, Mark Rutland wrote:
> On Mon, Jun 17, 2019 at 06:06:57AM -0700, Paul E. McKenney wrote:
> > On Mon, Jun 17, 2019 at 12:58:19PM +0100, Mark Rutland wrote:
> > > On Tue, Jun 11, 2019 at 12:24:10PM -0700, Paul E. McKenney wrote:
> > > > This commit removes the open-coded CPU-offline notification with new
> > > > common code.  In particular, this change avoids calling scheduler code
> > > > using RCU from an offline CPU that RCU is ignoring.  This is a minimal
> > > > change.  A more intrusive change might invoke the cpu_check_up_prepare()
> > > > and cpu_set_state_online() functions at CPU-online time, which would
> > > > allow onlining throw an error if the CPU did not go offline properly.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > 
> > > FWIW:
> > > 
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > 
> > > On the assumption that Russell is ok with this, I think this should be
> > > dropped into the ARM patch system [1].
> > > 
> > > Paul, are you familiar with that, or would you prefer that someone else
> > > submits the patch there? I can do so if you'd like.
> > 
> > I never have used this system, so please do drop it in there!  Let me
> > know when you have done so, and I will then drop it from -rcu.
> 
> After testing that multi_v7_defconfig built, I've just submitted this as
> 8872/1:
> 
>   https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8872/1

Very good, thank you!  I will drop this from my -rcu tree.

							Thanx, Paul
