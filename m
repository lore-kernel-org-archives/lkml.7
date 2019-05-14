Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75709C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FA72085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfENKTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:19:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbfENKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:19:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EACiIV090130
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:19:04 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sfu50sm4b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:19:04 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 14 May 2019 11:19:03 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 11:19:01 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EAIxJd45744180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 10:19:00 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C25ECC6055;
        Tue, 14 May 2019 10:18:59 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DCF9C6057;
        Tue, 14 May 2019 10:18:59 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.248])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 10:18:59 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id F2A642E3373; Tue, 14 May 2019 15:48:56 +0530 (IST)
Date:   Tue, 14 May 2019 15:48:56 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] powerpc/pseries: Fix cpu_hotplug_lock acquisition
 in resize_hpt
Reply-To: ego@linux.vnet.ibm.com
References: <1557480294-808-1-git-send-email-ego@linux.vnet.ibm.com>
 <874l5xtt6v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l5xtt6v.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19051410-0004-0000-0000-0000150E3C19
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011096; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203141; UDB=6.00631506; IPR=6.00984063;
 MB=3.00026879; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-14 10:19:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051410-0005-0000-0000-00008BA75E7A
Message-Id: <20190514101856.GH31206@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 05:02:16PM +1000, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > Subject: Re: [RESEND PATCH] powerpc/pseries: Fix cpu_hotplug_lock acquisition in resize_hpt
> 
> ps. A "RESEND" implies the patch is unchanged and you're just resending
> it because it was ignored.
> 
> In this case it should have just been "PATCH v2", with a note below the "---"
> saying "v2: Rebased onto powerpc/next ..."

Ok. I will send a v3 :-)

> 
> cheers
> 
> > During a memory hotplug operations involving resizing of the HPT, we
> > invoke a stop_machine() to perform the resizing. In this code path, we
> > end up recursively taking the cpu_hotplug_lock, first in
> > memory_hotplug_begin() and then subsequently in stop_machine(). This
> > causes the system to hang. With lockdep enabled we get the following
> > error message before the hang.
> >
> >   swapper/0/1 is trying to acquire lock:
> >   (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: stop_machine+0x2c/0x60
> >
> >   but task is already holding lock:
> >   (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: mem_hotplug_begin+0x20/0x50
> >
> >   other info that might help us debug this:
> >    Possible unsafe locking scenario:
> >
> >          CPU0
> >          ----
> >     lock(cpu_hotplug_lock.rw_sem);
> >     lock(cpu_hotplug_lock.rw_sem);
> >
> >    *** DEADLOCK ***
> >
> > Fix this issue by
> >   1) Requiring all the calls to pseries_lpar_resize_hpt() be made
> >      with cpu_hotplug_lock held.
> >
> >   2) In pseries_lpar_resize_hpt() invoke stop_machine_cpuslocked()
> >      as a consequence of 1)
> >
> >   3) To satisfy 1), in hpt_order_set(), call mmu_hash_ops.resize_hpt()
> >      with cpu_hotplug_lock held.
> >
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >
> > Rebased this one against powerpc/next instead of linux/master.
> >
> >  arch/powerpc/mm/book3s64/hash_utils.c | 9 ++++++++-
> >  arch/powerpc/platforms/pseries/lpar.c | 8 ++++++--
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> > index 919a861..d07fcafd 100644
> > --- a/arch/powerpc/mm/book3s64/hash_utils.c
> > +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/libfdt.h>
> >  #include <linux/pkeys.h>
> >  #include <linux/hugetlb.h>
> > +#include <linux/cpu.h>
> >  
> >  #include <asm/debugfs.h>
> >  #include <asm/processor.h>
> > @@ -1928,10 +1929,16 @@ static int hpt_order_get(void *data, u64 *val)
> >  
> >  static int hpt_order_set(void *data, u64 val)
> >  {
> > +	int ret;
> > +
> >  	if (!mmu_hash_ops.resize_hpt)
> >  		return -ENODEV;
> >  
> > -	return mmu_hash_ops.resize_hpt(val);
> > +	cpus_read_lock();
> > +	ret = mmu_hash_ops.resize_hpt(val);
> > +	cpus_read_unlock();
> > +
> > +	return ret;
> >  }
> >  
> >  DEFINE_DEBUGFS_ATTRIBUTE(fops_hpt_order, hpt_order_get, hpt_order_set, "%llu\n");
> > diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> > index 1034ef1..2fc9756 100644
> > --- a/arch/powerpc/platforms/pseries/lpar.c
> > +++ b/arch/powerpc/platforms/pseries/lpar.c
> > @@ -859,7 +859,10 @@ static int pseries_lpar_resize_hpt_commit(void *data)
> >  	return 0;
> >  }
> >  
> > -/* Must be called in user context */
> > +/*
> > + * Must be called in user context. The caller should hold the
> > + * cpus_lock.
> > + */
> >  static int pseries_lpar_resize_hpt(unsigned long shift)
> >  {
> >  	struct hpt_resize_state state = {
> > @@ -913,7 +916,8 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
> >  
> >  	t1 = ktime_get();
> >  
> > -	rc = stop_machine(pseries_lpar_resize_hpt_commit, &state, NULL);
> > +	rc = stop_machine_cpuslocked(pseries_lpar_resize_hpt_commit,
> > +				     &state, NULL);
> >  
> >  	t2 = ktime_get();
> >  
> > -- 
> > 1.9.4
> 

