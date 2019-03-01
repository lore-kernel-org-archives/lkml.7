Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34F0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDB820854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkXp6HPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbfCACxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:53:20 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45431 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfCACxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:53:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so26110001qtg.12;
        Thu, 28 Feb 2019 18:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=TK7BjLktjcqgMQgF+xaLsftFdaoXOehqJcc3OuuaSTA=;
        b=qkXp6HPmnSMMDKzFHr8nL5XpvjQaPOQCqIYZJiL3wBNKrh05dj5zaRStTM8wUdZCzC
         1ApHtCzbj00auuPjSLM5pS2r9R2acgkHivEnhf6woTljC8ZMd2kbQZPSkhjdvnNRPEk6
         90IKNEQyqta/fnDjjOSGKZw2V1hRKpupXgs1v/7Rzz9mStrQ2BtsW9QVSKUK9DRB3ViY
         ni7YKARy1dyJfSRyk7Bdsjlkhppk7KVh81JUgi3lwVYjgdqxNbg23UGFAfY83yUccyS+
         WhBLCpVWTZq73KmnpTrjFKWEEiC6ZmhcHfOPh9eBq8bYLvA/w/nqvqVClW7cTqSynwAj
         hrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=TK7BjLktjcqgMQgF+xaLsftFdaoXOehqJcc3OuuaSTA=;
        b=uJ+es+EgzMe0rE/0ETm1dPhRFlf7XOui2hJHpHfIP3PkNU85ceQ8aUO+/dRIPjLiVZ
         FhP6KPFDFLMjOiKszF98Sk8XvhawZ/UR4QDEMihRrdl+uGtvcOncydujaUfGsG4cwR66
         Kyy5l441ghQKAH9KdXh5aosnqIXs4Or4ATG0dH5qtFz+qbGnwgSbkCahwksE9Ufe2ghQ
         rtBbzjx4bY9Krt5TLttV3Dz7Et4IOYc4fhIOoK34j/FHGLtRzJkpX0hH3Mr+Q+p2XtXH
         XNxGF+JePKB1w8xZNS+A0eRo3D+tcjYoCCs/N5n1BNOLJ+9kdPPuSW4ReBnZmEM+tBJD
         rsDw==
X-Gm-Message-State: APjAAAXt20uVJzwMaHirUkDRfFIePw1Mai2IZE9V/ixSb6SZS4Aoj03w
        QwQgCIr2eN2KbD3Wd0mt+RY=
X-Google-Smtp-Source: APXvYqzaBdzQl3DwdoAy3Fv2Xjoeyn3qn8t7QzEel5T7SrlKLLKPLFxAhE2T5ETKyb5mXrQKgD5KUQ==
X-Received: by 2002:ac8:1a64:: with SMTP id q33mr2195943qtk.274.1551408798806;
        Thu, 28 Feb 2019 18:53:18 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f7sm3364626qke.28.2019.02.28.18.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Feb 2019 18:53:18 -0800 (PST)
Date:   Thu, 28 Feb 2019 23:53:14 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v2 3/4] staging: iio: ad5933: add ABI documentation
Message-ID: <20190301025314.p53nlcfey3qarms4@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ABI documentation for the ad5933 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-ad5933          | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad5933 b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
new file mode 100644
index 000000000000..81e3d3f6f724
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
@@ -0,0 +1,91 @@
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_scale
+Date:		February 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The output peak-to-peak voltage range. Writting 0 sets range
+		to 2.0V p-p typical, 1 sets range to 200mV p-p typical, 2 sets
+		range to 400mV p-p typical, 3 sets range to 1.0V p-p typical.
+		The p-p value of the ac output exitation voltage scales with 
+		supply voltage according to the following formula:
+		Output Excitation Voltage (V p-p) = normalized_3v3 × [VDD/3.3]
+		where normalized_3v3 is one of the four voltage range above and
+		VDD is the supply voltage.
+
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_scale_available
+Date:		February 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:	
+		Prints available peak-to-peak voltage range to buffer.
+
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_start
+Date:		February 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The start frequency. Set this to define de frequency point at
+		which the device should start the next frequency sweep. Default
+		start frequency point set to 10000Hz.
+
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_increment
+Date:		February 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The frequency sweep increment. Set this to define at which rate
+		frequency sweep points are incremented. After the measurement at
+		a frequency point is completed, the next measurement will be 
+		made with a frequency 'frequency increment'Hz higher than the
+		previous point until the defined number of increments has been
+		made. Default frequency increment set to 200Hz.
+		
+
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_points
+Date:		February 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The number of increments. This defines the number of frequency
+		points in the frequency sweep. Device stores a 9-bit integer
+		number in binary format for this so the maximum number of
+		increments that can be programmed is 511.
+
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_settling_cycles
+Date:		February 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of settling time cycles. This attribute is a 11 bit field
+		divided in two parts. The 9 least significant bit define the
+		number of output excitation cycles that are passed through the
+		unknown impedance, after the receipt of a start frequency sweep,
+		increment frequency, or repeat frequency command, before the ADC
+		is triggered to perform a conversion of the response signal. The
+		2 most significant bits define a multiplier for the number of
+		cycles obtained from de least significant bits. Let D10 and D9
+		be these two bits, the resulting multiplier is defined as
+		follows.
+		D10 D9 = 0 0 => No. of cycles x 1 (default)
+		D10 D9 = 0 1 => No. of cycles x 2
+		D10 D9 = 1 0 => Reserved
+		D10 D9 = 1 1 => No. of cycles x 4
+
+		See the datasheet for detailed information.
+
+What:/sys/bus/iio/devices/iio:deviceX/in_voltage0_scale
+Date:		February 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The PGA gain amplifier for the response signal. Set this to 0
+		to gain the output of the current-to-voltage amplifier by a
+		factor of 5. Set to 1 (default) to amplify the response signal
+		into the ADC by a multiplication factor of x1.
+
+What:/sys/bus/iio/devices/iio:deviceX/in_voltage0_scale_available
+Date:		February 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Prints available PGA gain amplifier to buffer.
-- 
2.20.1

