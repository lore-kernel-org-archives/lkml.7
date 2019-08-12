Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B58C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3F320651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="pzLtY8G2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfHLN3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:29:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37261 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfHLN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:29:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so2622525wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JzKOQ5mHteEnLA3+yRVnS5bSf+ysPwr2I6LlVQ1trvk=;
        b=pzLtY8G2u2/YII4gwwFRhcLQv7ubDho6IeAvFlIPIiH33bEq1k+YrhsW5qreW0lcGu
         L8H/7jxTlCtE75v4uGJMXzTyAYnqsKESIRyU1jB0U7ym/F7mmhSp5BVEuO/DH8YSeROJ
         Dc09BPlQNUtirekVi4fIOejsDxaRLtS8mZE7wCpdo5j3Bo8oxBepPRqFCJW1Binat5hE
         5za6BeXQ+pd9wwO9PzFuAdc4BM9RVXMes78v2npvz+0UN+xMG2P5u5pIjbSGtzGJG8DL
         m/RTpwiDSM7MSXoIHZ6J/00igHnxLlvu3FGtWKTFAAgwcJCUqLpY4j0wDuevn0vIjLvh
         0csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JzKOQ5mHteEnLA3+yRVnS5bSf+ysPwr2I6LlVQ1trvk=;
        b=IGarmtVK3+DkexVID5HXtG4DunZtnj3CT5R9LjzMRDaEFuv0pRLy/LSakTK+uK0ilt
         xJB1s9nFzR2wPjFH13C6px6pMUzaztREfAbkEywM/A/sTAny40NFfpsiMSi4h8nVJSn5
         gfrQ2FESrVmrSwvNiewpJ3tDXDiIOiQuP42fzg4t1y8kZbUNoHGYwU0e8cQQmPLYrDwZ
         GXr03p9/TWZR7W3DpN9OcZGqJ+wKzqjMeKQBU8vBWumgvVK440QxKSKKj7P/GnBQK7c+
         FJJYEsQs4HgVITbpJi77QGDxK/R893AF1sDZWfUsAZKd2AF3Vd6rWQwlJlh+tGQVzB8n
         8mwA==
X-Gm-Message-State: APjAAAWfTXvYDhY7umJSweIxduPArX4kw1E+Z0zlyr2pquWMuLKVDBo7
        d36TDqQErTeTaVThWNRnPjiiUnM7+v3bhg==
X-Google-Smtp-Source: APXvYqwaEf6WuwVVerQyI89ctyrQfAdB2zFMlbGgzZgdebonBeQNWlY4URBWmb2S8aG6AGspzUC0+Q==
X-Received: by 2002:a05:6000:148:: with SMTP id r8mr13154631wrx.312.1565616586205;
        Mon, 12 Aug 2019 06:29:46 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r4sm70346111wrq.82.2019.08.12.06.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 06:29:45 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: [RFC PATCH] hwmon: (iio_hwmon) Enable power exporting from IIO
Date:   Mon, 12 Aug 2019 15:29:41 +0200
Message-Id: <71aec0191e0e5f32cc760f95844d8ee215b48c7f.1565616579.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason why power channel shouldn't be exported as is done for
voltage, current, temperature and humidity.

Power channel is available on iio ina226 driver.

Tested on Xilinx ZCU102 board.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

But I don't think values are properly converted. Voltage1 is fine but the
rest is IMHO wrong. But this patch should enable power channel to be shown
which looks good.

root@zynqmp-debian:~# iio_info -a && sensors -u
Library version: 0.16 (git tag: v0.16)
Compiled with backends: local xml ip usb serial
Using auto-detected IIO context at URI "local:"
IIO context created with local backend.
Backend version: 0.16 (git tag: v0.16)
Backend description string: Linux zynqmp-debian 5.3.0-rc4-00004-ga7ca33daed22-dirty #41 SMP PREEMPT Mon Aug 12 15:06:58 CEST 2019 aarch64
IIO context has 1 attributes:
	local,kernel: 5.3.0-rc4-00004-ga7ca33daed22-dirty
IIO context has 1 devices:
	iio:device0: ina226 (buffer capable)
		9 channels found:
			voltage0:  (input, index: 0, format: le:U16/16>>0)
			3 channel-specific attributes found:
				attr  0: integration_time value: 0.001100
				attr  1: raw value: 70
				attr  2: scale value: 0.002500000
			voltage1:  (input, index: 1, format: le:U16/16>>0)
			3 channel-specific attributes found:
				attr  0: integration_time value: 0.001100
				attr  1: raw value: 958
				attr  2: scale value: 1.250000000
			power2:  (input, index: 2, format: le:U16/16>>0)
			2 channel-specific attributes found:
				attr  0: raw value: 3
				attr  1: scale value: 0.006250000
			current3:  (input, index: 3, format: le:U16/16>>0)
			2 channel-specific attributes found:
				attr  0: raw value: 70
				attr  1: scale value: 0.000250000
			timestamp:  (input, index: 4, format: le:S64/64>>0)
			allow:  (input)
			1 channel-specific attributes found:
				attr  0: async_readout value: 0
			oversampling:  (input)
			1 channel-specific attributes found:
				attr  0: ratio value: 4
			sampling:  (input)
			1 channel-specific attributes found:
				attr  0: frequency value: 114
			shunt:  (input)
			1 channel-specific attributes found:
				attr  0: resistor value: 10.000000000
		2 device-specific attributes found:
				attr  0: current_timestamp_clock value: realtime

				attr  1: integration_time_available value: 0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244
		2 buffer-specific attributes found:
				attr  0: data_available value: 0
				attr  1: watermark value: 1
		1 debug attributes found:
				debug attr  0: direct_reg_access value: 0x4327
ina226_fourth-isa-0000
Adapter: ISA adapter
in1:
  in1_input: 0.000
in2:
  in2_input: 1.198
power1:
  power1_input: 0.000
curr1:
  curr1_input: 0.000
---
 drivers/hwmon/iio_hwmon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index f1c2d5faedf0..aedb95fa24e3 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -59,7 +59,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	struct iio_hwmon_state *st;
 	struct sensor_device_attribute *a;
 	int ret, i;
-	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1;
+	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, power_i = 1;
 	enum iio_chan_type type;
 	struct iio_channel *channels;
 	struct device *hwmon_dev;
@@ -114,6 +114,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 			n = curr_i++;
 			prefix = "curr";
 			break;
+		case IIO_POWER:
+			n = power_i++;
+			prefix = "power";
+			break;
 		case IIO_HUMIDITYRELATIVE:
 			n = humidity_i++;
 			prefix = "humidity";
-- 
2.17.1

