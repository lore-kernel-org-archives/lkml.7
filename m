Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8DC468A0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D4A21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344947;
	bh=XJuLrN8kscGxV2LSE1Q2hKSMSi3jSHcgf3UBylZxNCY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NQRM8xr/CWFlka6HMzxF0BpWErfIa8dUAUA0WSLk1oREqjNuYypTI2vQp31sWWSLa
	 UsyiYJ0UT1NknKHiH0qIdmj4ixhp8SDPGubH74tXshBc45Awva907OAHfuA3NE1DW8
	 M/VK7zAcGDF8ZCP1ksny9xUax0nsXTgNmkXFlY8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfGEQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:42:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37169 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfGEQmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:24 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so15978220iok.4;
        Fri, 05 Jul 2019 09:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nlXZ7u0rxXu0XMq6FG+OHVHwTKfcbW3lBZ9QzezvgQ=;
        b=sFNqqqzRlAA4SMpiDaVvec20s8KX0ZfFYVnx5NXskiA/YXfMOjI3abxFu7pZ2i3XlW
         vwdL6MzchTzI7wMlQVpMvo65193c2Mif93/n97yhJvK4lr4nmhtdhg5LmC5RAjUDK8pp
         mZbCbA+js9weh7ozapfV5tTUWfPSVkhSMoJbtccW58bxWG3GWW2mIzMNRY6XmDk9wTG9
         XppY9JKwKO3aSmNbm5wX8HsBXrGx1XTLtEcEZVeJTe4QG1GEsPqz9ddCyQwc48avY+Jk
         f+vcx6YmXYiRaT3xEWbf1SyqgSLFOeBR9v4RHn48+LuOWMWqTfF8af4GbXojefaUA7pI
         vbnA==
X-Gm-Message-State: APjAAAU4mMtenbse/ulg9Xa4d2odgScA6xLMNu3H1+noY+ppD66Sxr+k
        /Fi78a7mWOokagwZ34oJfxwqoyg=
X-Google-Smtp-Source: APXvYqzM3MTheDkYKqJsDxrjwbKNkXHZsWgJIUt0bbxTWr9csYiLC5zscIL04ZJlvsbcj4gbapjptw==
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr4983031iot.243.1562344943338;
        Fri, 05 Jul 2019 09:42:23 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 00/13] Conversion of panel bindings to DT schema
Date:   Fri,  5 Jul 2019 10:42:08 -0600
Message-Id: <20190705164221.4462-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the common panel bindings to DT schema format. 
Besides the conversion of common panel properties, a few panel bindings 
are converted here as well. These are all the ones with references to 
panel-common.txt or panel-lvds.txt.

I'll apply the series to drm-misc. One patch from v2 already got applied 
without its dependency.

v3:
- Consistently list all used properties and add 'additionalProperties: 
  false'

Rob

Rob Herring (13):
  dt-bindings: display: Convert common panel bindings to DT schema
  dt-bindings: display: Convert ampire,am-480272h3tmqw-t01h panel to DT
    schema
  dt-bindings: display: Convert armadeus,st0700-adapt panel to DT schema
  dt-bindings: display: Convert bananapi,s070wv20-ct16 panel to DT
    schema
  dt-bindings: display: Convert dlc,dlc0700yzg-1 panel to DT schema
  dt-bindings: display: Convert pda,91-00156-a0 panel to DT schema
  dt-bindings: display: Convert raspberrypi,7inch-touchscreen panel to
    DT schema
  dt-bindings: display: Convert tfc,s9700rtwv43tr-01b panel to DT schema
  dt-bindings: display: Convert panel-lvds to DT schema
  dt-bindings: display: Convert innolux,ee101ia-01 panel to DT schema
  dt-bindings: display: Convert mitsubishi,aa104xd12 panel to DT schema
  dt-bindings: display: Convert mitsubishi,aa121td01 panel to DT schema
  dt-bindings: display: Convert sgd,gktw70sdae4se panel to DT schema

 .../panel/ampire,am-480272h3tmqw-t01h.txt     |  26 ---
 .../panel/ampire,am-480272h3tmqw-t01h.yaml    |  42 +++++
 .../display/panel/arm,versatile-tft-panel.txt |   2 +-
 .../display/panel/armadeus,st0700-adapt.txt   |   9 --
 .../display/panel/armadeus,st0700-adapt.yaml  |  33 ++++
 .../display/panel/bananapi,s070wv20-ct16.txt  |  12 --
 .../display/panel/bananapi,s070wv20-ct16.yaml |  31 ++++
 .../display/panel/dlc,dlc0700yzg-1.txt        |  13 --
 .../display/panel/dlc,dlc0700yzg-1.yaml       |  31 ++++
 .../display/panel/innolux,ee101ia-01d.txt     |   7 -
 .../display/panel/innolux,ee101ia-01d.yaml    |  31 ++++
 .../bindings/display/panel/lvds.yaml          | 107 +++++++++++++
 .../display/panel/mitsubishi,aa104xd12.txt    |  47 ------
 .../display/panel/mitsubishi,aa104xd12.yaml   |  75 +++++++++
 .../display/panel/mitsubishi,aa121td01.txt    |  47 ------
 .../display/panel/mitsubishi,aa121td01.yaml   |  74 +++++++++
 .../bindings/display/panel/panel-common.txt   | 101 ------------
 .../bindings/display/panel/panel-common.yaml  | 149 ++++++++++++++++++
 .../bindings/display/panel/panel-lvds.txt     | 121 --------------
 .../bindings/display/panel/panel.txt          |   4 -
 .../display/panel/pda,91-00156-a0.txt         |  14 --
 .../display/panel/pda,91-00156-a0.yaml        |  31 ++++
 .../panel/raspberrypi,7inch-touchscreen.txt   |  49 ------
 .../panel/raspberrypi,7inch-touchscreen.yaml  |  71 +++++++++
 .../display/panel/sgd,gktw70sdae4se.txt       |  41 -----
 .../display/panel/sgd,gktw70sdae4se.yaml      |  68 ++++++++
 .../bindings/display/panel/simple-panel.txt   |  29 +---
 .../display/panel/tfc,s9700rtwv43tr-01b.txt   |  15 --
 .../display/panel/tfc,s9700rtwv43tr-01b.yaml  |  33 ++++
 29 files changed, 778 insertions(+), 535 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/lvds.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-lvds.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml

-- 
2.20.1

