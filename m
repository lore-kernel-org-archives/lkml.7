Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFB8C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0D12245B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lXCcNpQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKMJOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:14:25 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32947 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfKMJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:13:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191113091352euoutp02ea0e628df62b6baddf68bc4990dfa7ba~Wrf91hB552229622296euoutp02i
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191113091352euoutp02ea0e628df62b6baddf68bc4990dfa7ba~Wrf91hB552229622296euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573636432;
        bh=2hSYwsWRrAXuVQQ2q56rq82t4/LIFohQQV4E4ogL2q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXCcNpQFMRH/Se9QyO+8MbT+tDgPgNiDkjHAhUSudDlbcRAxhft+K0wrb0p8lCA9c
         yx47DfHLJJxmrJXZ0Ocqc5e/gcUuTWDJERvWxhq1IufZqPbwKxCmxlJX3uOXOb5zcC
         XHj9h09YVEcGZRRBpou69i4EKqtFLL80t395qiM0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113091352eucas1p1a9bcbb3837a23f4d7707f726deb061cd~Wrf9lPHVq1266712667eucas1p1r;
        Wed, 13 Nov 2019 09:13:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9E.24.04309.059CBCD5; Wed, 13
        Nov 2019 09:13:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113091351eucas1p2f83c221ce94fdea695775e00d5215458~Wrf9UUWKf2780427804eucas1p2M;
        Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113091351eusmtrp28ed5dcd8cf12aecc5e302a572297fa4c~Wrf9TnkE91340513405eusmtrp2T;
        Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-06-5dcbc9502f36
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1C.1A.04166.F49CBCD5; Wed, 13
        Nov 2019 09:13:51 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091351eusmtip19eb2d99482a66f74433152085f7cadc6~Wrf80lxbK0379503795eusmtip1Q;
        Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 2/7] devfreq: protect devfreq stats data with spinlock
Date:   Wed, 13 Nov 2019 10:13:31 +0100
Message-Id: <20191113091336.5218-3-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113091336.5218-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87oBJ0/HGiy5w2OxccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujOMvzrMXLJGpWPduInsD4zbxLkZODgkBE4mG
        C23MXYxcHEICKxgl3l+fyAThfGGUWHj2KZTzmVFi1cnr7DAtv1/sZwOxhQSWM0qsvM0G13H9
        4VuwIjYBfYmDZ0+ygNgiAtISnYsgxjIL/GaS2PpnLyNIQljATeLM2Q3MIDaLgKpER9NasDiv
        gLXEhq79QIM4gLbJS8x5qwES5hSwkVj6cw07RImgxMmZT8DmMwOVNG+dDfaDhMA8don799+x
        QVzqInH7+UMmCFtY4tXxLVAfyEj83zkfKl4u8XRhHztEcwujxIP2jywQCWuJw8cvsoIcwSyg
        KbF+lz5E2FFibs9eqNv4JG68FYS4gU9i0rbpzBBhXomONiGIalWJ56d6oDZJS3T9X8cKUeIh
        8f1w4ARGxVlInpmF5JlZCGsXMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEw+p/8d
        /7KDcdefpEOMAhyMSjy8B+adihViTSwrrsw9xCjBwawkwruj4kSsEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBkaGflWWCWp36/N7XiUsOOSe+mZm+FrV
        t7Zfq2M3Pdd9LnvqvanlajehMqN5vqHnEne/TPXOWGWnlt83x+Yr9/+kiStVzJsM9jS2q61Y
        UjiHdUnKhHfpRyq3dhzy0g26YK4V1vbrymoDfcYHpldY/8xYEFdxppAr6Ksc3xyzcyeEHKfM
        Xj57aoESS3FGoqEWc1FxIgB7M6oKOgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7r+J0/HGuw/bWqxccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jOMvzrMXLJGpWPduInsD4zbxLkZODgkBE4nfL/azdTFycQgJLGWUWHFjNRNE
        Qlqi8TSMLSzx51oXVNEnRolJ+w6xgCTYBPQlDp49CWaLADV0LprIBFLELNDILHHxQBNYt7CA
        m8SZsxuYQWwWAVWJjqa1jCA2r4C1xIau/exdjBxAG+Ql5rzVAAlzCthILP25hh3EFgIqebLh
        LRtEuaDEyZlPwHYxA5U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
        NzECI2XbsZ+bdzBe2hh8iFGAg1GJh/fAvFOxQqyJZcWVuYcYJTiYlUR4d1SciBXiTUmsrEot
        yo8vKs1JLT7EaAr0w0RmKdHkfGAU55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0t
        SC2C6WPi4JRqYPQ3CU7vkaz9LN+uolwdlqsSd8LRPC9T48eigkk1e0S/popvFk56LZkkW7qZ
        ff4EJ96p7/jyNeO2BqtMFonx44+JSOV4Wv9v+6QHWb89fB5d1l75apnN3rvHs4Q02rgPdV+5
        UPrn0FPB7s5/4cqS8iv/Znxk6vuVe+3e2Z02Dhezai8GdJy0VWIpzkg01GIuKk4EAG64pseq
        AgAA
