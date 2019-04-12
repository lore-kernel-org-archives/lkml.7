Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0CEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C4F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ODm9DX0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfDLJXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:23:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33477 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfDLJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:23:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so11053705wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFZmJxKfIVRPvgSc5v5AF5OOxltARLfujv2opyzbGXM=;
        b=ODm9DX0j3BpCarhysWf0bYuSdprUQoduPvSTgZvYb5MFKhZN0rgalp2MN//aGz4esS
         zzdYpqzWtMAPyv3xKFQIfCqgm9OfP1u6hm67hMkY6BCXWqRLyN1rHPHgWJUdeqtWzYpQ
         F6t4DOaZREFNO/xfBJe+V6URgDrDicdKrrGazB6F5uMnAfd4NichYB09ExM+FCv0pQ4m
         mAPh2KgD84Y37eRqHII6rPXhC9+XnC9sz+YmrHIiiHOJRGJZRD9SG2AK/3Zz8cqPYUGa
         uMTfG1j31QwZrC6OhtaUlfOvMB3mHzX81hUi8YW3gs5j1beN0QQJ2V1ACA8wjb1fIJ0s
         0GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFZmJxKfIVRPvgSc5v5AF5OOxltARLfujv2opyzbGXM=;
        b=WRCGI5Szr/EGwdzb5Nk9oDuS2mrpo46k34rH1X+8bL7nV8YwiwvthCTMey6Lz+P/Is
         +45IRCBlGplFb6Is3wrFSaaoTcCYqUyJUL0xvCm9I4kjdED+AN7bmaY4swoAv/FlU5iY
         PO2dCM/neaEIerdf5DOVsQFmNX/2K1d1j9shJn7Tf1WAYpVyNvt7aJsVKRvde66xRVZ9
         We2NsmH16d124QY/TtymuWGbuX0h2nI2wHqA2FJHkrlvuGouseMwt2jPCiwYRflzipPj
         uwCB4nIfHLiT9LxQXfOTIVVbe7gtVHlHEXkoc9eVodlaNyJG2/LKIFWv07/6mbyFB095
         jjnQ==
X-Gm-Message-State: APjAAAVGmW/OO8aAM9houHdvs6GUIGVMey7YEEP2meyc9bdiIfosHkqZ
        Ti71XXa3VAvOczsKP15TL5lYlw==
X-Google-Smtp-Source: APXvYqwn8inanJ8QzEt82E4Yv6STjtm6hgUsZrShhHs8lqcvjvP9wFG8dO+2qksyPwKYqG3K4enMLw==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr12992801wrt.13.1555061020295;
        Fri, 12 Apr 2019 02:23:40 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s21sm6630224wmh.22.2019.04.12.02.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 02:23:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: pwm: Update bindings for the Meson G12A Family
Date:   Fri, 12 Apr 2019 11:23:35 +0200
Message-Id: <20190412092337.6941-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412092337.6941-1-narmstrong@baylibre.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the doc to explicitly support Meson G12A Family

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 1fa3f7182133..e2bcd8e92ad0 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -7,6 +7,8 @@ Required properties:
                          or "amlogic,meson-gxbb-ao-pwm"
                          or "amlogic,meson-axg-ee-pwm"
                          or "amlogic,meson-axg-ao-pwm"
+                         or "amlogic,meson-g12a-ee-pwm"
+                         or "amlogic,meson-g12a-ao-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
-- 
2.21.0

