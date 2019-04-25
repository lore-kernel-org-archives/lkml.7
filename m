Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BAFC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B820206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AXvyrbrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfDYPkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:40:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35637 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDYPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:40:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so50560pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9Y7B+CeLYhx3Q0s+6+K+1WBb1zBEwhZDiIr8GtHvto=;
        b=AXvyrbrZwlrD48HT5WD5NUZnt5xXqnZnQNBABQU/t2W7a8lP9YG+5m1l8w+KytSbCw
         /H6lMMo4es7fbOmLfiDyZNiIEtNy4Nbl+L1EAV+CbsuBkSTA42g42GlEUwCcQahQpgss
         /ItIvK9ypHOoO7hJRk7fjTq5LZndyQVZT0/W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9Y7B+CeLYhx3Q0s+6+K+1WBb1zBEwhZDiIr8GtHvto=;
        b=l2zA9gop7HJlcLt5M4J33JT8T9kyEa1ES0FTGyrWNDKGzzYIzb/lY+RR7b58NlyzJY
         pAmabFiSPX8gsMp4RfwsRsIdvPgU7zt4D9PR9hSuLJlz5Iiuqg+uN3r9ewY74umr2TRh
         PQQ9l7QWL9Fi1TYnFhmF67jnCCbKjYT1B9WKQHI8nFZNFNnvwON4Bk17RnuwFYiLBKE+
         RxEEUzqSuQ0o+pnnjENn08ESfzdNDCjfzekw6kYkDGYdv3NzMx4q5DyXd1zHSJRSWyh4
         LcKJnOTLoqyfX0KVEqkra/YIkpnWJcJWc0klv1rTD1AJnvIAPM6BKqzF8nJoCpHCn+3y
         w9FA==
X-Gm-Message-State: APjAAAUK9FbwIhfIlBAmZaDBnuLD2vsKi9Vb2HGVdNtuocI1P6vLni9L
        wzBizNafQjJKddw9YyMKt4cN4OsfLK4=
X-Google-Smtp-Source: APXvYqzQnDnl7mNs9HRmGlyygBTArTSR9rk+i9bJ8k6dviK9WGY2nAvBBtYp0aXc7qqkLpzqfvbg1A==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr33822675pfh.165.1556206846715;
        Thu, 25 Apr 2019 08:40:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j9sm49948689pfc.43.2019.04.25.08.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:40:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        amstan@chromium.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        Randy Li <ayaka@soulik.info>, mka@chromium.org,
        ryandcase@chromium.org, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: Fix phy_reset_work compile error for peripheral-only config
Date:   Thu, 25 Apr 2019 08:40:20 -0700
Message-Id: <20190425154021.4465-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit a0a493835f9a ("usb: dwc2: optionally assert phy reset when
waking up") I added to code that is compiled in both the host and
peripheral configs but it referenced a structure member that I added
to a section that was only there for host or dual-mode configs.  That
led to the compile error:

>> drivers/usb/dwc2/core_intr.c:448:25: error: 'struct dwc2_hsotg' has no member named 'phy_reset_work'

We'll add a little helper function to schedule the work and then we
can have a dummy version of that helper in peripheral-only mode.

Fixes: a0a493835f9a ("usb: dwc2: optionally assert phy reset when waking up")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/usb/dwc2/core.h      | 3 +++
 drivers/usb/dwc2/core_intr.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 6698c7097499..152ac41dfb2d 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1438,6 +1438,8 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg);
 int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg);
 int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg,
 			       int rem_wakeup, int reset);
+static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)
+{ schedule_work(&hsotg->phy_reset_work); }
 #else
 static inline int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg)
 { return 0; }
@@ -1461,6 +1463,7 @@ static inline int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg)
 static inline int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg,
 					     int rem_wakeup, int reset)
 { return 0; }
+static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg) {}
 
 #endif
 
diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 16ff33574116..6af6add3d4c0 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -445,7 +445,7 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 			 * schedule it for later.
 			 */
 			if (hsotg->reset_phy_on_wake)
-				schedule_work(&hsotg->phy_reset_work);
+				dwc2_host_schedule_phy_reset(hsotg);
 
 			mod_timer(&hsotg->wkp_timer,
 				  jiffies + msecs_to_jiffies(71));
-- 
2.21.0.593.g511ec345e18-goog

