Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC550C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED58217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="KFZsA7IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfK2Ivh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:51:37 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25848 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2Ivh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:51:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575017432; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=LSYr/M+9wHznshlfolwm0DLElRchueotv8QGjVE4cCaYyoQ7ku4uZmHsjhIBwCqj0VWwBxol55jSU/CMFvQjbQuhbh2kNmf90Hx56a0ZLHctu1zXMFmnilElnqFecoECdFbhqLq+zsNzSO1sCBz3Z+wZWI3ASUhgcI4r8MNm1Q8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1575017432; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=pw0egvHiVYhWeoLwAgb0PomIYXZGRVshTmDHr4ijsP0=; 
        b=DrSiOzWHuFZKS6PTUc6Zl4hfPqHdRnzF1tp97OTkAHaMkRsSlxk6gMa7LuoOGNTBTdCqgucvoDuo2KfSDqUoDX/ClHWhpecLSkHMpBC8yFy9NdE8vO5ooKr9F4ze9JUc3AnbEGI3x/DeffFMttZ1sWFTEkDFvOyDdoG6S6QtF4M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=GRCNonozQ6UTQYflb9vuR6vQ/JabWMz4oObSachLGlDaMqCLG+Xi0miOf2VhsaxqAY+5kNGWvgaC
    veoV092bQAzZL8N/dHmHqogFDjEnPEZofNTwtNTuK7BG55OCj7xk  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1575017432;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=pw0egvHiVYhWeoLwAgb0PomIYXZGRVshTmDHr4ijsP0=;
        b=KFZsA7IUBhiGXBdF2y0dQ852Sa0QLsxW9D/GqNwFn8gM1k9FBd72v4XHHropninr
        KOKFd8W/MpVyYNp6h1JfsgukahMHJwqtbLeHpTnRwmaXELCfe4uwul8kO2hSlUyrTS8
        mHRxjk+M6uZPVy2xEr4XQjlBC6DMI0gBkMzu+xBY=
Received: from zhouyanjie-virtual-machine.localdomain (139.207.146.46 [139.207.146.46]) by mx.zohomail.com
        with SMTPS id 157501743029720.844468900447623; Fri, 29 Nov 2019 00:50:30 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        jhogan@kernel.org, mripard@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, syq@debian.org, ralf@linux-mips.org,
        heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, krzk@kernel.org,
        geert+renesas@glider.be, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 772753199@qq.com
Subject: [PATCH v6 03/12] dt-bindings: MIPS: Add Ingenic XBurst based boards.
Date:   Fri, 29 Nov 2019 16:48:44 +0800
Message-Id: <1575017333-29020-4-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575017333-29020-1-git-send-email-zhouyanjie@zoho.com>
References: <1575017333-29020-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ingenic XBurst based boards, prepare for later dts.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---

Notes:
    v1->v2:
    No change.
    
    v2->v3:
    No change.
    
    v3->v4:
    Adjust the description to make it more reasonable.
    
    v4->v5:
    Adjust item naming to prevent conflicts with
    subsequent "CU Geo" boards.
    
    v5->v6:
    No change.

 .../devicetree/bindings/mips/ingenic/devices.yaml  | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/ingenic/devices.yaml

diff --git a/Documentation/devicetree/bindings/mips/ingenic/devices.yaml b/Documentation/devicetree/bindings/mips/ingenic/devices.yaml
new file mode 100644
index 00000000..6bba181
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/ingenic/devices.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/ingenic/devices.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic XBurst based Platforms Device Tree Bindings
+
+maintainers:
+  - Zhou Yanjie <zhouyanjie@zoho.com>
+description: |
+  Devices with a Ingenic XBurst CPU shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Qi Hardware Ben NanoNote
+        items:
+          - const: qi,lb60
+
+      - description: Game Consoles Worldwide GCW Zero
+        items:
+          - const: gcw,zero
+
+      - description: MIPS Creator CI20
+        items:
+          - const: img,ci20
+
+      - description: YSH & ATIL General Board CU Neo
+        items:
+          - const: yna,cu1000-neo
+...
-- 
2.7.4


