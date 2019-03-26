Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD053C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62622075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfCZPgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:36:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbfCZPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:36:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QFXvgV077516
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:36:52 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfp4t2gy4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:36:51 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 15:36:51 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 15:36:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QFakCp17235984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 15:36:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66FECB2071;
        Tue, 26 Mar 2019 15:36:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49C6CB2064;
        Tue, 26 Mar 2019 15:36:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 15:36:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CB18016C3238; Tue, 26 Mar 2019 08:36:46 -0700 (PDT)
Date:   Tue, 26 Mar 2019 08:36:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Reply-To: paulmck@linux.ibm.com
References: <155349021177.1111.15681654355431465791.stgit@noble.brown>
 <155349033961.1111.18247269615646768227.stgit@noble.brown>
 <20190326050320.gwk3tgtqwl5csivt@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326050320.gwk3tgtqwl5csivt@gondor.apana.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032615-0064-0000-0000-000003C04506
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010818; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179981; UDB=6.00617481; IPR=6.00960696;
 MB=3.00026164; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 15:36:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032615-0065-0000-0000-00003CD7D1CA
Message-Id: <20190326153646.GL4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 01:03:20PM +0800, Herbert Xu wrote:
> On Mon, Mar 25, 2019 at 04:05:39PM +1100, NeilBrown wrote:
> >
> > + * Sometimes we unlock a bucket by writing a new pointer there.  In that
> > + * case we don't need to unlock, but we do need to reset state such as
> > + * local_bh. For that we have rht_unlocked().  This doesn't include
> > + * the memory barrier that bit_spin_unlock() provides, but rcu_assign_pointer()
> > + * will have provided that.
> 
> Hmm, are you sure that's enough? IIRC rcu_assign_pointer only
> provides a write barrier compared to the more complete (but one-way)
> barrier that a spin-lock provides.

Not seeing the code, I have no opinion on the safety in this case,
but I did want to mention that rcu_assign_pointer() has been upgraded
to a release store, so that it orders all prior accesses from the
viewpoint of some other thread that just picked up the stored pointer
via rcu_dereference().

But you are quite right, rcu_assign_pointer() used to just do an
smp_wmb().  It is now new and improved!  ;-)

							Thanx, Paul

