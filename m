Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A78C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318A2215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KSgdtxzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfJDTIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:08:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63956 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727795AbfJDTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:08:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94J6SvI022492
        for <linux-kernel@vger.kernel.org>; Fri, 4 Oct 2019 12:08:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=jT1yH6T7d7kCJOJ+Apa+Eep0k3jDOY8sh6pPi7FDHnA=;
 b=KSgdtxzzRq0Spt04R+JOATyUm/GZoYkg/VAFLF6ZMHBukG1hnGD8Q9+UEkgiFwMer406
 43je8HTqNxVv7UtBoE7XhR3dCyc7o+NZubWAiaP3aGm5binYW7Xxkhso4gjUsd7k0HOX
 DvS0zz+MUVRxXr8+6K4LCvMh0wrHpFb0LCM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vdmh9dxjb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 12:08:12 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Oct 2019 12:08:11 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 8B588183FD477; Fri,  4 Oct 2019 12:08:08 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] mm: memcg/slab: fix panic in __free_slab() caused by premature memcg pointer release
Date:   Fri, 4 Oct 2019 12:07:58 -0700
Message-ID: <20191004190758.103393-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_12:2019-10-03,2019-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=3
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=552 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910040154
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten reported the following panic in __free_slab() happening on a s390=
x
machine:

349.361168=C2=A8 Unable to handle kernel pointer dereference in virtual k=
ernel address space
349.361210=C2=A8 Failing address: 0000000000000000 TEID: 0000000000000483
349.361223=C2=A8 Fault in home space mode while using kernel ASCE.
349.361240=C2=A8 AS:00000000017d4007 R3:000000007fbd0007 S:000000007fbff0=
00 P:000000000000003d
349.361340=C2=A8 Oops: 0004 ilc:3 =C3=9D#1=C2=A8 PREEMPT SMP
349.361349=C2=A8 Modules linked in: tcp_diag inet_diag xt_tcpudp ip6t_rpf=
ilter ip6t_REJECT \
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat ip6tab=
le_mangle \
ip6table_raw ip6table_security iptable_at nf_nat
349.361436=C2=A8 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-05872-g6=
133e3e4bada-dirty #14
349.361445=C2=A8 Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
349.361450=C2=A8 Krnl PSW : 0704d00180000000 00000000003cadb6 (__free_sla=
b+0x686/0x6b0)
349.361464=C2=A8            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1=
 PM:0 RI:0 EA:3
349.361470=C2=A8 Krnl GPRS: 00000000f3a32928 0000000000000000 000000007fb=
f5d00 000000000117c4b8
349.361475=C2=A8            0000000000000000 000000009e3291c1 00000000000=
00000 0000000000000000
349.361481=C2=A8            0000000000000003 0000000000000008 000000002b4=
78b00 000003d080a97600
349.361481=C2=A8            0000000000000003 0000000000000008 000000002b4=
78b00 000003d080a97600
349.361486=C2=A8            000000000117ba00 000003e000057db0 00000000003=
cabcc 000003e000057c78
349.361500=C2=A8 Krnl Code: 00000000003cada6: e310a1400004        lg     =
 %r1,320(%r10)
349.361500=C2=A8            00000000003cadac: c0e50046c286        brasl  =
 %r14,ca32b8
349.361500=C2=A8           #00000000003cadb2: a7f4fe36            brc    =
 15,3caa1e
349.361500=C2=A8           >00000000003cadb6: e32060800024        stg    =
 %r2,128(%r6)
349.361500=C2=A8            00000000003cadbc: a7f4fd9e            brc    =
 15,3ca8f8
349.361500=C2=A8            00000000003cadc0: c0e50046790c        brasl  =
 %r14,c99fd8
349.361500=C2=A8            00000000003cadc6: a7f4fe2c            brc    =
 15,3caa
349.361500=C2=A8            00000000003cadc6: a7f4fe2c            brc    =
 15,3caa1e
349.361500=C2=A8            00000000003cadca: ecb1ffff00d9        aghik  =
 %r11,%r1,-1
