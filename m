Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5692C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94624218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0HcPPTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCPPGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:06:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45855 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfCPPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:06:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so13374778qtv.12;
        Sat, 16 Mar 2019 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lobLDAlrnYC0TAuM5nbXmB+CxrZAEtQnGAufgWBeZPs=;
        b=A0HcPPTY9nSf2kf92LaO44Wk5LS/NaXQJPvFvX6LEM1CYZF1W6AAPMqQP5TqQ0T56n
         Ba3cVWtIoIYwR+uOxb3I5q6tecAepOADeUDg037Zcn418cI7O/6Z5gdBvK5a6cl1E6x+
         fEUo2lx4D0Y8C+x+C2Kn1RkSmsv651e9pFTrl9w+rSD8WVyHyocSWRtYvbPdoYVcDyRL
         E3/9V2ZhFDMULUU/tQiR8TztOq7MgNeUa8sqG8eLb0CHvBQ0AJpDQtRKLX0ncmddWzQ/
         ttahoWStDTyUrEh6Xrlf64Dh21WrCiSThCVo9h5yx0h/ITx8rAIrsjzwWP6ryVRKLX91
         gBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lobLDAlrnYC0TAuM5nbXmB+CxrZAEtQnGAufgWBeZPs=;
        b=eLeKlTTwF0uG/TlOu7e/8Lsjki2g5rXl9dHUpMS8Jv0mOK/jqwEGu9G7MtnyJS7lLI
         aFyBjUVhlZ2t8G5pII2V4JzaLjpMfNKdWWiN4X4PgSCzQxRW0e9A8hKZLMkQd3mOYymF
         4Opp5DQ7FvquZvxQk6nh7NL2Hy5YO2reBZlkNSLTML5yM7BEzCkTCRoAl4PcAQLnE6Y8
         G1J8TmPQBMurgL/wlWVsl3MKswCIyjEgjlKf8ttE4HK1oJX+5wW3zYOLKxq+503pGUEU
         8NHfp2hkvyZNFr4cJDjQIkfTij8gfo/FJBiNDZnUMaEM3P0biBKN2wokDPDDPBd8lLrp
         UaZA==
X-Gm-Message-State: APjAAAU/zOWClOi+jGRbv4TxMs4SznSJ2R8gQDgI4+iDAk2LcHmh0wPh
        pES8gqdj481zjE0mi5DJd4s=
X-Google-Smtp-Source: APXvYqxxmy9a7+1TnoFm/IMgrF3Pe4MpfTZtjzNmJz4xkMhgLnG3qHzPKx+tIOR5mVxKBjdzcwGHOg==
X-Received: by 2002:a0c:9e2d:: with SMTP id p45mr6632266qve.28.1552748782613;
        Sat, 16 Mar 2019 08:06:22 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 55sm3550738qtq.25.2019.03.16.08.06.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 08:06:22 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:06:18 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v4 1/7] staging: iio: ad5933: change multi-line comment style
Message-ID: <20190316150618.7g6hxbmadvxe623o@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make multi-line comments compliant with the preferred code style.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3134295f014f..05e2185bfdae 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -474,7 +474,8 @@ static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
 			ad5933_store,
 			AD5933_OUT_SETTLING_CYCLES);
 
-/* note:
+/*
+ * note:
  * ideally we would handle the scale attributes via the iio_info
  * (read|write)_raw methods, however this part is a untypical since we
  * don't create dedicated sysfs channel attributes for out0 and in0.
@@ -572,7 +573,8 @@ static int ad5933_ring_postenable(struct iio_dev *indio_dev)
 {
 	struct ad5933_state *st = iio_priv(indio_dev);
 
-	/* AD5933_CTRL_INIT_START_FREQ:
+	/*
+	 * AD5933_CTRL_INIT_START_FREQ:
 	 * High Q complex circuits require a long time to reach steady state.
 	 * To facilitate the measurement of such impedances, this mode allows
 	 * the user full control of the settling time requirement before
@@ -663,7 +665,8 @@ static void ad5933_work(struct work_struct *work)
 	}
 
 	if (status & AD5933_STAT_SWEEP_DONE) {
-		/* last sample received - power down do
+		/*
+		 * last sample received - power down do
 		 * nothing until the ring enable is toggled
 		 */
 		ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
-- 
2.20.1

