Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D621C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8A820820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDIWIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:08:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfDIWIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 18:08:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39M8mpW089425
        for <linux-kernel@vger.kernel.org>; Tue, 9 Apr 2019 18:08:50 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rs1abp24c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 18:08:50 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 9 Apr 2019 23:08:49 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Apr 2019 23:08:44 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x39M8hqT30015542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Apr 2019 22:08:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D03E2B20AC;
        Tue,  9 Apr 2019 22:08:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A184DB20AE;
        Tue,  9 Apr 2019 22:08:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Apr 2019 22:08:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 27A9916C1140; Tue,  9 Apr 2019 15:08:45 -0700 (PDT)
Date:   Tue, 9 Apr 2019 15:08:45 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 01/18] drivers core: Add I/O ASID allocator
Reply-To: paulmck@linux.ibm.com
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190409100049.GC9224@smile.fi.intel.com>
 <20190409100436.GA28683@infradead.org>
 <20190409103030.GK9224@smile.fi.intel.com>
 <20190409145308.GZ14111@linux.ibm.com>
 <20190409152130.GS9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409152130.GS9224@smile.fi.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040922-2213-0000-0000-000003741565
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010898; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01186769; UDB=6.00621583; IPR=6.00967529;
 MB=3.00026368; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-09 22:08:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040922-2214-0000-0000-00005DF6D20C
Message-Id: <20190409220845.GM14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 06:21:30PM +0300, Andriy Shevchenko wrote:
> On Tue, Apr 09, 2019 at 07:53:08AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 09, 2019 at 01:30:30PM +0300, Andriy Shevchenko wrote:
> > > On Tue, Apr 09, 2019 at 03:04:36AM -0700, Christoph Hellwig wrote:
> > > > On Tue, Apr 09, 2019 at 01:00:49PM +0300, Andriy Shevchenko wrote:
> > > > > I think it makes sense to add a helper macro to rcupdate.h
> > > > > (and we have several cases in kernel that can utilize it)
> > > > > 
> > > > > #define kfree_non_null_rcu(ptr, rcu_head)		\
> > > > > 	do {						\
> > > > > 		if (ptr)				\
> > > > > 			kfree_rcu(ptr, rcu_head);	\
> > > > > 	} while (0)
> > > > > 
> > > > > as a more common pattern for resource deallocators.
> > > > 
> > > > I think that should move straight into kfree_rcu.  
> > > 
> > > Possible. I didn't dare to offer this due to lack of knowledge how it's used in
> > > other places.
> > > 
> > > > In general
> > > > we expect *free* to deal with NULL pointers transparently, so we
> > > > should do so here as well.
> > > 
> > > Exactly my point, thanks.
> > 
> > As shown below?
> 
> Looks pretty much good to me, thanks!
> Reviewed-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thank you!

							Thanx, Paul

> > And now that you mention it, it is a bit surprising that no one has
> > complained before.  ;-)
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 23ad938244968e9d2a8001a1c52887c113b182f6
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Tue Apr 9 07:48:18 2019 -0700
> > 
> >     rcu: Make kfree_rcu() ignore NULL pointers
> >     
> >     This commit makes the kfree_rcu() macro's semantics be consistent
> >     with the likes of kfree() by adding a check for NULL pointers, so
> >     that kfree_rcu(NULL, ...) is a no-op.
> >     
> >     Reported-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
> >     Reported-by: Christoph Hellwig <hch@infradead.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 922bb6848813..c68649b9bcec 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -828,9 +828,13 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
> >   * The BUILD_BUG_ON check must not involve any function calls, hence the
> >   * checks are done in macros here.
> >   */
> > -#define kfree_rcu(ptr, rcu_head)					\
> > -	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
> > -
> > +#define kfree_rcu(ptr, rhf)						\
> > +do {									\
> > +	typeof (ptr) ___p = (ptr);					\
> > +									\
> > +	if (___p)							\
> > +		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> > +} while (0)
> >  
> >  /*
> >   * Place this after a lock-acquisition primitive to guarantee that
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

