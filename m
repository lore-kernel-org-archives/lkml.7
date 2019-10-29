Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3628CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CA5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVDOx6Sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfJ2SV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:21:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45943 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfJ2SV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:21:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so10113962pgj.12;
        Tue, 29 Oct 2019 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71OLTh41XrKOgl2b277xHxckY89HIxO01AHDWRPgmpQ=;
        b=HVDOx6SpM3iNoabX6kbFg8wVXEL7fQYdvrcfljTSfGQv1BcHl95QQPafoBrA3RQpBm
         d8ukeqaLVeYLTDzfPqc3BfkSk/Igy6rdUPTRF3s0Jt41s7U/wlNGo3EJoCuXffEP0+hd
         YVJUhgi3RqwkTdj8oyAArB3ERCUeG1SHRkkS55g32s89MinQZtg92aBgFEKOhf+Xp+dJ
         fmiBEoKzgJ/UELxLK1GJy/PwhZTDA5vU2Q3/7Rx2t3/Q9oXuy8YJzXdjCimY5nFJvTxu
         U8z28v7X8SgBixQ7aiPTaLqb/0CUcaCF8i9niyIac/+Q3Ku3ZaGnZEynjzq1dOXVSFe/
         OO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71OLTh41XrKOgl2b277xHxckY89HIxO01AHDWRPgmpQ=;
        b=RCfA5DESViF9akojFPi/jjXWsyxZK1FIRsABXpPpbhmmHhkeHieb/rablFps8u0QZ5
         oaSKYPfhwrhesfA9evchN3lIcALFPrweTGoNDQyFobqStPNLpsxSvIx5B/0AbdRf262C
         o4yd9+etY94g9tquGMM3+sAwt77puTbaHnpijKzJrXL3EXdj5ZWRjWQO5t2IX5Q3L838
         jRIYtDLy9C6/K7Iml4RdIIuooYFVvbNow0Ro+QkaDLyF8bJEaXmmsu9Aj5Ay8qOGXAoG
         A2OVdF9O4NRZlEqqhsKTHe+61Nlsx1JdDZcJRWWcSRh0KEvDPM8fVZF85bi/kpVOrpWs
         ZQ8Q==
X-Gm-Message-State: APjAAAWijic6jTxCA6h87IK6zTHfZfgCo15uXiKwnkn8X71L57JbVaT6
        ksbttrCZFTT4ATd1A7CwO/XJEsXJD1Q=
X-Google-Smtp-Source: APXvYqx8/f20Koaa9igAtGwiT6Fa2k/qo+Kax/K+OlebL05JtE02KjKFn+X4YH1sFALw4hbn8dqL0A==
X-Received: by 2002:a17:90a:c097:: with SMTP id o23mr8477800pjs.41.1572373285690;
        Tue, 29 Oct 2019 11:21:25 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1:3a3e])
        by smtp.gmail.com with ESMTPSA id j10sm13488418pfn.128.2019.10.29.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:21:25 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 2/2] docs: hwmon: Document bel-pfe pmbus driver
Date:   Tue, 29 Oct 2019 11:20:54 -0700
Message-Id: <20191029182054.32279-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029182054.32279-1-rentao.bupt@gmail.com>
References: <20191029182054.32279-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add documentation for bel-pfe pmbus driver which supports BEL PFE1100 and
PFE3000 power supplies.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2.

 Documentation/hwmon/bel-pfe.rst | 112 ++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/hwmon/bel-pfe.rst

diff --git a/Documentation/hwmon/bel-pfe.rst b/Documentation/hwmon/bel-pfe.rst
new file mode 100644
index 000000000000..4b4a7d67854c
--- /dev/null
+++ b/Documentation/hwmon/bel-pfe.rst
@@ -0,0 +1,112 @@
+Kernel driver bel-pfe
+======================
+
+Supported chips:
+
+  * BEL PFE1100
+
+    Prefixes: 'pfe1100'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.belfuse.com/resources/datasheets/powersolutions/ds-bps-pfe1100-12-054xa.pdf
+
+  * BEL PFE3000
+
+    Prefixes: 'pfe3000'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.belfuse.com/resources/datasheets/powersolutions/ds-bps-pfe3000-series.pdf
+
+Author: Tao Ren <rentao.bupt@gmail.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for below power supply devices
+which support PMBus Protocol:
+
+  * BEL PFE1100
+
+    1100 Watt AC to DC power-factor-corrected (PFC) power supply.
+    PMBus Communication Manual is not publicly available.
+
+  * BEL PFE3000
+
+    3000 Watt AC/DC power-factor-corrected (PFC) and DC-DC power supply.
+    PMBus Communication Manual is not publicly available.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+Example: the following will load the driver for an PFE3000 at address 0x20
+on I2C bus #1::
+
+	$ modprobe bel-pfe
+	$ echo pfe3000 0x20 > /sys/bus/i2c/devices/i2c-1/new_device
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+
+Sysfs entries
+-------------
+
+======================= =======================================================
+curr1_label		"iin"
+curr1_input		Measured input current
+curr1_max               Input current max value
+curr1_max_alarm         Input current max alarm
+
+curr[2-3]_label		"iout[1-2]"
+curr[2-3]_input		Measured output current
+curr[2-3]_max           Output current max value
+curr[2-3]_max_alarm     Output current max alarm
+
+fan[1-2]_input          Fan 1 and 2 speed in RPM
+fan1_target             Set fan speed reference for both fans
+
+in1_label		"vin"
+in1_input		Measured input voltage
+in1_crit		Input voltage critical max value
+in1_crit_alarm		Input voltage critical max alarm
+in1_lcrit               Input voltage critical min value
+in1_lcrit_alarm         Input voltage critical min alarm
+in1_max                 Input voltage max value
+in1_max_alarm           Input voltage max alarm
+
+in2_label               "vcap"
+in2_input               Hold up capacitor voltage
+
+in[3-8]_label		"vout[1-3,5-7]"
+in[3-8]_input		Measured output voltage
+in[3-4]_alarm           vout[1-2] output voltage alarm
+
+power[1-2]_label	"pin[1-2]"
+power[1-2]_input        Measured input power
+power[1-2]_alarm	Input power high alarm
+
+power[3-4]_label	"pout[1-2]"
+power[3-4]_input	Measured output power
+
+temp[1-3]_input		Measured temperature
+temp[1-3]_alarm         Temperature alarm
+======================= =======================================================
+
+.. note::
+
+    - curr3, fan2, vout[2-7], vcap, pin2, pout2 and temp3 attributes only
+      exist for PFE3000.
-- 
2.17.1

