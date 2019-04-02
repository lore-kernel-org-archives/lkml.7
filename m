Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD4620857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfDBO3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:29:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731348AbfDBO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:29:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32ETdKG095942
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 10:29:44 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rm880n23k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:29:43 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Apr 2019 15:29:36 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 15:29:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32ETTIw21495872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 14:29:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EED2B206A;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ED31B2065;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 88A3316C2A3D; Tue,  2 Apr 2019 07:29:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Tejun Heo <tj@kernel.org>,
        linux-nvdimm@lists.01.org
Subject: [PATCH RFC tip/core/rcu 1/4] dax/super: Dynamically allocate dax_srcu
Date:   Tue,  2 Apr 2019 07:29:30 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402142816.GA13084@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19040214-0040-0000-0000-000004DB706D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010860; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183284; UDB=6.00619477; IPR=6.00964032;
 MB=3.00026260; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 14:29:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040214-0041-0000-0000-000008E670DD
Message-Id: <20190402142933.14547-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
requires that the size of the reserved region be increased, which is
not something we really want to be doing.  This commit therefore removes
the DEFINE_STATIC_SRCU() from drivers/dax/super.c in favor of defining
dax_srcu as a simple srcu_struct, initializing it in dax_core_init(),
and cleaning it up in dax_core_exit().

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <linux-nvdimm@lists.01.org>
---
 drivers/dax/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0a339b85133e..3b152db30c6b 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -25,7 +25,7 @@
 #include "dax-private.h"
 
 static dev_t dax_devt;
-DEFINE_STATIC_SRCU(dax_srcu);
+static struct srcu_struct dax_srcu;
 static struct vfsmount *dax_mnt;
 static DEFINE_IDA(dax_minor_ida);
 static struct kmem_cache *dax_cache __read_mostly;
@@ -665,6 +665,10 @@ static int __init dax_core_init(void)
 {
 	int rc;
 
+	rc = init_srcu_struct(&dax_srcu);
+	if (rc)
+		goto err_srcu;
+
 	rc = dax_fs_init();
 	if (rc)
 		return rc;
@@ -678,10 +682,13 @@ static int __init dax_core_init(void)
 		goto err_bus;
 	return 0;
 
+
 err_bus:
 	unregister_chrdev_region(dax_devt, MINORMASK+1);
 err_chrdev:
 	dax_fs_exit();
+	cleanup_srcu_struct(&dax_srcu);
+err_srcu:
 	return 0;
 }
 
@@ -690,6 +697,7 @@ static void __exit dax_core_exit(void)
 	unregister_chrdev_region(dax_devt, MINORMASK+1);
 	ida_destroy(&dax_minor_ida);
 	dax_fs_exit();
+	cleanup_srcu_struct(&dax_srcu);
 }
 
 MODULE_AUTHOR("Intel Corporation");
-- 
2.17.1

