Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81980C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DC32173C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="bd0ZeXdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfCaCm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 22:42:57 -0400
Received: from onstation.org ([52.200.56.107]:34328 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbfCaCm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 22:42:57 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1998A456C5;
        Sun, 31 Mar 2019 02:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1554000176;
        bh=muKtaP7s2o9g6Q+mrZieprYU6lrLLDUOs6zDUCbJtbw=;
        h=From:To:Cc:Subject:Date:From;
        b=bd0ZeXdpg3LtE441EyUehWcCYyi1jc6JyqG0hzBHkiV8MKkJnr1A5lD4pNY696/eZ
         qfXUCNPzNVE1PN6pCbdVyVu/L0nRC3ylwzClKuZPyjy40IyGz8ZSUcsH68RB4InQw8
         YULr5MR7P74WIbjNuADWECgHPH+UG/2FOQ+VFhTg=
From:   Brian Masney <masneyb@onstation.org>
To:     arnd@arndb.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        sugaya.taichi@socionext.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: arm: correct dt_binding_check parse error
Date:   Sat, 30 Mar 2019 22:42:40 -0400
Message-Id: <20190331024240.3012-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make dt_binding_check' fails with the following error:

  Documentation/devicetree/bindings/arm/cpus.yaml:  while scanning a
  plain scalar
    in "<unicode string>", line 231, column 19
  found a tab character that violates indentation
    in "<unicode string>", line 232, column 1
  make[1]: *** [Documentation/devicetree/bindings/Makefile:12:
    Documentation/devicetree/bindings/arm/cpus.example.dts] Error 1

Correct the parse error by replacing the tabs with spaces to keep
'make dt_binding_check' happy.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Fixes: fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for Milbeaut")
---
Issue is in linux-next-20190329.

 Documentation/devicetree/bindings/arm/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 60eab6dc3c0b..591bbd012d63 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -229,7 +229,7 @@ patternProperties:
                 - renesas,r9a06g032-smp
                 - rockchip,rk3036-smp
                 - rockchip,rk3066-smp
-		- socionext,milbeaut-m10v-smp
+                - socionext,milbeaut-m10v-smp
                 - ste,dbx500-smp
 
       cpu-release-addr:
-- 
2.20.1

