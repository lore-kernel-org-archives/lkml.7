Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873EEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EA02080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfHYNuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:50:46 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42037 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfHYNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:50:44 -0400
X-Originating-IP: 87.18.63.98
Received: from uno.homenet.telecomitalia.it (unknown [87.18.63.98])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 08232C0006;
        Sun, 25 Aug 2019 13:50:38 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli@fpond.eu, airlied@linux.ie, daniel@ffwll.ch
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH v3 02/14] dt-bindings: display, renesas,du: Document cmms property
Date:   Sun, 25 Aug 2019 15:51:42 +0200
Message-Id: <20190825135154.11488-3-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825135154.11488-1-jacopo+renesas@jmondi.org>
References: <20190825135154.11488-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the newly added 'cmms' property which accepts a list of phandle
and channel index pairs that point to the CMM units available for each
Display Unit output video channel.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index c97dfacad281..c2265e2a1af2 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -45,6 +45,10 @@ Required Properties:
     instance that serves the DU channel, and the channel index identifies the
     LIF instance in that VSP.

+  - cmms: A list of phandles to the CMM instances present in the SoC, one
+    for each available DU channel. The property shall not be specified for
+    SoCs that do not provide any CMM (such as V3M and V3H).
+
 Required nodes:

 The connections to the DU output video ports are modeled using the OF graph
@@ -91,6 +95,7 @@ Example: R8A7795 (R-Car H3) ES2.0 DU
 			 <&cpg CPG_MOD 721>;
 		clock-names = "du.0", "du.1", "du.2", "du.3";
 		vsps = <&vspd0 0>, <&vspd1 0>, <&vspd2 0>, <&vspd0 1>;
+		cmms = <&cmm0 &cmm1 &cmm2 &cmm3>;

 		ports {
 			#address-cells = <1>;
--
2.22.0

