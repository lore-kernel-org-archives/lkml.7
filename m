Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F127C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DB92171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUlwrKA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbfETNyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:54:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44800 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390239AbfETNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:54:07 -0400
Received: by mail-io1-f65.google.com with SMTP id f22so11033133iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+Jpk+XthHVG0qFI+gAyJW+786CYrgpLqGw1dG639sc=;
        b=kUlwrKA6Jg9T6clWLPJgeGUuaE9PZk89mqOd9MnvQdrLTvEBvGPK+iniaIoOUfuyIn
         QXoEpsQP3UrMYBN3jNm4JMiGQwiLHjLiNqoSubqfzcWS9J3nMo+Hq8ev5PXyG69DjXHV
         fcIxJ3nHRXB+WfFuhNsCaJL9aSPf0Y5+wQgDHH6x1REzX40cC8jtntFcuHXQBst6HXIF
         VDgfxkjCCr4/AKfVplJelzBYtiIe0RoYpR9mfu99YYKNYe5yJMuUIkEaZC6dft8Z3as9
         urvLde/3DeJRDV2EZz67QkJ6chBk0YkJGVMrr0UIEB3gNKwPmIuzAloPUTyWXsOgD/2k
         U3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+Jpk+XthHVG0qFI+gAyJW+786CYrgpLqGw1dG639sc=;
        b=UUnUqOg0vhUu/cnZmaRtacYnaZhPfSTTURJa7F5fw55JVLS25cMaAu45z5w7EIs02x
         EPNBUoO4dp/HFU6aAvf0dJArMlep2Mta9cJI7lFu8Kweqef6ONbz2IHW2d61LU+p8wTH
         xSyemC45jQPufqfVzdI4dbT4eJfRKbGjiVzTmBm016uCO00W32MrnFkkR32abkQZN8HO
         o+qfEip5K1Z88/ArBFMLs9zf2alCaVYje3dhvRsFe2lbtwALIsmdiL4qtGQl2KXGosur
         A12L1HV2Nn8K1dQlLBmlZPMTvgE9c7ecJbwP4PJ+7jk4WStrd+c50b8EzQ4mvSqLKkj+
         W6OA==
X-Gm-Message-State: APjAAAWDfbvOPFojqS2qcRcgCEh3Yu/BxCwv3rkGHOMukFtOayvhWJr4
        MhaYfyNOf94KQUDw++f3Eqlxfg==
X-Google-Smtp-Source: APXvYqwdkj2XNTZy7A/BcMrnQZOHJaq1jEZ10NGzfy1RdztnJ5TzENVJ8ePAl4JCjYVq+ttbEYBKKA==
X-Received: by 2002:a5e:a71a:: with SMTP id b26mr12962200iod.95.1558360446575;
        Mon, 20 May 2019 06:54:06 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id n17sm6581185ioa.0.2019.05.20.06.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 06:54:06 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     arnd@arndb.de, subashab@codeaurora.org, david.brown@linaro.org,
        agross@kernel.org, davem@davemloft.net
Cc:     bjorn.andersson@linaro.org, ilias.apalodimas@linaro.org,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum trailer
Date:   Mon, 20 May 2019 08:53:51 -0500
Message-Id: <20190520135354.18628-6-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520135354.18628-1-elder@linaro.org>
References: <20190520135354.18628-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of C bit-fields in the rmnet_map_dl_csum_trailer
structure with a single integral field, using field masks to
encode or get at sub-field values.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h      | 6 ++++--
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index f3231c26badd..fb1cdb4ec41f 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -51,13 +51,15 @@ struct rmnet_map_header {
 
 struct rmnet_map_dl_csum_trailer {
 	u8  reserved1;
-	u8  valid:1;
-	u8  reserved2:7;
+	u8  flags;		/* RMNET_MAP_DL_* */
 	u16 csum_start_offset;
 	u16 csum_length;
 	__be16 csum_value;
 } __aligned(1);
 
+#define RMNET_MAP_DL_CSUM_VALID_FMASK	GENMASK(0, 0)
+#define RMNET_MAP_DL_RESERVED_FMASK	GENMASK(7, 1)
+
 struct rmnet_map_ul_csum_header {
 	__be16 csum_start_offset;
 	__be16 csum_info;	/* RMNET_MAP_UL_* */
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 72b64114505a..a95111cdcd29 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -362,7 +362,7 @@ int rmnet_map_checksum_downlink_packet(struct sk_buff *skb, u16 len)
 
 	csum_trailer = (struct rmnet_map_dl_csum_trailer *)(skb->data + len);
 
-	if (!csum_trailer->valid) {
+	if (!u8_get_bits(csum_trailer->flags, RMNET_MAP_DL_CSUM_VALID_FMASK)) {
 		priv->stats.csum_valid_unset++;
 		return -EINVAL;
 	}
-- 
2.20.1

