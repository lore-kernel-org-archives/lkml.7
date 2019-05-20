Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4286C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58AC213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cGIxTaAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbfETOgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:36:51 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40256 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbfETOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:36:51 -0400
Received: by mail-wr1-f52.google.com with SMTP id h4so14904554wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFRzHXcbH/njSoGGo1Gbge1+dcPHXnbF0eN6VmDGfKk=;
        b=cGIxTaAv7Xxcx+gwpdz+0E36ZfBnEKC49CjmBmWKp1oag2/nul4LIkhXLIDtC28CKS
         s7+A37RJlbOJLnGk4r2rvohjxHlAqHzgliP1t36VSosNA8knV3qKQtCm7cg9QKSDXjYW
         /vK5jjh3nyiv/thu4IOsnIFKIfwXwo6kPct7PmhrhZ4QVo/LTxwDkmQXwpEJC6o+gj8R
         z9b8CjojJPGxCb1T6epaj/IkfT6df3W9XGi4gxlWoK34sk9Y/EqSbvOPRrE9kdYtRhr/
         FlXHQsDAbi+detoTyngqRN+xLcznwSjKiDT2LsULYZMpHr8LXeLMXXmsgQ/GQfPiqd+T
         v6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFRzHXcbH/njSoGGo1Gbge1+dcPHXnbF0eN6VmDGfKk=;
        b=a6/Q1kXT1qnS74lLd7T8tmiq+JA9jZsWHiDT54SPpiSfbOKkjP20GdCgf+EEJo4jdB
         O6vLyi7Z8lZQ7e3VnNPVZGkpNgpE1lHXrTDE2MRVU8vDf5wnIh463GuXvX56Dj7ctpxt
         p9ULi0ex4SUb1v+bNu2B5F3VcC4J4YtuQWJdIEDJAkrk1DxiIN8TJQpLsnMOQpcQHHWa
         K5vSyV4b8G6nSabGlnqFmFhDAqKzCY1WO5z+JF1XbxFd9WP7uqjPoBOTbR/LUfZg0vgG
         hbOWlqz9S53do2C2y0ZcRUqXnn+ZPPNxuh0K7jpADgwAJQNxzkb28mOTof0JUu2uvmvp
         l4ug==
X-Gm-Message-State: APjAAAXKAitY52wx/BFBSFytZFk8pTE6uAX7DBxnMu8tJZAehWkJ/YnI
        xvrzYdskwFUntp/GIzxmQCCLig==
X-Google-Smtp-Source: APXvYqzIAdN8iLbDHuNeo3JWIWO1opaYbet7cj7r+qxT8zkkAZ5YaL/XT5xl6XMxfrwKdAM+J/6Krw==
X-Received: by 2002:adf:f548:: with SMTP id j8mr11400171wrp.171.1558363009994;
        Mon, 20 May 2019 07:36:49 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a10sm20518729wrm.94.2019.05.20.07.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:36:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] mmc: meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:36:45 +0200
Message-Id: <20190520143647.2503-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic MMC drivers.

Neil Armstrong (2):
  mmc: meson-gx-mmc: update with SPDX Licence identifier
  mmc: meson-mx-sdio: update with SPDX Licence identifier

 drivers/mmc/host/meson-gx-mmc.c  | 15 +--------------
 drivers/mmc/host/meson-mx-sdio.c |  6 +-----
 2 files changed, 2 insertions(+), 19 deletions(-)

-- 
2.21.0

