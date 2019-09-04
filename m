Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DDDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190E92077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfIDDmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 23:42:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63556 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfIDDmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:42:37 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x843gJwc093123
        for <linux-kernel@vger.kernel.org>; Tue, 3 Sep 2019 23:42:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ut0m5xuk5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:42:35 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 4 Sep 2019 04:42:32 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 04:42:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x843gQv352560044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 03:42:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CBBE11C04A;
        Wed,  4 Sep 2019 03:42:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3824B11C050;
        Wed,  4 Sep 2019 03:42:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 03:42:26 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id F1B0EA0147;
        Wed,  4 Sep 2019 13:42:24 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Gabriel Paubert <paubert@iram.es>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
Date:   Wed, 04 Sep 2019 13:42:25 +1000
In-Reply-To: <20190903201121.GD3547@lt-gp.iram.es>
References: <20190903052407.16638-1-alastair@au1.ibm.com>
         <20190903052407.16638-4-alastair@au1.ibm.com>
         <20190903130430.GC31406@gate.crashing.org>
         <d268ee78-607e-5eb3-ed89-d5c07f672046@c-s.fr>
         <20190903160415.GA9749@gate.crashing.org>
         <321b003a-9633-5ff4-c4a2-59a47ec23421@c-s.fr>
         <20190903183157.GB9749@gate.crashing.org>
         <20190903201121.GD3547@lt-gp.iram.es>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090403-0008-0000-0000-00000310C0F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090403-0009-0000-0000-00004A2F14AF
Message-Id: <fcaeaf050acdf75f3c03c20e8ad8f996a2459a6b.camel@au1.ibm.com>
Subject: RE: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 22:11 +0200, Gabriel Paubert wrote:
> On Tue, Sep 03, 2019 at 01:31:57PM -0500, Segher Boessenkool wrote:
> > On Tue, Sep 03, 2019 at 07:05:19PM +0200, Christophe Leroy wrote:
> > > Le 03/09/2019 à 18:04, Segher Boessenkool a écrit :
> > > > (Why are they separate though?  It could just be one loop var).
> > > 
> > > Yes it could just be a single loop var, but in that case it would
> > > have 
> > > to be reset at the start of the second loop, which means we would
> > > have 
> > > to pass 'addr' for resetting the loop anyway,
> > 
> > Right, I noticed that after hitting send, as usual.
> > 
> > > so I opted to do it 
> > > outside the inline asm by using to separate loop vars set to
> > > their 
> > > starting value outside the inline asm.
> > 
> > The thing is, the way it is written now, it will get separate
> > registers
> > for each loop (with proper earlyclobbers added).  Not that that
> > really
> > matters of course, it just feels wrong :-)
> 
> After "mtmsr %3", it is always possible to copy %0 to %3 and use it
> as
> an address register for the second loop. One register less to
> allocate
> for the compiler. Constraints of course have to be adjusted.
> 
> 

Given that we're dealing with registers holding data that has been
named outside the assembler, this feels dirty. We'd be using the
register passed in as 'msr' to hold the address instead.

Since we're not short on registers, I don't see this as a good change.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

