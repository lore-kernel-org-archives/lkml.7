Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6DACA9EAE
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36CE21835
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTlhg+47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJSOH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 10:07:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42067 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfJSOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:07:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so9080331wrw.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4oUvDhII8vHajj9ZiQGmAkvxzCNzCrUqcLrW308wtI8=;
        b=OTlhg+47jcB5gxIcILG5r1UG97FdYGTVDsDnYGGZzjNvG7bjVyaqz7jPqyXCAghaa3
         LPi48tzw2hDyfkJrpTf8k4P0ElQgwXzrX4OReDd0ltxCXyToQTTrF5JXgYNV6PeI0F22
         bx1KPArFHLdDDVfqmRDKt1PTpNa4oC9B7knY+yo2+W9/tFK4PJccfZf4YkRWrGkY7d0P
         FaUflFfKc2jwnPyrE5SAd8sdn7GvQY9m12+tyUbRReLoy1Xt9AbotZtxIhsA02FH6E5g
         M2+ddw4Ev4EMGIF48SQBBFdvJFC6O1cMV/uz6K1IRW3ciuqXsijFtYc2Seyyw3bYBnPD
         70zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4oUvDhII8vHajj9ZiQGmAkvxzCNzCrUqcLrW308wtI8=;
        b=iSCRb8ydhcplgt7bjXcT9Hc7alAlWxm+aDwMEWWXSM+S0O2OVK6iDsGMNj2HyN6NQN
         ALVxO1/KQRaP+Ags6q7sY4wbgdvCanK/gCNbxT25S1YJpoI31P/vAzurmvYM1i8CdEJa
         b5cKMedJgrccO1v6KZZXlnHwhpyLZ3eCiWye1UpcVpyaUD4QrNas4KLT5KNrr+/jH8y8
         Y78IwtTOvY3qz4nEUBphqEAtDFnfMO3rz/PMKEt/DuU2hLXYgkQQ9o+occxFJbkHQeqV
         fj8Gl1Ocw2aaJcljE+867AqlcjF+YgdIZf1sTq5TPwagUDCbiY5mHjO2E8PawN1Iz2Jv
         AYAg==
X-Gm-Message-State: APjAAAUdrj/7pijq4jDo3EbjEOHPGiSe2zR78ssDYgVxK25/mOgD4g9E
        WEIRV6ezwu3hcN70yE3E3Q==
X-Google-Smtp-Source: APXvYqxE4GeJX/ZROGt0CXiJsmc0ZNTDAM07dTSILyQQIQcj3WZUbVCgaiSa15PgD61gFKs78uaSbg==
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr11513756wrq.272.1571494072579;
        Sat, 19 Oct 2019 07:07:52 -0700 (PDT)
Received: from ninjahub.lan (host-92-23-80-57.as13285.net. [92.23.80.57])
        by smtp.googlemail.com with ESMTPSA id t4sm7893080wrm.13.2019.10.19.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 07:07:52 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        jerome.pouiller@silabs.com, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v1 5/5] staging: wfx: fix warnings of alignment should match open parenthesis
Date:   Sat, 19 Oct 2019 15:07:19 +0100
Message-Id: <20191019140719.2542-6-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019140719.2542-1-jbi.octave@gmail.com>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

: Fix warnings of alignment should match open parenthesis.
Issue detected by checkpatch tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/wfx/data_rx.c |  2 +-
 drivers/staging/wfx/data_tx.c |  2 +-
 drivers/staging/wfx/debug.c   | 14 ++++++++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/wfx/data_rx.c b/drivers/staging/wfx/data_rx.c
index 52fb0f255dcd..e7fcce8d0cc4 100644
--- a/drivers/staging/wfx/data_rx.c
+++ b/drivers/staging/wfx/data_rx.c
@@ -77,7 +77,7 @@ static int wfx_drop_encrypt_data(struct wfx_dev *wdev, struct hif_ind_rx *arg, s
 		break;
 	default:
 		dev_err(wdev->dev, "unknown encryption type %d\n",
-			 arg->rx_flags.encryp);
+			arg->rx_flags.encryp);
 		return -EIO;
 	}
 
diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index a02692f3210d..ea4205ac2149 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -40,7 +40,7 @@ static int wfx_get_hw_rate(struct wfx_dev *wdev,
 /* TX policy cache implementation */
 
 static void wfx_tx_policy_build(struct wfx_vif *wvif, struct tx_policy *policy,
-			    struct ieee80211_tx_rate *rates)
+				struct ieee80211_tx_rate *rates)
 {
 	int i;
 	size_t count;
diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
index 761ad9b4f27e..0a9ca109039c 100644
--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -141,10 +141,11 @@ static int wfx_rx_stats_show(struct seq_file *seq, void *v)
 	mutex_lock(&wdev->rx_stats_lock);
 	seq_printf(seq, "Timestamp: %dus\n", st->date);
 	seq_printf(seq, "Low power clock: frequency %uHz, external %s\n",
-		st->pwr_clk_freq,
-		st->is_ext_pwr_clk ? "yes" : "no");
-	seq_printf(seq, "Num. of frames: %d, PER (x10e4): %d, Throughput: %dKbps/s\n",
-		st->nb_rx_frame, st->per_total, st->throughput);
+		   st->pwr_clk_freq,
+		   st->is_ext_pwr_clk ? "yes" : "no");
+	seq_printf(seq,
+		   "N. of frames: %d, PER (x10e4): %d, Throughput: %dKbps/s\n",
+		   st->nb_rx_frame, st->per_total, st->throughput);
 	seq_puts(seq, "       Num. of      PER     RSSI      SNR      CFO\n");
 	seq_puts(seq, "        frames  (x10e4)    (dBm)     (dB)    (kHz)\n");
 	for (i = 0; i < ARRAY_SIZE(channel_names); i++) {
@@ -160,8 +161,9 @@ static int wfx_rx_stats_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(wfx_rx_stats);
 
-static ssize_t wfx_send_pds_write(struct file *file, const char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t wfx_send_pds_write(struct file *file,
+				  const char __user *user_buf,
+				  size_t count, loff_t *ppos)
 {
 	struct wfx_dev *wdev = file->private_data;
 	char *buf;
-- 
2.21.0

