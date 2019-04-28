Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D728C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C902075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfD1GBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:01:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbfD1GBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:01:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3S5rndb098882
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 02:01:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s542139xj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 02:01:20 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 28 Apr 2019 07:01:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 28 Apr 2019 07:01:13 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3S61C0l46792854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Apr 2019 06:01:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C91BAAE058;
        Sun, 28 Apr 2019 06:01:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB35AE04D;
        Sun, 28 Apr 2019 06:01:11 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 28 Apr 2019 06:01:11 +0000 (GMT)
Date:   Sun, 28 Apr 2019 09:01:10 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [RFC PATCH 0/7] x86: introduce system calls addess space
 isolation
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <CALCETrWkYYh=L1nSO7GYt0FvMhjCcEaQiM2JEi3FfkJbYJFh2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWkYYh=L1nSO7GYt0FvMhjCcEaQiM2JEi3FfkJbYJFh2g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19042806-4275-0000-0000-0000032F15AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042806-4276-0000-0000-0000383E688E
Message-Id: <20190428060109.GE14896@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904280042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 05:30:13PM -0700, Andy Lutomirski wrote:
> On Thu, Apr 25, 2019 at 2:46 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > Hi,
> >
> > Address space isolation has been used to protect the kernel from the
> > userspace and userspace programs from each other since the invention of the
> > virtual memory.
> >
> > Assuming that kernel bugs and therefore vulnerabilities are inevitable it
> > might be worth isolating parts of the kernel to minimize damage that these
> > vulnerabilities can cause.
> >
> > The idea here is to allow an untrusted user access to a potentially
> > vulnerable kernel in such a way that any kernel vulnerability they find to
> > exploit is either prevented or the consequences confined to their isolated
> > address space such that the compromise attempt has minimal impact on other
> > tenants or the protected structures of the monolithic kernel.  Although we
> > hope to prevent many classes of attack, the first target we're looking at
> > is ROP gadget protection.
> >
> > These patches implement a "system call isolation (SCI)" mechanism that
> > allows running system calls in an isolated address space with reduced page
> > tables to prevent ROP attacks.
> >
> > ROP attacks involve corrupting the stack return address to repoint it to a
> > segment of code you know exists in the kernel that can be used to perform
> > the action you need to exploit the system.
> >
> > The idea behind the prevention is that if we fault in pages in the
> > execution path, we can compare target address against the kernel symbol
> > table.  So if we're in a function, we allow local jumps (and simply falling
> > of the end of a page) but if we're jumping to a new function it must be to
> > an external label in the symbol table.
> 
> That's quite an assumption.  The entry code at least uses .L labels.
> Do you get that right?
> 
> As far as I can see, most of what's going on here has very little to
> do with jumps and calls.  The benefit seems to come from making sure
> that the RET instruction actually goes somewhere that's already been
> faulted in.  Am I understanding right?

Well, RET indeed will go somewhere that's already been faulted in. But
before that, the first CALL to not-yet-mapped code will fault and bring in
the page containing the CALL target.

If the CALL is made into a middle of a function, SCI will refuse to
continue the syscall execution.

As for the local jumps, as long as they are inside a page that was already
mapped or the next page, they are allowed.

This does not take care (yet) of larger functions where local jumps are
further then PAGE_SIZE.

Here's an example trace of #PF's produced by a dummy get_answer system call
from patch 7:

[   12.012906] #PF: DATA: do_syscall_64+0x26b/0x4c0 fault at 0xffffffff82000bb8
[   12.012918] #PF: INSN: __x86_indirect_thunk_rax+0x0/0x20 fault at __x86_indirect_thunk_rax+0x0/0x20
[   12.012929] #PF: INSN: __x64_sys_get_answer+0x0/0x10 fault at __x64_sys_get_answer+0x0/0x10
 
> --Andy
> 

-- 
Sincerely yours,
Mike.

