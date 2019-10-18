Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F105FCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C28222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632918AbfJRIkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:40:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727903AbfJRIkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:40:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9I8bWWQ053607
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:40:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqa0yr49v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:40:41 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 18 Oct 2019 09:40:39 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Oct 2019 09:40:37 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9I8eb5g57475080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 08:40:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2846A4054;
        Fri, 18 Oct 2019 08:40:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D828A405C;
        Fri, 18 Oct 2019 08:40:36 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.90])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Oct 2019 08:40:36 +0000 (GMT)
Subject: Perf record is broken on kernel 5.4.0.rc3
References: <b1678611-bafd-36db-b91c-aad87943489f@linux.ibm.com>
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Hechao Li <hechaol@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
X-Forwarded-Message-Id: <b1678611-bafd-36db-b91c-aad87943489f@linux.ibm.com>
Date:   Fri, 18 Oct 2019 10:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b1678611-bafd-36db-b91c-aad87943489f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101808-0008-0000-0000-00000323320C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101808-0009-0000-0000-00004A4252EF
Message-Id: <318faccf-a5fb-50f3-2635-6037b4670eb6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I ran into a eBPF program load error, system call bpf() returned -EPERM.
It turned out that
  bpf_prog_load()
    bpf_prog_charge_memlock()
     __bpf_prog_charge() operated on a strange value of user->locked_vm:
                         user->locked_vm:0xfffffffffffffe04
                         when accounting for 1 page.

I bisected this strange value to
commit d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")

I added printk at end of function perf_mmap() to show allocation
and at end of function perf_mmap_close() to display memory release.
Then I run command 'perf record -e rbd000' to record samples and saving
them in the auxiliary trace buffer.

Here is the output, copied from the dmesg buffer:

During allocation the values increase
[52.250027] perf_mmap user->locked_vm:0x87 pinned_vm:0x0 ret:0 
[52.250115] perf_mmap user->locked_vm:0x107 pinned_vm:0x0 ret:0
[52.250251] perf_mmap user->locked_vm:0x188 pinned_vm:0x0 ret:0
[52.250326] perf_mmap user->locked_vm:0x208 pinned_vm:0x0 ret:0
[52.250441] perf_mmap user->locked_vm:0x289 pinned_vm:0x0 ret:0
[52.250498] perf_mmap user->locked_vm:0x309 pinned_vm:0x0 ret:0 
[52.250613] perf_mmap user->locked_vm:0x38a pinned_vm:0x0 ret:0 
[52.250715] perf_mmap user->locked_vm:0x408 pinned_vm:0x2 ret:0 
[52.250834] perf_mmap user->locked_vm:0x408 pinned_vm:0x83 ret:0 
[52.250915] perf_mmap user->locked_vm:0x408 pinned_vm:0x103 ret:0 
[52.251061] perf_mmap user->locked_vm:0x408 pinned_vm:0x184 ret:0 
[52.251146] perf_mmap user->locked_vm:0x408 pinned_vm:0x204 ret:0 
[52.251299] perf_mmap user->locked_vm:0x408 pinned_vm:0x285 ret:0 
[52.251383] perf_mmap user->locked_vm:0x408 pinned_vm:0x305 ret:0 
[52.251544] perf_mmap user->locked_vm:0x408 pinned_vm:0x386 ret:0 
[52.251634] perf_mmap user->locked_vm:0x408 pinned_vm:0x406 ret:0 
[52.253018] perf_mmap user->locked_vm:0x408 pinned_vm:0x487 ret:0 
[52.253197] perf_mmap user->locked_vm:0x408 pinned_vm:0x508 ret:0 
[52.253374] perf_mmap user->locked_vm:0x408 pinned_vm:0x589 ret:0
[52.253550] perf_mmap user->locked_vm:0x408 pinned_vm:0x60a ret:0
[52.253726] perf_mmap user->locked_vm:0x408 pinned_vm:0x68b ret:0
[52.253903] perf_mmap user->locked_vm:0x408 pinned_vm:0x70c ret:0
[52.254084] perf_mmap user->locked_vm:0x408 pinned_vm:0x78d ret:0
[52.254263] perf_mmap user->locked_vm:0x408 pinned_vm:0x80e ret:0

The value of user->locked_vm increases to a limit then the memory
is tracked by pinned_vm.

During deallocation the size is subtracted from pinned_vm until
it hits a limit. Then a larger value is subtracted from locked_vm
leading to a large number (because of type unsigned):
[64.267797] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x78d
[64.267826] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x70c
[64.267848] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x68b
[64.267869] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x60a
[64.267891] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x589
[64.267911] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x508
[64.267933] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x487
[64.267952] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x406
[64.268883] perf_mmap_close mmap_user->locked_vm:0x307 pinned_vm:0x406
[64.269117] perf_mmap_close mmap_user->locked_vm:0x206 pinned_vm:0x406
[64.269433] perf_mmap_close mmap_user->locked_vm:0x105 pinned_vm:0x406
[64.269536] perf_mmap_close mmap_user->locked_vm:0x4 pinned_vm:0x404
[64.269797] perf_mmap_close mmap_user->locked_vm:0xffffffffffffff84 pinned_vm:0x303
[64.270105] perf_mmap_close mmap_user->locked_vm:0xffffffffffffff04 pinned_vm:0x202
[64.270374] perf_mmap_close mmap_user->locked_vm:0xfffffffffffffe84 pinned_vm:0x101
[64.270628] perf_mmap_close mmap_user->locked_vm:0xfffffffffffffe04 pinned_vm:0x0

This value sticks for the user until system is rebooted, causing
follow-on system calls using locked_vm resource limit to fail.

This happens on a s390 (where I can proof it), but I am sure this
affects other plattforms too as above commit changes common code.

If you send me a fix, I can verify it.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

