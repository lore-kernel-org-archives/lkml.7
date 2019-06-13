Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAA1C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A803C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWRs0MOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbfFMPOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:14:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39763 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbfFMN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:27:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so3118007pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DBRBCInmQIIrq3PA/7j6razRSFLaq/I+7XxbaFaBLnQ=;
        b=OWRs0MOvTQ94JcwvOdnbboi+qx64+ffJgswSAsQUEEOS+zc6bCDDCTgvd9pBEJYwF4
         L9vOlhYIGA5Q35OK3q5Yh69ylWmSrNMSduyPeBdgT+EcBOo8ZuiofsU4OyoSInbTMq98
         c89La+XDApUi1xILQVzFR78tZqQfgtzp9JnfmMBhiGN5p5gvzjK9UI8vPzUqS7n6ow/W
         hM9YuZ5+RQFFSWQGsav+Yb5iVQpFg4A1YFjyTMQ2ggQNXu3CJB5mIhXHXwlyeDu3k1Yk
         4OVhNfBhQcFaDSmw8cJwskcSt8R4Qj+XK2HAcJMOXS/6C2e3r06b+sMxEXEicsMyhF79
         Lf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DBRBCInmQIIrq3PA/7j6razRSFLaq/I+7XxbaFaBLnQ=;
        b=YH7FvwSlcKkC5eG0wrFfoaJysfvzqeIGfpE3fp0jg07SpLsJTQJRyBLB/3v8RFuoso
         PftPn7V4RfkCXXYFqei68oqPiqZv2Qu0DzwNIzZ9cJFO/evjafj7/T5jG+XqwfEeFfH1
         LJyxtQQMmHKrgVtWXTOXr7HNSN5UDGh4Ogjv28VRbjbR/SKzDjiRcj9dCqCmuPQxzf3z
         bkbu7lqrcnFxwAeqZ+i4kytUY/ZAX+4jU97Jrd74UNRWXHh1SAGEpM0mny1vg697RZd0
         EM3UbM3/XYiR8JFdnEqAgONXQrs3+jLJfG2AKgob0OR0ctlUqebHg3J309Z7zNu0Ocd3
         Kiww==
X-Gm-Message-State: APjAAAUqW20SeeZYOAODeqq8vU3LcDu5SJzbXPRPEMxbvdpMd/lgJ/wt
        EwpewFtl3jCj5LiC4rGm0AWC
X-Google-Smtp-Source: APXvYqyd2679N/PfxZ85sAdFYaSA5u2C4jSlTrIU9KwIfjTJrcqzpCjPqiE5WmFoLe+yIqqlKeqbfg==
X-Received: by 2002:a17:902:868b:: with SMTP id g11mr85197609plo.183.1560432438394;
        Thu, 13 Jun 2019 06:27:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7141:4858:bdd9:1134:3bdd:7ab4])
        by smtp.gmail.com with ESMTPSA id y14sm1837pjr.13.2019.06.13.06.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:27:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbrobinson@gmail.com,
        yossi@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Add 96Boards Meerkat96 board support
Date:   Thu, 13 Jun 2019 18:57:03 +0530
Message-Id: <20190613132705.5150-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds board support for 96Boards Meerkat96 board from
Novtech. This board is one of the Consumer Edition boards of the 96Boards
family based on i.MX7D SoC. Following are the currently supported
features of the board:

* uSD
* WiFi/BT
* USB

More information about this board can be found in 96Boards product page:
https://www.96boards.org/product/imx7-96/

Thanks,
Mani

Changes in v2:

* Addressed the comments from Shawn on board dts.

Manivannan Sadhasivam (2):
  dt-bindings: arm: Document 96Boards Meerkat96 devicetree binding
  ARM: dts: Add support for 96Boards Meerkat96 board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx7d-meerkat96.dts         | 389 ++++++++++++++++++
 3 files changed, 391 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-meerkat96.dts

-- 
2.17.1

