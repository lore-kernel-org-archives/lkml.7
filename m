Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48046C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AF420820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec7+e/vO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbfIWOOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:14:52 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39396 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfIWOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:14:51 -0400
Received: by mail-wr1-f48.google.com with SMTP id r3so14154697wrj.6;
        Mon, 23 Sep 2019 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xDojPBQ0esilIp1GUWD6dVVMPDHyVZuOXZ5O6hXNfas=;
        b=ec7+e/vOexOvTupF4N51DyUI9IK+tzeCpvquHyORkLq46BBh5H1XRCPAgK316lNwp1
         D7+8f/SzrN8b6TBnPmAIQaclhWgoXOsxC9ygJ8ft+vBjwRPRPlkc3HjBLQMb3KvAcpg8
         Le1f6VFKWhQ4xXJiv6POOQaq7spIJohCaaRTO/12bWV522WIpZbVaTEVlDxJG2XwwAj+
         zUWP7PIo9IZHH6NAXPRwYsdKOG2YfrRbt4VyBkw2Eud/aHYU18ZKtQpiZsw4DmX2EaEX
         b2/FIX8uLF1FKHTy/WrZVX/TpcfIh+xoP45nWV/wJtuP8OVqDcFzDRPvHmPjnBgF+oqm
         d7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xDojPBQ0esilIp1GUWD6dVVMPDHyVZuOXZ5O6hXNfas=;
        b=QpPv/rwGp0ngHliZcwrHOI/mS2HJ7hlu4nMhaPEy3B5V8rIbZB3Hyb3g6El67PJckF
         lK6ylAyYrrVmuPSFnSeo4bROUyRiMTSEj9dU0a2NBjbWNWU9jEbxTSidM58QJ0T+eryd
         t6fIfADD44Q1JYAzynPeoBHzYjv0ysUODihpzzXa7Q20jZpJWDC00nry9lfulOkKlzzj
         uQZ2NcCSIabf7N7sBUHD3gCJqN4JeWGvcMhwgIH8Y8poEbCjRSv1V76xWuCvP25WPstk
         30Lv8FM/oWGTQR5xK2OROW7cvzeqLa83i1fuh2zdieh4JnwAE891OUOx/JhH1LweYu9I
         lqYg==
X-Gm-Message-State: APjAAAWFdHAYFU26PFHf+2jrCnrbmsFtcEmOPFmRqCQgGfaNRLOUpmIW
        0v+O4g/FYbGAxtjpCqY4rCc=
X-Google-Smtp-Source: APXvYqw3564AefETCZx7N1ORzHLmEWXRNjXvrRmIeHPR7ZbKIzG3YpOhOxBKCySAVsDdCkGT6koM1g==
X-Received: by 2002:adf:fb8e:: with SMTP id a14mr9614815wrr.304.1569248088812;
        Mon, 23 Sep 2019 07:14:48 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id h17sm7001700wmb.33.2019.09.23.07.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 07:14:48 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleg Ivanov <balbes-150@yandex.ru>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: Add vendor prefix for Ugoos
Date:   Mon, 23 Sep 2019 18:13:54 +0400
Message-Id: <1569248036-6729-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569248036-6729-1-git-send-email-christianshewitt@gmail.com>
References: <1569248036-6729-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugoos Industrial Co., Ltd. are a manufacturer of ARM based TV Boxes/Dongles,
Digital Signage and Advertisement Solutions [0].

[0] (https://ugoos.com)

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbb..d962be9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -965,6 +965,8 @@ patternProperties:
     description: Ubiquiti Networks
   "^udoo,.*":
     description: Udoo
+  "^ugoos,.*":
+    description: Ugoos Industrial Co., Ltd.
   "^uniwest,.*":
     description: United Western Technologies Corp (UniWest)
   "^upisemi,.*":
-- 
2.7.4

