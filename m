Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CIPOqkzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfCRUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:47:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35079 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfCRUr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:47:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so12699196wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xdEjMClilgNv8/8kONKzwjjh/piLUyVN8GRovW1S520=;
        b=CIPOqkztsjF0JLMSRllS4l2mccMHIMLYaAz7gdg/mdMwXpDdJ9ReuODAQHuzQbXkjS
         kQq2iHPbq5BSznOZVbjyQ+z6mRjXvzHQ9JloW7GX3fiVdpqN7KoQeoQNHnSuyYCS0kvO
         KpOdDlwlTNC2aFQA8oPEQmVqPVnWmHKo47Tuy+xvi/6pbREcveueGEM1MaO+9d+pc4Gt
         3OJe8is04jvXlDPnOiFXzxS5xjHuEpHcGjW3KQUAl/M8z1cnYsCqZNSR9hF2wsZwvLE3
         Fpl8gHEos6FkjxTaWpFePDx1c95iIXpeZHfL34edKcE6qY+u5w7Iq/6dbnpelnXWB4IG
         vwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xdEjMClilgNv8/8kONKzwjjh/piLUyVN8GRovW1S520=;
        b=M9FmWSGczpHNRAHDJedSF8aHMZDtLIg6aEbyz+wIqWaAD2nMg/nWoDsSGDOnShqBwM
         2/Ci+33doObKJCXszwU+9TlWcNOcdAtLigT8TgSObp0LNPJn7M9ZMVIzd+osj9shJxn9
         rwDomnV5SAvJfe0doXqhDruE562/JAjgX9FezeffX2TshTBqZLdJ7Z1WVqEC1t+EBlqF
         tXHuKQStlBx9gbk2ptYThkCbRiypEx2LujGD54MhBZ8cV24ya37i8Qo1QnH+HedMhSUF
         /s3HkpiV8gbU0sp6vowvvP2AlUiYbdPFEXQnIRCcjz0J6NQ43XiYuWXIpoGFD0vHzAsB
         JCqQ==
X-Gm-Message-State: APjAAAUXpHfzyrrev7X0+q1zto8h+H1Fc24/12iXDdcQgJGPwEpTerrQ
        PnVe9rh9bq2wzKq1c9RTaks=
X-Google-Smtp-Source: APXvYqyAj6VPfPkkwt0HGRwCHv7yvs/hbUKdXalZBFEtOcrjvQmJ0Y4YnXiV7Nga5VPbpKF8Z8Z5sg==
X-Received: by 2002:adf:82c9:: with SMTP id 67mr5757540wrc.261.1552942047561;
        Mon, 18 Mar 2019 13:47:27 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900918378ACFECF051C.dip0.t-ipconnect.de. [2003:dc:d739:9900:9183:78ac:fecf:51c])
        by smtp.googlemail.com with ESMTPSA id y12sm224849wma.44.2019.03.18.13.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 13:47:26 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        bbrezillon@kernel.org, miquel.raynal@bootlin.com
Cc:     liang.yang@amlogic.com, richard@nod.at, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] meson-nand: two small memory related fixes
Date:   Mon, 18 Mar 2019 21:47:20 +0100
Message-Id: <20190318204722.9901-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to add support for older Meson SoCs to the meson-nand
driver I was experiencing a crash in meson_nfc_read_buf(). While trying
to find out why that happened I inspected the code in that function and
found that there's:
- a missing check on the return value of a kzalloc() call
- a potential memory leak in it

Both fixes have nothing to do with my original crash (for which I'll
open a separate thread).


Changes since v1:
- collected Liang's Acked-by's (thank you!)
- rebased on top of v5.1-rc1


Martin Blumenstingl (2):
  mtd: rawnand: meson: add missing ENOMEM check in meson_nfc_read_buf()
  mtd: rawnand: meson: fix a potential memory leak in meson_nfc_read_buf

 drivers/mtd/nand/raw/meson_nand.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.21.0

