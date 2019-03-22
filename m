Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE858C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A271C2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254283;
	bh=ecPN3jQSX2sBjdB9wxbsoIHTtu+3Hs0bvg5DQoyhmxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rbkPdw25HhDOWX34uxWm2+sAw/d8uzGpo3+RPS5JxD8VKORr/LVVf5vMebGT8mXKK
	 BptoVfxbRzIubWAjut48UHISekwzUSdDFS8n4O/4/gYsnf/A/dPakBQrEgpVdudjW0
	 Gn2XHUY/pnc0IC530B7yj8pRI1wwVE6kv2cd1g00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfCVLbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfCVLbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 025F5218B0;
        Fri, 22 Mar 2019 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254277;
        bh=ecPN3jQSX2sBjdB9wxbsoIHTtu+3Hs0bvg5DQoyhmxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dc0AT0k6GNYUT6K6QFMAKeWpZZCUBMLb3e6eTbTaZ3sbB2cSuogwvzS5T5/sxdtRl
         HxfpWinboe5S693M64tKJhEEWJX7ll+p/nnPOEASDgsNlyYBhvB9u+5zrB4cRquHTn
         Pt4oKOUvHTipDABTf7zWRR4X6at2ese49dOCPQc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Donghee Han <dh.han@samsung.com>,
        Sangkyu Kim <skwith.kim@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 058/230] cpufreq: Use struct kobj_attribute instead of struct global_attr
Date:   Fri, 22 Mar 2019 12:13:16 +0100
Message-Id: <20190322111240.754500984@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 625c85a62cb7d3c79f6e16de3cfa972033658250 upstream.

The cpufreq_global_kobject is created using kobject_create_and_add()
helper, which assigns the kobj_type as dynamic_kobj_ktype and show/store
routines are set to kobj_attr_show() and kobj_attr_store().

These routines pass struct kobj_attribute as an argument to the
show/store callbacks. But all the cpufreq files created using the
cpufreq_global_kobject expect the argument to be of type struct
attribute. Things work fine currently as no one accesses the "attr"
argument. We may not see issues even if the argument is used, as struct
kobj_attribute has struct attribute as its first element and so they
will both get same address.

But this is logically incorrect and we should rather use struct
kobj_attribute instead of struct global_attr in the cpufreq core and
drivers and the show/store callbacks should take struct kobj_attribute
as argument instead.

This bug is caught using CFI CLANG builds in android kernel which
catches mismatch in function prototypes for such callbacks.

Reported-by: Donghee Han <dh.han@samsung.com>
Reported-by: Sangkyu Kim <skwith.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/cpufreq/cpufreq.c          |    6 +++---
 drivers/cpufreq/cpufreq_governor.h |   10 +++++-----
 drivers/cpufreq/intel_pstate.c     |   14 +++++++-------
 include/linux/cpufreq.h            |   12 ++----------
 4 files changed, 17 insertions(+), 25 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -474,13 +474,13 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_transitio
  *                          SYSFS INTERFACE                          *
  *********************************************************************/
 static ssize_t show_boost(struct kobject *kobj,
-				 struct attribute *attr, char *buf)
+			  struct kobj_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
 }
 
-static ssize_t store_boost(struct kobject *kobj, struct attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
+			   const char *buf, size_t count)
 {
 	int ret, enable;
 
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -48,11 +48,11 @@ enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 
 /* Create attributes */
 #define gov_sys_attr_ro(_name)						\
-static struct global_attr _name##_gov_sys =				\
+static struct kobj_attribute _name##_gov_sys =				\
 __ATTR(_name, 0444, show_##_name##_gov_sys, NULL)
 
 #define gov_sys_attr_rw(_name)						\
-static struct global_attr _name##_gov_sys =				\
+static struct kobj_attribute _name##_gov_sys =				\
 __ATTR(_name, 0644, show_##_name##_gov_sys, store_##_name##_gov_sys)
 
 #define gov_pol_attr_ro(_name)						\
@@ -74,7 +74,7 @@ __ATTR(_name, 0644, show_##_name##_gov_p
 /* Create show/store routines */
 #define show_one(_gov, file_name)					\
 static ssize_t show_##file_name##_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, char *buf)		\
+(struct kobject *kobj, struct kobj_attribute *attr, char *buf)		\
 {									\
 	struct _gov##_dbs_tuners *tuners = _gov##_dbs_cdata.gdbs_data->tuners; \
 	return sprintf(buf, "%u\n", tuners->file_name);			\
@@ -90,7 +90,7 @@ static ssize_t show_##file_name##_gov_po
 
 #define store_one(_gov, file_name)					\
 static ssize_t store_##file_name##_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, const char *buf, size_t count) \
+(struct kobject *kobj, struct kobj_attribute *attr, const char *buf, size_t count) \
 {									\
 	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
 	return store_##file_name(dbs_data, buf, count);			\
@@ -254,7 +254,7 @@ static inline int delay_for_sampling_rat
 
 #define declare_show_sampling_rate_min(_gov)				\
 static ssize_t show_sampling_rate_min_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, char *buf)		\
+(struct kobject *kobj, struct kobj_attribute *attr, char *buf)		\
 {									\
 	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
 	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -368,13 +368,13 @@ static void __init intel_pstate_debug_ex
 /************************** sysfs begin ************************/
 #define show_one(file_name, object)					\
 	static ssize_t show_##file_name					\
-	(struct kobject *kobj, struct attribute *attr, char *buf)	\
+	(struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
 	{								\
 		return sprintf(buf, "%u\n", limits->object);		\
 	}
 
 static ssize_t show_turbo_pct(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total, no_turbo, turbo_pct;
@@ -390,7 +390,7 @@ static ssize_t show_turbo_pct(struct kob
 }
 
 static ssize_t show_num_pstates(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total;
@@ -401,7 +401,7 @@ static ssize_t show_num_pstates(struct k
 }
 
 static ssize_t show_no_turbo(struct kobject *kobj,
-			     struct attribute *attr, char *buf)
+			     struct kobj_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -414,7 +414,7 @@ static ssize_t show_no_turbo(struct kobj
 	return ret;
 }
 
-static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
+static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 			      const char *buf, size_t count)
 {
 	unsigned int input;
@@ -438,7 +438,7 @@ static ssize_t store_no_turbo(struct kob
 	return count;
 }
 
-static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
@@ -463,7 +463,7 @@ static ssize_t store_max_perf_pct(struct
 	return count;
 }
 
-static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -203,20 +203,12 @@ __ATTR(_name, _perm, show_##_name, NULL)
 static struct freq_attr _name =			\
 __ATTR(_name, 0644, show_##_name, store_##_name)
 
-struct global_attr {
-	struct attribute attr;
-	ssize_t (*show)(struct kobject *kobj,
-			struct attribute *attr, char *buf);
-	ssize_t (*store)(struct kobject *a, struct attribute *b,
-			 const char *c, size_t count);
-};
-
 #define define_one_global_ro(_name)		\
-static struct global_attr _name =		\
+static struct kobj_attribute _name =		\
 __ATTR(_name, 0444, show_##_name, NULL)
 
 #define define_one_global_rw(_name)		\
-static struct global_attr _name =		\
+static struct kobj_attribute _name =		\
 __ATTR(_name, 0644, show_##_name, store_##_name)
 
 


