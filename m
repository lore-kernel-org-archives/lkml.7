Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C0EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBA52067B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzz6eTmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKKLb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:31:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32845 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKLb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:31:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so10566306pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wQ8N+KA4QdswtlAn03t/0lkW6AyogqYP1p+/zebuU3k=;
        b=fzz6eTmnCHSzgfHm+F9KSKSXxf8LVByz/JTIJZO7G2LjaoT0RjN6qPPKdXs+3LL/IA
         1GVailmzDlDeuREvMUxvJ+xqG/CGEEg/pAFDrlchlEIWLIU9SmuxCVgPABW+jGSZ9eW3
         GuQIx32Ab1FQDK5sOCHX8Nns0vGXPw651PQ6ru00m08ZE+7veSa6Ns9sbmwsXcTpWa54
         8Vg6oPZTr4wAwI9IU3GWh1zoOppOwxHmuzBotnjTMZGDIFRv6VAG2T0fCMz2uawbCQCS
         ENr2HN7tWHQ71sJ9yrfyNR8ENxwg7kXrppAFoeHz64zPrHZfmv0HNb/geYRVj+2Bb+sa
         S50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wQ8N+KA4QdswtlAn03t/0lkW6AyogqYP1p+/zebuU3k=;
        b=uKRd/s5VAljjFVR7OFQe1XD3pUx8YO1njwnMgnTJTmN1+vWwpwMLz1ox4R2LBb6HCK
         NApdwMmFdZ9ZCJEkcJ6yvNY80Thd7LyPLKUF0pJdHZkrOpulsaaUbAtuWLkYmpkCOYky
         8I+XtWfaZoPf2DBEZ6NL0GFexhin/H6VMQmd/p7B/i2nKCRy1OpdcATvt3avcn4y3dJE
         +8LCHEtaezNHMvFUXtv1HtQXM4gwZY2pds0mgJrTlo31RwTJuRqkm+VgP5dv1uvyzqrj
         +6sIwjyP6UtoKzm9WJkmMJ1kBiL2lF/mrUn3ffrwR5V5VJjs7LqQ9Ce9sqGbCnacSE9k
         UDog==
X-Gm-Message-State: APjAAAXs0bP3b7J36FYQo0O4RjZHBIf2ip77QWYUIb5FbYeXn51Hy4zf
        o+T1AaYFxX2SVD6kTb0tQKY6Og==
X-Google-Smtp-Source: APXvYqyRN+ytjyasbPOi1n+bkrl3ZY1icxCMoBihsUQ6BVbam4FcrrAYUXBdsKV/iv1gSI0SvP+c+A==
X-Received: by 2002:a63:d916:: with SMTP id r22mr28461215pgg.45.1573471885985;
        Mon, 11 Nov 2019 03:31:25 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id f24sm12918778pjp.12.2019.11.11.03.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 03:31:24 -0800 (PST)
Date:   Mon, 11 Nov 2019 17:01:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static
 OPPs again
Message-ID: <20191111113117.d7jdolfetb24rgmb@vireshk-i7>
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
 <20191018211214.444D32089C@mail.kernel.org>
 <20191021022516.gecunkpahu7okvm5@vireshk-i7>
 <20191028120133.3E85F2086D@mail.kernel.org>
 <CAKohpo=ky8FR4thsuW1xPnZrEW8zgXL0n4e+9rkRE0RLKKk1uQ@mail.gmail.com>
 <20191030143400.1680D20656@mail.kernel.org>
 <20191111082131.ysngb7dfal6fpu2h@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111082131.ysngb7dfal6fpu2h@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-19, 13:51, Viresh Kumar wrote:
> On 30-10-19, 07:33, Stephen Boyd wrote:
> > I agree a simple refcount_t makes more sense here instead of using a
> > kref. That would be clearer.
> 
> I was using kref as I wanted to call the cleanup routine when kref
> reaches 0. A refcount_t will have the same problem as the warning in
> this came from refcount mechanism only (which is used by kref). You
> can't increment a refcount_t if it is zero :)
> 
> Any other suggestions other than local counting ?

i.e. something like this, untested.

---
 drivers/opp/core.c | 26 ++++++++------------------
 drivers/opp/of.c   | 14 +++++---------
 drivers/opp/opp.h  |  6 ++----
 3 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 467b2348a289..ea1d89177511 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -988,7 +988,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
-	kref_init(&opp_table->list_kref);
 
 	/* Secure the device table modification */
 	list_add(&opp_table->node, &opp_tables);
@@ -1076,27 +1075,18 @@ static void _opp_remove_all_static(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp, *tmp;
 
+	mutex_lock(&opp_table->lock);
+
+	if (!opp_table->parsed_static_opps || --opp_table->parsed_static_opps)
+		goto unlock;
+
 	list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
 		if (!opp->dynamic)
 			dev_pm_opp_put(opp);
 	}
 
-	opp_table->parsed_static_opps = false;
-}
-
-static void _opp_table_list_kref_release(struct kref *kref)
-{
-	struct opp_table *opp_table = container_of(kref, struct opp_table,
-						   list_kref);
-
-	_opp_remove_all_static(opp_table);
-	mutex_unlock(&opp_table_lock);
-}
-
-void _put_opp_list_kref(struct opp_table *opp_table)
-{
-	kref_put_mutex(&opp_table->list_kref, _opp_table_list_kref_release,
-		       &opp_table_lock);
+unlock:
+	mutex_unlock(&opp_table->lock);
 }
 
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
@@ -2276,7 +2266,7 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 		return;
 	}
 
-	_put_opp_list_kref(opp_table);
+	_opp_remove_all_static(opp_table);
 
 	/* Drop reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1cbb58240b80..2c433e9f9223 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -658,17 +658,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	struct dev_pm_opp *opp;
 
 	/* OPP table is already initialized for the device */
+	mutex_lock(&opp_table->lock);
 	if (opp_table->parsed_static_opps) {
-		kref_get(&opp_table->list_kref);
+		opp_table->parsed_static_opps++;
+		mutex_unlock(&opp_table->lock);
 		return 0;
 	}
 
-	/*
-	 * Re-initialize list_kref every time we add static OPPs to the OPP
-	 * table as the reference count may be 0 after the last tie static OPPs
-	 * were removed.
-	 */
-	kref_init(&opp_table->list_kref);
+	opp_table->parsed_static_opps = 1;
+	mutex_unlock(&opp_table->lock);
 
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
@@ -701,8 +699,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	if (pstate_count)
 		opp_table->genpd_performance_state = true;
 
-	opp_table->parsed_static_opps = true;
-
 	return 0;
 }
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 51ad942d1b6b..4e69b855a6a0 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -127,11 +127,10 @@ enum opp_table_access {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
  * @kref:	for reference count of the table.
- * @list_kref:	for reference count of the OPP list.
  * @lock:	mutex protecting the opp_list and dev_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
- * @parsed_static_opps: True if OPPs are initialized from DT.
+ * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
@@ -167,7 +166,6 @@ struct opp_table {
 	struct list_head dev_list;
 	struct list_head opp_list;
 	struct kref kref;
-	struct kref list_kref;
 	struct mutex lock;
 
 	struct device_node *np;
@@ -176,7 +174,7 @@ struct opp_table {
 	/* For backward compatibility with v1 bindings */
 	unsigned int voltage_tolerance_v1;
 
-	bool parsed_static_opps;
+	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;

-- 
viresh
