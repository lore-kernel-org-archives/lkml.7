Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF5C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F89A217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKj2Cgfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfEIVOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34297 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfEIVOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so1964700pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7P5q4QlYjlB1PoaalbGvh8L1Fqv8yMUpPNP9xHcgwI=;
        b=mKj2Cgfps3G1zkXLP/TIIcygJDNMHzTg6Im1Me8vkc9Tt/pT5I3JuoMevxlhdjlXaP
         vlcQwc3KzzYMSbUXV9An0OBLQ9UIyV07iY9hhxhJV2UqDrw0rS16/AoF0aF59mU0dUKA
         y56TmbTurVjtUNNP1jvaKkxMZAUfZRLEwQHHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7P5q4QlYjlB1PoaalbGvh8L1Fqv8yMUpPNP9xHcgwI=;
        b=s+x4zLBeXfCAP+5kgE6ggBExbtMkLPW0rmbJF4of8W8P5NF0JfRjnZxn0QEZUZJk6w
         FSBM3+wPSPaTFjcfirEEpmqfr53EUGHH9lLAemQ98ght/oU3dVqtfRs59kGiD65pfJbG
         UuitweQ26w2mZDpm1YGlAs/BU32qjkU29v1J7mlFxfviRTq2+7BI++zDZovdb2D9Dk8R
         JmhNm1LK/ew8U8MCx0k0690qP3z3V9+pfLRz7k8syYtJ8OuQAmyYJHmDxmK4byjZbXdF
         6sS/lFk2mlT9dM9XcFjRG76LeKSSBOs62LYUzZXmHF8nt7NQjay2qmWta5aWcgCtbatl
         /SDw==
X-Gm-Message-State: APjAAAUICp9FCL5lqYAlqs4pWmWm822mrGErL6KrDq9RACdO58GTMbzt
        lUWGFcl/E8UcFkMa6FZwrYd7jg==
X-Google-Smtp-Source: APXvYqxsq242WuHcF8/Wt0+0fgOWnGWASQJ3tDGCiBrsZLC4ZM6LkVI2F+ZEyqL/TfDx1mm8LexPxQ==
X-Received: by 2002:a63:b706:: with SMTP id t6mr2570714pgf.305.1557436445625;
        Thu, 09 May 2019 14:14:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p2sm5140870pfi.73.2019.05.09.14.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:04 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 02/30] mfd: cros_ec: Zero BUILD_ macro
Date:   Thu,  9 May 2019 14:13:25 -0700
Message-Id: <20190509211353.213194-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined out build macro used when compiling embedded controller
firmware.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 48292d449921..7b8fac4d0c89 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -13,6 +13,11 @@
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
+
+
+
+#define BUILD_ASSERT(_cond)
+
 /*
  * Current version of this protocol
  *
-- 
2.21.0.1020.gf2820cf01a-goog

