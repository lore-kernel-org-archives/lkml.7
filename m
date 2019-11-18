Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5C218AE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKRRMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:12:00 -0500
Received: from pietrobattiston.it ([92.243.7.39]:50842 "EHLO
        jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbfKRRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:11:59 -0500
Received: from amalgama (pno-math-19.ulb.ac.be [164.15.133.19])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: giovanni)
        by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id 16B0BE0546;
        Mon, 18 Nov 2019 18:11:57 +0100 (CET)
Received: by amalgama (Postfix, from userid 1000)
        id CD1053C0244; Mon, 18 Nov 2019 18:11:56 +0100 (CET)
From:   Giovanni Mascellani <gio@debian.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Giovanni Mascellani <gio@debian.org>
Subject: [PATCH v4 2/2] dell-smm-hwmon: Add documentation
Date:   Mon, 18 Nov 2019 18:11:48 +0100
Message-Id: <20191118171148.76373-2-gio@debian.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118171148.76373-1-gio@debian.org>
References: <20191118171148.76373-1-gio@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part of the documentation is taken from the README of the userspace
utils (https://github.com/vitorafsr/i8kutils). The license is GPL-2+
and the author Massimo Dal Zotto is already credited as author of
the module. Therefore there should be no copyright problem.

I also added a paragraph with specific information on the experimental
support for automatic BIOS fan control.

Signed-off-by: Giovanni Mascellani <gio@debian.org>
---
 Documentation/hwmon/dell-smm-hwmon.rst | 112 +++++++++++++++++++++++++
 Documentation/hwmon/index.rst          |   1 +
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/hwmon/dell-smm-hwmon.rst

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
new file mode 100644
index 000000000000..f80d30d8a02a
--- /dev/null
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -0,0 +1,112 @@
+Kernel driver dell-smm-hwmon
+============================
+
+Description
+-----------
+
+On many Dell laptops the System Management Mode (SMM) BIOS can be
+queried for the status of fans and temperature sensors. The userspace
+suite `i8kutils`__ can be used to read the sensors and automatically
+adjust fan speed.
+
+ __ https://github.com/vitorafsr/i8kutils
+
+``/proc`` interface
+-------------------
+
+The information provided by the kernel driver can be accessed by
+simply reading the ``/proc/i8k`` file. For example::
+
+    $ cat /proc/i8k
+    1.0 A17 2J59L02 52 2 1 8040 6420 1 2
+
+The fields read from ``/proc/i8k`` are::
+
+    1.0 A17 2J59L02 52 2 1 8040 6420 1 2
+    |   |   |       |  | | |    |    | |
+    |   |   |       |  | | |    |    | +------- 10. buttons status
+    |   |   |       |  | | |    |    +--------- 9.  AC status
+    |   |   |       |  | | |    +-------------- 8.  right fan rpm
+    |   |   |       |  | | +------------------- 7.  left fan rpm
+    |   |   |       |  | +--------------------- 6.  right fan status
+    |   |   |       |  +----------------------- 5.  left fan status
+    |   |   |       +-------------------------- 4.  CPU temperature (Celsius)
+    |   |   +---------------------------------- 3.  Dell service tag (later known as 'serial number')
+    |   +-------------------------------------- 2.  BIOS version
+    +------------------------------------------ 1.  /proc/i8k format version
+
+A negative value, for example -22, indicates that the BIOS doesn't
+return the corresponding information. This is normal on some
+models/BIOSes.
+
+For performance reasons the ``/proc/i8k`` doesn't report by default
+the AC status since this SMM call takes a long time to execute and is
+not really needed.  If you want to see the ac status in ``/proc/i8k``
+you must explictitly enable this option by passing the
+``power_status=1`` parameter to insmod. If AC status is not
+available -1 is printed instead.
+
+The driver provides also an ioctl interface which can be used to
+obtain the same information and to control the fan status. The ioctl
+interface can be accessed from C programs or from shell using the
+i8kctl utility. See the source file of ``i8kutils`` for more
+information on how to use the ioctl interface.
+
+``sysfs`` interface
+-------------------
+
+Temperature sensors and fans can also be queried and set via the
+standard ``hwmon`` interface on ``sysfs``.
+
+Disabling automatic BIOS fan control
+------------------------------------
+
+On some laptops, the BIOS automatically sets fan speed every few
+seconds. Therefore the fan speed set via ``/proc/i8k`` or via the
+``sysfs`` interface is quickly overwritten.
+
+There is experimental support for disabling automatic BIOS fan
+control, at least on laptops where the corresponding SMM command is
+known, by writing the value ``1`` in the attribute ``pwm1_enable``
+(writing ``2`` enables automatic BIOS control again). Even if you have
+more than one fan, all of them are set to either enabled or disabled
+automatic fan control at the same time and, notwithstanding the name,
+``pwm1_enable`` sets automatic control for all fans.
+
+If ``pwm1_enable`` is not available, then it means that SMM codes for
+enabling and disabling automatic BIOS fan control are not known for
+your laptop. You can experiment with the code in `this repository`__
+to probe the BIOS on your machine and discover the appropriate codes.
+
+ __ https://github.com/clopez/dellfan/
+
+Module parameters
+-----------------
+
+* force:bool
+                   Force loading without checking for supported
+                   models. (default: 0)
+
+* ignore_dmi:bool
+                   Continue probing hardware even if DMI data does not
+                   match. (default: 0)
+
+* restricted:bool
+                   Allow fan control only to processes with the
+                   ``CAP_SYS_ADMIN`` capability set or processes run
+                   as root. In this case normal users will be able to
+                   read temperature and fan status but not to control
+                   the fan.  If your notebook is shared with other
+                   users and you don't trust them you may want to use
+                   this option. (default: 1)
+
+* power_status:bool
+                   Report AC status in ``/proc/i8k``. (default: 0)
+
+* fan_mult:uint
+                   Factor to multiply fan speed with. (default:
+                   autodetect)
+
+* fan_max:uint
+                   Maximum configurable fan speed. (default:
+                   autodetect)
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 230ad59b462b..092435ad6bb8 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -44,6 +44,7 @@ Hardware Monitoring Kernel Drivers
    coretemp
    da9052
    da9055
+   dell-smm-hwmon
    dme1737
    ds1621
    ds620
-- 
2.24.0

