Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ABFC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E5F2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2P5mpaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfHRJei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:34:38 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40671 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:38 -0400
Received: by mail-wr1-f45.google.com with SMTP id c3so5636228wrd.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKeAlNEc3rXnBz1KhBA8MjW9VAbwSC7UB92heLeHBMk=;
        b=M2P5mpaJ6nbuBifjaGoOVw004maWiNPdsQT3vY2C9WVaG5Ph7qlI0OskXyUxt40fl0
         ypdEHYSxaeFwgGNRe/WNV5VhUQ/RabhxIpHBozlYsp6QoW2o9PeObe/nJYeuuJUwhq0L
         JpkjZoQZQq/mz1b+9/bkn6D18tqyQgo/m0KTbMCq6uRE7vwmZ3XZm8X29J13GyKgwIvg
         Vl7bPELu8gK2M2xjvVAGZmUUKLfZi5+IQxJolz9T4g6eGVsiLccp/ez/M1rDQSaZqzqw
         0bmbhM1rcJRfVzS85Yf+RgQMr/SAKrmltnTtLaKxkyPsX4w3dNNTIi21XwSTAZ3U+PHj
         uiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKeAlNEc3rXnBz1KhBA8MjW9VAbwSC7UB92heLeHBMk=;
        b=J1KW2a/MkhTLD/xo+OxE/JsQOF8hZqHg141kv0hZH/QqNBQAyI1hWt4wOuO3ecNq7Q
         d3VzWkPLGEzNPk4De3w6Qm9JP5D/CoPCl0U0QCvq8vpupqYmBAKMNgEsry9TXY2K2rZE
         WgM9GQmnfl62uWVtP9JNPVWcg1aMG2uXPNdz4JcioyWo9qylZUIWq9RK0WX9VW2aKLYB
         L1RQh/8JshZA0mLyC2jqOpA3kYMkPT8JTE9ZpsvTzEMF1mlJ3kwyKR+f2xxMjsshWtKY
         PJ3k4MJD8pxvN2x+HBCrvRHPWAOOmpWNQVmmGky8o5jx4aQ9y7qD7ImACDeGODR0PJrP
         mgHg==
X-Gm-Message-State: APjAAAVq0Xi9FNZ6qnfLMlLx9DuSQZKXLyNFqHaQ4Q6CecJ50RXpTPpH
        bYJbncEY6IRW4BwYoNZBrsZFvRoXHDM=
X-Google-Smtp-Source: APXvYqxOlCp3iVZmz462kToWv7xGzyup14m++kaOUFoHWlrzn8EnvpPryC+24lNvnQs4lWD1Jll4jA==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr20338812wrv.39.1566120876134;
        Sun, 18 Aug 2019 02:34:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w13sm25042828wre.44.2019.08.18.02.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:34:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] nvmem: patches(set 1) for 5.4
Date:   Sun, 18 Aug 2019 10:33:38 +0100
Message-Id: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.4 which includes:
- adding support to new imx mx8mn octp and mx8qm fsl providers
- fix for smaller word size in meson provider and fix in sunxi provier.
- finally author email update from Stefan 

Can you please queue them up for 5.4.

thanks,
srini

Anson Huang (2):
  dt-bindings: imx-ocotp: Add i.MX8MN compatible
  nvmem: imx-ocotp: Add i.MX8MN support

Fugang Duan (2):
  dt-bindings: fsl: scu: add new compatible string for ocotp
  nvmem: imx: add i.MX8QM platform support

Martin Blumenstingl (1):
  nvmem: meson-mx-efuse: allow reading data smaller than word_size

Stefan Mavrodiev (1):
  nvmem: sunxi_sid: fix A64 SID controller support

Stefan Wahren (1):
  nvmem: mxs-ocotp: update MODULE_AUTHOR() email address

 .../devicetree/bindings/arm/freescale/fsl,scu.txt          | 4 +++-
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt      | 3 ++-
 drivers/nvmem/imx-ocotp-scu.c                              | 7 +++++++
 drivers/nvmem/imx-ocotp.c                                  | 7 +++++++
 drivers/nvmem/meson-mx-efuse.c                             | 3 ++-
 drivers/nvmem/mxs-ocotp.c                                  | 2 +-
 drivers/nvmem/sunxi_sid.c                                  | 1 +
 7 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.21.0