X-CMS-MailID: 20191113091351eucas1p2f83c221ce94fdea695775e00d5215458
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091351eucas1p2f83c221ce94fdea695775e00d5215458
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091351eucas1p2f83c221ce94fdea695775e00d5215458
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091351eucas1p2f83c221ce94fdea695775e00d5215458@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protect access to devfreq transitions stats with spinlock.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 18 +++++++++++++++---
 include/linux/devfreq.h   |  3 +++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1602cca20fc4..ac04b5baef70 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -163,10 +163,16 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	cur_time = get_jiffies_64();
 
 	/* Immediately exit if previous_freq is not initialized yet. */
-	if (!devfreq->previous_freq)
-		goto out;
+	if (!devfreq->previous_freq) {
+		spin_lock(&devfreq->stats_lock);
+		devfreq->last_stat_updated = cur_time;
+		spin_unlock(&devfreq->stats_lock);
+		return 0;
+	}
 
 	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
+
+	spin_lock(&devfreq->stats_lock);
 	if (prev_lev < 0) {
 		ret = prev_lev;
 		goto out;
@@ -174,7 +180,6 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 
 	devfreq->time_in_state[prev_lev] +=
 			 cur_time - devfreq->last_stat_updated;
-
 	lev = devfreq_get_freq_level(devfreq, freq);
 	if (lev < 0) {
 		ret = lev;
@@ -189,6 +194,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 
 out:
 	devfreq->last_stat_updated = cur_time;
+	spin_unlock(&devfreq->stats_lock);
 	return ret;
 }
 EXPORT_SYMBOL(devfreq_update_status);
@@ -478,7 +484,9 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
+	spin_lock(&devfreq->stats_lock);
 	devfreq->last_stat_updated = get_jiffies_64();
+	spin_unlock(&devfreq->stats_lock);
 	devfreq->stop_polling = false;
 
 	if (devfreq->profile->get_cur_freq &&
@@ -707,6 +715,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	devfreq->last_stat_updated = get_jiffies_64();
+	spin_lock_init(&devfreq->stats_lock);
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
@@ -1405,6 +1414,8 @@ static ssize_t trans_stat_show(struct device *dev,
 
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
+
+	spin_lock(&devfreq->stats_lock);
 	for (i = 0; i < max_state; i++)
 		len += sprintf(buf + len, "%10lu",
 				devfreq->profile->freq_table[i]);
@@ -1429,6 +1440,7 @@ static ssize_t trans_stat_show(struct device *dev,
 
 	len += sprintf(buf + len, "Total transition : %u\n",
 					devfreq->total_trans);
+	spin_unlock(&devfreq->stats_lock);
 	return len;
 }
 static DEVICE_ATTR_RO(trans_stat);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index b81a86e47fb9..a344e0be99f3 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -135,6 +135,8 @@ struct devfreq_dev_profile {
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
  * @last_stat_updated:	The last time stat updated
+ * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
+ *			and total_trans used for statistics
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
  *
  * This structure stores the devfreq information for a give device.
@@ -176,6 +178,7 @@ struct devfreq {
 	unsigned int *trans_table;
 	u64 *time_in_state;
 	unsigned long long last_stat_updated;
+	spinlock_t stats_lock;
 
 	struct srcu_notifier_head transition_notifier_list;
 };
-- 
2.24.0

