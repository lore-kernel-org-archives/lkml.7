Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32CBC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F3520850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQkM3zb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDNSFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:05:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41545 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:05:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so7448314pfd.8;
        Sun, 14 Apr 2019 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxtAWt79LINx6AhQK0vzVvPhTuuv9NiQ9uCVJgHz65Q=;
        b=oQkM3zb/X5vReshuvHnygcTT/6XAxKeMVV9wfjxwoU2whd/apLk7+7CqUZzn8Bffsw
         bGbuYUF7tZH5Xy+XDZaAFBee8yf0w2joCleUxX/NLK8CeLEpntW7KDxLm68IXq2+Kenn
         5OYYfZGcgoQ78dx5x3y1JqdRIV4YO15UFdHDpIKmKWUIfK/tAEFyFS3tBPeshpGQbnID
         zhVPGUPglxdbA3FY9vwVONdNBIn4KSiDEfPXecpv1yIXUfBW+u/Xl6u4jAv1klHbVXFq
         NlopcmFB89eqwqzLp8h0qm7icIhirzVOJUIU62juUris3N0u8Ot9XRV5R8NDZux1eyno
         Btrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxtAWt79LINx6AhQK0vzVvPhTuuv9NiQ9uCVJgHz65Q=;
        b=Y/fTcBSJT5f/OAJ6bAckn5Hs37VOsRSN6qnkgIvDodInTHgCCzhH5rEenr8bE6coJK
         bWdLqua0A+KSXiuHfDmeDhJUzTmxgDhWsix6r3LV6A9ryX1B9vDwL/hNaHG2AGDimU/7
         nA0J8feOnsm7pJR+rM1jkci7QAbYQevnwdpCph1B0nu9qWyU+4+v4z7EM4kTT9nlEvaA
         vp14lyNyhObzC/TS1cpmGd3jAOuRyU7K8y6kQYJqRTepmgYZWMOAFBtkPXK+4mZGJ74r
         iFtbii/TpZlgkeJLwJshre9VUUlwBl+DIqhYbiYfTcqbCMTvIZJLYac/dUwiQ01i5OMH
         pnYA==
X-Gm-Message-State: APjAAAVgjsrLraaeb3OIKQaKKe5kXPYQbVprDtn5w/9530icFPBbF01r
        YigPC1voXmrRT5bokb49Plk=
X-Google-Smtp-Source: APXvYqwFpZ/4GfRnzlhZVPz3A/0bDRPJQFqwyJrpw/w3/SVtSkx+dklld3heOl3sRuodIkR5v8rwkQ==
X-Received: by 2002:a63:e850:: with SMTP id a16mr62701283pgk.195.1555265146177;
        Sun, 14 Apr 2019 11:05:46 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e7sm43359712pfc.132.2019.04.14.11.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 11:05:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/6] Introduce machine-specific regulators coupling API
Date:   Sun, 14 Apr 2019 20:59:33 +0300
Message-Id: <20190414175939.12368-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was looking into how to properly implement regulators coupling for
NVIDIA Tegra SoC's and ended up with this patchset that introduces
machine-specific regulators coupling. Upstream kernel now has support
for a simple variants of regulators coupling in a form of limiting
maximum voltage spreading between two regulators, but that's not enough
for the case of Tegra SoC's. It's a bit difficult to support universally
all possible coupling restrictions in a form of device-tree description,
so here comes the machine-specific coupling API which allow platforms
to customize coupling algorithms.

Dmitry Osipenko (6):
  regulator: core: Introduce API for machine-specific regulators
    coupling
  regulator: core: Parse max-spread value per regulator couple
  regulator: core: Expose some of core functions
  regulator: core Bump MAX_COUPLED to 3
  soc/tegra: regulators: Add regulators coupler for Tegra20
  soc/tegra: regulators: Add regulators coupler for Tegra30

 drivers/regulator/core.c               |  89 +++++---
 drivers/regulator/of_regulator.c       |  49 ++--
 drivers/soc/tegra/Kconfig              |  12 +
 drivers/soc/tegra/Makefile             |   2 +
 drivers/soc/tegra/regulators-tegra20.c | 304 +++++++++++++++++++++++++
 drivers/soc/tegra/regulators-tegra30.c | 256 +++++++++++++++++++++
 include/linux/regulator/driver.h       |  14 +-
 include/linux/regulator/machine.h      |  22 +-
 8 files changed, 694 insertions(+), 54 deletions(-)
 create mode 100644 drivers/soc/tegra/regulators-tegra20.c
 create mode 100644 drivers/soc/tegra/regulators-tegra30.c

-- 
2.21.0

