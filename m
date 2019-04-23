Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A57C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3B1218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfDWWje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:39:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbfDWWje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:39:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NMd4Lm130011
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 18:39:33 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s28whxh8j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 18:39:32 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 23 Apr 2019 23:39:32 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 23:39:30 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NMdTPD25231530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 22:39:29 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47599BE051;
        Tue, 23 Apr 2019 22:39:29 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D6B4BE054;
        Tue, 23 Apr 2019 22:39:27 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.214.110])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 22:39:26 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v4] powerpc/pseries: Remove limit in wait for dying CPU
Date:   Tue, 23 Apr 2019 19:39:14 -0300
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042322-0012-0000-0000-0000172B09B7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010983; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193417; UDB=6.00625613; IPR=6.00974238;
 MB=3.00026564; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 22:39:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042322-0013-0000-0000-000056FC40C0
Message-Id: <20190423223914.3882-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing DLPAR CPU add/remove on a system under stress,
pseries_cpu_die() doesn't wait long enough for a CPU to die:

[  446.983944] cpu 148 (hwid 148) Ready to die...
[  446.984062] cpu 149 (hwid 149) Ready to die...
[  446.993518] cpu 150 (hwid 150) Ready to die...
[  446.993543] Querying DEAD? cpu 150 (150) shows 2
[  446.994098] cpu 151 (hwid 151) Ready to die...
[  447.133726] cpu 136 (hwid 136) Ready to die...
[  447.403532] cpu 137 (hwid 137) Ready to die...
[  447.403772] cpu 138 (hwid 138) Ready to die...
[  447.403839] cpu 139 (hwid 139) Ready to die...
[  447.403887] cpu 140 (hwid 140) Ready to die...
[  447.403937] cpu 141 (hwid 141) Ready to die...
[  447.403979] cpu 142 (hwid 142) Ready to die...
[  447.404038] cpu 143 (hwid 143) Ready to die...
[  447.513546] cpu 128 (hwid 128) Ready to die...
[  447.693533] cpu 129 (hwid 129) Ready to die...
[  447.693999] cpu 130 (hwid 130) Ready to die...
[  447.703530] cpu 131 (hwid 131) Ready to die...
[  447.704087] Querying DEAD? cpu 132 (132) shows 2
[  447.704102] cpu 132 (hwid 132) Ready to die...
[  447.713534] cpu 133 (hwid 133) Ready to die...
[  447.714064] Querying DEAD? cpu 134 (134) shows 2

This is a race between one CPU stopping and another one calling
pseries_cpu_die() to wait for it to stop. That function does a short busy
loop calling RTAS query-cpu-stopped-state on the stopping CPU to verify
that it is stopped, but I think there's a lot for the stopping CPU to do
which may take longer than this loop allows.

As can be seen in the dmesg right before or after the "Querying DEAD?"
messages, if pseries_cpu_die() waited a little longer it would have seen
the CPU in the stopped state.

What I think is going on is that CPU 134 was inactive at the time it was
unplugged. In that case, dlpar_offline_cpu() calls H_PROD on that CPU and
immediately calls pseries_cpu_die(). Meanwhile, the prodded CPU activates
and start the process of stopping itself. The busy loop is not long enough
to allow for the CPU to wake up and complete the stopping process.

This can be a problem because if the busy loop finishes too early, then the
kernel may offline another CPU before the previous one finished dying,
which would lead to two concurrent calls to rtas-stop-self, which is
prohibited by the PAPR.

Since the hotplug machinery already assumes that cpu_die() is going to
work, we can simply loop until the CPU stops.

Also change the loop to wait 100 µs between each call to
smp_query_cpu_stopped() to avoid querying RTAS too often.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Analyzed-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

I have seen this problem since v4.8. Should this patch go to stable as
well?

Changes since v3:
- Changed to loop until the CPU stops rather than for a fixed amount
  of time.

Changes since v2:
- Increased busy loop to 200 iterations so that it can last up to 20 ms
  (suggested by Gautham).
- Changed commit message to include Gautham's remarks.

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 97feb6e79f1a..d75cee60644c 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -214,13 +214,17 @@ static void pseries_cpu_die(unsigned int cpu)
 			msleep(1);
 		}
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
-
-		for (tries = 0; tries < 25; tries++) {
+		/*
+		 * rtas_stop_self() panics if the CPU fails to stop and our
+		 * callers already assume that we are going to succeed, so we
+		 * can just loop until the CPU stops.
+		 */
+		while (true) {
 			cpu_status = smp_query_cpu_stopped(pcpu);
 			if (cpu_status == QCSS_STOPPED ||
 			    cpu_status == QCSS_HARDWARE_ERROR)
 				break;
-			cpu_relax();
+			udelay(100);
 		}
 	}
 

