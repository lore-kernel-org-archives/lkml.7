Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8483FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5801920857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbfDBOad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:30:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728448AbfDBOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:30:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32EUMqg121367
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 10:30:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rm92taaa1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:30:26 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Apr 2019 15:29:37 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 15:29:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32ETTrL17957116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 14:29:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AFEDB206B;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7999CB2066;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8FE2B16C2A47; Tue,  2 Apr 2019 07:29:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH RFC tip/core/rcu 2/4] drivers/gpu/drm: Dynamically allocate drm_unplug_srcu
Date:   Tue,  2 Apr 2019 07:29:31 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402142816.GA13084@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19040214-0068-0000-0000-000003AF73B4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010860; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183284; UDB=6.00619477; IPR=6.00964032;
 MB=3.00026260; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 14:29:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040214-0069-0000-0000-0000480482B1
Message-Id: <20190402142933.14547-2-paulmck@linux.ibm.com>
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
requires that the size of the reserved region be increased, which is not
something we really want to be doing.  This commit therefore removes
the DEFINE_STATIC_SRCU() from drivers/gpu/drm/drm_drv.c in favor of
defining drm_unplug_srcu as a simple srcu_struct, initializing it in
drm_core_init(), and cleaning it up in drm_core_exit().

In this particular case, drm_unplug_srcu is statically allocated and thus
guaranteed to be initially zero.  Unfortunately, cleanup_srcu_struct()
cannot rely on this in the general case (which includes dynamically
allocated srcu_struct structures), and therefore cannot tell whether it
is being called on something that has been passed to init_srcu_struct().
Thus the code added to drm_core_init() is a bit non-standard.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/drm_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 381581b01d48..ce4582af814d 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -77,7 +77,7 @@ static bool drm_core_init_complete = false;
 
 static struct dentry *drm_debugfs_root;
 
-DEFINE_STATIC_SRCU(drm_unplug_srcu);
+static struct srcu_struct drm_unplug_srcu;
 
 /*
  * DRM Minors
@@ -958,12 +958,18 @@ static void drm_core_exit(void)
 	drm_sysfs_destroy();
 	idr_destroy(&drm_minors_idr);
 	drm_connector_ida_destroy();
+	cleanup_srcu_struct(&drm_unplug_srcu);
 }
 
 static int __init drm_core_init(void)
 {
 	int ret;
 
+	ret = init_srcu_struct(&drm_unplug_srcu);
+	if (ret) {
+		DRM_ERROR("Cannot create DRM class: %d\n", ret);
+		return ret; /* cannot cleanup after failed srcu_struct init. */
+	}
 	drm_connector_ida_init();
 	idr_init(&drm_minors_idr);
 
-- 
2.17.1

