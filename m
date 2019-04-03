Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F83DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B102E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ys0DR8XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDCQBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:01:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45938 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:01:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33Fs8Jg091591;
        Wed, 3 Apr 2019 15:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=m9/fVJl/h3Kd1KuK3z0lqXqKJeT7piCvZPAM9eU/c/8=;
 b=ys0DR8XZC0YAZvbuOkLQlwFLkYZiTCmf0p3sfDetash2oLWhcI/DR3BxXKfHBR8Nm//3
 tVFHQYx5jsLJT5Yyk+6QFKFYjUp6ogGxcSsGTFJ5pY19qW8pvvoWEpWXpEpx8Mq/vkgP
 wpiG5deCHbow6vkO4Ytxbzyp9tWUSxi+n0wkHkUGwv7CXLYfsyzFZR90Bc40Se8dbDff
 JqPcJ9GgzILz+SDLyYA4kxm8v6nt4e70O+4uIeaoBwmGEIwgzuLi2i8dATpEhIujJdni
 A59HJPonxahfIIwDj4rfR7muFqgtraJ11X0zNM8dWl4yD6MOnLR9rZDE0PU2bfoqDJFI tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rhwyda5fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 15:58:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33Fw9pX179888;
        Wed, 3 Apr 2019 15:58:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2rm8f56372-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 15:58:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x33FwDYU029010;
        Wed, 3 Apr 2019 15:58:13 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 08:58:13 -0700
Date:   Wed, 3 Apr 2019 11:58:39 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alan Tull <atull@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Moritz Fischer <mdf@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190403155839.m447czluxd74n5ad@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030108
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:04:24PM -0700, Andrew Morton wrote:
> On Tue,  2 Apr 2019 16:41:53 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> >  static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
> >  {
> >  	long ret = 0;
> > +	s64 locked_vm;
> >  
> >  	if (!current || !current->mm)
> >  		return ret; /* process exited */
> >  
> >  	down_write(&current->mm->mmap_sem);
> >  
> > +	locked_vm = atomic64_read(&current->mm->locked_vm);
> >  	if (inc) {
> >  		unsigned long locked, lock_limit;
> >  
> > -		locked = current->mm->locked_vm + stt_pages;
> > +		locked = locked_vm + stt_pages;
> >  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> >  			ret = -ENOMEM;
> >  		else
> > -			current->mm->locked_vm += stt_pages;
> > +			atomic64_add(stt_pages, &current->mm->locked_vm);
> >  	} else {
> > -		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
> > -			stt_pages = current->mm->locked_vm;
> > +		if (WARN_ON_ONCE(stt_pages > locked_vm))
> > +			stt_pages = locked_vm;
> >  
> > -		current->mm->locked_vm -= stt_pages;
> > +		atomic64_sub(stt_pages, &current->mm->locked_vm);
> >  	}
> 
> With the current code, current->mm->locked_vm cannot go negative. 
> After the patch, it can go negative.  If someone else decreased
> current->mm->locked_vm between this function's atomic64_read() and
> atomic64_sub().
> 
> I guess this is a can't-happen in this case because the racing code
> which performed the modification would have taken it negative anyway.
> 
> But this all makes me rather queazy.

mmap_sem is still held in this patch, so updates to locked_vm are still
serialized and I don't think what you describe can happen.  A later patch
removes mmap_sem, of course, but it also rewrites the code to do something
different.  This first patch is just a mechanical type change from unsigned
long to atomic64_t.

So...does this alleviate your symptoms?

> Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
> thinking that the benefit of removing a few mmap_sem-takings from a few
> obscure drivers (sorry ;)) is pretty small.

Not sure about the other drivers, but vfio type1 isn't obscure.  We use it
extensively in our cloud, and from Andrea's __GFP_THISNODE thread a few months
back it seems Red Hat also uses it:

  https://lore.kernel.org/linux-mm/20180820032204.9591-3-aarcange@redhat.com/

> Also, the argument for switching 32-bit arches to a 64-bit counter was
> suspiciously vague.  What overflow issues?  Or are we just being lazy?

If user-controlled values are used to increase locked_vm, multiple threads
doing it at once on a 32-bit system could theoretically cause overflow, so in
the absence of atomic overflow checking, the 64-bit counter on 32b is defensive
programming.

I wouldn't have thought to do it, but Jason Gunthorpe raised the same issue in
the pinned_vm series:

  https://lore.kernel.org/linux-mm/20190115205311.GD22031@mellanox.com/

I'm fine with changing it to atomic_long_t if the scenario is too theoretical
for people.


Anyway, thanks for looking at this.
