Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A227C04E87
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C86720833
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="hZ4gxLpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfERWly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 18:41:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42834 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbfERWlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 18:41:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id d4so6646330qkc.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HjafOF3we2ISgKmws+AAmSPCOfvoMlLfEcLpwFAOH20=;
        b=hZ4gxLpg6e+HdwfQ1NXXRXfPKNh09IvaB2r/AWlEKTZFEOStyNY7rBeDbJe6CnaQ3Q
         UaR1WbRUT9HhSIT2GZshGU5CmTP46jiP/ZpxgKvNwwznxCDNWAys9BL+DXLLH7trevO+
         g5ahNdjbPGvFwrZ4cOxY7e+VsQy6uTF5ET2N/T1jZje7SH/dHL3NeYwuCXx6JIdHYsmd
         LKwC4D/zcDzCvNO3pD79ItH1bdGXVBwM2G1vAeL9p6ll8P7YWDSCd3yw+olCwj0BPVgN
         ym7wqa2PpNPaeyfuUijgm1dMLd/0su+PQenVezSJnZJ3IDkmWojRSFFjNmHr5r3pT/mJ
         f6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HjafOF3we2ISgKmws+AAmSPCOfvoMlLfEcLpwFAOH20=;
        b=T5242HyVvAIAYwH+N1BsXzXt3dIMntRwVrbSrBDHz+H/TBTa4WRFcAIY6fQUHZPY9R
         x92GG3waRzLg6w6Z2EEc2fHYMxI03FSxWbkpY79uFGXh5P0AtMDLCZIiaQB0bPChTWKV
         3Iys4D1EC6kQGYV+LzOYOvgbbvVsHjCfR5ZuK+v9bVHIN//s7WIqTxBbVnTSLTaKb2is
         wgXP8B+RyZVvBovh9tOi8sngT0C3v3OatpbRl5RAdvY1Kwjx/wAfCEzvHwQZnbL3Ndhm
         ZPlXtwznSCqJ5zdFWaXhYN7ycacm+9O6T7GBCue3PMzxG+RmZ9pXp3SBp8ue+4F9KxNm
         IOOA==
X-Gm-Message-State: APjAAAUZYZ406mUoJOuR/4i9bai7LhTdbpKq43PCAJTwLKNAMXtO6KO5
        O5qHB4g+exEtGHbUqA6D17PaGg==
X-Google-Smtp-Source: APXvYqws6NF4t7YOPS1d8LkVgLg7sYRMajLfSLBfYLOL1vQBd5nqSp7jevx1MMGLFOVwau3R4HRHnQ==
X-Received: by 2002:a37:7fc3:: with SMTP id a186mr50951745qkd.65.1558219312472;
        Sat, 18 May 2019 15:41:52 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d32sm7348992qtk.0.2019.05.18.15.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:41:52 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Melissa Wen <melissa.srw@gmail.com>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [PATCH 1/2] staging: iio: cdc: ad7150: create of_device_id array
Date:   Sat, 18 May 2019 19:41:35 -0300
Message-Id: <20190518224136.16942-2-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
In-Reply-To: <20190518224136.16942-1-barbara.fernandes@usp.br>
References: <20190518224136.16942-1-barbara.fernandes@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create structure of type of_device_id in order to register all devices
the driver is able to manage.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Co-developed-by: Melissa Wen <melissa.srw@gmail.com>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed-by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/cdc/ad7150.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 4b1c90e1b0ea..072094227e1b 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -655,11 +655,21 @@ static const struct i2c_device_id ad7150_id[] = {
 	{}
 };
 
+static const struct of_device_id ad7150_of_i2c_match[] = {
+	{ .compatible = "adi,ad7150" },
+	{ .compatible = "adi,ad7151" },
+	{ .compatible = "adi,ad7156" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ad7150_of_i2c_match);
+
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
 
 static struct i2c_driver ad7150_driver = {
 	.driver = {
 		.name = "ad7150",
+		.of_match_table = ad7150_of_i2c_match
 	},
 	.probe = ad7150_probe,
 	.id_table = ad7150_id,
-- 
2.22.0.rc0.1.g337bb99195.dirty

