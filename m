Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D28BC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D0721734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ukY8+mEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbfETOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:34:59 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38687 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfETOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:34:58 -0400
Received: by mail-wm1-f53.google.com with SMTP id t5so11946984wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+BMa4gsX2SpWHDg4/WOwzhZkAoB1v5cWmwKV6NHcXY=;
        b=ukY8+mENM/jud63R4hHoyLnpb5YoLntE59nddqMWgAWBxvI8Ge+UqHnh2bsKJMcHrg
         z4bfVaI0pNwpaiTKqWx9fvMdMUE+3W1FE9QBzIUA9kpLOhx+VTOAniJ7Ys+sLj1VP8jO
         q5uurLzzFO6dmFja+ooLoRdGt9x6ZaUlsgBi31xyuSapXUPbNylOjSx3gBMPbOcPKU5C
         AK2lIN1NNbvyviI+UaDdFYkSKP/dtX468MCfLg/UCqGZQWza7rz74tCw/Gisx5P0N+/g
         UmU60+F+YHqLMfcdS1P+tY2ZDYVWXYicA6VdTFokP+cKB8ZC0ZmmLcb/txe/VdsBhJq2
         PhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+BMa4gsX2SpWHDg4/WOwzhZkAoB1v5cWmwKV6NHcXY=;
        b=MStfZFHFhA/MkMxLkEGolGE5HNYNuTng4aEPCxXoPQlwzSlKHsRw5ODSKAWpop0Hna
         /9mmicdAPEtg6RT5Ik9xsKgECl8pOqSrPFCimsiJBUCAPV9TmlwOjZsdXT94ZIAsGCJ/
         bvu6yk424KaZ4Gk06K7UlCqh6BaO4FKdOfwTw9pp8DC1eF9/2svAfHBu00N4vew3x92u
         8rM8pp4X86Mv53X6vUIfcPDAM6iQXViwl4tclVIlzpHQbbw8em5gAtkc2Of7wajsQEzs
         7y13B8qPx72Ple+fun8aGxn/8ZT7YhTy55oH6GgAvE6r3ehQkRhVDZvX5pDUKZY79khA
         Xk5w==
X-Gm-Message-State: APjAAAUebGFZzwklmt83MQYXTap82f17+NiBm3aL0WB2xz1dMAauy1sK
        SEjR2Btd5f93gq3Ef0Y5H0l86g==
X-Google-Smtp-Source: APXvYqzlWv9ZU+3BpEhFfR0ZEw53esmcczKsZgnkpqrvwm3DR8JioPy73X+ScQPOKEO+mUDg1IMuKw==
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr8758291wmh.148.1558362896292;
        Mon, 20 May 2019 07:34:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c2sm12756186wrr.13.2019.05.20.07.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:34:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH net-next 0/2] net: stmmac: dwmac-meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:34:48 +0200
Message-Id: <20190520143450.2143-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic Meson6 and Meson8 dwmac
glue drivers.

Neil Armstrong (2):
  net: stmmac: dwmac-meson: update with SPDX Licence identifier
  net: stmmac: dwmac-meson8b: update with SPDX Licence identifier

 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c   | 8 +-------
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

-- 
2.21.0

