Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F01C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D192085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmGB1X5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfHLKvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:51:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33092 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfHLKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:51:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so104263488wru.0;
        Mon, 12 Aug 2019 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8y69qpb8UD4pmGymBCCj0vrAYWumiZEmgRjo9Gkt4hE=;
        b=FmGB1X5vECdUSw5GDk1JEITe8ZmsplF/0xnLiaAdpOIwzo5QbdcgBssKwh//qmwyCU
         sdGiGk/A5GQjJmUBeNo7UwcL0y3F0qBemh8jmQfWxsj7ahELFP2AYX7NJYG3dh51CLBr
         MYTmkJwSVJ0teDz6aMOa4QuzlKIsE5jYkvnlQfTSwwfJqxIJ/sft41zJ/uX2E4T59RLc
         XmT320ySyTOt/7VTGWrZmy2qql0ZGKz84zVjyykLuQf4IrSarVgD15V4SNiZWthHua6/
         zkTB+GihV4zXFjlbGAoOz3Dn17PqeBPxR9FuiXkGyX/wzraBxP5S8+R6x+7bBo4pkycZ
         mgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8y69qpb8UD4pmGymBCCj0vrAYWumiZEmgRjo9Gkt4hE=;
        b=dVdzJIdVLHnp+VrJzesndH9GR491C+c+VMrGvHORY1nnupeAjbYRem8O582tzWo2Ta
         30Qhf1+vBX63O9CTnu1lmF2G4dlG8fX+IUoNtLyRHWm08ZSEh293M0VX5ujR8NJROUm+
         Qp5Czsi0d8gLbcpp2edSuzKuAxxMYXfXQd/nZEMadsH5KTNSurKw98VS0tG8c06Qafzg
         SQorEQaTLEubjeWzrJic4gFi2XYrx97+Xak6QfwWuK98TiJSMjqWj1dAqhWAb46xZQhI
         i7DyRMqxhosGJGktM1pNPhtEfNZmfohEHvsVvvtzTDgsD4px/wxRX/OQdjybaZOQGsZF
         FtWQ==
X-Gm-Message-State: APjAAAX+8Lot98OlLnAUFY1nzsH9UoHUkTuX31/bjyTjMLULQoDWXh30
        aeSjDtJp0an0YgmoyQeUitk=
X-Google-Smtp-Source: APXvYqxO/zN5LoGuQdjgdLXcwdnLGqCiCs6Za6BT+vZzRtge3ZxZPKPUNKyec3jeFUKnm1IP5O8/gQ==
X-Received: by 2002:a5d:63d0:: with SMTP id c16mr35364533wrw.22.1565607081493;
        Mon, 12 Aug 2019 03:51:21 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id z8sm22797916wru.13.2019.08.12.03.51.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:51:21 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 0/2] Allwinner H6 SPDIF support
Date:   Mon, 12 Aug 2019 12:51:13 +0200
Message-Id: <20190812105115.26676-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) which
is different from the previous H3 generation and not compatible.

Difference are an increase of fifo sizes, some memory mapping are different
and there is now the possibility to output the master clock on a pin.

Actually all these features are unused and only a bit for flushing the TX
fifo is required.

Changes since v5:
 - Move soundcard to board device-tree

Changes since v4:
 - rename audio card name to sun50i-h6-spdif
 - drop patches already merged

Changes since v3:
 - rename reg_fctl_ftx to val_fctl_ftx
 - rebase this series on sound-next
 - fix dt-bindings due to change in sound-next
 - change node name sound_spdif to sound-spdif

Changes since v2:
 - Split quirks and H6 support patch
 - Add specific section for quirks comment

Changes since v1:
 - Remove H3 compatible
 - Add TX fifo bit flush quirks
 - Add H6 bindings in SPDIF driver

Clément Péron (2):
  arm64: dts: allwinner: Add SPDIF node for Allwinner H6
  arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 22 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 20 +++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.20.1

