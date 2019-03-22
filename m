Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A853218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfCVNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:40:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfCVNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:40:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MDeK1c599385
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 06:40:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MDeKP1599382;
        Fri, 22 Mar 2019 06:40:20 -0700
Date:   Fri, 22 Mar 2019 06:40:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-77dcc6233e0def71e104d728ab5a39c2fca51127@git.kernel.org>
Cc:     kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        johannes@sipsolutions.net, tglx@linutronix.de, mingo@kernel.org,
        anna-maria@linutronix.de, hpa@zytor.com, bigeasy@linutronix.de,
        davem@davemloft.net
Reply-To: johannes@sipsolutions.net, kvalo@codeaurora.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, anna-maria@linutronix.de,
          davem@davemloft.net, bigeasy@linutronix.de
In-Reply-To: <20190301224821.29843-2-bigeasy@linutronix.de>
References: <20190301224821.29843-2-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] mac80211_hwsim: Replace hrtimer tasklet with
 softirq hrtimer
Git-Commit-ID: 77dcc6233e0def71e104d728ab5a39c2fca51127
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  77dcc6233e0def71e104d728ab5a39c2fca51127
Gitweb:     https://git.kernel.org/tip/77dcc6233e0def71e104d728ab5a39c2fca51127
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 1 Mar 2019 23:48:19 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 14:35:30 +0100

mac80211_hwsim: Replace hrtimer tasklet with softirq hrtimer

Switch the timer to HRTIMER_MODE_REL_SOFT, which executed the timer callback in
softirq context and remove the hrtimer_tasklet.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@codeaurora.org>
Link: https://lkml.kernel.org/r/20190301224821.29843-2-bigeasy@linutronix.de

---
 drivers/net/wireless/mac80211_hwsim.c | 46 ++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 0838af04d681..2a407a71bcd1 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -521,7 +521,7 @@ struct mac80211_hwsim_data {
 	unsigned int rx_filter;
 	bool started, idle, scanning;
 	struct mutex mutex;
-	struct tasklet_hrtimer beacon_timer;
+	struct hrtimer beacon_timer;
 	enum ps_mode {
 		PS_DISABLED, PS_ENABLED, PS_AUTO_POLL, PS_MANUAL_POLL
 	} ps;
@@ -1460,7 +1460,7 @@ static void mac80211_hwsim_stop(struct ieee80211_hw *hw)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	data->started = false;
-	tasklet_hrtimer_cancel(&data->beacon_timer);
+	hrtimer_cancel(&data->beacon_timer);
 	wiphy_dbg(hw->wiphy, "%s\n", __func__);
 }
 
@@ -1583,14 +1583,12 @@ static enum hrtimer_restart
 mac80211_hwsim_beacon(struct hrtimer *timer)
 {
 	struct mac80211_hwsim_data *data =
-		container_of(timer, struct mac80211_hwsim_data,
-			     beacon_timer.timer);
+		container_of(timer, struct mac80211_hwsim_data, beacon_timer);
 	struct ieee80211_hw *hw = data->hw;
 	u64 bcn_int = data->beacon_int;
-	ktime_t next_bcn;
 
 	if (!data->started)
-		goto out;
+		return HRTIMER_NORESTART;
 
 	ieee80211_iterate_active_interfaces_atomic(
 		hw, IEEE80211_IFACE_ITER_NORMAL,
@@ -1601,12 +1599,9 @@ mac80211_hwsim_beacon(struct hrtimer *timer)
 		bcn_int -= data->bcn_delta;
 		data->bcn_delta = 0;
 	}
-
-	next_bcn = ktime_add(hrtimer_get_expires(timer),
-			     ns_to_ktime(bcn_int * 1000));
-	tasklet_hrtimer_start(&data->beacon_timer, next_bcn, HRTIMER_MODE_ABS);
-out:
-	return HRTIMER_NORESTART;
+	hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
+			ns_to_ktime(bcn_int * NSEC_PER_USEC));
+	return HRTIMER_RESTART;
 }
 
 static const char * const hwsim_chanwidths[] = {
@@ -1680,15 +1675,15 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, u32 changed)
 	mutex_unlock(&data->mutex);
 
 	if (!data->started || !data->beacon_int)
-		tasklet_hrtimer_cancel(&data->beacon_timer);
-	else if (!hrtimer_is_queued(&data->beacon_timer.timer)) {
+		hrtimer_cancel(&data->beacon_timer);
+	else if (!hrtimer_is_queued(&data->beacon_timer)) {
 		u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
 		u32 bcn_int = data->beacon_int;
 		u64 until_tbtt = bcn_int - do_div(tsf, bcn_int);
 
-		tasklet_hrtimer_start(&data->beacon_timer,
-				      ns_to_ktime(until_tbtt * 1000),
-				      HRTIMER_MODE_REL);
+		hrtimer_start(&data->beacon_timer,
+			      ns_to_ktime(until_tbtt * NSEC_PER_USEC),
+			      HRTIMER_MODE_REL_SOFT);
 	}
 
 	return 0;
@@ -1751,7 +1746,7 @@ static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
 			  info->enable_beacon, info->beacon_int);
 		vp->bcn_en = info->enable_beacon;
 		if (data->started &&
-		    !hrtimer_is_queued(&data->beacon_timer.timer) &&
+		    !hrtimer_is_queued(&data->beacon_timer) &&
 		    info->enable_beacon) {
 			u64 tsf, until_tbtt;
 			u32 bcn_int;
@@ -1759,9 +1754,10 @@ static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
 			tsf = mac80211_hwsim_get_tsf(hw, vif);
 			bcn_int = data->beacon_int;
 			until_tbtt = bcn_int - do_div(tsf, bcn_int);
-			tasklet_hrtimer_start(&data->beacon_timer,
-					      ns_to_ktime(until_tbtt * 1000),
-					      HRTIMER_MODE_REL);
+
+			hrtimer_start(&data->beacon_timer,
+				      ns_to_ktime(until_tbtt * NSEC_PER_USEC),
+				      HRTIMER_MODE_REL_SOFT);
 		} else if (!info->enable_beacon) {
 			unsigned int count = 0;
 			ieee80211_iterate_active_interfaces_atomic(
@@ -1770,7 +1766,7 @@ static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
 			wiphy_dbg(hw->wiphy, "  beaconing vifs remaining: %u",
 				  count);
 			if (count == 0) {
-				tasklet_hrtimer_cancel(&data->beacon_timer);
+				hrtimer_cancel(&data->beacon_timer);
 				data->beacon_int = 0;
 			}
 		}
@@ -2922,9 +2918,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 
-	tasklet_hrtimer_init(&data->beacon_timer,
-			     mac80211_hwsim_beacon,
-			     CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&data->beacon_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_ABS_SOFT);
+	data->beacon_timer.function = mac80211_hwsim_beacon;
 
 	err = ieee80211_register_hw(hw);
 	if (err < 0) {
