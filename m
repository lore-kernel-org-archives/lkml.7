Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D318C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5330421655
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqmZgGUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443232AbfIYSmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:42:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42982 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439865AbfIYSmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:42:54 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so1387085iod.9;
        Wed, 25 Sep 2019 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7TqSWERPDP6dY8lexk4L6mhRR8imTrM3/l99588sDqo=;
        b=FqmZgGUBYxcX6ZXTvgF1ZCGrqCQk4byoZONJBWX/y2WJE1WFxXZy/a/FjD26O420kK
         FxIDzsvAtqvHmKAYSZaqFkUxG57+n9YbAw6NzXffmaE5miqSzRbgKlBOkq2qM0ov5C90
         mX0sV8PP9TGvYnH+e+0pwJqj6vipdHKVWkQFS8/SzjzsMdSSX8aVgkHuepyIB+CJm0yc
         bdmpz6vLOEpQ5Iis1pI4zxssvDaAwPycCtxq9kWhX4q6i8xS7edBxEgMXOXMdmqwUyWn
         +yFrgyQDxWpXUbsy5Acr+k8aLkXAdy9rm1WPZGM0vFjGNNSVue/6B+axo7tFHDgYzyYz
         emyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7TqSWERPDP6dY8lexk4L6mhRR8imTrM3/l99588sDqo=;
        b=FNyczd9NfXZdzKeGNnOSgyI7rnbDGYy6wcNhCrT29JMWiYvhVZbPX5luRjiwnHguYY
         sHboV+vG0peBInncx697OATxqTzdaTnYOIAvrVzV7L6ZWzLE9FeyBkbT1QdamwlQzsAg
         I30PSU0PLbTctCA593iCx/YyXvI4bY4fihE/yJ052NxnADH50JHTlgZc/tML7ts3GV76
         54gFyReh06lv+fBxicP+KZvGk+lmHIB8KTiOGw/eJRQrRvELzTJgfQw5Zm9/AlgbX8wp
         clCtVT2ieHc69B9tkjzSMzSX/D/vWB/ZLXZsA34vDKeb2T9YrxKdfZzZ49b/o2Ep5PLn
         lnrw==
X-Gm-Message-State: APjAAAXstVJw6MkLSgdDV18ynxgIoVX1YeTGXYZ/gYHlM6el56DJV0Ub
        NePYgtu4sXrmcjBbFpCV4X8=
X-Google-Smtp-Source: APXvYqwwrDy8W/AtYbORQyLWMA9NN2CDdud93Tg9fQpFlGiWbambEjDSW7EoczUuk/UioCsYM2LQuQ==
X-Received: by 2002:a6b:3e55:: with SMTP id l82mr877956ioa.216.1569436972896;
        Wed, 25 Sep 2019 11:42:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id q17sm337511ile.5.2019.09.25.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 11:42:52 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date:   Wed, 25 Sep 2019 13:42:37 -0500
Message-Id: <20190925184239.22330-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184239.22330-1-aford173@gmail.com>
References: <20190925184239.22330-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the WVGA panel
Logic PD Type 28 display.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Correct build errors from 'make dt_binding_check'
V2:  Use YAML instead of TXT for binding

diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
new file mode 100644
index 000000000000..74ba650ea7a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR X11)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/logicpd,type28.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Logic PD Type 28 4.3" WQVGA TFT LCD panel
+
+maintainers:
+  - Adam Ford <aford173@gmail.com>
+
+properties:
+  compatible:
+    const: logicpd,type28
+
+  power-supply:
+    description: Regulator to provide the supply voltage
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO pin to enable or disable the panel
+    maxItems: 1
+
+  backlight:
+    description: Backlight used by the panel
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.17.1

