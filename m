Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6CEC46460
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AAA2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfEAFkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 01:40:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726065AbfEAFkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 01:40:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x415RDVK136393
        for <linux-kernel@vger.kernel.org>; Wed, 1 May 2019 01:40:09 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s74khhx65-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 01:40:09 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 1 May 2019 06:40:07 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 06:40:03 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x415e23k61276382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 05:40:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6021D4C050;
        Wed,  1 May 2019 05:40:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 389484C058;
        Wed,  1 May 2019 05:40:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 May 2019 05:40:01 +0000 (GMT)
Date:   Wed, 1 May 2019 08:39:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [RFC PATCH 5/7] x86/mm/fault: hook up SCI verification
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-6-git-send-email-rppt@linux.ibm.com>
 <20190426074223.GY4038@hirez.programming.kicks-ass.net>
 <20190428054711.GD14896@rapoport-lnx>
 <CALCETrWrtRo1PqdVmJQQ95J8ORy9WBkUraJCqL6JNmmAkw=H0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWrtRo1PqdVmJQQ95J8ORy9WBkUraJCqL6JNmmAkw=H0w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19050105-0020-0000-0000-000003381EA9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050105-0021-0000-0000-0000218AA112
Message-Id: <20190501053958.GA3877@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=409 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 09:44:09AM -0700, Andy Lutomirski wrote:
> On Sat, Apr 27, 2019 at 10:47 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Fri, Apr 26, 2019 at 09:42:23AM +0200, Peter Zijlstra wrote:
> > > On Fri, Apr 26, 2019 at 12:45:52AM +0300, Mike Rapoport wrote:
> > > > If a system call runs in isolated context, it's accesses to kernel code and
> > > > data will be verified by SCI susbsytem.
> > > >
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > ---
> > > >  arch/x86/mm/fault.c | 28 ++++++++++++++++++++++++++++
> > > >  1 file changed, 28 insertions(+)
> > >
> > > There's a distinct lack of touching do_double_fault(). It appears to me
> > > that you'll instantly trigger #DF when you #PF, because the #PF handler
> > > itself will not be able to run.
> >
> > The #PF handler is able to run. On interrupt/error entry the cr3 is
> > switched to the full kernel page tables, pretty much like PTI does for
> > user <-> kernel transitions. It's in the patch 3.
> >
> >
> 
> PeterZ meant page_fault, not do_page_fault.  In your patch, page_fault
> and some of error_entry run before that magic switchover happens.  If
> they're not in the page tables, you double-fault.

The entry code is in sci page tables, just like in user-space page tables
with PTI.
 
> And don't even try to do SCI magic in the double-fault handler.  As I
> understand it, the SDM and APM aren't kidding when they say that #DF
> is an abort, not a fault.  There is a single case in the kernel where
> we recover from #DF, and it was vetted by microcode people.
> 

-- 
Sincerely yours,
Mike.

