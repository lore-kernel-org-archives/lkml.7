Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E9DC4646D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59A920665
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMX0Cm6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfF3RY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 13:24:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35960 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfF3RYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 13:24:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so10656790ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GFCzf2qYFkFg+4VKLMFV4Jixzxe0BQO8ulzJAgHRDlU=;
        b=lMX0Cm6LTzBuz+GHYDw0DNMsSrZKxRSBoVT4X7KPkCYaRNDNuqp58zcRnME8wwOcjL
         RTt9eCCiXyF3G1LNlJaXYWNpZrTmMep2KnZ+C6G/9mUT71kvIaW9TmW1evExUi3ndh0u
         ymN77nvvdUXy8MprSwEjZAwSsPAZpbuXv/Gzu7pZsFWin0Fd21ujRNcha+iY7eZeRn9e
         9I3fRo5LQk9SI4Ob3706WeVB/gFYYUM8h3086qitcZrpEvB+DNhzEdYBnQh9fH+CDCi5
         SgjSWD2j4sX0knHWGtdB5YSXRsyiDo9XAy/8Srqb2XlwX4MWfTkqzDCbRXcI/ACyZifP
         Cutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GFCzf2qYFkFg+4VKLMFV4Jixzxe0BQO8ulzJAgHRDlU=;
        b=M1h+TGXFw5cxTqzi2HGxOZebeIqjR523lO/A+2ydTzf5VoLWptpeEQc5fL/taD1VYm
         8btkQNeokeBNdKgXMBs6cLXWAs7rlQRz71K1h554ttzfQ4sSW4CCXPgJU7jcdfTKS1UE
         EGcLyMPn8lPPVxAnht1wUEX0eqVUHfOStUagcPGNZN4WpdOz8daLV1nlkEW7nue105HE
         lYHBwllN4H/vQq2p5Sf5Z+nVocjD8DmXbwZU9e68hnr96eMXJ4kzrbZcps1oU9c9D/P9
         sjKUPyr1eU1VR9ZHEcC7aT12mNuLzyNOaX+NPd7pGNGtaogqUOaDwGkc/bT77lVOd9v0
         vj4A==
X-Gm-Message-State: APjAAAVSdQ47xeEt1C48pSGOUzMXvkSWKvyNUcSnvAwBKbz39HhlLdEk
        0t9Yw3MSoap/HCZqYBz+emH8iA==
X-Google-Smtp-Source: APXvYqwAXi5uK3x1DFuhXQqmX1L9KHW5byM66gGMbQ8wr8qpQgljkcF3+f5HnY6iVrxdeUMLUEmmMw==
X-Received: by 2002:a2e:8849:: with SMTP id z9mr11396486ljj.203.1561915463532;
        Sun, 30 Jun 2019 10:24:23 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id c1sm2273795lfh.13.2019.06.30.10.24.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 10:24:23 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 net-next 5/6] net: ethernet: ti: cpsw_ethtool: allow res split while down
Date:   Sun, 30 Jun 2019 20:23:47 +0300
Message-Id: <20190630172348.5692-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190630172348.5692-1-ivan.khoronzhuk@linaro.org>
References: <20190630172348.5692-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's possible to set channel num while interfaces are down. When
interface gets up it should resplit budget. This resplit can happen
after phy is up but only if speed is changed, so should be set before
this, for this allow it to happen while changing number of channels,
when interfaces are down.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index 6ab0cec8560a..99935c1d265d 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -620,8 +620,7 @@ int cpsw_set_channels_common(struct net_device *ndev,
 		}
 	}
 
-	if (cpsw->usage_count)
-		cpsw_split_res(cpsw);
+	cpsw_split_res(cpsw);
 
 	ret = cpsw_resume_data_pass(ndev);
 	if (!ret)
-- 
2.17.1

