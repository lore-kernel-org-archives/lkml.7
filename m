Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC6EC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919F0218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDNTcnPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfKGUq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:46:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33430 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGUq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:46:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id d6so2280800lfc.0;
        Thu, 07 Nov 2019 12:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRPY2QI7LGnP1fwI1XGEjgN8hS6ZNhTh7sEjWEKqz3M=;
        b=JDNTcnPLIR3fsbrNqa6N8UdbU5UJ06+eIb46PaBZElxxZJ8daq2JSQIPXF9wjccjKr
         Lv7909Hj0a3WPsRP6EBc4FSkoe1R9eSdVUghC6Dm1KAFXKTYk6vkkSPAPBGwLqpjHxWr
         Jj3sfxBbyJxGFDdM2BBUzKHAzy4X+VApms/gx/DVLH6ggX0jq3HJjKDn9vsQFCJ7aZ1X
         4WUfIcIWwaCXpNy7DzyQGjhImgZKIcGd82TGA01cmFLUuOB8bD6nYbh4fwT8qg/jhavo
         RJCMMR7+tc4dcMR/udColJ0eDoTN7zJCszjrr+emx/wnH9nwuTUU47QYNSCBZmZ53ztQ
         zpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRPY2QI7LGnP1fwI1XGEjgN8hS6ZNhTh7sEjWEKqz3M=;
        b=O0N3cQnDsEiRdc7z70giWuyXGy6AHx8Jwoyichl22eqfkAwvWmIRz/JQzqDGT6zYrf
         Awwu3gKYJfWNlMojYeDEc7yiaVYLgLfHcv79ODRj4qsrX+w4x7RdBZGiMO+eZx5tb3C/
         q0DzjcfElvXqpKIDPDNXIU05+nPtlW6IEj2ve+B6EsLqTvp0TzATOn6gB0HT3W/2zKn4
         uGTnIgBrttku3fJyHAqidO1mRYfsCZ7R8Ulnc2Ae4ydkNa3IN0c6HGNcSksjPfgTEIxi
         AUxublkEGplWwcDbaQhDGGqG9VBivfwz4YKSY4ZvFhA2wpAHIiFU5X77igAhaL93h4lm
         zCIA==
X-Gm-Message-State: APjAAAXKEKiSrnebzc421TnwHvz+RTm3opEcy6xu9CF1+69Q8o2ACtc6
        z8inYdcJ6ddIy2wJoloOZcQ=
X-Google-Smtp-Source: APXvYqx+X9FSowYO/oLK/7eoF1bHHGrqtHJqTZvVurYmumhD/sMFQJXLVI+wyUbSqo58WGBDXL/LDA==
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr3947997lfi.70.1573159615527;
        Thu, 07 Nov 2019 12:46:55 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id g26sm1419323lfh.1.2019.11.07.12.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:46:54 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     megous@megous.com
Cc:     arnd@arndb.de, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, icenowy@aosc.io, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, mark.rutland@arm.com,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        robh+dt@kernel.org, tglx@linutronix.de, wens@csie.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] phy: allwinner: Fix GENMASK misuse
Date:   Thu,  7 Nov 2019 21:46:45 +0100
Message-Id: <20191107204645.13739-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191020134229.1216351-3-megous@megous.com>
References: <20191020134229.1216351-3-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments are supposed to be ordered high then low.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Spotted while trying to add compile time checks of GENMASK arguments.
Patch has only been compile tested.

 drivers/phy/allwinner/phy-sun50i-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
index 1169f3e83a6f..b1c04f71a31d 100644
--- a/drivers/phy/allwinner/phy-sun50i-usb3.c
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -49,7 +49,7 @@
 #define SUNXI_LOS_BIAS(n)		((n) << 3)
 #define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
 #define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
-#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
+#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(2, 0)
 
 struct sun50i_usb3_phy {
 	struct phy *phy;
-- 
2.24.0

