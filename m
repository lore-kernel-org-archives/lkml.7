Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B949BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD2D206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFNQL9Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfGaLTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:19:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45156 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfGaLTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:19:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so69219087wre.12;
        Wed, 31 Jul 2019 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KcDf9JPXvVOUHUqnGxxJEbg/DckgQKkqSGJL2PojFY8=;
        b=rFNQL9Ae+WG2F0nAgGCxgs7LLf0Lvn49SXyS7ddcptDWNih/oCuwS7zooUVnRCu4de
         vsw+SyMfiV0Cv9bj7PWLe6rFhn/fDvwFSMY9R/yBxSHIRHO7O5TVo8XCdlHDXiYCkSm9
         TR6+cYqdSNeDT52PYDqLZe2F7Pv+V2N0pcmiKM0tu0uwtsjUGegoX8LJQYJonCdnscGC
         zymBNMSUqAW0ZuThwHD5JYahaJJRckQsLSCQmopyDUz+OFkU3t91CAZFFWssF9D7PTj/
         +/67jYMBho/x73ZY2CZ2gBmWarAvS/9a81qoifjNtUF/kei43/qaaZGfNnY6kVPbDS7u
         1zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KcDf9JPXvVOUHUqnGxxJEbg/DckgQKkqSGJL2PojFY8=;
        b=grcldrlLdT9UhgjkfwInxzY8NdfTdfai8PVDyO14xouKukBOGUnfbEllUfDhbFRhVw
         pB1o4hbph3SnKO4jsAMAJ2yxGC/E3eJsr5D7KFFaU36X5rQ9QgNIR+0m29wMAPpe6bFj
         CiGUjBuie9E9gmShybRq0iupclGYrKO4bFiO3ECsJDb3zEcFifk3eJptKeJiJtnjH8lB
         xMwQJvAbbMOP26LiKg2AZgepBOBR/shYXm2ECPSOOWdNX2FYn3dQ2zGi3wfv1Qd4sHSK
         qsPZxMLVCR3y7pjigQhrmTSu1aHcRTAL1lhGz/a2ag1fmgPrKQEqH5Md4ElWjZp0Qi/j
         +w/Q==
X-Gm-Message-State: APjAAAVK+EwLFbN0z5OSgL9QVXTQOE3vVUwPqrM2ySieC8N8SsL0BiBq
        +iPsEWXrlSUDCuhCFhPRsfs=
X-Google-Smtp-Source: APXvYqyqXq6srNMThwdET1OBjnv0iw9Y8NEFRS4E/EE1rk9yKrazSMjmJXqsaTSy7P+uyvXCmHSP9g==
X-Received: by 2002:adf:c003:: with SMTP id z3mr50150385wre.243.1564571983946;
        Wed, 31 Jul 2019 04:19:43 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id b8sm88035205wmh.46.2019.07.31.04.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 04:19:43 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.wolfsonmicro.com, srinivas.kandagatla@linaro.org,
        piotrs@opensource.cirrus.com, paul@crapouillou.net,
        kmarinushkin@birdec.tech, anders.roxell@linaro.org,
        jbrunet@baylibre.com, m.felsch@pengutronix.de, vkoul@kernel.org,
        nh6z@nh6z.net, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com
Subject: [PATCH 0/2] ASoC: Add uda1334 codec driver
Date:   Wed, 31 Jul 2019 14:19:28 +0300
Message-Id: <20190731111930.20230-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch contains uda1334 documentation.
The second patch contains the codec driver.

Andra Danciu (2):
  dt-bindings: sound: Add bindings for UDA1334 codec
  ASoC: codecs: Add uda1334 codec driver

 .../devicetree/bindings/sound/uda1334.txt          |  17 ++
 sound/soc/codecs/Kconfig                           |   9 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/uda1334.c                         | 295 +++++++++++++++++++++
 4 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uda1334.txt
 create mode 100644 sound/soc/codecs/uda1334.c

-- 
2.11.0

