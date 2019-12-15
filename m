Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D522C2D0D6
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130F620663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Y3B7esRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oe0HD8Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLOEZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:25:08 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55703 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbfLOEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:25:05 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 379475AC9;
        Sat, 14 Dec 2019 23:25:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Dec 2019 23:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=eiExqcZ7ujXnf
        ULrpep8+tjQvNG7hCVX9mCQFkEA6Uo=; b=Y3B7esRl9WjdxAbHeNYyrAjnpTM5n
        /sxSOD24kVHfDwnWXzc2FcA0QeX+Syj9i8dtZz/HLEb96dWpD90JPa2DDsbG10qq
        4qp9saXXWWXMD7wOGjpEfA2ZBy3F588WejM4+hUDCNddldCGctUhQTjJJtEdZKtU
        ZgnuJFqVGgxe/FVzNxYkWApkmkQJrbeaHg0jYbhFfXNJ841aeD5t4oRGtFGb7ifU
        4WPajAbXxI4R+C5O4WTzm7HJfHbrNNMalRaXBdTqC4HPlL2YOHJWdBeREiek+29K
        EIuP5IbCbDQfy6RvOT9C/Wcf9cOAswMvclhtT7bRCGpal1ek3jqsaqBNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eiExqcZ7ujXnfULrpep8+tjQvNG7hCVX9mCQFkEA6Uo=; b=Oe0HD8Xi
        1Mk7itRp/qo0Mk7pIEd/zKrwkmAT+4VBjv7vwuJq/ybqpemhfBTI2Xne8EBclGfP
        xNl+10hp1MAddEx9AbVSXE8Ng/PNI5k/jg/2QyYhZDNaKn2jW3xrs0YMtSG3YRKc
        ldF0KsHlOmF87mgZ2kNbtFwm8GA1/MqlUFnXvZo1zx9LTj3zwBb3K+yyU6GGraqs
        ZK0I0U8K9kKd5kF67i/XKy84Rdny2+Evnn/QD3II5pRN6QN/4As1oC4QdrBaz5E3
        1nnzBqdiPxMr5+CCw63bWtt6T0/aBKS4SjkkJsEV+PelyL4PDUmtjesCRm1EBZfk
        pQR+e8WWak2tXA==
X-ME-Sender: <xms:oLX1XYDiok_1POBQxg95OkoXKhgLHZktDPGxuFQK7HTd-nJ1SQFbtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:oLX1XSLpkAWwI3qOhoCsdTWKd9fqMHG0la571rOACOwOKvyhpipQdQ>
    <xmx:oLX1XbzWSA3A86E2CJGAWj90Ea1rxhHH_sRktGr7nCtFPxqbiVhXfA>
    <xmx:oLX1XWw7An2FuzIJTNcjVCiiH8eFAWLmCHz95XkzsfH8fRw2GK3Tpw>
    <xmx:oLX1XRH3K7Di1erBh9UIyftu4nis3iwYuRKcTDaFU4EYI89DrSYflQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2730A80059;
        Sat, 14 Dec 2019 23:25:03 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 8/8] firmware: arm_scpi: Support unidirectional mailbox channels
Date:   Sat, 14 Dec 2019 22:24:55 -0600
Message-Id: <20191215042455.51001-9-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191215042455.51001-1-samuel@sholland.org>
References: <20191215042455.51001-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mailbox controllers have only unidirectional channels, so we need a
pair of them for each SCPI channel. If a mbox-names property is present,
look for "rx" and "tx" mbox channels; otherwise, the existing behavior
is preserved, and a single mbox channel is used for each SCPI channel.

Note that since the mailbox framework only supports a single phandle
with each name (mbox_request_channel_byname always returns the first
one), this new mode only supports a single SCPI channel.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/firmware/arm_scpi.c | 58 +++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index a80c331c3a6e..36ff9dd8d0fa 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -231,7 +231,8 @@ struct scpi_xfer {
 
 struct scpi_chan {
 	struct mbox_client cl;
-	struct mbox_chan *chan;
+	struct mbox_chan *rx_chan;
+	struct mbox_chan *tx_chan;
 	void __iomem *tx_payload;
 	void __iomem *rx_payload;
 	struct list_head rx_pending;
@@ -505,7 +506,7 @@ static int scpi_send_message(u8 idx, void *tx_buf, unsigned int tx_len,
 	msg->rx_len = rx_len;
 	reinit_completion(&msg->done);
 
-	ret = mbox_send_message(scpi_chan->chan, msg);
+	ret = mbox_send_message(scpi_chan->tx_chan, msg);
 	if (ret < 0 || !rx_buf)
 		goto out;
 
@@ -854,8 +855,13 @@ static void scpi_free_channels(void *data)
 	struct scpi_drvinfo *info = data;
 	int i;
 
-	for (i = 0; i < info->num_chans; i++)
-		mbox_free_channel(info->channels[i].chan);
+	for (i = 0; i < info->num_chans; i++) {
+		struct scpi_chan *pchan = &info->channels[i];
+
+		if (pchan->tx_chan != pchan->rx_chan)
+			mbox_free_channel(pchan->tx_chan);
+		mbox_free_channel(pchan->rx_chan);
+	}
 }
 
 static int scpi_remove(struct platform_device *pdev)
@@ -903,6 +909,7 @@ static int scpi_probe(struct platform_device *pdev)
 	struct resource res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	bool use_mbox_names = false;
 
 	scpi_info = devm_kzalloc(dev, sizeof(*scpi_info), GFP_KERNEL);
 	if (!scpi_info)
@@ -916,6 +923,14 @@ static int scpi_probe(struct platform_device *pdev)
 		dev_err(dev, "no mboxes property in '%pOF'\n", np);
 		return -ENODEV;
 	}
+	if (of_get_property(dev->of_node, "mbox-names", NULL)) {
+		use_mbox_names = true;
+		if (count != 2) {
+			dev_err(dev, "need exactly 2 mboxes with mbox-names\n");
+			return -ENODEV;
+		}
+		count /= 2;
+	}
 
 	scpi_info->channels = devm_kcalloc(dev, count, sizeof(struct scpi_chan),
 					   GFP_KERNEL);
@@ -961,15 +976,34 @@ static int scpi_probe(struct platform_device *pdev)
 		mutex_init(&pchan->xfers_lock);
 
 		ret = scpi_alloc_xfer_list(dev, pchan);
-		if (!ret) {
-			pchan->chan = mbox_request_channel(cl, idx);
-			if (!IS_ERR(pchan->chan))
-				continue;
-			ret = PTR_ERR(pchan->chan);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to get channel%d err %d\n",
-					idx, ret);
+		if (ret)
+			return ret;
+
+		if (use_mbox_names) {
+			pchan->rx_chan = mbox_request_channel_byname(cl, "rx");
+			if (IS_ERR(pchan->rx_chan)) {
+				ret = PTR_ERR(pchan->rx_chan);
+				goto fail;
+			}
+			pchan->tx_chan = mbox_request_channel_byname(cl, "tx");
+			if (IS_ERR(pchan->rx_chan)) {
+				ret = PTR_ERR(pchan->tx_chan);
+				goto fail;
+			}
+		} else {
+			pchan->rx_chan = mbox_request_channel(cl, idx);
+			if (IS_ERR(pchan->rx_chan)) {
+				ret = PTR_ERR(pchan->rx_chan);
+				goto fail;
+			}
+			pchan->tx_chan = pchan->rx_chan;
 		}
+		continue;
+
+fail:
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get channel%d err %d\n",
+				idx, ret);
 		return ret;
 	}
 
-- 
2.23.0

