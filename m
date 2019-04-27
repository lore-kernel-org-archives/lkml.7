Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED34C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3962146E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329313;
	bh=hHlLwpQnjlPb7b8t6V2AC/MpGJEAho2u5pLABzaAtWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2bDTg8cOU/wES4FvGYj/xIrzRAw8RaITSCraF9TmSoyECe+MbCRGHbl2h853bpT09
	 rQrEoRjBLxo0EMgKKUbpIOHQ7C5sSzTFhbUD6jb1yNRnvqIxwtgXJ8pJZhNyxmcw6o
	 IrYta0ydhEvPZE5gLjmMdv3mgycBMPhqwbXDhCvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfD0Blw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbfD0Blp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11967216B7;
        Sat, 27 Apr 2019 01:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329304;
        bh=hHlLwpQnjlPb7b8t6V2AC/MpGJEAho2u5pLABzaAtWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOptQExdhHv9vn4kYcCvweCvTZ2Zfgu9MG73yCCTXRF1sAAKonie/0BEdud7qoK1U
         YVtGYB4KcixUI1cEug/b84Bwc9+vuN7vmLo425aJjU2pvvXdl3myLme6TyGtw+vGOH
         WR+ejobILtshTBoznedSjzEp39Yb09rtss/4YldE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 31/53] ASoC: cs35l35: Disable regulators on driver removal
Date:   Fri, 26 Apr 2019 21:40:28 -0400
Message-Id: <20190427014051.7522-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 47c4cc08cb5b34e93ab337b924c5ede77ca3c936 ]

The chips main power supplies VA and VP are enabled during probe but
then never disabled, this will cause warnings from the regulator
framework on driver removal. Fix this by adding a remove callback and
disabling the supplies, whilst doing so follow best practice and put the
chip back into reset as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l35.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index bd6226bde45f..17e0101081ef 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1634,6 +1634,16 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	return ret;
 }
 
+static int cs35l35_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs35l35_private *cs35l35 = i2c_get_clientdata(i2c_client);
+
+	regulator_bulk_disable(cs35l35->num_supplies, cs35l35->supplies);
+	gpiod_set_value_cansleep(cs35l35->reset_gpio, 0);
+
+	return 0;
+}
+
 static const struct of_device_id cs35l35_of_match[] = {
 	{.compatible = "cirrus,cs35l35"},
 	{},
@@ -1654,6 +1664,7 @@ static struct i2c_driver cs35l35_i2c_driver = {
 	},
 	.id_table = cs35l35_id,
 	.probe = cs35l35_i2c_probe,
+	.remove = cs35l35_i2c_remove,
 };
 
 module_i2c_driver(cs35l35_i2c_driver);
-- 
2.19.1

