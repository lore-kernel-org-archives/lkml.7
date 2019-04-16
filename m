Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E52218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI51+awT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfDPXiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:38:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35733 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPXiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:38:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so11096221plp.2;
        Tue, 16 Apr 2019 16:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ2S/OecX3EMPJFaarNftMD33sd0fzH4CfQgwwvYYXQ=;
        b=PI51+awTK6iH3/Xp5fNPhJbpYbemmgGMu5x/f7pTg2QAmnXaOkUU87V3n/yO1pf5Fa
         2VSW6Rl4+JBeUjvRI8lAyBo3uz7yuBjoJC+iGFh8cYeWHmN4qFsP73C9t6Cx2wmIC9CU
         oAgudlZxIllqpdKDUKIpFaU3sVua5PGUHMoRsTOSASVUdpJkY6lhrm4bAYn/fNVAvrwR
         Av2HUm+2ytQCLUAtCOEPpWLP7/hQAcW+uUb2PTP9q4RC8n8OhGcitBlQOd8VxhNktztx
         biBPLt7QPR9cC0BUgVm/tF+lM0QM655LhofDXAVm1d8Dl06PcriJUYw2PRoOTEoUuNQx
         EFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ2S/OecX3EMPJFaarNftMD33sd0fzH4CfQgwwvYYXQ=;
        b=bidaFHuWPZVcik30XhA4/QWn5tTrjfu4Ta+VN3VTTZuNryc5tfZfQ1jqfxNIOI6TiF
         gbHl5vAgVJNfVeWexHI0Gr40ObdAAhEIP42h14A/A2vTB0O6xN3SelSBfHRxoM1hhhxl
         58ebBHZ+0Q6BrDSiphF+4IyphVAw2+kOYHApUkjeKhu5Y2RNg6YG/ISM6J6AGvNPmusa
         Vo8g192JSjRCxfv6KxAxNowJIH4xni9tgs192M16e/Cc1sGT5ukfr/JZYmpJkLPo7ZMg
         +pcgt8pzPhcbbslXZNANLqSUmjSQwi/FNoGIlPDgiPlT39MT2VgH/l7BtRkeU5Ans3ul
         R2cg==
X-Gm-Message-State: APjAAAUM6bL/giy5Otf8wpHP7EJmdCh5C9Ji4Mlj4Ztg+mgwrszRDyVp
        9ojdLUS32I4tVm6I0ICvCSWWrr+d
X-Google-Smtp-Source: APXvYqyXeieuD+tpduxDTEy/JdvB9FXLCK3xkkB3tCNtkz/6jO/h32GnrLh7vEkoI3VHKir7U93CPg==
X-Received: by 2002:a17:902:7893:: with SMTP id q19mr84789091pll.154.1555457894510;
        Tue, 16 Apr 2019 16:38:14 -0700 (PDT)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id m8sm60580835pgn.59.2019.04.16.16.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:38:13 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:MEDIA DRIVERS FOR RENESAS
        - VIN), linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH] media: rcar-csi2: Fix field detection
Date:   Tue, 16 Apr 2019 16:38:07 -0700
Message-Id: <20190416233807.20213-1-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCAR Gen3 hardware manual doesn't mention that the "Word Count" field
in the MIPI CSI-2 Frame Start packet is really the frame number. FS packets
are short packets, and short packets do not have a WC but rather a 16-bit
data field, and for Frame synchronization packets (FS/FE) the 16-bit data
field contains a frame number.

Here is a reprinting from the MIPI CSI-2 specification, version 2
(section 9.1.2 Low Level Protocol Short Packet Format):

"Figure 42 and Figure 43 show the Low Level Protocol Short Packet
structures for the D-PHY and C-PHY physical layer options, respectively.
For each option, the Short Packet structure matches the Packet Header of
the corresponding Low Level Protocol Long Packet structure with the
exception that the Packet Header Word Count (WC) field shall be replaced
by the Short Packet Data Field...For Frame Synchronization Data Types
the Short Packet Data Field shall be the frame number..."

Also in section 9.8.1 Frame Synchronization Packets, the CSI-2 spec reads:

"The behavior of the 16-bit frame number shall be as one of the following
- Frame number is always zero – frame number is inoperative.
- Frame number increments by 1 for every FS packet with the same Virtual
  Channel and is periodically reset to one e.g. 1, 2, 1, 2, 1, 2, 1, 2 or
  1, 2, 3, 4, 1, 2, 3, 4"

So from the above, FLD_NUM in the FLD register matches against the
frame number transmitted by the CSI-2 source in the Frame Start Packet,
and goes as "1,2,1,2,1,2" or "1,2,3,4,...,1,2,3,4". If there is a match,
the RCAR CSI-2 receiver declares the field as the even, e.g. the BOTTOM,
field.

