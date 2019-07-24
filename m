Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF90C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E56D214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998635;
	bh=85TZvY90Gulq+3qFamnVICFHB9OgplZysqG7hO2qies=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iQmED27ZuEmMi7aOvWq3StxBEVYeue/lw8vu6YeFohVxVK7nD0EoTLY20xRpTAwNu
	 oE961a+XZjnuFEVTtYTld/NksoA7LfqBJSw4k+/2LKX9Zq+VNEYBrUQgIMlWVJIEvI
	 zaUkDQ7ZpgRfcHAq8JMoMh/6mEbqlz0jxxKaQclg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfGXUDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392316AbfGXUDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:03:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660C6206BA;
        Wed, 24 Jul 2019 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998627;
        bh=85TZvY90Gulq+3qFamnVICFHB9OgplZysqG7hO2qies=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCwCHgQ6B/a/F8mdz/qhLxs8urhknkZUJ3gj0cdlOTrk8u0mY9zip/awQphtSQXbC
         HPQdZz5hLRnASXJpG3zm8utKK3/UyvcOB9NbzfT7PQcMUp1lLhlSolyQznQMvbzcO5
         f+MXJ6R6CruEIQ23+t9CEUm0PNaaiEE2Ue7pqNFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/271] media: fdp1: Support M3N and E3 platforms
Date:   Wed, 24 Jul 2019 21:18:48 +0200
Message-Id: <20190724191700.202894357@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4e8c120de9268fc26f583268b9d22e7d37c4595f ]

New Gen3 R-Car platforms incorporate the FDP1 with an updated version
register. No code change is required to support these targets, but they
will currently report an error stating that the device can not be
identified.

Update the driver to match against the new device types.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_fdp1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index 2a15b7cca338..0d1467028811 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -257,6 +257,8 @@ MODULE_PARM_DESC(debug, "activate debug info");
 #define FD1_IP_H3_ES1			0x02010101
 #define FD1_IP_M3W			0x02010202
 #define FD1_IP_H3			0x02010203
+#define FD1_IP_M3N			0x02010204
+#define FD1_IP_E3			0x02010205
 
 /* LUTs */
 #define FD1_LUT_DIF_ADJ			0x1000
@@ -2365,6 +2367,12 @@ static int fdp1_probe(struct platform_device *pdev)
 	case FD1_IP_H3:
 		dprintk(fdp1, "FDP1 Version R-Car H3\n");
 		break;
+	case FD1_IP_M3N:
+		dprintk(fdp1, "FDP1 Version R-Car M3N\n");
+		break;
+	case FD1_IP_E3:
+		dprintk(fdp1, "FDP1 Version R-Car E3\n");
+		break;
 	default:
 		dev_err(fdp1->dev, "FDP1 Unidentifiable (0x%08x)\n",
 				hw_version);
-- 
2.20.1



