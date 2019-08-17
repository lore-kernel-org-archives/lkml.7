Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A13C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 21:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D059F20578
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 21:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfHQVm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 17:42:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726372AbfHQVm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 17:42:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7HLgJQo070110;
        Sat, 17 Aug 2019 17:42:20 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ueagrykqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Aug 2019 17:42:20 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7HLdlMV021950;
        Sat, 17 Aug 2019 21:42:17 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2ue9760hdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Aug 2019 21:42:17 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7HLgHQ636438384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 21:42:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03038B2065;
        Sat, 17 Aug 2019 21:42:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6CAEB205F;
        Sat, 17 Aug 2019 21:42:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 17 Aug 2019 21:42:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BE05416C1700; Sat, 17 Aug 2019 14:42:17 -0700 (PDT)
Date:   Sat, 17 Aug 2019 14:42:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        rcu@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH -rcu/dev] Please squash: fixup! rcu/tree: Add basic
 support for kfree_rcu() batching
Message-ID: <20190817214217.GD28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190817042211.137149-1-joel@joelfernandes.org>
 <alpine.DEB.2.21.9999.1908162131490.18249@viisi.sifive.com>
 <20190817044308.GA139754@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817044308.GA139754@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-17_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908170237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 12:43:08AM -0400, Joel Fernandes wrote:
> On Fri, Aug 16, 2019 at 09:38:54PM -0700, Paul Walmsley wrote:
> > On Sat, 17 Aug 2019, Joel Fernandes (Google) wrote:
> > 
> > > xchg() on a bool is causing issues on riscv and arm32.
> > 
> > Indeed, it seems best not to use xchg() on any type that's not 32 bits 
> > long or that's not the CPU's native word size.  Probably we should update 
> > the documentation.
> 
> I would endorse any such documentation effort ;-)
> 
> > > Please squash this into the -rcu dev branch to resolve the issue.
> > > 
> > > Please squash this fix.

Done, please see below for updated version.

> > > Fixes: -rcu dev commit 3cbd3aa7d9c7bdf ("rcu/tree: Add basic support for kfree_rcu() batching")
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.9999.1908161931110.32497@viisi.sifive.com/T/#me9956f66cb611b95d26ae92700e1d901f46e8c59
> > Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

I added the link, thank you Paul!  If you meant the Reviewed-by to apply
to the entire kfree_rcu() patch, I will of course be very happy to apply
that as well.

> Thanks Paul! And nice to meet you again after many years ;-) Glad to see you
> working on riscv.

What Joel said!  ;-)

							Thanx, Paul
