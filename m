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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A69CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1E721835
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSfm+/fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfJSOH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 10:07:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52678 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfJSOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:07:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so8871750wmh.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzESKhvNCTT5RhFCFcaQxIFkB4Hb29h8Yzywkz7FpuM=;
        b=ZSfm+/fzTL4ZRtIdnUiIR1EvTUPJZO7WwqsR8jUvw3wGgIcIwQOTEjvTWJVI8IcOCk
         +ei9PZnUiNIA+avq6qq7Pl2oZdkxUhn6jfV0qApzlixXh2SAX8YZJjM1PFSwcDD3Em+J
         dV64V4W2ncc4XUJL+buTOeLqJIBzaYKrB5jTvp67/Ee2I0l2bgXLY6Wa+RTQipBGEnMQ
         hChNCc3U6+snFJka4AFt90jIV2DEJoHe/MikXtJJoZvOFeeDaYy99uexZAbFgQd4ayrH
         cMJj+zzNS3v3hmmz1ULZo5/KrrsicsjEayg6yM4PYZNeveC3d/QS3FeoVvkBgRzVwjS5
         eA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzESKhvNCTT5RhFCFcaQxIFkB4Hb29h8Yzywkz7FpuM=;
        b=KAkCGka0S7deqDZamJwwbroy742tOmYXNv6RlrccIxLSrWqSE7STTFc6q16yk2AIXm
         dV46WKlrjJ1V5KAorejEMOaFEt8XSuq+kyq+im+yQrxwNQrNU9Foi4KLbDBJ1170tgTy
         4owOPtkfALPAQBiZYBtG+KnKmRTIKhHo1ifkQ8vjKX+wuNtABGwWRNHmm87bKSmxYsce
         6+IeQF5JOvlwpbthtzJTpoi+9K6CDKDsO3EzFK0z+Taj2dhHnYN5Yp6ZhtHQ2SuvaiH/
         l01XFS3oyuPcF05Hv8bk6UvTctowEZ/j47TJ5lTonJACVHMEwNpMPKPLBmp6sv9y3vpq
         euHA==
X-Gm-Message-State: APjAAAVl2MmJI0c9WKNbYEhCc374rTHxTwvQbvBDTGYwm5yCHQoXV5yY
        oRMEA1KgbgzRCWSSIegYrg==
X-Google-Smtp-Source: APXvYqz26o6r1pVSl6JlbZf0CO9bG56M5BlJitbLvwW+UXmYOXO+4vdZpI+Yf8IfkmVVIyBHsNMErw==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr12384486wmg.50.1571494071661;
        Sat, 19 Oct 2019 07:07:51 -0700 (PDT)
Received: from ninjahub.lan (host-92-23-80-57.as13285.net. [92.23.80.57])
        by smtp.googlemail.com with ESMTPSA id t4sm7893080wrm.13.2019.10.19.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 07:07:51 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        jerome.pouiller@silabs.com, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v1 4/5] staging: wfx: correct misspelled words
Date:   Sat, 19 Oct 2019 15:07:18 +0100
Message-Id: <20191019140719.2542-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019140719.2542-1-jbi.octave@gmail.com>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct misspelled words: retrieved and auxiliary.
Issue detected by checkpatch tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/wfx/data_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index 619ab2cac5fc..a02692f3210d 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -32,7 +32,7 @@ static int wfx_get_hw_rate(struct wfx_dev *wdev,
 		}
 		return rate->idx + 14;
 	}
-	// WFx only support 2GHz, else band information should be retreived
+	// WFx only support 2GHz, else band information should be retrieved
 	// from ieee80211_tx_info
 	return wdev->hw->wiphy->bands[NL80211_BAND_2GHZ]->bitrates[rate->idx].hw_value;
 }
@@ -664,7 +664,7 @@ static int wfx_tx_inner(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 	req->ht_tx_parameters = wfx_tx_get_tx_parms(wvif->wdev, tx_info);
 	req->tx_flags.retry_policy_index = wfx_tx_get_rate_id(wvif, tx_info);
 
-	// Auxilliary operations
+	// Auxiliary operations
 	wfx_tx_manage_pm(wvif, hdr, tx_priv, sta);
 	wfx_tx_queue_put(wvif->wdev, &wvif->wdev->tx_queue[queue_id], skb);
 	wfx_bh_request_tx(wvif->wdev);
-- 
2.21.0

