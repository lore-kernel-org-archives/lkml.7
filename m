Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D47C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88AE2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTW0wZ3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfHPP6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:58:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38945 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfHPP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:58:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so3329593pfn.6;
        Fri, 16 Aug 2019 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PoloVULM911anludKTQHYfSvmuLN6FTBR2hjXpDeBXY=;
        b=vTW0wZ3ZuNxw8rzOf7RKNLMdbJDK9Gz96Y1tf/keYFne0Sz53pJtgzLdxZG+sfluOX
         PosHcRRZxxTLnFtYkrtPUG/2bx+OOjICVlI+ZGngX20OncUlOi9p0E0WROb0yj7wP05H
         mv8cE1G3F6wzNiiasfpemOgmrTDKs/8LfQD2/p8NZ5scPd1CBrxlUoJNSafvN5ikxFHj
         HbfpKOU7sksv/B6NAmaT3X05oT6xBqlGydkU4DjRGtucdN/ERgH3zrpmrzFveHm7JGX1
         sq4CPUN+qZTLLxs3LpYB2LzXx/ywcNWbhipakKlwTByqmYrvDxc3m74O0IuX0VnVVcR9
         V/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PoloVULM911anludKTQHYfSvmuLN6FTBR2hjXpDeBXY=;
        b=Oonrsa0sJuaJ+9Z7b8y/DyG9Fh6hrzm2rukAdEsIlLpWbcGUERQGf73Vvp4qGZx1uo
         IJwdIXVWfORN9WIbdJFPN5GTT7OclopFOIqTEzJCzPGYi8IoEddzuoXvu9J2eSbYuTwy
         t8G1TsvBvywW9hL+mmAEPnB/4YY1jWp7OUEii5CcvQiPcb/pJT14W58XfAz2q+vR9P2o
         GDa7S91CrLPLPsyxSezVTAUQVF5seMtboysHfhYI7CUtuK9gZxZ/zamUODWL7w0x0IXW
         3671rkhONAiPwLwkSyXAYd6AhV6xP5dMH2/9b9FjGPo6U/ugQc25YGDsJSjr6dsgB9pK
         4WdA==
X-Gm-Message-State: APjAAAUd5nnNdEhlq1xNmLjGMae2vtgLLPxGTHCiXw6TNdEihKnVNh1K
        AQLGrD8oXRD9sojmeJ7pP48=
X-Google-Smtp-Source: APXvYqwO2QPstr1atjcPz6YfyQbIQS/NHnTkmgQZY8GHgLSuWsv1jS7yJiG0Xt0T9Ay9tYauuz+M7w==
X-Received: by 2002:a63:fe17:: with SMTP id p23mr8368278pgh.103.1565971097219;
        Fri, 16 Aug 2019 08:58:17 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id s24sm5746052pgm.3.2019.08.16.08.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:58:16 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH 0/2] clk: Add driver for ast2600
Date:   Sat, 17 Aug 2019 01:28:04 +0930
Message-Id: <20190816155806.22869-1-joel@jms.id.au>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello clock maintainers,

This adds a new driver for the ast2600 BMC's clocks. It's a separate
from the existing aspeed one as the ast2600 changes enough from the
previous generation to make it hard to support with one driver.

It has been tested on the ast2600 evaluation board.

Joel Stanley (2):
  clk: aspeed: Move structures to header
  clk: Add support for AST2600 SoC

 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-aspeed.c                  |  63 +-
 drivers/clk/clk-aspeed.h                  |  76 +++
 drivers/clk/clk-ast2600.c                 | 711 ++++++++++++++++++++++
 include/dt-bindings/clock/ast2600-clock.h | 116 ++++
 5 files changed, 906 insertions(+), 61 deletions(-)
 create mode 100644 drivers/clk/clk-aspeed.h
 create mode 100644 drivers/clk/clk-ast2600.c
 create mode 100644 include/dt-bindings/clock/ast2600-clock.h

-- 
2.23.0.rc1

