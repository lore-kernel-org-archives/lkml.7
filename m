Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF2DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1AB204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zyk5gtjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfJ2TR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:17:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44849 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2TR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:17:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so14873514wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=b2dn1SeqtrpMCE6ny/3qCkKIFN0yrPzK+VM5xpNw4d8=;
        b=Zyk5gtjpdLviBk9jsvEc7RR3u0srQtn1vTw21Hbym/7TKEtqDQ10J94GFRTW56KZon
         iegTxSsVi958hn92pams/H1a6pv0byz0R+RVVdIg9VlFqQP4TdVF2m/W3mbTTQJoExTj
         ff7oFJ9mjcyC4V1fNllS5vPG1g0vd+DhmJOD23iGdrzH9taOtdwZwx7LSZH4Br1IT3wx
         H2wWaXQ4Q+JelxMhRDW52Q4a+XvUAJ10bBfu3KPm7ieV5y/nh58Lkh7jrcvG/05CsW2w
         ExzFZU8zX+9phkTM6Ys7RBmB5tL3I1eQ8RbgUWuMHI9sn6liP8aK6Y0s6C+FtxlLII9S
         rhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b2dn1SeqtrpMCE6ny/3qCkKIFN0yrPzK+VM5xpNw4d8=;
        b=E6639I6QUyD+OaX3pBk/FR+wAyJRwnj+hMQsb/pneprgWxXkNNj90dJeq6qf1oTrZL
         M4QKGqtFOIOj6Qa8vGJhMaIBTq5ZqAF/zr2JLyKXZDrxh1LfKiCVYJrNLYcLCoRrNNAi
         MGz0bUrLlTdQkXtyF1kwvOn5VgWBX6wMnGfFa3lLGRA8Yx5thF3o1bGKTyw/Pz30Q+eu
         7YyekCxwZV0vnJywCyQYCHpRJFUsnuRAOJlIBDCinEYJ52cDIzs9FELFg4FaOVSSE97S
         F78gpo/55sO9v8k2t14M/iSHTeU59A1lSBFGf3Iyw0+eEKQwWTSTJHT7RqfoDfisVIRs
         Kfbw==
X-Gm-Message-State: APjAAAUf/nffOoxaN7XgwBTJlhpYjnlzENDEXaz/H6rJMwJ02vywlsuw
        bokThJXNP00bMrbpzAbzaAFPHQ==
X-Google-Smtp-Source: APXvYqyM2go1b1G/RM2lrR+mSRZw44cAY0wBRI/Rk71pe1bwQfHZOxviW2/DPPw2w8+V6inqVnkBvw==
X-Received: by 2002:adf:de91:: with SMTP id w17mr13462824wrl.322.1572376674466;
        Tue, 29 Oct 2019 12:17:54 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v128sm5493043wmb.14.2019.10.29.12.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Oct 2019 12:17:53 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/2] ARM64: dts: allwinner: Add devicetree for pine H64 modelA evaluation board
Date:   Tue, 29 Oct 2019 19:17:41 +0000
Message-Id: <1572376663-22023-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Pineh64 have two existing model (A and B) with some hardware difference and
so need two different DT file.
But the current situation has only one file for both.
This serie fix this situation by being more clear on which DT file is
needed for both model.

Regards

Changes since v1:
- Added the first patch for stating which model support the
  sun50i-h6-pine-h64.dts

Corentin Labbe (2):
  ARM64: dts: sun50i-h6-pine-h64: state that the DT supports the modelB
  ARM64: dts: allwinner: add pineh64 model A

 .../devicetree/bindings/arm/sunxi.yaml        |  9 +++++--
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-pine-h64-modelA.dts   | 26 +++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  4 +--
 4 files changed, 36 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA.dts

-- 
2.21.0

