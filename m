Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780352146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwJp/g+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCSCUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42488 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfCSCUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:45 -0400
Received: by mail-io1-f67.google.com with SMTP id c4so16362584ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xz8TtdHzn7FvNUl6ufCxByebYkG7gs/9oxNPLul8KYs=;
        b=TwJp/g+zcBUp8Qi00b5MwP4CXkovYaSSJ7+H0OKGMnQDnVfIJi1lqMEw1GdEX5ZPGB
         hwdjtkFb8qCIs6uqwh1AIP2L516OCdNwY4envXeTqJppIh+sKUMQ8dsDQuVbKHb/XWs8
         ns3dGZTbe79jZoszGKiiPycKkuELQ12A1lGdNTrAez/7cNEa3ph4a/TTNw02bFqMAaRi
         61PfKVK99+x4z84xJ+NSHqc3NsmM5GJbij4otLMD3pH2wD1SH5QS2Cvi4QDPyYIhCfgJ
         /VJJDskND0Hb+y7eNlAojjbvmBTjZ8H5HNtghQGCMYyiGHYos64WXW7uvWNUVXEclMCZ
         eDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xz8TtdHzn7FvNUl6ufCxByebYkG7gs/9oxNPLul8KYs=;
        b=j0RctaoFtyrSuSiSQcHz6N6A094u2AL/TLOjilXoGVnhkmD2D/6p/qNUT2GRA57Ptb
         qO+FlhECyEgyDx2FlH8CwSi/T40jshmglmaMjYdZhqs8fk5owwiF44m07Of0irq+Q938
         Zw/vifVae0lC5GqQuMTddN2HRlfwvACNT4fY9sIfekJEp8j/vI7HbnqSXIfq9iorXC3n
         1Epegx2kltgwHl8+7hHM/n84eziIn26wFNMPDlun+5GNAPa8Re+pqOK4Pt0ab+MRHa37
         ibYo12+MVwbdwpCX01OAh3KyG4kQcEvkyk4+bB3NuppDAoTefdX7oXpxpMBNQg2T0cGy
         PcMg==
X-Gm-Message-State: APjAAAXfvKUWvhYs1UEU2VZ3iiIKbOFJgZDvPHvG7KTtxOv2/uxIWdH/
        lVbFRtzn1VDXxa7kcQY+HbSrQ0YQK6Q=
X-Google-Smtp-Source: APXvYqwYIOESPmsRT3Z36DAC1g6f9UyaO7Z0uO8H46ipL8UppA9qB8kRhqmSjn6lLPM4ukIVIVu0gA==
X-Received: by 2002:a6b:1847:: with SMTP id 68mr39756ioy.166.1552962044758;
        Mon, 18 Mar 2019 19:20:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:44 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 11/11] staging: mt7621-mmc: Only unmap_sg if mapped
Date:   Mon, 18 Mar 2019 20:20:12 -0600
Message-Id: <20190319022012.11051-12-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A failure while processing the start command could cause dma_unmap_sg()
to be called without first calling dma_map_sg().

Since calling dma_unmap_sg() is only needed when data != NULL, move the
unmap call into the corresponding if {} block.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index b52e0284ea8e..f14ff75cc4b7 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -695,7 +695,7 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 		/* then wait command done */
 		if (msdc_command_resp(host, cmd, 1, CMD_TIMEOUT) != 0)
-			goto done;
+			goto unmap;
 
 		/* for read, the data coming too fast, then CRC error
 		 *  start DMA no business with CRC.
@@ -732,18 +732,17 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		/* Last: stop transfer */
 		if (data->stop) {
 			if (msdc_do_command(host, data->stop, 0, CMD_TIMEOUT) != 0)
-				goto done;
+				goto unmap;
 		}
-	}
 
-done:
-	if (data) {
+unmap:
 		host->data = NULL;
 		dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 		host->blksz = 0;
 	}
 
+done:
 	if (mrq->cmd->error)
 		host->error = 0x001;
 	if (mrq->data && mrq->data->error)
-- 
2.21.0

