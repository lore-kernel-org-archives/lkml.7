Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888DDCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFAD2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="oEa6goVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390915AbfJWJyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:54:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46947 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390246AbfJWJyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:54:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id d1so20332995ljl.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RseJbARsp4zZmSYZa3mBVZ+J4mOiNk8o0Hk/Uodixac=;
        b=oEa6goVbFlEFPi2VsLP+4D6bF276hL+d8S1U5fdHxP7AzDevelgMOsPlNNmZKXvujr
         djoqsLj1Gvel08INKZQmFQy1skvGYAdFQiUZWxgj6sc/qBvADTsHrnexKAfQY1DCibCw
         ZyT90uCs4hY+tCsnhfmfUGPP2cRwob1R0V3aHwWdP4tRTIu0iOW9JqFO8QyhOGPrNvL1
         H1hy73G8wFIduI+q/slN2TXdq/oTUdoR+pbcKlv48iCOYw1pEN1L4sDUjpNmUjDjGRKB
         Z41G5pSC+PSVRDdBU1CqrLuXtvHzQvOPm8uENpElUciKmm1oVYartpU1TamjwDtUtyVR
         Y5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RseJbARsp4zZmSYZa3mBVZ+J4mOiNk8o0Hk/Uodixac=;
        b=WtNlrXNXp9yUnXFPId9hfBwlAU2cZLjaqYgaOQX84o2Q0LUl9QZ2+1qrb1hJPMb/5/
         Bq8Ndd3/TpXNbYMIOhvzxGucLkVaVuENknGe/q5W006ltaX1gzpBP++ogEbXbei7g8Ay
         Lgmqad6kICh+BmPNgYr4ULTL7yClNLAGb35J6+vvxy8Bb7sfnS8XuDgRx2k3FyKSUNXK
         KBUZDJsPEymj4a2Tvt/CRA18QuLWsNcj0hPLx1Ipv+Ad0HG6csQPoGjhFU15FWEhzfTs
         wjc1+WX27ESu79YN3dKkfLYysZFzRsyhC2NaCQl23DOlV8DB0AnjNbmAUq1XspdAIw5T
         n/LA==
X-Gm-Message-State: APjAAAXUKeKiem0hmhnKc9Uapaxs+iVvD80gbv8iUsTK5BIav78jNMlL
        ZVZbZiB2MbNW3JA1IIlE+uKa0Q==
X-Google-Smtp-Source: APXvYqyJl56KzCgKPlNhrUrXj1Ty6IPLUatOhK7VsrenqN8txKOggHYnkPZxIo57UYGpqchDKT4n0A==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr22200182ljb.51.1571824491757;
        Wed, 23 Oct 2019 02:54:51 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id f8sm3176147ljj.98.2019.10.23.02.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:54:51 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:54:44 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/1] openrisc: add support for LiteX
Message-ID: <20191023115427.23684-1-mholenko@antmicro.com>
References: <20191023115427.23684-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023115427.23684-0-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

This adds support for a basic LiteX-based SoC with a mor1kx soft CPU.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
 MAINTAINERS                               |  1 +
 arch/openrisc/boot/dts/or1klitex.dts      | 49 +++++++++++++++++++++++
 arch/openrisc/configs/or1klitex_defconfig | 18 +++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 arch/openrisc/boot/dts/or1klitex.dts
 create mode 100644 arch/openrisc/configs/or1klitex_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index c24a37833e78..e84b2cb4c186 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9500,6 +9500,7 @@ S:	Maintained
 F:	include/linux/litex.h
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
 F:	drivers/tty/serial/liteuart.c
+F:	arch/openrisc/boot/dts/or1klitex.dts
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
diff --git a/arch/openrisc/boot/dts/or1klitex.dts b/arch/openrisc/boot/dts/or1klitex.dts
new file mode 100644
index 000000000000..63399398002d
--- /dev/null
+++ b/arch/openrisc/boot/dts/or1klitex.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LiteX-based System on Chip
+ *
+ * Copyright (C) 2019 Antmicro Ltd <www.antmicro.com>
+ */
+
+/dts-v1/;
+/ {
+	compatible = "opencores,or1ksim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&pic>;
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		bootargs = "console=liteuart";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			compatible = "opencores,or1200-rtlsvn481";
+			reg = <0>;
+			clock-frequency = <100000000>;
+		};
+	};
+
+	pic: pic {
+		compatible = "opencores,or1k-pic";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+
+	serial0: serial@e0001800 {
+		device_type = "serial";
+		compatible = "litex,liteuart";
+		reg = <0xe0001800 0x100>;
+	};
+};
diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
new file mode 100644
index 000000000000..0e4c2e74451c
--- /dev/null
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -0,0 +1,18 @@
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BUG_ON_DATA_CORRUPTION=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_CROSS_COMPILE="or32-linux-"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_EMBEDDED=y
+CONFIG_HZ_100=y
+CONFIG_INITRAMFS_SOURCE="openrisc-rootfs.cpio.gz"
+CONFIG_OF_OVERLAY=y
+CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_SERIAL_LITEUART=y
+CONFIG_SERIAL_LITEUART_CONSOLE=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_TTY_PRINTK=y
-- 
2.23.0

