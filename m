Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608D4C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0D426F5D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Exrmzr0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfFCSe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:34:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44912 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfFCSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so2277013pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nb+PgCRBJxop3uf8r602eq6y1vRy3WUbzAXUz/wfEs8=;
        b=Exrmzr0Pv/rn0cesaXFdN43DSBj2vNYxvfrY407IBv+l8PAtUViJ4o5BsGkSd8hC1e
         dAXXdBgfcyfXEF2tE1H04cZ3qv0MBzYhXVTP3RDpCW8LxKcV9D3VTTiTQPpKPO/guJpF
         ATlu/13n9et54oqDsAQD54G0uDMLDZCKGG29Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nb+PgCRBJxop3uf8r602eq6y1vRy3WUbzAXUz/wfEs8=;
        b=hUaMZfoztcW9VeleC5nqx+fTMvpGxmz7PRe0FgnT4CI5dl0j2SDvhSZ0r3LD6rk2I+
         f9XURC+yVTwln19zM7Hy2asdnrs+Em2ywFAPsbHxNJ2BnSuqMf2TC/BQxWNOyzUqAOYB
         gEUDpDpAf/DsFgxUhyKjxnaFP29/0AUui917kz9Z8mCe7T3wUTdlBnuMJ+KeTWowcwJ8
         wdT+OCOYeMoB/uWy0k+Lx4nLojIj+10Z5mAePFufZbBU1aM4HJSGEF+aI7MA0evIRfU8
         3jnRhF/aSs6BDKk25fGrCq6oiwZHpMnSKU+0JBEBuCSivcEO8gWDBzyIoMZKzcTWOuN1
         0ztg==
X-Gm-Message-State: APjAAAWP4NDdjx/kR11xX44Ts9e5/8BE/c5z5ddIPmC17q+izRlr65xN
        hWfZTmA736yAeyIJGHA48G2BLQ==
X-Google-Smtp-Source: APXvYqzg2GsQdPQCqzTAsGUqBYg9mmxxW5ZwdJcwGOJjC1wRZk/Qg4qCH7oPmmhSJS7pMvVSqynP6A==
X-Received: by 2002:a17:90a:af8a:: with SMTP id w10mr32552517pjq.132.1559586878476;
        Mon, 03 Jun 2019 11:34:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j22sm21415275pfn.121.2019.06.03.11.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 20/30] mfd: cros_ec: Add API for keyboard testing
Date:   Mon,  3 Jun 2019 11:33:51 -0700
Message-Id: <20190603183401.151408-21-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command to allow keyboard testing in factory.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index e05cdcb12481..cc054a0a4c4c 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3142,6 +3142,17 @@ struct ec_params_mkbp_simulate_key {
 	uint8_t pressed;
 } __ec_align1;
 
+#define EC_CMD_GET_KEYBOARD_ID 0x0063
+
+struct ec_response_keyboard_id {
+	uint32_t keyboard_id;
+} __ec_align4;
+
+enum keyboard_id {
+	KEYBOARD_ID_UNSUPPORTED = 0,
+	KEYBOARD_ID_UNREADABLE = 0xffffffff,
+};
+
 /* Configure keyboard scanning */
 #define EC_CMD_MKBP_SET_CONFIG 0x0064
 #define EC_CMD_MKBP_GET_CONFIG 0x0065
@@ -3390,6 +3401,13 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
 
+/* Run keyboard factory test scanning */
+#define EC_CMD_KEYBOARD_FACTORY_TEST 0x0068
+
+struct ec_response_keyboard_factory_test {
+	uint16_t shorted;	/* Keyboard pins are shorted */
+} __ec_align2;
+
 /* Fingerprint events in 'fp_events' for EC_MKBP_EVENT_FINGERPRINT */
 #define EC_MKBP_FP_RAW_EVENT(fp_events) ((fp_events) & 0x00FFFFFF)
 #define EC_MKBP_FP_ERRCODE(fp_events)   ((fp_events) & 0x0000000F)
-- 
2.21.0.1020.gf2820cf01a-goog

