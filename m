Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B294C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B152072D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfLIJR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:17:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbfLIJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:17:59 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB99HK9J126637
        for <linux-kernel@vger.kernel.org>; Mon, 9 Dec 2019 04:17:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrtgyj225-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 04:17:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Mon, 9 Dec 2019 09:17:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Dec 2019 09:17:53 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB99HqdJ50855956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 09:17:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41CD042041;
        Mon,  9 Dec 2019 09:17:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C41E14203F;
        Mon,  9 Dec 2019 09:17:49 +0000 (GMT)
Received: from in.ibm.com (unknown [9.109.247.23])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  9 Dec 2019 09:17:49 +0000 (GMT)
Date:   Mon, 9 Dec 2019 14:47:46 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     guro@fb.com
Cc:     mhocko@kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        shakeelb@google.com, vdavydov.dev@gmail.com, longman@redhat.com
Subject: Re: [PATCH 00/16] The new slab memory controller
Reply-To: bharata@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905214553.1643060-1-guro@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 19120909-0016-0000-0000-000002D30E58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120909-0017-0000-0000-000033351ECC
Message-Id: <20191209091746.GA16989@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_01:2019-12-09,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 suspectscore=1 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=746
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see the below crash during early boot when I try this patchset on
PowerPC host. I am on new_slab.rfc.v5.3 branch.

BUG: Unable to handle kernel data access at 0x81030236d1814578
Faulting instruction address: 0xc0000000002cc314
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in: ip_tables x_tables autofs4 sr_mod cdrom usbhid bnx2x crct10dif_vpmsum crct10dif_common mdio libcrc32c crc32c_vpmsum
CPU: 31 PID: 1752 Comm: keyboard-setup. Not tainted 5.3.0-g9bd85fd72a0c #155
NIP:  c0000000002cc314 LR: c0000000002cc2e8 CTR: 0000000000000000
REGS: c000001e40f378b0 TRAP: 0380   Not tainted  (5.3.0-g9bd85fd72a0c)
MSR:  900000010280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 44022224  XER: 00000000
CFAR: c0000000002c6ad4 IRQMASK: 1 
GPR00: c0000000000b8a40 c000001e40f37b40 c000000000ed9600 0000000000000000 
GPR04: 0000000000000023 0000000000000010 c000001e40f37b24 c000001e3cba3400 
GPR08: 0000000000000020 81030218815f4578 0000001e50220000 0000000000000030 
GPR12: 0000000000002200 c000001fff774d80 0000000000000000 00000001072600d8 
GPR16: 0000000000000000 c0000000000bbaac 0000000000000000 0000000000000000 
GPR20: c000001e40f37c48 0000000000000001 0000000000000000 c000001e3cba3400 
GPR24: c000001e40f37dd8 0000000000000000 c000000000fa0d58 0000000000000000 
GPR28: c000001e3a080080 c000001e32da0100 0000000000000118 0000000000000010 
NIP [c0000000002cc314] __mod_memcg_state+0x58/0xd0
LR [c0000000002cc2e8] __mod_memcg_state+0x2c/0xd0
Call Trace:
[c000001e40f37b90] [c0000000000b8a40] account_kernel_stack+0xa4/0xe4
[c000001e40f37bd0] [c0000000000ba4a4] copy_process+0x2b4/0x16f0
[c000001e40f37cf0] [c0000000000bbaac] _do_fork+0x9c/0x3e4
[c000001e40f37db0] [c0000000000bc030] sys_clone+0x74/0xa8
[c000001e40f37e20] [c00000000000bb34] ppc_clone+0x8/0xc
Instruction dump:
4bffa7e9 2fa30000 409e007c 395efffb 3d000020 2b8a0001 409d0008 39000020 
e93d0718 e94d0028 7bde1f24 7d29f214 <7ca9502a> 7fff2a14 7fe9fe76 7d27fa78 

Looks like page->mem_cgroup_vec is allocated but not yet initialized
with memcg pointers when we try to access them.

I did get past the crash by initializing the pointers like this
in account_kernel_stack(), but I am pretty sure that this is not the
place to do this:

diff --git a/kernel/fork.c b/kernel/fork.c
index 541fd805fb88..be21419feae2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -380,13 +380,26 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
                 * All stack pages are in the same zone and belong to the
                 * same memcg.
                 */
-               struct page *first_page = virt_to_page(stack);
+               struct page *first_page = virt_to_head_page((stack));
+               unsigned long off;
+               struct mem_cgroup_ptr *memcg_ptr;
+               struct mem_cgroup *memcg;
 
                mod_zone_page_state(page_zone(first_page), NR_KERNEL_STACK_KB,
                                    THREAD_SIZE / 1024 * account);
 
-               mod_memcg_page_state(first_page, MEMCG_KERNEL_STACK_KB,
+               if (!first_page->mem_cgroup_vec)
+                       return;
+               off = obj_to_index(task_struct_cachep, first_page, stack);
+               memcg_ptr = first_page->mem_cgroup_vec[off];
+               if (!memcg_ptr)
+                       return;
+               rcu_read_lock();
+               memcg = memcg_ptr->memcg;
+               if (memcg)
+                       __mod_memcg_state(memcg, MEMCG_KERNEL_STACK_KB,
                                     account * (THREAD_SIZE / 1024));
+               rcu_read_unlock();
        }
 }

Regards,
Bharata.

