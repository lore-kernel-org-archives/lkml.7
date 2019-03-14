Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CAAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FDA206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCNDJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:09:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbfCNDJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:09:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2E39FeQ111776
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:09:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r78u8dbmr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:09:30 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Thu, 14 Mar 2019 03:09:28 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 03:09:24 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2E39NKx26935382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 03:09:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE9FC4C04A;
        Thu, 14 Mar 2019 03:09:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C5E34C046;
        Thu, 14 Mar 2019 03:09:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 03:09:23 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 39986A00E2;
        Thu, 14 Mar 2019 14:09:22 +1100 (AEDT)
Subject: Re: [PATCH 1/1] arch/powerpc: Rework local_paca to avoid LTO
 warnings
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 14:09:22 +1100
In-Reply-To: <87ef7atjnk.fsf@dja-thinkpad.axtens.net>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
         <87ef7atjnk.fsf@dja-thinkpad.axtens.net>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031403-0008-0000-0000-000002CD0BE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031403-0009-0000-0000-000022390C35
Message-Id: <07a2633c1264db39d2ef91d6824c319f57027c26.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-14 at 10:54 +1100, Daniel Axtens wrote:
> "Alastair D'Silva" <alastair@au1.ibm.com> writes:
> 
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > When building an LTO kernel, the existing code generates warnings:
> >     ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
> >         ‘local_paca’ used for multiple global register variables
> >      register struct paca_struct *local_paca asm("r13");
> >                               ^
> >     ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
> >         ‘local_paca’
> > 
> > This patch reworks local_paca into an inline getter & setter
> > function,
> > which addresses the warning.
> > 
> > Generated ASM from this patch is broadly similar (addresses have
> > changed and the compiler uses different GPRs in some places).
> 
> Ditto to Christophe's comment; I'd love to know how to build this so
> I
> can actually see the differences. Perhaps you could bundle up all the
> required changes and send it as a patch series with a cover letter
> explaining this?

The differences are visible in a normal build, but if you want to play
with LTO, see my comments to Christophe.

> 
> > +static inline struct paca_struct *get_paca_no_preempt_check(void)
> > +{
> > +	register struct paca_struct *paca asm("r13");
> > +	return paca;
> > +}
> 
> Isn't the convention to have the { on the same line as the function,
> or
> am I horrible mis-remembering things?
> 
You are :)

> Should these functions be __always_inline?
> 

Yes, they should, I'll add that to V3.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