349.361619=C2=A8 Call Trace:
349.361627=C2=A8 (=C3=9D<00000000003cabcc>=C2=A8 __free_slab+0x49c/0x6b0)
349.361634=C2=A8  =C3=9D<00000000001f5886>=C2=A8 rcu_core+0x5a6/0x7e0
349.361643=C2=A8  =C3=9D<0000000000ca2dea>=C2=A8 __do_softirq+0xf2/0x5c0
349.361652=C2=A8  =C3=9D<0000000000152644>=C2=A8 irq_exit+0x104/0x130
349.361659=C2=A8  =C3=9D<000000000010d222>=C2=A8 do_IRQ+0x9a/0xf0
349.361667=C2=A8  =C3=9D<0000000000ca2344>=C2=A8 ext_int_handler+0x130/0x=
134
349.361674=C2=A8  =C3=9D<0000000000103648>=C2=A8 enabled_wait+0x58/0x128
349.361681=C2=A8 (=C3=9D<0000000000103634>=C2=A8 enabled_wait+0x44/0x128)
349.361688=C2=A8  =C3=9D<0000000000103b00>=C2=A8 arch_cpu_idle+0x40/0x58
349.361695=C2=A8  =C3=9D<0000000000ca0544>=C2=A8 default_idle_call+0x3c/0=
x68
349.361704=C2=A8  =C3=9D<000000000018eaa4>=C2=A8 do_idle+0xec/0x1c0
349.361748=C2=A8  =C3=9D<000000000018ee0e>=C2=A8 cpu_startup_entry+0x36/0=
x40
349.361756=C2=A8  =C3=9D<000000000122df34>=C2=A8 arch_call_rest_init+0x5c=
/0x88
349.361761=C2=A8  =C3=9D<0000000000000000>=C2=A8 0x0
349.361765=C2=A8 INFO: lockdep is turned off.
349.361769=C2=A8 Last Breaking-Event-Address:
349.361774=C2=A8  =C3=9D<00000000003ca8f4>=C2=A8 __free_slab+0x1c4/0x6b0
349.361781=C2=A8 Kernel panic - not syncing: Fatal exception in interrupt

The kernel panics on an attempt to dereference the NULL memcg pointer.
When shutdown_cache() is called from the kmem_cache_destroy() context,
a memcg kmem_cache might have empty slab pages in a partial list,
which are still charged to the memory cgroup. These pages are released
by free_partial() at the beginning of shutdown_cache(): either
directly or by scheduling a RCU-delayed work (if the kmem_cache has
the SLAB_TYPESAFE_BY_RCU flag). The latter case is when the reported
panic can happen: memcg_unlink_cache() is called immediately after
shrinking partial lists, without waiting for scheduled RCU works.
It sets the kmem_cache->memcg_params.memcg pointer to NULL,
and the following attempt to dereference it by __free_slab()
from the RCU work context causes the panic.

To fix the issue, let's postpone the release of the memcg pointer
to destroy_memcg_params(). It's called from a separate work context
by slab_caches_to_rcu_destroy_workfn(), which contains a full RCU
barrier. This guarantees that all scheduled page release RCU works
will complete before the memcg pointer will be zeroed.

Big thanks for Karsten for the perfect report containing all necessary
information, his help with the analysis of the problem and testing
of the fix.

Fixes: fb2f2b0adb98 ("mm: memcg/slab: reparent memcg kmem_caches on cgrou=
p removal")
Reported-by: Karsten Graul <kgraul@linux.ibm.com>
Tested-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: David Rientjes <rientjes@google.com>
---
 mm/slab_common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0b94a37da531..8afa188f6e20 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -178,10 +178,13 @@ static int init_memcg_params(struct kmem_cache *s,
=20
 static void destroy_memcg_params(struct kmem_cache *s)
 {
-	if (is_root_cache(s))
+	if (is_root_cache(s)) {
 		kvfree(rcu_access_pointer(s->memcg_params.memcg_caches));
-	else
+	} else {
+		mem_cgroup_put(s->memcg_params.memcg);
+		WRITE_ONCE(s->memcg_params.memcg, NULL);
 		percpu_ref_exit(&s->memcg_params.refcnt);
+	}
 }
=20
 static void free_memcg_params(struct rcu_head *rcu)
@@ -253,8 +256,6 @@ static void memcg_unlink_cache(struct kmem_cache *s)
 	} else {
 		list_del(&s->memcg_params.children_node);
 		list_del(&s->memcg_params.kmem_caches_node);
-		mem_cgroup_put(s->memcg_params.memcg);
-		WRITE_ONCE(s->memcg_params.memcg, NULL);
 	}
 }
 #else
--=20
2.21.0

