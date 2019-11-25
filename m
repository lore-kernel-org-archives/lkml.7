Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84416C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADB12068E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vf4Q7/Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfKYLDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:03:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42087 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKYLDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:03:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id s5so7193455pfh.9;
        Mon, 25 Nov 2019 03:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YX9FYnMnEjEQyU0MsRPNoHp7QHzcj1gPPp8hGQZZD8o=;
        b=vf4Q7/NaNY58UBG9BItjs21OJst+8aWtW8RFu7ON1rEqr3i6r2P94LwYRrsHkj4Swy
         5Y5Mgg3qYChBAqN7nnIGc+ptKqKRtTfB5H9pRO8X/kfNDRZFqdQTf0l98epHbTupoKSj
         qxbrb+nXMxECET4JJlGa0CBOp/p7RRc6C2cVWlTbZK4mPdMhqRcr0I8ghWqSXesjpFhX
         rtKIikC1a8SonSzM/DnBwy2rfW/Ch2QXdDY5XledJs5boQW3kK2iqevQRUFMVl2BbNAw
         FwdDSnty1u2Sj/v+n+GSs/r8QwTnEq8Hl6OS15QyFooNINDO5woN+N4+YgBNNUh7jAjV
         VfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YX9FYnMnEjEQyU0MsRPNoHp7QHzcj1gPPp8hGQZZD8o=;
        b=YPbmKNUzhOMGHiaGc4XvGA2XvpRVVUDaz4iDRJkqNf6sKHBxfxLpcxKQgDdPSRwi6C
         C3PxstICCxXfJLXPSl/ixCyaFmvcWax0Z/wC7POlwq6S09U1x+IPqGHvlXdZBD0e1jYG
         5M35t0zEyhzIGXjFvYbulWt4INWsNFkiDUynPQOd5Y2hCcWgIL+5c+N+BeJAdb/3nJqg
         fg8nM2w91F/Bnbwub8K3KIkafQbPBcxy52ZRxo9XfG8km2UI14Hc4a72a5XaR+19gt3w
         B6ymLI0q+11jlp80zcgROpe5NaoddWfe8PL/feOCD/PBnLbZz+TdeICHX/QtgDzTc4v2
         ZMSw==
X-Gm-Message-State: APjAAAWvOpkStS6J8RTIJW1fdxMYc9w6o/2G91GXFidx0tFkbnIQo+Fj
        MEtykHZP6fKANPuHhOcHru9F0kuMji8=
X-Google-Smtp-Source: APXvYqxhf2FuEKVOxBThPADkhKMyx8yWenCVxENN7j5+xcTs44H4WtOKQ6MIpIcdmjAzVbxtPwkbcw==
X-Received: by 2002:a63:4d8:: with SMTP id 207mr31223972pge.441.1574679811923;
        Mon, 25 Nov 2019 03:03:31 -0800 (PST)
Received: from localhost.localdomain ([182.78.163.34])
        by smtp.gmail.com with ESMTPSA id c6sm8176503pfj.59.2019.11.25.03.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 03:03:31 -0800 (PST)
From:   kc27041980@gmail.com
X-Google-Original-From: KC17041980@gmail.com
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        KC27041980 <kc27041980@gmail.com>
Subject: [PATCH 1/1] acpi/ec.c: Move call to kref_get() to under the mutex_lock(&ec->mutex)
Date:   Mon, 25 Nov 2019 16:33:18 +0530
Message-Id: <1574679798-18958-1-git-send-email-KC17041980@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KC27041980 <kc27041980@gmail.com>

Move call to kref_get() to under the mutex_lock(&ec->mutex) as this
will remove any delete race scenarios.

Signed-off-by: KC27041980 <kc27041980@gmail.com>
---
 drivers/acpi/ec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index da1e5c5..9c1bd57 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1073,8 +1073,12 @@ acpi_ec_get_query_handler_by_value(struct acpi_ec *ec, u8 value)
 			break;
 		}
 	}
+
+	if (found)
+		acpi_ec_get_query_handler(handler);
 	mutex_unlock(&ec->mutex);
-	return found ? acpi_ec_get_query_handler(handler) : NULL;
+
+	return found ? handler : NULL;
 }
 
 static void acpi_ec_query_handler_release(struct kref *kref)
-- 
2.7.4

