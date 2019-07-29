Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A37C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA00217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428339;
	bh=Ri8Lf7KuVoUcz8vIt4dVavL3u7/BioDQ0jRea6h2ctc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G4A0W5MZ370T1JX3O54Jahq+Ud2r2nVjFFsj6Jq2zMyc/8yCEMJHRrJ4dedSw8J6e
	 x8lV/tvT7mrBFtULgP/E60mMyyib/UuC37+Hw5Ihig2QBLR2goJATrud6gLiwifUab
	 reNTodT4YEilUeZKTXC6UvU0aN4wnFCwAwM/ztCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfG2TZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbfG2TZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:25:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C31221655;
        Mon, 29 Jul 2019 19:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428335;
        bh=Ri8Lf7KuVoUcz8vIt4dVavL3u7/BioDQ0jRea6h2ctc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vml1v06pcpQFQ6wAM+Rk3UKALyddp3I+Mpl7SU8xRZZGLrRdF9fFXpaD1SrevNSNV
         oE9Hpk0yAmzDa9fTU6jSRqCG75rNQB1BLkbi+3rJCCxabhdMl4vUnVvjyIsh5xL8fc
         AmllCVJgX7k4rE4L9ep5PNBBU2M2EaDi4KijsShM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 043/293] media: fdp1: Support M3N and E3 platforms
Date:   Mon, 29 Jul 2019 21:18:54 +0200
Message-Id: <20190729190826.082257146@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
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
index 3245bc45f4a0..a889332d5d30 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -261,6 +261,8 @@ MODULE_PARM_DESC(debug, "activate debug info");
 #define FD1_IP_H3_ES1			0x02010101
 #define FD1_IP_M3W			0x02010202
 #define FD1_IP_H3			0x02010203
+#define FD1_IP_M3N			0x02010204
+#define FD1_IP_E3			0x02010205
 
 /* LUTs */
 #define FD1_LUT_DIF_ADJ			0x1000
@@ -2369,6 +2371,12 @@ static int fdp1_probe(struct platform_device *pdev)
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



