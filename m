Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83DAC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B652C2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfEPONZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:13:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726758AbfEPONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:13:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GE3QXB003662
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:13:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sh8d6ka47-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:13:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 16 May 2019 15:13:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 15:13:17 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GEDHUw51249156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 14:13:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFFF3A4053;
        Thu, 16 May 2019 14:13:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57921A4051;
        Thu, 16 May 2019 14:13:16 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 16 May 2019 14:13:16 +0000 (GMT)
Date:   Thu, 16 May 2019 17:13:14 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Bad virt_to_phys since commit 54c7a8916a887f35
References: <20190516133820.GA43059@lakrids.cambridge.arm.com>
 <20190516134105.GB43059@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516134105.GB43059@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19051614-0028-0000-0000-0000036E6144
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051614-0029-0000-0000-0000242DFC48
Message-Id: <20190516141314.GF19122@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 02:41:06PM +0100, Mark Rutland wrote:
> On Thu, May 16, 2019 at 02:38:20PM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > Since commit:
> > 
> >   54c7a8916a887f35 ("initramfs: free initrd memory if opening /initrd.image fails")
> 
> Ugh, I dropped a paragarph here.
> 
> Since that commit, I'm seeing a boot-time splat on arm64 when using
> CONFIG_DEBUG_VIRTUAL. I'm running an arm64 syzkaller instance, and this
> kills the VM, preventing further testing, which is unfortunate.
> 
> Mark.
> 
> > IIUC prior to that commit, we'd only attempt to free an intird if we had
> > one, whereas now we do so unconditionally. AFAICT, in this case
> > initrd_start has not been initialized (I'm not using an initrd or
> > initramfs on my system), so we end up trying virt_to_phys() on a bogus
> > VA in free_initrd_mem().
> > 
> > Any ideas on the right way to fix this?

If I remember correctly, initrd_start would be 0 unless explicitly set by
the arch setup code, so something like this could work:

diff --git a/init/initramfs.c b/init/initramfs.c
index 435a428c2af1..05fe60437796 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -529,6 +529,9 @@ extern unsigned long __initramfs_size;
 
 void __weak free_initrd_mem(unsigned long start, unsigned long end)
 {
+       if (!start)
+               return;
+
        free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
                        "initrd");
 }


> > 
> > Thanks,
> > Mark.
> > 
> > [    5.251023][    T1] ------------[ cut here ]------------
> > [    5.252465][    T1] virt_to_phys used for non-linear address: (____ptrval____) (0x0)
> > [    5.254388][    T1] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x88/0xb8
> > [    5.256473][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-11058-g83f3ef3 #4
> > [    5.258513][    T1] Hardware name: linux,dummy-virt (DT)
> > [    5.259923][    T1] pstate: 80400005 (Nzcv daif +PAN -UAO)
> > [    5.261375][    T1] pc : __virt_to_phys+0x88/0xb8
> > [    5.262623][    T1] lr : __virt_to_phys+0x88/0xb8
> > [    5.263879][    T1] sp : ffff80000be4fc60
> > [    5.264941][    T1] x29: ffff80000be4fc60 x28: 0000000040000000 
> > [    5.266522][    T1] x27: ffff200015445000 x26: 0000000000000000 
> > [    5.268112][    T1] x25: 0000000000000000 x24: ffff2000163e0000 
> > [    5.269691][    T1] x23: ffff2000163e0440 x22: ffff2000163e0000 
> > [    5.271270][    T1] x21: ffff2000163e0400 x20: 0000000000000000 
> > [    5.272860][    T1] x19: 0000000000000000 x18: ffff200016aa0f80 
> > [    5.274430][    T1] x17: ffff2000153a0000 x16: 00000000f2000000 
> > [    5.276018][    T1] x15: 1fffe40002d5560d x14: 1ffff00007716109 
> > [    5.277596][    T1] x13: ffff200016e17000 x12: ffff040002a83fd9 
> > [    5.279179][    T1] x11: 1fffe40002a83fd8 x10: ffff040002a83fd8 
> > [    5.280765][    T1] x9 : 1fffe40002a83fd8 x8 : dfff200000000000 
> > [    5.282343][    T1] x7 : ffff040002a83fd9 x6 : ffff20001541fec0 
> > [    5.283929][    T1] x5 : ffff80003b8b0040 x4 : 0000000000000000 
> > [    5.285509][    T1] x3 : ffff2000102c6504 x2 : ffff1000017c9f54 
> > [    5.287091][    T1] x1 : 15eab2dadba38000 x0 : 0000000000000000 
> > [    5.288678][    T1] Call trace:
> > [    5.289532][    T1]  __virt_to_phys+0x88/0xb8
> > [    5.290701][    T1]  free_initrd_mem+0x3c/0x50
> > [    5.291894][    T1]  populate_rootfs+0x2f4/0x358
> > [    5.293123][    T1]  do_one_initcall+0x568/0xb94
> > [    5.294349][    T1]  kernel_init_freeable+0xd44/0xe2c
> > [    5.295695][    T1]  kernel_init+0x14/0x1c0
> > [    5.296814][    T1]  ret_from_fork+0x10/0x1c
> > [    5.297947][    T1] irq event stamp: 288672
> > [    5.299069][    T1] hardirqs last  enabled at (288671): [<ffff2000102c4cac>] console_unlock+0x89c/0xe50
> > [    5.301521][    T1] hardirqs last disabled at (288672): [<ffff2000100823e0>] do_debug_exception+0x268/0x3e0
> > [    5.304061][    T1] softirqs last  enabled at (288668): [<ffff2000100835e0>] __do_softirq+0xa38/0xf48
> > [    5.306457][    T1] softirqs last disabled at (288653): [<ffff2000101ac994>] irq_exit+0x2a4/0x318
> > [    5.308777][    T1] ---[ end trace 3cf83e3c184a4d3e ]---
> 

-- 
Sincerely yours,
Mike.

