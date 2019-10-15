Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B73DC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D442C20872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNB7zsId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfJODbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:31:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44350 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfJODbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:31:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so8875619pll.11;
        Mon, 14 Oct 2019 20:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcTiANv3bdbvw944ObmUJeWBJyrPQFWZ0rLqctEkp3k=;
        b=kNB7zsIdYUG3wLG6gGYVv52cd+gyptFAO4DIh6Z8KZ3IWYgVUBSYnbnYvHogqvoZHq
         CdAowTkTxenQFx5sh4/Oh2vPHdy/2Fqp+oEYCrmz36cYzOTZU6sulNPyHfdCOtmi7wqR
         n/32uySBMaCkubkVGFSOD+75IsaKFhFm2a2c4c/G0XnUaiRETiirn1EfojiKOHbA0Q0T
         18aBDoRqBkS4kJf0kVtxzBstftE6RJeX4ZleeWkNFwu5fM4w0ffxMK9Y1tqLWK/0ydx/
         SGq6lR5VOQY4ejQk+Ft0oBP1nNeqndhG6mSlyIepZ1JthtHdfQhRd0649Cj45MrSeHvd
         u/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcTiANv3bdbvw944ObmUJeWBJyrPQFWZ0rLqctEkp3k=;
        b=QyW5/4NLYhd3cGwx5eZfrTShOTCIQq/ynVcXx33N/kcIeShJK1NaHtlOL3B0j6uBU/
         b+E9QQqMRwyEE7zSkXtdPvIe4LY8yyEZktTpdCqZGzqkrsSw2C7tjPRcNMgzlbfEHU/R
         lbTJZqkGjt7ajgzjzDQymTMpGAtw9Lh9yrZsIpGmPEsTVuqeV1Gv7KPITrdNj0CKmrg0
         XByKn2wamDVNgXoWHvXuQ8L3m4jQi9hlFy/RSjS1N37/8RgETb3h3HpREIFhSxEjVkGl
         0BSsfd4Qh4bsug2ALZ87YfB1jgWJxZCv3NLDej0inydroxkpOA2BNNB5WEB/ovVnP8Mc
         QgIA==
X-Gm-Message-State: APjAAAXu7h/IdVBQWKys2mLOP1uTMqGS4NbuI8IWgw3rSfTn6t7Zk3KG
        JYhtV50ozwLPySPkH5z6HGxeqDAY
X-Google-Smtp-Source: APXvYqyKaU0kicO0Q8U5Q4TPzIszdr401voEh0M21j5kNj87ZilmOxqwqkZMY0fhNSvAhGcigF7eiQ==
X-Received: by 2002:a17:902:b70b:: with SMTP id d11mr32144741pls.339.1571110290299;
        Mon, 14 Oct 2019 20:31:30 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id y9sm7808565pgq.11.2019.10.14.20.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 20:31:29 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v3 0/2] Add support for AXI DMA controller on Milbeaut series
Date:   Mon, 14 Oct 2019 22:31:16 -0500
Message-Id: <20191015033116.14580-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The following series adds AXI DMA (XDMAC) controller support on Milbeaut series.
This controller is capable of only Mem<->MEM transfers. Number of channels is
configurable {2,4,8}

Changes Since v2:
 # Drop unused variable

Changes Since v1:
  # Spelling mistake fix

Jassi Brar (2):
  dt-bindings: milbeaut-m10v-xdmac: Add Socionext Milbeaut XDMAC
    bindings
  dmaengine: milbeaut-xdmac: Add XDMAC driver for Milbeaut platforms

 .../bindings/dma/milbeaut-m10v-xdmac.txt      |  24 +
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/milbeaut-xdmac.c                  | 418 ++++++++++++++++++
 4 files changed, 453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
 create mode 100644 drivers/dma/milbeaut-xdmac.c

-- 
2.20.1

