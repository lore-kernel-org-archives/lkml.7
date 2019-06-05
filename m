Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F84BC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471AB206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559771643;
	bh=NI4PAi7U+n7W9+1SuYtLVELE87TLQbUIbXQy7ITF7bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YRfNRhPtb4atfr+fCg9vKyckZvt16NDS1V4CObDVoZPO2V8XEOMhfGejef2UAC8RP
	 3Np7icaOmW47koIFnc7G8Lkx7gqTLeoVW89kDQDEbltjDxHrzSTjo29Oza5aBi9yS+
	 LvBhDkCKucFQ9rpUnMx19AVY0tHUXzbFt+YQD6gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfFEVx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:53:57 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55455 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:53:54 -0400
Received: by mail-it1-f193.google.com with SMTP id i21so5928881ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MFyANsOfT2/dVaaB+yS4Zlbz3DsUe/iLn0n5jQfuhY=;
        b=c/+iPmc5OhjPBTC8fIGFRCsAv5tx4rbBrYosMDKZ8NdpwyG6jN+XuJWOsYqj/42nGI
         Fh9xT4wddK2o/2Z7qvXDX7pK1gLyHS5w7cmoEQGTCpDn40F4WkrLdMrKGI/EYYU4UmiN
         UJxeW6HmsjKDp99T3/4JaO4r86yGjtdQAsEK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MFyANsOfT2/dVaaB+yS4Zlbz3DsUe/iLn0n5jQfuhY=;
        b=DFQYzEFCZ21qQOY7KmIhZPOrc8YMbJUehVh0w8dnnldlO5IQPIKpxdV8YTxZbcMZG5
         F5K5RMsvUA1yjdb+cuCEPO0r+T2oMSYy/y16O/nbVpBHx5DB+WKC1zXUDu+Ed3O5hlqN
         SOGXeXleboL/wfbTbwLGh6WHMj5fy/dhiZbdKhzwB+guX1Ed+z3JWcYtt2AyyLbkWTwl
         Jy/To3EBAJwiNGa8K0YSpvUfiULXQJFA7O3/iwokpI2l20YO2kkKx6g49CL3xE0rQuCw
         mcosiqmZoyZVU09TJOyjKGJoEtABJ0r3bzd+GoHc8BHBnMwa9Vb76X7N2CFOcFWXDN8C
         Wvdw==
X-Gm-Message-State: APjAAAWPSZJH+r7pQxOYwXbOOByMi9HRV/K2aD5MGheHgfYRNJH/iuIm
        jzbfrVJmIe7RMzPKWmE90AuQfg==
X-Google-Smtp-Source: APXvYqxvQbbOCGSd5hhFsnMM4rfLypzKXLxd+LF3XfEkwiqqQQIsrXgSBq3EtDBtpnneODuE0ChWPg==
X-Received: by 2002:a24:4a13:: with SMTP id k19mr28902699itb.5.1559771633929;
        Wed, 05 Jun 2019 14:53:53 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e127sm37484ite.33.2019.06.05.14.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:53:53 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, ezequiel@collabora.com,
        paul.kocialkowski@bootlin.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: v4l2-core: Shifting signed 32-bit value by 31 bits error
Date:   Wed,  5 Jun 2019 15:53:47 -0600
Message-Id: <bac3ee3b10de409b6cdf7286e0e84737e63662ee.1559764506.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1559764506.git.skhan@linuxfoundation.org>
References: <cover.1559764506.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following cppcheck error:

Checking drivers/media/v4l2-core/v4l2-ioctl.c ...
[drivers/media/v4l2-core/v4l2-ioctl.c:1370]: (error) Shifting signed 32-bit value by 31 bits is undefined behaviour

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 6859bdac86fe..333e387bafeb 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1364,7 +1364,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 					(char)((fmt->pixelformat >> 8) & 0x7f),
 					(char)((fmt->pixelformat >> 16) & 0x7f),
 					(char)((fmt->pixelformat >> 24) & 0x7f),
-					(fmt->pixelformat & (1 << 31)) ? "-BE" : "");
+					(fmt->pixelformat & BIT(31)) ? "-BE" : "");
 			break;
 		}
 	}
-- 
2.17.1

