Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A846CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738B7206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YunCs4u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLSUOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:14:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33770 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:14:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so3725674pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 12:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMMywuKwJV2Fexy2EwbBoyvnOBPKk+LIASA6iUC07mI=;
        b=YunCs4u7CukxXe9EO9ONB2QJKoX6JLW5rY2znXc5TyUDA3b93gMAVkvNz4YpTEo+0P
         8nMX0oTvmIxXDrIgnLKaIkrOwDNNNjHzo/ktQ9zhQxzYeEmfwbQw/ytA3jRTArlKnwKg
         Z3Hx4JcP9iGygsFruTtsuZQoCdbKn+XsmXqLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMMywuKwJV2Fexy2EwbBoyvnOBPKk+LIASA6iUC07mI=;
        b=qY+6N0BH5QMS/22XeSvgjMhDcTA+K1TBvKsGN4ahMYl+cBAU+PcBQNAG5v91BU5SsN
         YlxQt9sdHgLIuIPLwpi6usz2OzOgczxsPbiKP+5C1QxVctgOpp57+m6TwrVAxnEeruFs
         ZWEXr/TmAK5pcho23+uFXhc2H4wwduwlfOc3q4iEiFub38sQXKqz/YLGT4vUfYKuhWe+
         QDoPpvYLPaTIRn5haN2gBH6H3EedYWC6TjwnZUwjT/l1aba+fnUTfErQtXP9OOduJau6
         8cT0uVBhAKrzwqo89zndBA5hbuXKyyCdGLL5GLI7wSlvGQWCkaJcQGWuSk82NaW8BlMj
         cDtQ==
X-Gm-Message-State: APjAAAVxBr+Ipk0aLeHrekp/qu8gfJeFcqzW6Kzx8W6eLZZiR6v7Evr/
        GQj3ONFQxMHNPwBqTfoH3rt+QQ==
X-Google-Smtp-Source: APXvYqzPfnZVxVZy+T7up4r02cZsZmvXobrYP5a7Y89yiOyquetil3Eus3cjeDeaj5q2gVrLvKdCww==
X-Received: by 2002:a63:710:: with SMTP id 16mr10869887pgh.58.1576786490437;
        Thu, 19 Dec 2019 12:14:50 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id m101sm7841100pje.13.2019.12.19.12.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:14:50 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
Date:   Thu, 19 Dec 2019 12:13:42 -0800
Message-Id: <20191219201340.196259-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191219201340.196259-1-pmalani@chromium.org>
References: <20191219201340.196259-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
subdevice on non-ACPI platforms.

This driver allows other cros-ec devices to receive PD event
notifications from the Chrome OS Embedded Controller (EC) via a
notification chain.

Change-Id: I4c062d261fa1a504b43b0a0c0a98a661829593b9
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index c4b977a5dd966..1dde480f35b93 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
 static const struct mfd_cell cros_usbpd_charger_cells[] = {
 	{ .name = "cros-usbpd-charger", },
 	{ .name = "cros-usbpd-logger", },
+#ifndef CONFIG_ACPI
+	{ .name = "cros-usbpd-notify", },
+#endif
 };
 
 static const struct cros_feature_to_cells cros_subdevices[] = {
-- 
2.24.1.735.g03f4e72817-goog

