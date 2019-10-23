Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB68CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30AB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XcUqdG2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392056AbfJWVHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:07:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37352 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391902AbfJWVH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:07:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so12862132pgi.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTdZZnlA7EABBBAHUknV0T6AXSDyE/LhNtrQ1WO3UbI=;
        b=XcUqdG2izYOn+mbHak6wx+UZELo+hDTuO/+fxjKpVKHu0vitTZdRpxSAWCiL288QOM
         Y4sQAcicvH5dezcg14hGy1Asu7I5ifDnXHph8pEEYigQaild/ZOsD1de9jXymX4iAo4U
         YtPkllEHsNkBl1XYV8p60uhU9i8FsE8WCeV/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTdZZnlA7EABBBAHUknV0T6AXSDyE/LhNtrQ1WO3UbI=;
        b=lo1W5f4+BgG19xVw0osCYbSYfiadqDcvJoD0Mpdi8UUYJQ9CXGchjQAJRaSnRXRzQf
         J/GQIHZB9D7zKAXAsm9FrS0Z12fQJvZMshk4tShjzy49dAz4mibGcxPVzqN4jBL0oLAE
         NWn6Z9L3Hq1NkTpsI3rCx9uROJ0r71ZfaFNK82U+4vP07b3yYgJvVL5wwA8vDXItdcVL
         bpNA4LBnJwwTUVXjFkpdVXohYFggwWbTI2pmdZmw6Ni6rafDkBpyb8vvQUK272vcW65u
         jGSw1QkgDxL5DZh792qyWjHrc5ZUn3foHWF16RAgwRswFLsERvPKANqst3Frb3o2Lbi+
         /tOw==
X-Gm-Message-State: APjAAAU0yJMEtN+O3beOr/dTUEV/TxNr8i1l3n3pmOcDbnUQHiPJfqFD
        UiJ+g812wHuYMmdAsiQnmR8xJA==
X-Google-Smtp-Source: APXvYqxIMniSNwAkzc2lHxYvMbXHhVnLpxKHVTcbtv205RmdruWuesi6Yx4Fs/+BBpFofGh5PgQlew==
X-Received: by 2002:a63:3d41:: with SMTP id k62mr11959835pga.129.1571864848131;
        Wed, 23 Oct 2019 14:07:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z12sm26529195pfj.41.2019.10.23.14.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 14:07:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-rockchip@lists.infradead.org, stefan.wahren@i2se.com,
        mka@chromium.org, Alexandru M Stan <amstan@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: dwc2: Fix NULL qh in dwc2_queue_transaction
Date:   Wed, 23 Oct 2019 14:06:31 -0700
Message-Id: <20191023140530.v2.1.I9850aab29e945168070b0a9c50c421d5485e7d97@changeid>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru M Stan <amstan@chromium.org>

When a usb device disconnects in a certain way, dwc2_queue_transaction
still gets called after dwc2_hcd_cleanup_channels.

dwc2_hcd_cleanup_channels does "channel->qh = NULL;" but
dwc2_queue_transaction still wants to dereference qh.
This adds a check for a null qh.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
[dianders: rebased to mainline]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
While testing a newer version of the Linux kernel on rk3288-veyron
devices we saw a bunch of crashes reported in dwc2_queue_transaction()
where chan->qh was NULL [1].  I don't know how to reproduce those
crashes myself, but I noticed that in our 3.14 kernel we had a patch
that probably fixed it.  That patch was sent upstream ages ago [2] but
never landed.  Here I've rebased the patch.  While I haven't
reproduced the crash myself, it seems fairly likely that this will fix
the problem.

[1] https://crbug.com/1017388
[2] https://lore.kernel.org/r/1442952651-4341-2-git-send-email-amstan@chromium.org

Changes in v2:
- Rebased to mainline

 drivers/usb/dwc2/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 81afe553aa66..b90f858af960 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2824,7 +2824,7 @@ static int dwc2_queue_transaction(struct dwc2_hsotg *hsotg,
 		list_move_tail(&chan->split_order_list_entry,
 			       &hsotg->split_order);
 
-	if (hsotg->params.host_dma) {
+	if (hsotg->params.host_dma && chan->qh) {
 		if (hsotg->params.dma_desc_enable) {
 			if (!chan->xfer_started ||
 			    chan->ep_type == USB_ENDPOINT_XFER_ISOC) {
-- 
2.23.0.866.gb869b98d4c-goog