NTSC transmits bottom/even field first, and PAL and HD transmit top/odd
field first. So fields with a frame number 1 in the CSI-2 Frame Start
Packet are bottom/even fields for NTSC, and frame number 2 are bottom/even
fields for PAL/HD.

But the above assumes the transmitting CSI-2 sensor is sending frame
numbers in the sequence "1,2,1,2,...". But according to the CSI-2 spec,
sensors are also allowed to send frame numbers that simply increment as
in "1,2,3,4,...". To generalize to catch those cases, set FLD_DET_SEL
to 0x01, which according to the RCAR Gen3 hardware manual means "the
field is detected as the EVEN field when FLD_NUM[0] matches WC[0]".
Then, the even/bottom fields have odd frame numbers for NTSC, and even
frame numbers for PAL (this patch assumes HDMI sources will not
implement .g_std(), so std will be 0 in that case).

Finally, set the FLD register to non-zero value only if trnsmitter is
sending ALTERNATE fields.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 37 ++++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index a438ec2c218f..c5bee20d7907 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -67,6 +67,7 @@ struct rcar_csi2;
 /* Field Detection Control */
 #define FLD_REG				0x1c
 #define FLD_FLD_NUM(n)			(((n) & 0xff) << 16)
+#define FLD_FLD_DET_SEL(n)		(((n) & 0x3) << 4)
 #define FLD_FLD_EN4			BIT(3)
 #define FLD_FLD_EN3			BIT(2)
 #define FLD_FLD_EN2			BIT(1)
@@ -462,10 +463,11 @@ static int rcsi2_calc_mbps(struct rcar_csi2 *priv, unsigned int bpp)
 	return mbps;
 }
 
-static int rcsi2_start(struct rcar_csi2 *priv)
+static int rcsi2_start(struct rcar_csi2 *priv, struct v4l2_subdev *nextsd)
 {
 	const struct rcar_csi2_format *format;
-	u32 phycnt, vcdt = 0, vcdt2 = 0;
+	u32 phycnt, vcdt = 0, vcdt2 = 0, fld = 0;
+	v4l2_std_id std = 0;
 	unsigned int i;
 	int mbps, ret;
 
@@ -476,6 +478,10 @@ static int rcsi2_start(struct rcar_csi2 *priv)
 	/* Code is validated in set_fmt. */
 	format = rcsi2_code_to_fmt(priv->mf.code);
 
+	ret = v4l2_subdev_call(nextsd, video, g_std, &std);
+	if (ret < 0 && ret != -ENOIOCTLCMD && ret != -ENODEV)
+		return ret;
+
 	/*
 	 * Enable all supported CSI-2 channels with virtual channel and
 	 * data type matching.
@@ -509,9 +515,30 @@ static int rcsi2_start(struct rcar_csi2 *priv)
 	rcsi2_reset(priv);
 	rcsi2_write(priv, PHTC_REG, 0);
 
+	/*
+	 * NTSC standard transmits even/bottom field first, then odd/top.
+	 * PAL standard and interlaced HD transmit odd/top field first,
+	 * then even/bottom.
+	 *
+	 * For CSI-2 sensors that transmit frame numbers (in the CSI-2
+	 * Frame Start packet) as "1,2,1,2,..." or "1,2,3,4,5,...", then:
+	 *
+	 * - for NTSC, the even/bottom fields have odd frame numbers.
+	 * - for PAL and HD, the even/bottom fields have even frame numbers.
+	 */
+	if (priv->mf.field == V4L2_FIELD_ALTERNATE) {
+		fld = FLD_FLD_DET_SEL(1) | FLD_FLD_EN4 | FLD_FLD_EN3 |
+			FLD_FLD_EN2 | FLD_FLD_EN;
+
+		if (std & V4L2_STD_525_60)
+			fld |= FLD_FLD_NUM(1); /* NTSC */
+		else
+			fld |= FLD_FLD_NUM(0); /* PAL or HD */
+	}
+
 	/* Configure */
-	rcsi2_write(priv, FLD_REG, FLD_FLD_NUM(2) | FLD_FLD_EN4 |
-		    FLD_FLD_EN3 | FLD_FLD_EN2 | FLD_FLD_EN);
+	rcsi2_write(priv, FLD_REG, fld);
+
 	rcsi2_write(priv, VCDT_REG, vcdt);
 	if (vcdt2)
 		rcsi2_write(priv, VCDT2_REG, vcdt2);
@@ -591,7 +618,7 @@ static int rcsi2_s_stream(struct v4l2_subdev *sd, int enable)
 	if (enable && priv->stream_count == 0) {
 		pm_runtime_get_sync(priv->dev);
 
-		ret = rcsi2_start(priv);
+		ret = rcsi2_start(priv, nextsd);
 		if (ret) {
 			pm_runtime_put(priv->dev);
 			goto out;
-- 
2.17.1

