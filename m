Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8452054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfCMVW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:22:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbfCMVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:22:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DL9Mso139072
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 17:22:57 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r788h403f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 17:22:57 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Mar 2019 21:22:55 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 21:22:52 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DLMp3323199972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 21:22:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EF3DB2065;
        Wed, 13 Mar 2019 21:22:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30FF2B2064;
        Wed, 13 Mar 2019 21:22:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 21:22:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 583E116C2F61; Wed, 13 Mar 2019 14:22:55 -0700 (PDT)
Date:   Wed, 13 Mar 2019 14:22:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Barret Rhoden <brho@google.com>,
        Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eial Czerwacki <eial@scalemp.com>,
        linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
Reply-To: paulmck@linux.ibm.com
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
 <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
 <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
 <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031321-0068-0000-0000-000003A52506
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010752; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173933; UDB=6.00613819; IPR=6.00954596;
 MB=3.00025966; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-13 21:22:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031321-0069-0000-0000-000047CF3AAE
Message-Id: <20190313212255.GY13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 01:26:40PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 13, 2019 at 03:40:04PM -0400, Barret Rhoden wrote:
> > Are there any other alternatives?  Not using static SRCU in any code
> > that could be built as a module seems a little harsh.
> 
> Yes, allocate the srcu dynamically on module init and destroy on
> module exit.  That's how the other similar case got solved too.  We
> can't keep bumping up reserved size by the number of static SRCUs in
> modules.  It's mostly there to make trivial small things easier.  We
> don't lose anything meaningful by allocating srcu dynamically.

Should I define DEFINE_SRCU() and DEFINE_STATIC_SRCU() only if
!defined(MODULE)?

Untested (probably doesn't even build) patch below.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 7f7c8c050f63..a979da9cf71f 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -105,6 +105,8 @@ struct srcu_struct {
  * Define and initialize a srcu struct at build time.
  * Do -not- call init_srcu_struct() nor cleanup_srcu_struct() on it.
  *
+ * Build-time srcu_struct definition is not allowed in modules.
+ *
  * Note that although DEFINE_STATIC_SRCU() hides the name from other
  * files, the per-CPU variable rules nevertheless require that the
  * chosen name be globally unique.  These rules also prohibit use of
@@ -120,11 +122,13 @@ struct srcu_struct {
  *
  * See include/linux/percpu-defs.h for the rules on per-CPU variables.
  */
-#define __DEFINE_SRCU(name, is_static)					\
-	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);\
+#ifndef MODULE
+#  define __DEFINE_SRCU(name, is_static)				\
+	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
 	is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name##_srcu_data)
-#define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
-#define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
+#  define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
+#  define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
+#endif
 
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5ff797fd3715..7cf1e3aed695 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -496,9 +496,18 @@ static struct rcu_torture_ops rcu_busted_ops = {
  * Definitions for srcu torture testing.
  */
 
-DEFINE_STATIC_SRCU(srcu_ctl);
 static struct srcu_struct srcu_ctld;
-static struct srcu_struct *srcu_ctlp = &srcu_ctl;
+static struct srcu_struct *srcu_ctlp;
+
+#ifndef MODULE
+DEFINE_STATIC_SRCU(srcu_ctl);
+
+static void srcu_torture_init(void)
+{
+	rcu_sync_torture_init();
+	srcu_ctlp = &srcu_ctl;
+}
+#endif
 
 static int srcu_torture_read_lock(void) __acquires(srcu_ctlp)
 {
@@ -565,9 +574,10 @@ static void srcu_torture_synchronize_expedited(void)
 	synchronize_srcu_expedited(srcu_ctlp);
 }
 
+#ifndef MODULE
 static struct rcu_torture_ops srcu_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= rcu_sync_torture_init,
+	.init		= srcu_torture_init,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
@@ -581,25 +591,25 @@ static struct rcu_torture_ops srcu_ops = {
 	.irq_capable	= 1,
 	.name		= "srcu"
 };
+#endif
 
-static void srcu_torture_init(void)
+static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
 	WARN_ON(init_srcu_struct(&srcu_ctld));
 	srcu_ctlp = &srcu_ctld;
 }
 
-static void srcu_torture_cleanup(void)
+static void srcud_torture_cleanup(void)
 {
 	cleanup_srcu_struct(&srcu_ctld);
-	srcu_ctlp = &srcu_ctl; /* In case of a later rcutorture run. */
 }
 
 /* As above, but dynamically allocated. */
 static struct rcu_torture_ops srcud_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= srcu_torture_init,
-	.cleanup	= srcu_torture_cleanup,
+	.init		= srcud_torture_init,
+	.cleanup	= srcud_torture_cleanup,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
@@ -617,8 +627,8 @@ static struct rcu_torture_ops srcud_ops = {
 /* As above, but broken due to inappropriate reader extension. */
 static struct rcu_torture_ops busted_srcud_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= srcu_torture_init,
-	.cleanup	= srcu_torture_cleanup,
+	.init		= srcud_torture_init,
+	.cleanup	= srcud_torture_cleanup,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,

