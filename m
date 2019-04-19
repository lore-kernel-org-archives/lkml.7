Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CF4C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6422171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkZ8/X33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfDSULu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:11:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33675 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDSULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:11:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so3047308plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZKeSUUUQGTRmZxCS8jznOXNyqkqOgW2KyZJn0I7vAUM=;
        b=SkZ8/X33CU6Hpz9cO6mROiWAqKKJtJxcdQDEeXHfyzpHO4HEtbBB+sE8G6T0PCY/g2
         psuIm/AUp8q//zTDXwyEXbMBEO+n7cItTTGnmQQTH6nvvYNCx1egayUzi1Z+1cb6+4pi
         9T/PG8oHqogftJudKc0/dES01lF65+2AWwvOzW2sYYfxz8k8Jq/33zkuC00q5ku6/gPq
         y15NzvD1eSDPkUUUEGGITCxMAUwdeOW32tla/g9HfKZmt9DN7HqnH751e81SF/Q55ZLW
         jB4ngiVZObPG0KXYOyi0nSlBVdwrow40J33AESlyxkQxa2KnvtZFHybcQ+nPFWuJJz3a
         ECKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZKeSUUUQGTRmZxCS8jznOXNyqkqOgW2KyZJn0I7vAUM=;
        b=PbpbnqtBBwb6cTgwpOHt/QgNHD/b48Wk/NJWbpGqKYXGmY97FbZAtxIXBi5GIleEFv
         DTv03mw5QjEFafOZW/iVbfnL+mRkqnXDQUede8hY+XdamgqNEdbSl2lsNhyiTqhZSkKG
         7GxLhFU/MLYEXxJF8rKBEmZG7ZHILW3xJ6bzr5WfG+kDRxyi5MyVinChqGgNZqgu4UkQ
         Hp+ohFQozPG71QBSRgRIFGZoSyA24znak2yvwENZXjVY6udtO45DXXquX6oVlnzPXpkj
         CKsNrhkYqx31j1XHT7hz/asqX3XC0k9oXsPXwPeHbUWslkrTuTvET9rls0c893zmyRbu
         gLMg==
X-Gm-Message-State: APjAAAU2bvJOJy+ATt7AP4B6c4/wUASriRAYCtgHxP51Z7gS8odR1ued
        fDtIJ3ann7h/tmYLgoOaetuvaQ==
X-Google-Smtp-Source: APXvYqzo/GfaX8iHMaHRgcGhDIXxApkuJ0/5mhuZls9eK1mxeK0g+NlaSi58riMFALB2nJdIgFF/qQ==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr3072326plq.97.1555671289558;
        Fri, 19 Apr 2019 03:54:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v189sm6890820pgd.77.2019.04.19.03.54.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 03:54:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     broonie@kernel.org, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: soc: sprd: Add Spreadtrum MCDT documentation
Date:   Fri, 19 Apr 2019 18:54:31 +0800
Message-Id: <f7edc4078b2d6f44ed5ad47c14dd58da5cc50f21.1555670768.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Spreadtrum multi-channel data transfer controller,
which is used for sound stream transmission between audio subsystem and
other AP/CP subsystems.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/soc/sprd/sprd-mcdt.txt     |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sprd/sprd-mcdt.txt

diff --git a/Documentation/devicetree/bindings/soc/sprd/sprd-mcdt.txt b/Documentation/devicetree/bindings/soc/sprd/sprd-mcdt.txt
new file mode 100644
index 0000000..274ba0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sprd/sprd-mcdt.txt
@@ -0,0 +1,19 @@
+Spreadtrum Multi-Channel Data Transfer Binding
+
+The Multi-channel data transfer controller is used for sound stream
+transmission between audio subsystem and other AP/CP subsystem. It
+supports 10 DAC channel and 10 ADC channel, and each channel can be
+configured with DMA mode or interrupt mode.
+
+Required properties:
+- compatible: Should be "sprd,sc9860-mcdt".
+- reg: Should contain registers address and length.
+- interrupts: Should contain one interrupt shared by all channel.
+
+Example:
+
+mcdt@41490000 {
+	compatible = "sprd,sc9860-mcdt";
+	reg = <0 0x41490000 0 0x170>;
+	interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.7.9.5

