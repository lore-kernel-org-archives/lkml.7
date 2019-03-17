Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630B3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342BC20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wTxv4dNQ";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wTxv4dNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCQPsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:48:14 -0400
Received: from node.akkea.ca ([192.155.83.177]:34228 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfCQPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:48:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id D1B0C4E2051;
        Sun, 17 Mar 2019 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552837690; bh=s+6m1sYsHHJqUIM+QrwqYy+oYJGYPAMDNtRdXukaGbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wTxv4dNQUR9r3V1sZ/19c2+snMijeIp3ZidSKTtAmpQPGb5b+9tljfKo1yeUO4s8e
         sgt12Yw6qrumyue++4s/S9fy5HjOz9Q5gpRyh+ryJgz/urM70vboLTeSvnc//C+mWW
         V6uhCp9e9voRhGDkN3oT4BTDyoB5i72bXs/D4r6I=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GEZDAtmBLnGq; Sun, 17 Mar 2019 15:48:10 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 0EF834E204D;
        Sun, 17 Mar 2019 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552837690; bh=s+6m1sYsHHJqUIM+QrwqYy+oYJGYPAMDNtRdXukaGbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wTxv4dNQUR9r3V1sZ/19c2+snMijeIp3ZidSKTtAmpQPGb5b+9tljfKo1yeUO4s8e
         sgt12Yw6qrumyue++4s/S9fy5HjOz9Q5gpRyh+ryJgz/urM70vboLTeSvnc//C+mWW
         V6uhCp9e9voRhGDkN3oT4BTDyoB5i72bXs/D4r6I=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] iio: light: vcnl4000 use word writes instead of byte writes
Date:   Sun, 17 Mar 2019 08:47:58 -0700
Message-Id: <20190317154802.15174-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317154802.15174-1-angus@akkea.ca>
References: <20190317154802.15174-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VCNL4200 datasheet says that word read and writes should be used
to access the registers.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/iio/light/vcnl4000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 04fd0d4b6f19..5295330b65e2 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -140,10 +140,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	data->rev = (ret >> 8) & 0xf;
 
 	/* Set defaults and enable both channels */
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 0x00);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 0x00);
 	if (ret < 0)
 		return ret;
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 0x00);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 0x00);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

