Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F45C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00A120679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413538;
	bh=QonCWYkne752CqtzUkgcC5uyR/NBuJ258Kl5qwn3ToY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QE2iQt+h21ycmprhQCdLEMHKHU1gWvfkYQ1EJCMKY+TJxAC2zfh0yx27JYADlN6GH
	 y3EiedopoD9npmK56t+qu0zn9+LnGHNocdelw89J4+QCmW8q30A/o73iaWo+368CNg
	 oCDR5Lhazqc5aOErpWwCOGATzKLrdowtMmtiV7E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfFXV64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:58:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42182 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfFXV6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:54 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so128946ior.9;
        Mon, 24 Jun 2019 14:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEFj1m00BQHw9ShNEs9XZxRgQ7JCz9e7ngBon7KyAz4=;
        b=RR5i4QRaqQ77jUTz0L6iYW5yZPvgETVurBznmH+KCidhK7C5iZZAXdebTPrbs72FVp
         jk1s+bIUvVkwNXVQ/BQQ4As+Ico/zu0Zqr5CxmSQFUVwcIMTw91A8hS5Lz0SBj+eZV63
         5iOdvIqFT1QmcAf7IRR9kxVomlGXjISCrZ2fMCZUmXig73awQ9TptWASxt1CHyAeH/sM
         qGazRYbiX/KJp3/tsBnGm+DCzfM8Q1yxhQtq10qy4V0E8Hh5chFOBQIVGB3m3cLeLHBP
         dnhm9sy9P9HTSE+VeZ2ZjL19w5366TqrdBjY2vRMVonr2hUHRnLjQZqNZkb/bKFYrF87
         K5sA==
X-Gm-Message-State: APjAAAXBmOmkObebseZaiFVF4/XFd2TEzOVAn7l+ouxTIS7Ejdyc91LO
        gsakrwXE460uVNiHPQZw4w==
X-Google-Smtp-Source: APXvYqw/FHO+gVZRrGcciOK3h3Kb/yWTmo0PoEZ7PQLBbItysz7a1oMFgC77m1j4HXKE5Et7o3a8FQ==
X-Received: by 2002:a5d:8759:: with SMTP id k25mr17594429iol.307.1561413532967;
        Mon, 24 Jun 2019 14:58:52 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.58.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:58:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 01/15] dt-bindings: display: rockchip-lvds: Remove panel references
Date:   Mon, 24 Jun 2019 15:56:35 -0600
Message-Id: <20190624215649.8939-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel bindings are outside the scope of the Rockchip LVDS interface
binding. The references are about to change too, so rather than update
them just drop the section on the panel bindings.

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/rockchip/rockchip-lvds.txt       | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
index da6939efdb43..7849ff039229 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
@@ -32,17 +32,6 @@ Their connections are modeled using the OF graph bindings specified in
 - video port 0 for the VOP input, the remote endpoint maybe vopb or vopl
 - video port 1 for either a panel or subsequent encoder
 
-the lvds panel described by
-	Documentation/devicetree/bindings/display/panel/simple-panel.txt
-
-Panel required properties:
-- ports for remote LVDS output
-
-Panel optional properties:
-- data-mapping: should be "vesa-24","jeida-24" or "jeida-18".
-This describes decribed by:
-	Documentation/devicetree/bindings/display/panel/panel-lvds.txt
-
 Example:
 
 lvds_panel: lvds-panel {
-- 
2.20.1

