Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42DC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFEB206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfD1GJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:09:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbfD1GJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:09:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3S69aVC109215
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 02:09:38 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s54mrtqrd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 02:09:37 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 28 Apr 2019 07:08:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 28 Apr 2019 07:08:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3S68UHQ51380324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Apr 2019 06:08:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A195AE053;
        Sun, 28 Apr 2019 06:08:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3BBDAE045;
        Sun, 28 Apr 2019 06:08:28 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 28 Apr 2019 06:08:28 +0000 (GMT)
Date:   Sun, 28 Apr 2019 09:08:27 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 0/7] x86: introduce system calls addess space
 isolation
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1c12e195-1286-0136-eae5-4b392d9fe4c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c12e195-1286-0136-eae5-4b392d9fe4c0@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19042806-0012-0000-0000-000003160643
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042806-0013-0000-0000-0000214E67F8
Message-Id: <20190428060826.GF14896@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=676 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904280044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 07:41:09AM -0700, Dave Hansen wrote:
> On 4/25/19 2:45 PM, Mike Rapoport wrote:
> > The idea behind the prevention is that if we fault in pages in the
> > execution path, we can compare target address against the kernel symbol
> > table.  So if we're in a function, we allow local jumps (and simply falling
> > of the end of a page) but if we're jumping to a new function it must be to
> > an external label in the symbol table.  Since ROP attacks are all about
> > jumping to gadget code which is effectively in the middle of real
> > functions, the jumps they induce are to code that doesn't have an external
> > symbol, so it should mostly detect when they happen.
> 
> This turns the problem from: "attackers can leverage any data/code that
> the kernel has mapped (anything)" to "attackers can leverage any
> code/data that the current syscall has faulted in".
> 
> That seems like a pretty restrictive change.
> 
> > At this time we are not suggesting any API that will enable the system
> > calls isolation. Because of the overhead required for this, it should only
> > be activated for processes or containers we know should be untrusted. We
> > still have no actual numbers, but surely forcing page faults during system
> > call execution will not come for free.
> 
> What's the minimum number of faults that have to occur to handle the
> simplest dummy fault?
 
For the current implementation it's 3.

Here is the example trace of #PF's produced by a dummy get_answer
system call from patch 7:

[   12.012906] #PF: DATA: do_syscall_64+0x26b/0x4c0 fault at 0xffffffff82000bb8
[   12.012918] #PF: INSN: __x86_indirect_thunk_rax+0x0/0x20 fault at __x86_indirect_thunk_rax+0x0/0x20
[   12.012929] #PF: INSN: __x64_sys_get_answer+0x0/0x10 fault at__x64_sys_get_answer+0x0/0x10

For the sci_write_dmesg syscall that does copy_from_user() and printk() its
between 35 and 60 depending on console and /proc/sys/kernel/printk values.

This includes both code and data accesses. The data page faults can be
avoided if we pre-populate SCI page tables with data.

-- 
Sincerely yours,
Mike.

