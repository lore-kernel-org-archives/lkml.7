Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D5C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4B220665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413534;
	bh=9RHutXjfDl0ccdWJ7iSsWD7ux8RXWewcFpcXHGGwHGM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hQ1SKe6Oeprgnsvgr33QrpxyhJRHzDqWhjPfnMRf6oBHZ4VXgU9862t2m9aL9njE9
	 PQU/z/s+1pjwIOse3jpjkDvbJi/OVVuH6n3nQmaNYkomp9a/BykBt3cHAQeaK4D2Er
	 cZQ92WQbYCv9WDdA6q2YkMfByi6fAfDvIIMIZiw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfFXV6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:58:53 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:33557 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfFXV6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:52 -0400
Received: by mail-io1-f49.google.com with SMTP id u13so1057239iop.0;
        Mon, 24 Jun 2019 14:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uM4dZl8hD5W0Ng6JXl84WrF4vu6F9ad7AQJYlmPgT/Q=;
        b=R23y6qQHPZBxAlu2QcOGTRQb89EPfP4L0b98lVwN16Mcl8/LFGTTjpggKzJv73Np8t
         dGpsWLslXIijFaAVyZaFsNoyvGoGot7/HtJpKi1VZvQt0fbwTVN1YIUQfXWPckJdRYF7
         ++srYmXy4rwNu7kmk2RzhHj9IfIMa3yjn0CjFQ8tmA/+TIFjHH79wWO794HTRLqZwRjH
         gK07gW5+zMGCdQQ9C+63NL1jqXBGpcqUAeKIlEO5inOXSbDQr/NXJ7t7q9r356Tyt41u
         w4ETpvV68doGE3X8SHaj+1jvlNVL2xRMzaJt8g+iUb/Z/NtB/SQaJAisGVYcfUUnV39G
         Ygvg==
X-Gm-Message-State: APjAAAUlrNOYPfDdGZPSHa5YMd3oyVDjqOCQQU9U9zQf+iaY+cuEUikz
        w8B/VjbATOBI9BK5CQ4anw==
X-Google-Smtp-Source: APXvYqzop/7WORnCldt5IXvpf7uk9nCqbvMhBidbGV24RJR/cbv6s3xV2UCKCK7udclytSub7YsBrA==
X-Received: by 2002:a6b:c90c:: with SMTP id z12mr110760237iof.11.1561413531618;
        Mon, 24 Jun 2019 14:58:51 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.58.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:58:50 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 00/15] Conversion of panel bindings to DT schema
Date:   Mon, 24 Jun 2019 15:56:34 -0600
Message-Id: <20190624215649.8939-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the common panel bindings to DT schema format. 
Besides the conversion of common panel properties, a few panel bindings 
are converted here as well. These are all the ones with references to 
panel-common.txt or panel-lvds.txt.

Rob

Rob Herring (15):
  dt-bindings: display: rockchip-lvds: Remove panel references
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
  dt-bindings: display: Convert tpo,tpg110 panel to DT schema
  dt-bindings: display: Convert panel-lvds to DT schema
  dt-bindings: display: Convert innolux,ee101ia-01 panel to DT schema
  dt-bindings: display: Convert mitsubishi,aa104xd12 panel to DT schema
  dt-bindings: display: Convert mitsubishi,aa121td01 panel to DT schema
  dt-bindings: display: Convert sgd,gktw70sdae4se panel to DT schema

 .../panel/ampire,am-480272h3tmqw-t01h.txt     |  26 ---
 .../panel/ampire,am-480272h3tmqw-t01h.yaml    |  42 +++++
 .../display/panel/arm,versatile-tft-panel.txt |   2 +-
 .../display/panel/armadeus,st0700-adapt.txt   |   9 --
 .../display/panel/armadeus,st0700-adapt.yaml  |  27 ++++
 .../display/panel/bananapi,s070wv20-ct16.txt  |  12 --
 .../display/panel/bananapi,s070wv20-ct16.yaml |  24 +++
 .../display/panel/dlc,dlc0700yzg-1.txt        |  13 --
 .../display/panel/dlc,dlc0700yzg-1.yaml       |  28 ++++
 .../display/panel/innolux,ee101ia-01d.txt     |   7 -
 .../display/panel/innolux,ee101ia-01d.yaml    |  22 +++
 .../bindings/display/panel/lvds.yaml          | 107 +++++++++++++
 .../display/panel/mitsubishi,aa104xd12.txt    |  47 ------
 .../display/panel/mitsubishi,aa104xd12.yaml   |  71 +++++++++
 .../display/panel/mitsubishi,aa121td01.txt    |  47 ------
 .../display/panel/mitsubishi,aa121td01.yaml   |  69 ++++++++
 .../bindings/display/panel/panel-common.txt   | 101 ------------
 .../bindings/display/panel/panel-common.yaml  | 149 ++++++++++++++++++
 .../bindings/display/panel/panel-lvds.txt     | 121 --------------
 .../bindings/display/panel/panel.txt          |   4 -
 .../display/panel/pda,91-00156-a0.txt         |  14 --
 .../display/panel/pda,91-00156-a0.yaml        |  25 +++
 .../panel/raspberrypi,7inch-touchscreen.txt   |  49 ------
 .../panel/raspberrypi,7inch-touchscreen.yaml  |  71 +++++++++
 .../display/panel/sgd,gktw70sdae4se.txt       |  41 -----
 .../display/panel/sgd,gktw70sdae4se.yaml      |  63 ++++++++
 .../bindings/display/panel/simple-panel.txt   |  29 +---
 .../display/panel/tfc,s9700rtwv43tr-01b.txt   |  15 --
 .../display/panel/tfc,s9700rtwv43tr-01b.yaml  |  30 ++++
 .../bindings/display/panel/tpo,tpg110.txt     |  70 --------
 .../bindings/display/panel/tpo,tpg110.yaml    | 101 ++++++++++++
 .../display/rockchip/rockchip-lvds.txt        |  11 --
 32 files changed, 831 insertions(+), 616 deletions(-)
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
 delete mode 100644 Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml

-- 
2.20.1

