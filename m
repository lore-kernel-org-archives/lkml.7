Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A238E20693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzH4mSbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394488AbfIFOda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:33:30 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38805 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbfIFOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:33:28 -0400
Received: by mail-wm1-f50.google.com with SMTP id o184so7348122wme.3;
        Fri, 06 Sep 2019 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xDojPBQ0esilIp1GUWD6dVVMPDHyVZuOXZ5O6hXNfas=;
        b=YzH4mSbbYfRqtEURYbLvIoEJ5+KI8c1yMt80p3RsRKRASmaiAW/4+gHJLWF5O+q4+/
         FQfD9kVr91N1VVEf32XobWKdDGkFaXiA3orv+mSsjDj+0UtzHWb+oJz1XSkabV+B4ZZC
         W1W7bcijUs7jyviTo8hEn9VmOnb59htd7b+9+VtVJP7d6WuLMJ2A2Q2pYtzYP5SP66T1
         CSds3XBTkBMqCyVD4We5j7y/OHQN89p4DAfFBnXlvo7GRMW+hspxt67gKj9qxcrrxVqH
         87RCcbZDJFnPnGAsEn6Xadjj9JOJ/cWQJzkP9djuTzNMqPsJN6oI3x4VaWcezPPqjIX4
         gmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xDojPBQ0esilIp1GUWD6dVVMPDHyVZuOXZ5O6hXNfas=;
        b=CrnzOryeM/R0T7wx8Mun6IKgs8TQUAeMpl3hNhHjN+K9JXypVd2DIBylfT1KMgsSvW
         Xqwopqu3Gw3RNS2tzslZbXc5Zepu5lau5oKUUzZ4c/Y4b/1y6MMxPccf4cgGqRVGVgwO
         YNDkoQF0SuI3VhuZxmy73esVhLq6jN/u7kehs2vHPnCPuPoEeXfuuZ7lYxYgRI8POSVh
         6xuhIemELc/onaqyRk7lxK7qaELE7GWUvvHrFMA9TRhNyaGSq7LaTulrMzULGjrX3gMk
         1gdukY0RlxIpuQlCgDuQJ1dmfDR1cpCK77AxbU11hC3eCT+s6zNbc1q6F+CvwVJSejiX
         xgQQ==
X-Gm-Message-State: APjAAAXyqXeIbKWHlO/62d9aSAGZ6LuJ64y/mggAwpUilG5zbHC2icxv
        JXrjYFJ0vIrgBYwUXVGh2Po=
X-Google-Smtp-Source: APXvYqxyRyW6xvWFqlJIoXCRJdrac/WsqsMJ83RWT2AIilwBlfvFC8Zganf13MgW1uMyO92xXFzvxg==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr7163587wma.132.1567780406289;
        Fri, 06 Sep 2019 07:33:26 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s9sm9300198wme.36.2019.09.06.07.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 07:33:25 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [RESEND PATCH v3 1/3] dt-bindings: Add vendor prefix for Ugoos
Date:   Fri,  6 Sep 2019 18:32:32 +0400
Message-Id: <1567780354-59472-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567780354-59472-1-git-send-email-christianshewitt@gmail.com>
References: <1567780354-59472-1-git-send-email-christianshewitt@gmail.com>
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

