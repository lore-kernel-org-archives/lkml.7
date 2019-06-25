Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F67C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0FC215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="M2hQ4mXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfFYIlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:41:36 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:38939 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfFYIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:41:36 -0400
Received: by mail-lj1-f169.google.com with SMTP id v18so15368192ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjgwcyJ55IU5CCabgiaO1OsncTqE3O0eNT0VvDy1+GQ=;
        b=M2hQ4mXh+4jE5DXo+Q21Be/cCzrAQDjHugIax3ds73ekaqhpev2mI6qQKiTsDafOq/
         7F9FrubHdDAGmfl5JwkVhvEksyy/N3UTi+YD1on3V5ZU/yU3RPuYuLxU/28OR3x3N2u4
         Ax1MVgGHv5UJyO6TE23YTw58j5OYNnQTN61st9LBqJqXRzCNYRFrjaaMHaOXqwuIC3DY
         BkUH9iPvTuk9b5dYdEw1lifvRllOZ+TtqR92LHYxy3j20FQapAom9YvNQGIRL/6h6O12
         n8SOdWo2fSvZN9vafdiD6b2G2p2qhLSmuRLsIsedi51B3i6w++f+mxL22ryZ7HzCl0bt
         p0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjgwcyJ55IU5CCabgiaO1OsncTqE3O0eNT0VvDy1+GQ=;
        b=Z3T2N62fgQHg50qJM+faOw2pwuHhobpvEZm9wVOHwODVYLn+aeFcsD2tf17OTWZgLc
         hvStUMuS6nBSdOAyRxWsJMoT/rbhULHMXspc/rhhfdLt3Fhm/xZaAqOVOTFOsNdJZFoz
         y8mx0XgvBS94REvLyh9YlbV2k/L+L4G9u6vsusXsBXAC9w1oEiXUoD36HTnT4X08CAfi
         TXD9oC4m0thAYIYVDO7wwFc9/nSpM3DKsQsRM6FB8Y2DbTzKTkb29PWJOSfbypLspADI
         xp3dhKcUq1oijb9bOTBQ/kvDMPrurpxHdLSgcDfdf63fJrxv5s6N9yaDe1S1BRVCCtbj
         iPlg==
X-Gm-Message-State: APjAAAUS0mi5dV13D9iQ7+AtobX9B3zslzNVufrjC/SJPgmHXoHSVeFu
        GHetoPUgjpvty1fXtYoNGcvwpw==
X-Google-Smtp-Source: APXvYqzyGcO4jNOkWAE+BhdGm3BGzMd6xcusm2A/UD2H84B2HiI8UCVcCgR8Xt2+j9HH985V/P7NkQ==
X-Received: by 2002:a2e:8181:: with SMTP id e1mr1405423ljg.226.1561452094275;
        Tue, 25 Jun 2019 01:41:34 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id h78sm341564ljf.88.2019.06.25.01.41.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:41:33 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 0/4] Minor style issue fixes for staging/kpc2000
Date:   Tue, 25 Jun 2019 10:41:26 +0200
Message-Id: <20190625084130.1107-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some fixes for minor space, parenthese and brace issues in
kpc2000 reported by checkpatch.pl.

- Simon

Simon Sandström (4):
  staging: kpc2000: add missing spaces in kpc2000_i2c.c
  staging: kpc2000: add missing spaces in kpc2000_spi.c
  staging: kpc2000: remove unnecessary parentheses in kpc2000_spi.c
  staging: kpc2000: fix brace issues in kpc2000_spi.c

 drivers/staging/kpc2000/kpc2000_i2c.c |  6 +++---
 drivers/staging/kpc2000/kpc2000_spi.c | 18 ++++++++----------
 2 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.20.1

