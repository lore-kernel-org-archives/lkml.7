Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F3C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D2421670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344967;
	bh=+gH+iPznLoQGMC9CZAFqzj9/kzBSbOHF4Khg4V48hYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F1I+0u26E/+pRTfCimOiJvriquEwRm6g1Mh4hyj8OJoOCMVeZa3XX2XkDk3aRxFq9
	 W4NEDW3E/2YQSTf3eCTuWZdSKgtOuJatRZUqLhbJVfQLtrly/hIGFOZsEtqgplaKCy
	 VDDIZfooK1JZkFv2GGqPm3BGBnQm85uE+/adMF4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfGEQmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:42:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46680 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbfGEQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:42 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so20266010iol.13;
        Fri, 05 Jul 2019 09:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FoIk+rbFwPJ/lDbdbtoXks82bIuWeLHVYlyQ0/EsZZU=;
        b=gQ48gEWFaEHTqV2CjE1K+Lww6iSTwGpdJKYJmocvP4wqhTJ0YcN9GX3AFT53+yhMCh
         kUXNCs7uqy+2l7JQP50Wjkd20jhK8rYwE723YcCH79KGQ52FyX3mPWOBFbv6FHDM2ls2
         /yznS/Cn1c5P5BpDVxCp0Te3C6R+cc0MiX8CaOuZKTc3aoCNJGcHgely1UJn+A7iqi7d
         Lz4ycGUGeYXAKpFkXMbPnpQxik8S7FjHngHK6fkn73f1w+ayPI6I6+769E3BrPHdk8G2
         dq9TQ8CwbLDob1pBIa7Svj8T2BJDHxREajFKWLmo1KgBr2jDOn7pXMPCCBMi6Qr9gGFR
         RhQg==
X-Gm-Message-State: APjAAAWwojJQltwYjN0FChfK4C2xER+SOHEWhF5PKQscCuaj0KVVlNNt
        rlvtXs8MRd4qLtFxsOIb9w==
X-Google-Smtp-Source: APXvYqyUJoGqrhu1jI2/dAFKaqMmF6AV+orNNmKQ/l+hsXENx8O/XWHlmlUk7xd29jsQqHmFggBF+g==
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr4984238iot.243.1562344961433;
        Fri, 05 Jul 2019 09:42:41 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v3 10/13] dt-bindings: display: Convert innolux,ee101ia-01 panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:18 -0600
Message-Id: <20190705164221.4462-11-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the innolux,ee101ia-01 LVDS panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/innolux,ee101ia-01d.txt     |  7 -----
 .../display/panel/innolux,ee101ia-01d.yaml    | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
deleted file mode 100644
index e5ca4ccd55ed..000000000000
--- a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
-
-Required properties:
-- compatible: should be "innolux,ee101ia-01d"
-
-This binding is compatible with the lvds-panel binding, which is specified
-in panel-lvds.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
new file mode 100644
index 000000000000..a69681e724cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,ee101ia-01d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
+
+maintainers:
+  - Heiko Stuebner <heiko.stuebner@bq.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: lvds.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: innolux,ee101ia-01d
+      - {} # panel-lvds, but not listed here to avoid false select
+
+  backlight: true
+  enable-gpios: true
+  power-supply: true
+  width-mm: true
+  height-mm: true
+  panel-timing: true
+  port: true
+
+additionalProperties: false
+...
-- 
2.20.1

