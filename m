Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B933C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED69218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="RDPwZD5R";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="RDPwZD5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfCUPl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:41:26 -0400
Received: from node.akkea.ca ([192.155.83.177]:39204 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCUPlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:41:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id A25834E2056;
        Thu, 21 Mar 2019 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553182861; bh=6k9qZsSXgZqdyav5V2ldzC4b11XN7BN7b7f+Hch7bug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RDPwZD5RYko5JNd4BS0cjjRaDH/asrehHYNSenxizq86vAV6uPgDi/n9V5+/aiJnF
         OeV2m2s6pLJ1xv2mcWT9kdBQqmxaGsCKtKxCKs8s6q/yj/bA8iWuWJRQcQenZn/VVZ
         xGrA2cJfRYOY6g+94qKkuuXCADU6end/rT/HS02Y=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lU3FEZbRkp9F; Thu, 21 Mar 2019 15:41:01 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 9B58D4E204B;
        Thu, 21 Mar 2019 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553182861; bh=6k9qZsSXgZqdyav5V2ldzC4b11XN7BN7b7f+Hch7bug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RDPwZD5RYko5JNd4BS0cjjRaDH/asrehHYNSenxizq86vAV6uPgDi/n9V5+/aiJnF
         OeV2m2s6pLJ1xv2mcWT9kdBQqmxaGsCKtKxCKs8s6q/yj/bA8iWuWJRQcQenZn/VVZ
         xGrA2cJfRYOY6g+94qKkuuXCADU6end/rT/HS02Y=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     jic23@kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] iio: light: vcnl4000 add devicetree hooks
Date:   Thu, 21 Mar 2019 08:40:44 -0700
Message-Id: <20190321154047.23236-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321154047.23236-1-angus@akkea.ca>
References: <20190321154047.23236-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an of_match table for devicetree probing.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/iio/light/vcnl4000.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 5e0a8eb83ebc..308cb2d2b641 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -363,9 +363,31 @@ static int vcnl4000_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id vcnl_4000_of_match[] = {
+	{
+		.compatible = "vishay,vcnl4000",
+		.data = "VCNL4000",
+	},
+	{
+		.compatible = "vishay,vcnl4010",
+		.data = "VCNL4010",
+	},
+	{
+		.compatible = "vishay,vcnl4010",
+		.data = "VCNL4020",
+	},
+	{
+		.compatible = "vishay,vcnl4200",
+		.data = "VCNL4200",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, vcnl4000_of_match);
+
 static struct i2c_driver vcnl4000_driver = {
 	.driver = {
 		.name   = VCNL4000_DRV_NAME,
+		.of_match_table = of_match_ptr(vcnl_4000_of_match),
 	},
 	.probe  = vcnl4000_probe,
 	.id_table = vcnl4000_id,
-- 
2.17.1

