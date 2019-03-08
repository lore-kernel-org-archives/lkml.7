Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D8B2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049616;
	bh=8BIM5txYh0hQpTGXMdpLDc/FJYhbwLA9xy1Gb91XfFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A5zs/dDAc+4hJ+zlFwtxk9vgntPUACXRPuhHMm3lkD7VRBcIOxl+ljS3OS+gOR9Eb
	 ov67MRFY+e+kh69Gh4hmqV36x9IPSNgnAgm3JO/rdxdythRQnw+Ry6ncqr0axjWoch
	 MEgr71QGpsOuSYy9yWcJr1KYAp5wnME6vUeIXMs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfCHMxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfCHMxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C772085A;
        Fri,  8 Mar 2019 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049610;
        bh=8BIM5txYh0hQpTGXMdpLDc/FJYhbwLA9xy1Gb91XfFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/qg0dL5PF78oyxebx2FByQ5G6j8sAK3T6mudt+y25bMOPWVyzfGwN0pnt8BXaTXd
         e97R+O2Zb7ijQ6WaPzWtQ+NOU8gP1kstaxNGsSH9YC8iB2+GoaBZmCsB1s/U6F7d0a
         U0iSkSm2Eqb0IWvgQR9clGR/6AsvCE2X7BzOMAjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Donghee Han <dh.han@samsung.com>,
        Sangkyu Kim <skwith.kim@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.20 01/76] cpufreq: Use struct kobj_attribute instead of struct global_attr
Date:   Fri,  8 Mar 2019 13:49:13 +0100
Message-Id: <20190308124914.844414523@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/cpufreq/cpufreq.c      |    6 +++---
 drivers/cpufreq/intel_pstate.c |   23 ++++++++++++-----------
 include/linux/cpufreq.h        |   12 ++----------
 3 files changed, 17 insertions(+), 24 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -545,13 +545,13 @@ EXPORT_SYMBOL_GPL(cpufreq_policy_transit
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
 
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -873,7 +873,7 @@ static void intel_pstate_update_policies
 /************************** sysfs begin ************************/
 #define show_one(file_name, object)					\
 	static ssize_t show_##file_name					\
-	(struct kobject *kobj, struct attribute *attr, char *buf)	\
+	(struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
 	{								\
 		return sprintf(buf, "%u\n", global.object);		\
 	}
@@ -882,7 +882,7 @@ static ssize_t intel_pstate_show_status(
 static int intel_pstate_update_status(const char *buf, size_t size);
 
 static ssize_t show_status(struct kobject *kobj,
-			   struct attribute *attr, char *buf)
+			   struct kobj_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -893,7 +893,7 @@ static ssize_t show_status(struct kobjec
 	return ret;
 }
 
-static ssize_t store_status(struct kobject *a, struct attribute *b,
+static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
 			    const char *buf, size_t count)
 {
 	char *p = memchr(buf, '\n', count);
@@ -907,7 +907,7 @@ static ssize_t store_status(struct kobje
 }
 
 static ssize_t show_turbo_pct(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total, no_turbo, turbo_pct;
@@ -933,7 +933,7 @@ static ssize_t show_turbo_pct(struct kob
 }
 
 static ssize_t show_num_pstates(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total;
@@ -954,7 +954,7 @@ static ssize_t show_num_pstates(struct k
 }
 
 static ssize_t show_no_turbo(struct kobject *kobj,
-			     struct attribute *attr, char *buf)
+			     struct kobj_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -976,7 +976,7 @@ static ssize_t show_no_turbo(struct kobj
 	return ret;
 }
 
-static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
+static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 			      const char *buf, size_t count)
 {
 	unsigned int input;
@@ -1023,7 +1023,7 @@ static ssize_t store_no_turbo(struct kob
 	return count;
 }
 
-static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
@@ -1053,7 +1053,7 @@ static ssize_t store_max_perf_pct(struct
 	return count;
 }
 
-static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
@@ -1085,12 +1085,13 @@ static ssize_t store_min_perf_pct(struct
 }
 
 static ssize_t show_hwp_dynamic_boost(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%u\n", hwp_boost);
 }
 
-static ssize_t store_hwp_dynamic_boost(struct kobject *a, struct attribute *b,
+static ssize_t store_hwp_dynamic_boost(struct kobject *a,
+				       struct kobj_attribute *b,
 				       const char *buf, size_t count)
 {
 	unsigned int input;
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -254,20 +254,12 @@ __ATTR(_name, 0644, show_##_name, store_
 static struct freq_attr _name =			\
 __ATTR(_name, 0200, NULL, store_##_name)
 
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
 
 


