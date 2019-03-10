Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1B20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh0jZyfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfCJRpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:45:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36243 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJRpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:45:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id c2so1435923qkb.3;
        Sun, 10 Mar 2019 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lobLDAlrnYC0TAuM5nbXmB+CxrZAEtQnGAufgWBeZPs=;
        b=Kh0jZyfvcC6VXiDhLEMg0ACDNX0MrlOwCoe2pU1IqHhp68rUj4Z+b2DlydpvnHEzVf
         C1LJfkyGkjCgHm2w6w+h5ZY7u9otQfZc+TMsbBB6j5gyoMggOEaucI0+/H1+dq+XdYf4
         1CwtHu4FE+lWZosQUm5uo3HmXDB8ulGzRxnOcP9wH/o/0mQuIsRUYhnf9ZdEj4jtYTWw
         y+mfV5jsr7EYFASyaxrg1QBOkf6KqVY7cpAYh+T5mcZIx8dnLyMAMM146q0WXHzoRIoQ
         V9aEwPzQWHY3BufSOT3aHdKPrBtZsI6K1BLMBMijSJP192su/r/Nfpzo9EEDsG7GjHKI
         JQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lobLDAlrnYC0TAuM5nbXmB+CxrZAEtQnGAufgWBeZPs=;
        b=cL09ytyxJNiUfJYQsTW8uu0PPRHCHP+XM0q+U6PV4ZZF2evqMNDU2eaAC61zlxrMfT
         LXOcYI+4GVQFGwkT8SrEVUiREf4phgf1JrMrm1vETJM2p22/7KciNpEZXHLn7PnCHAPL
         Zmt1rhtI3dCxT4y6p0rAZS/PEU2lJpV/IIORFzB6Xo0/MRfvXInrQWKw7PKlw954yaxS
         AnqITX6150lOU88a3qMrHxO+ejgMI5gkcG6C0m1kwibqsZ2LHacw+pRYCbrIFnn5/jX1
         ueMLLNrUK/GFSXI0nGMPl8cyT71YWK7by/jS52EdTpnPu9bJQ27RmZAUtsR1YRYpYucX
         Ak0A==
X-Gm-Message-State: APjAAAUN64ogfN4aO4+zuhqGVsAABe9ty1gOPzFv7r9N8s3ovDjgoxD5
        oND0sVxvEf2CrhZIEshcbJqFB5Rmh5v0ew==
X-Google-Smtp-Source: APXvYqy62foxczrhHce78frLo12VCLyy66yGeHEoegGHuomol2+HzIZHNSHXH8edm/QK+u0d8KefDg==
X-Received: by 2002:ae9:e10c:: with SMTP id g12mr4386898qkm.86.1552239910875;
        Sun, 10 Mar 2019 10:45:10 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v31sm2150904qtc.62.2019.03.10.10.45.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 10:45:10 -0700 (PDT)
Date:   Sun, 10 Mar 2019 14:45:06 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v3 1/7] staging: iio: ad5933: change multi-line comment style
Message-ID: <20190310174506.u7tbukmns3hyeq3b@smtp.gmail.com>
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

