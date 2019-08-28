Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963EFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F7D20856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxdtln2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfH1U1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:27:35 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38224 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfH1U1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:27:33 -0400
Received: by mail-pl1-f169.google.com with SMTP id w11so488420plp.5;
        Wed, 28 Aug 2019 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oa6hwJmjbKjuqI8KO2uQ2NpWyR7vXRuA7cSnTsaDRIs=;
        b=Uxdtln2knW+a66Nvahu7hXNoA79NZzi/SFnD3iimU/bnbJJwkFMf2VAlfAys0QIQmv
         5EgHJcGm3vRv0rCXec46xJMD9cx5CHWlL87gsa3z2K61OXRvGmPdiLGZ8DhHQiO/Z7aM
         0H//UheQy/CrJYQMYJjnX1Sv8J0AfEJI5XHlrpRh8rRY/0vYoVonNyEcZk+Pqbi8wZ54
         kqecVYNYdkFdDaCy7iGpQXYbV3Qb8iW5Cw+snpvlcWNkD+NTmywWR9lb0JDKtEncTuZm
         qIYWwYwbgBgnI00oxT/B6w3nfqR1pyn4AVXWpQ+2JbPce5p0P0baNP0c7sYb2gQ6FLKk
         to1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oa6hwJmjbKjuqI8KO2uQ2NpWyR7vXRuA7cSnTsaDRIs=;
        b=NFatfq5ELCnMVWlsJlEsGOAd9ufcxIldf/CyeQ+Y6vhDK40xUFeni1JxelLrWlWn5E
         PgsjbBPIhwUaizB6YGOXIE1n84hppPD775gtURNieLFVs8CxjWJFcgIAA3OUVF9Wj9S/
         U9H1OOzAoMtBX1ViJoRIdpyenPionBwHTJ0uOjMiX5Qwa7bSA6sTkx0BYf3yhQBE65tF
         L4XskmJ7fzSxpg3krf53n+3+Snxvu8sAZAq+iPOY3PHJXFV1YkN9NYNBFJXPkmVSFZzy
         W17Z964q/lbBlGSHtlcHEB3KznmwOhBUDS8YV3w0tq9PGvORnGsTixyFuccq57oku7BI
         2hGg==
X-Gm-Message-State: APjAAAXvGFg5IfQ5XhQ1hZZotNrMGJsWqFNJBlTna9TEIeKu2Fs18LdJ
        W7Q9TS17++2m0FVYXZ7mafk=
X-Google-Smtp-Source: APXvYqxuiA+0iXSqabEEiaHcDthz8NSS9AsGph/Zx11FbtNQgeEo36tT66h3LGF0XtVp+EJXHYEiQA==
X-Received: by 2002:a17:902:1107:: with SMTP id d7mr6091471pla.184.1567024052408;
        Wed, 28 Aug 2019 13:27:32 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.111])
        by smtp.gmail.com with ESMTPSA id g2sm253373pfq.88.2019.08.28.13.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:27:31 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv1 0/3] Odroid c2 missing regulator linking
Date:   Wed, 28 Aug 2019 20:27:20 +0000
Message-Id: <20190828202723.1145-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below small changes help re-configure or fix missing inter linking
of regulator node.

Changes based top on my prevoius series.

[0] https://patchwork.kernel.org/cover/11113091/

TOOD: Add support for DVFS GXBB odroid board in next series.

Best Regards
-Anand

Anand Moon (3):
  arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0
    regulator
  arm64: dts: meson: odroid-c2: Add missing regulator linked to
    VDDIO_AO3V3 regulator
  arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI
    supply

 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 44 ++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

-- 
2.23.0

