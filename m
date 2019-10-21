Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AC9CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A927E20830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNPXEVPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfJUFF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:05:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36859 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJUFF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:05:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so7010151pgk.3;
        Sun, 20 Oct 2019 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pxy+SjxJxYfLUhAFsu0Nbm4mmirWGbXqhMNfG1rN5fc=;
        b=uNPXEVPOhc7PtyHvjnTOr9Tw37fVORVAovKWrb9mkg1g5++6EKEnlZDnc7iOZJ9eXJ
         jzDVZkD1sFNTDkJPYgvOY2QBJEWbRj45nvsRwXqY3Nlk/vLaZcpjhGVRsW99sHaKGcLW
         GakTy01QtnKQRDi+JMaaxT8Xv2cPE/KnCMB57/fuArbOZ1+D/hNl3w17duJl7njCPF7j
         PeIoqIcRGGdUhP37YmBcbQF/e8G8EBWo0Kmo5iVsDMx2fymFWZMuwduY1J1lz2Vu85GP
         c4WEBsOBYHjiCTk6AQbPZ439y5u7tQ1FP+cVkWPEnpoVQxqeHdJDvLpeDEY8kxbe0opV
         8JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pxy+SjxJxYfLUhAFsu0Nbm4mmirWGbXqhMNfG1rN5fc=;
        b=UUzWmcY0fPVlMAIx5jRuyYA1fZfOErzB2v3w13reHtkiQilgkGPFRHvUiRQIx+8AHi
         LsQYJx58cBbrlHqzALZx6Vrn+5acD4RWmj3gL/3f5FvPLSDUeVs1lDgrmzLjf0LOcjqB
         37yosokuinJv1V4Hxb8f14ozQ3vgvBdBaaLB38IpTu8IX49fe6aMN2yq2evfZ1ETMtD3
         u70clpJyeGLoGFGjYzhp+2e96P7svPWg7/kp8IYAc6HOaZifcILyJdhcAjhDUUbKZZVP
         rHGY8ZnPYeOOYqN7HQI9d1IM0TxPLYdBGwx6BviU3DdN2LWT4Ak+zs8IlqeNA3LgJxy2
         ZCWw==
X-Gm-Message-State: APjAAAWUllt4KCWL8gHbFUJJuM6clDyxyzp8/G2Ru0t4RiRC80qowvap
        5+RHQRUTZQXDlKmDtULSSos=
X-Google-Smtp-Source: APXvYqzkDit0WXzbdvh8WzqFu4bucecX6K6NFb7w5V7MWhpjim8QXFo8+etuqfs/ce9dWcE9Io86Sg==
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr404997pjn.39.1571634353641;
        Sun, 20 Oct 2019 22:05:53 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id 127sm13611191pfy.56.2019.10.20.22.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Oct 2019 22:05:52 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] soc: amlogic: meson-gx-socinfo: Fix S905D3 ID for VIM3L
Date:   Mon, 21 Oct 2019 09:04:55 +0400
Message-Id: <1571634295-20154-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chip on the board is S905D3 not S905X3.

Fixes: 1d7c541b8a5b ("soc: amlogic: meson-gx-socinfo: Add S905X3 ID for VIM3L")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 87ed558..e612dae 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -69,7 +69,7 @@ static const struct meson_gx_package_id {
 	{ "S922X", 0x29, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
 	{ "S905X3", 0x2b, 0x5, 0xf },
-	{ "S905X3", 0x2b, 0xb0, 0xf2 },
+	{ "S905D3", 0x2b, 0xb0, 0xf2 },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
 };
 
-- 
2.7.4

