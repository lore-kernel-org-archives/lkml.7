Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC63C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845AF208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjb6qcY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfFGI5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:57:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42611 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfFGI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:57:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so1304924wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNrOP9bVL8WzVy3bzvsSNv+Sb0/Lb3pHrKp7Bekeixc=;
        b=cjb6qcY3L1FVfrYmUwzIy0VkpN6BDjsbZZMFOM7FoHLonsrmUhjkR5K67jGdT/lkWQ
         m1EsLAPt0M+2H+zVDZs/xmAU8F+ou6qSKR8SqbxW4h23LzXi4lEyYVM07mXgOTJtlu/D
         mtnJ/5Zrb/7IafTDfAz5E0MsS4lZEia1z/C44kbsJUJS/I6a3EcWI/UE/zvBlAwyvOHH
         /4DeqmVy215xmQj5xX8S+T8mGEnIWgSOVsW2umlRlxMnzNk7tsl74HO4/yR7eNnHVtHa
         IH+l6o/tsfoZ+cR30bMAHIZ6uKQ7O5uF7pDeUVJhIXM+TZUs6oVPoLds/5jRUorn91Ts
         RuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNrOP9bVL8WzVy3bzvsSNv+Sb0/Lb3pHrKp7Bekeixc=;
        b=CanaI5MYQo5jfVKO/J299a04T6JkIrUA5LnL/Cu9xvaj+AZ89okzEnqzCTD179MPvB
         ZnIGGFIkYknc0dwZ6aGYrcsUpA0Ltqp2TE2nsQgXXTrj2A/ZgJryCt4PQxvuEkRk2Mvg
         6nKxwuUv8AxWPJiCc/CytV4iU/hBqMY/v2mdawp1h0qA/eIcTm7w0CS4W2yd7DXNMnKl
         mZpdZeD7oKib/nqR5szsKdxDhW9urwjRgNLCnHJKrVJhgRnfKqN90uBg9ze8ikpyZYU5
         xz2++TMWvsWCuBnOGtGeZ2Jh+g1lzBJROFa3Wtc3pATouwpDvh/hqMklaOS5Ho5OTCaY
         CZzA==
X-Gm-Message-State: APjAAAWiM32qjIoilfQuRw03/xBjSNiGfVlQbTmd+rGdvK4gZu0s8RSq
        v/W80TY2pDJWf2wOfaeM53OcrA==
X-Google-Smtp-Source: APXvYqxbkSa2FvpzRrFhR3bjFZae70/IKTrI88s7YHzN1zi7y0jrxItssV8DEdhia6tZLf+gx9z9OA==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr18944862wrm.55.1559897830398;
        Fri, 07 Jun 2019 01:57:10 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id d10sm2035308wrh.91.2019.06.07.01.57.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 01:57:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 3/6] soundwire: core: define SDW_MAX_PORT
Date:   Fri,  7 Jun 2019 09:56:40 +0100
Message-Id: <20190607085643.932-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SDW_MAX_PORT so that other driver can use it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/soundwire/sdw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index aac68e879fae..80ca997e4e5d 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -36,6 +36,7 @@ struct sdw_slave;
 #define SDW_FRAME_CTRL_BITS		48
 #define SDW_MAX_DEVICES			11
 
+#define SDW_MAX_PORTS	14
 #define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
 
 #define SDW_DAI_ID_RANGE_START		100
-- 
2.21.0

