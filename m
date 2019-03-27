Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F57C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E528221734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUdTcIfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfC0OgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:36:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38221 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfC0Of6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:35:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id a6so11548325lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xqDhXSTUJNklRs7Nsz2EsWlg0IJVd5TtQANghzoIj6Y=;
        b=vUdTcIfazo4TkG+buldam+PhyFFNuDthLSslrkpqwoNrYsu9WlNlKvCd+BtFpo5FYh
         89eb2KqV9okg5JSqhPhLjyra4l3GTxsGzD17RUxkhr+oB4xNyS+EKB9yX1/Vib1G4qjV
         kelNtpBQgdCNT31xGRERRrVn/akwMUFsyT193BRZqUMiOFFEBy4T1lHJLhgAB10PDnkf
         8q0oG8j60vwlTk0DPt+SCObhXi0ferjtdFQkmBy6EIcmEG0VgMXI+JS9ls6pnKl3PgnR
         0pOR0NYNy9SkPTqPIUaMH3BCAe9q6a8sH3awjerhjj642XPPRHMLwUhHddsNk8uq8KKn
         jkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xqDhXSTUJNklRs7Nsz2EsWlg0IJVd5TtQANghzoIj6Y=;
        b=IA+lWEX3tOK2Tn6e/56gVA7D2eYc8bbDZcOjKA1IRuW1tc+/2D6GBpY1bvkK4i5BGD
         1H7puOye0CStveIOtmzn0WvkVJcL25zgaNJ9/S5Si/QwhbdWnHq0waxf5pjt63pM2Jra
         r9uairTdFn0d7asPxOauG7Ko7kNdek/P1vKAwqu7GE6xpwgkxXyGQlSGx2Xf6Bkx/lyG
         DJvO0DUA0bQ170XTw9ByVWhVR/rw6ecLXbd8/ZI8jK1y32JH1fux1fIsxQmVHEsvUUiP
         HBRtxdcT31+0NLzQKXF6zMf32aU9/QjKirpI594v3d11iS5SLNmvj1cKF3YK5/0Yk/ry
         JZfw==
X-Gm-Message-State: APjAAAXNbbsPG6jbOBebQPVzOnb1ZJ1+2lzq5eTG2QSNlxHSjHQtuiVF
        hNR6KovsDcA3PQh5dN8vhFCZGQ==
X-Google-Smtp-Source: APXvYqzEgmGdFWFkPc93PX7NAm6POm61bIL9xLa3T0OreH/UQDLKrqrYmy0xCbUzxhqvX5C9ZJv03g==
X-Received: by 2002:a19:d144:: with SMTP id i65mr17047487lfg.52.1553697356770;
        Wed, 27 Mar 2019 07:35:56 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q2sm4548789lfj.58.2019.03.27.07.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:35:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 1/4] PM / Domains: Add a generic data pointer to the genpd_power_state struct
Date:   Wed, 27 Mar 2019 15:35:45 +0100
Message-Id: <20190327143548.25305-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327143548.25305-1-ulf.hansson@linaro.org>
References: <20190327143548.25305-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add a data pointer to the genpd_power_state struct, to allow a genpd
backend driver to store per state specific data. To introduce the pointer,
we need to change the way genpd deals with freeing of the corresponding
allocated data.

More precisely, let's clarify the responsibility of whom that shall free
the data, by adding a ->free_states() callback to the struct
generic_pm_domain. The one allocating the data shall assign the callback,
to allow genpd to invoke it from genpd_remove().

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v13:
	- None (re-based).

---
 drivers/base/power/domain.c | 12 ++++++++++--
 include/linux/pm_domain.h   |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 96a6dc9d305c..ff6f992f7a1d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1686,6 +1686,12 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
 
+static void genpd_free_default_power_state(struct genpd_power_state *states,
+					   unsigned int state_count)
+{
+	kfree(states);
+}
+
 static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 {
 	struct genpd_power_state *state;
@@ -1696,7 +1702,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 
 	genpd->states = state;
 	genpd->state_count = 1;
-	genpd->free = state;
+	genpd->free_states = genpd_free_default_power_state;
 
 	return 0;
 }
@@ -1812,7 +1818,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
-	kfree(genpd->free);
+	if (genpd->free_states)
+		genpd->free_states(genpd->states, genpd->state_count);
+
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
 	return 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1ed5874bcee0..8e1399231753 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -69,6 +69,7 @@ struct genpd_power_state {
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
+	void *data;
 };
 
 struct genpd_lock_ops;
@@ -110,9 +111,10 @@ struct generic_pm_domain {
 			   struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
 	struct genpd_power_state *states;
+	void (*free_states)(struct genpd_power_state *states,
+			    unsigned int state_count);
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
-	void *free; /* Free the state that was allocated for default */
 	ktime_t on_time;
 	ktime_t accounting_time;
 	const struct genpd_lock_ops *lock_ops;
-- 
2.17.1

